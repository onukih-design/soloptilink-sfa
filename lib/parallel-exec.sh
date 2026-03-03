#!/usr/bin/env bash
# SoloptiLink Chain v10.0 - Parallel Execution Engine
# Runs multiple Claude Code sessions simultaneously for backend, frontend,
# and database tasks. Dramatically speeds up development.
# Sourced by the main orchestrator -- do NOT use set -euo pipefail.

# 1. parallel_init(session_id) -- colours, temp dirs, PID tracking
parallel_init() {
    local session_id="${1:?parallel_init: session_id required}"
    PX_GREEN='\033[0;32m'; PX_RED='\033[0;31m'; PX_YELLOW='\033[1;33m'
    PX_CYAN='\033[0;36m';  PX_BLUE='\033[0;34m'; PX_MAGENTA='\033[0;35m'
    PX_BOLD='\033[1m';     PX_RESET='\033[0m'
    PX_OUTPUT_DIR="/tmp/soloptilink_parallel_${session_id}_$$"
    mkdir -p "$PX_OUTPUT_DIR"
    declare -g -A PX_PIDS PX_STATUS PX_START_TIMES
    PX_PIDS=(); PX_STATUS=(); PX_START_TIMES=()
    declare -g PX_SESSION_ID="$session_id"
    declare -g PX_TOTAL_NODES=0 PX_SUCCEEDED=0 PX_FAILED=0
    declare -g PX_WALL_START=0  PX_WALL_END=0  PX_SEQUENTIAL_ESTIMATE=0
    declare -g -a PX_WAIT_PIDS=()
    echo -e "${PX_CYAN}[PX]${PX_RESET} Parallel engine initialised  session=${PX_BOLD}${session_id}${PX_RESET}"
}

# 2. parallel_execute(session_id, task_desc, nodes_json) -- MAIN
#    nodes_json: [{"id":"..","phase_func":".."},...]
parallel_execute() {
    local session_id="${1:?session_id required}"
    local task_desc="${2:?task_desc required}"
    local nodes_json="${3:?nodes_json required}"
    echo -e "${PX_CYAN}[PX]${PX_RESET} ${PX_BOLD}Parallel execution start${PX_RESET}: ${task_desc}"
    PX_WALL_START=$(date +%s)
    local node_ids=() phase_funcs=()
    if command -v jq >/dev/null 2>&1; then
        while IFS= read -r line; do
            node_ids+=("$(echo "$line" | jq -r '.id')")
            phase_funcs+=("$(echo "$line" | jq -r '.phase_func')")
        done < <(echo "$nodes_json" | jq -c '.[]')
    else
        # Fallback: line-based extraction without jq
        local _id _fn
        while IFS= read -r _id; do
            IFS= read -r _fn || true
            node_ids+=("$_id"); phase_funcs+=("$_fn")
        done < <(echo "$nodes_json" | tr ',' '\n' | sed -n 's/.*"id" *: *"\([^"]*\)".*/\1/p; s/.*"phase_func" *: *"\([^"]*\)".*/\1/p')
    fi
    local count=${#node_ids[@]}
    PX_TOTAL_NODES=$((PX_TOTAL_NODES + count))
    echo -e "${PX_CYAN}[PX]${PX_RESET} Launching ${PX_BOLD}${count}${PX_RESET} nodes in parallel..."
    local pids=()
    for i in $(seq 0 $((count - 1))); do
        local nid="${node_ids[$i]}"
        local pfunc="${phase_funcs[$i]}"
        _px_launch_node "$nid" "$pfunc" "$session_id" "$task_desc" "${PX_OUTPUT_DIR}/${nid}.log"
        pids+=("${PX_PIDS[$nid]}")
        echo -e "  ${PX_BLUE}>>>${PX_RESET} ${nid}  func=${pfunc}  pid=${PX_PIDS[$nid]}"
    done
    PX_WAIT_PIDS=("${pids[@]}")
    _px_wait_all "${PX_TIMEOUT:-300}"
    PX_WALL_END=$(date +%s)
    # Collect results
    local all_ok=0
    for nid in "${node_ids[@]}"; do
        local sf="${PX_OUTPUT_DIR}/${nid}.status"
        if [[ -f "$sf" ]]; then
            local code
            code=$(<"$sf")
            PX_STATUS[$nid]="$code"
            if [[ "$code" -eq 0 ]]; then
                PX_SUCCEEDED=$((PX_SUCCEEDED + 1))
                echo -e "  ${PX_GREEN}[OK]${PX_RESET}  ${nid}"
            else
                PX_FAILED=$((PX_FAILED + 1)); all_ok=1
                echo -e "  ${PX_RED}[FAIL]${PX_RESET} ${nid}  exit=${code}"
            fi
        else
            PX_STATUS[$nid]="-1"; PX_FAILED=$((PX_FAILED + 1)); all_ok=1
            echo -e "  ${PX_RED}[MISS]${PX_RESET} ${nid}  no status file"
        fi
    done
    return "$all_ok"
}

# 3. _px_launch_node(node_id, phase_func, session_id, task_desc, output_file)
_px_launch_node() {
    local node_id="$1" phase_func="$2" session_id="$3" task_desc="$4" output_file="$5"
    local status_file="${PX_OUTPUT_DIR}/${node_id}.status"
    PX_START_TIMES[$node_id]=$(date +%s)
    (
        exec >"$output_file" 2>&1
        echo "=== Node ${node_id} started $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "func=${phase_func}  session=${session_id}  task=${task_desc}"
        echo "---"
        if declare -F "$phase_func" >/dev/null 2>&1; then
            "$phase_func" "$session_id" "$task_desc" "$node_id"
            local rc=$?
        else
            echo "ERROR: function ${phase_func} not found"; local rc=127
        fi
        echo "---"
        echo "=== Node ${node_id} finished exit=${rc} ==="
        echo "$rc" > "$status_file"
        exit "$rc"
    ) &
    PX_PIDS[$node_id]=$!
}

# 4. _px_wait_all(timeout_sec) -- uses PX_WAIT_PIDS global
_px_wait_all() {
    local timeout_sec="${1:-300}" elapsed=0 poll=2
    local _px_count=${#PX_WAIT_PIDS[@]}
    echo -e "${PX_CYAN}[PX]${PX_RESET} Waiting for ${_px_count} processes  timeout=${timeout_sec}s"
    while [[ $elapsed -lt $timeout_sec ]]; do
        local all_done=true
        for pid in "${PX_WAIT_PIDS[@]}"; do
            kill -0 "$pid" 2>/dev/null && { all_done=false; break; }
        done
        if $all_done; then
            echo -e "${PX_GREEN}[PX]${PX_RESET} All processes completed in ${elapsed}s"
            return 0
        fi
        sleep "$poll"; elapsed=$((elapsed + poll))
        if (( elapsed % 10 == 0 )); then
            local running=0
            for pid in "${PX_WAIT_PIDS[@]}"; do
                kill -0 "$pid" 2>/dev/null && running=$((running + 1))
            done
            echo -e "${PX_YELLOW}[PX]${PX_RESET} ${elapsed}s elapsed, ${running} still running..."
        fi
    done
    echo -e "${PX_RED}[PX]${PX_RESET} Timeout ${timeout_sec}s. Killing remaining..."
    for pid in "${PX_WAIT_PIDS[@]}"; do
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid" 2>/dev/null; sleep 1; kill -9 "$pid" 2>/dev/null
            echo -e "  ${PX_RED}killed${PX_RESET} pid=${pid}"
        fi
    done
    return 1
}

# 5. parallel_find_runnable(dag_status_json)
#    Prints runnable node IDs whose deps are all "done".
parallel_find_runnable() {
    local dag_status_json="${1:?dag_status_json required}"
    if ! command -v jq >/dev/null 2>&1; then
        echo -e "${PX_RED}[PX]${PX_RESET} jq required for DAG analysis" >&2; return 1
    fi
    local runnable=()
    local node_ids
    node_ids=$(echo "$dag_status_json" | jq -r '.nodes | keys[]')
    for nid in $node_ids; do
        local st
        st=$(echo "$dag_status_json" | jq -r ".nodes[\"${nid}\"].status")
        [[ "$st" == "done" || "$st" == "running" || "$st" == "failed" ]] && continue
        local all_deps_done=true
        local deps
        deps=$(echo "$dag_status_json" | jq -r ".nodes[\"${nid}\"].deps[]?" 2>/dev/null)
        for dep in $deps; do
            local ds
            ds=$(echo "$dag_status_json" | jq -r ".nodes[\"${dep}\"].status")
            [[ "$ds" != "done" ]] && { all_deps_done=false; break; }
        done
        $all_deps_done && runnable+=("$nid")
    done
    printf '%s\n' "${runnable[@]}"
    local rcount=${#runnable[@]}
    echo -e "${PX_CYAN}[PX]${PX_RESET} Found ${rcount} runnable nodes" >&2
}

# 6. parallel_merge_results(output_dir)
parallel_merge_results() {
    local output_dir="${1:-$PX_OUTPUT_DIR}"
    if [[ ! -d "$output_dir" ]]; then
        echo -e "${PX_RED}[PX]${PX_RESET} Dir not found: ${output_dir}" >&2; return 1
    fi
    local merged="${output_dir}/_merged.log"
    local summary="${output_dir}/_summary.json"
    local succeeded=0 failed=0 total=0 changed_files=()
    echo -e "${PX_CYAN}[PX]${PX_RESET} Merging results from ${output_dir}..."
    {
        echo "============================================="
        echo " SoloptiLink Chain v10.0 - Parallel Results"
        echo " Merged: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "============================================="
    } > "$merged"
    for logfile in "$output_dir"/*.log; do
        [[ "$logfile" == *"_merged.log" ]] && continue
        [[ ! -f "$logfile" ]] && continue
        local nn
        nn=$(basename "$logfile" .log)
        total=$((total + 1))
        local ec=-1
        [[ -f "${output_dir}/${nn}.status" ]] && ec=$(<"${output_dir}/${nn}.status")
        [[ "$ec" -eq 0 ]] && succeeded=$((succeeded + 1)) || failed=$((failed + 1))
        echo "--- Node: ${nn} exit=${ec} ---" >> "$merged"
        cat "$logfile" >> "$merged"
        echo "" >> "$merged"
        while IFS= read -r line; do
            changed_files+=("$line")
        done < <(grep '^FILE_CHANGED:' "$logfile" 2>/dev/null | sed 's/^FILE_CHANGED://')
    done
    # Write summary JSON
    printf '{"total_nodes":%d,"succeeded":%d,"failed":%d,"merged_log":"%s"}\n' \
        "$total" "$succeeded" "$failed" "$merged" > "$summary"
    echo -e "${PX_CYAN}[PX]${PX_RESET} Merged ${total} logs -> ${merged}"
    local ccount=${#changed_files[@]}
    echo -e "  ${PX_GREEN}ok${PX_RESET}=${succeeded}  ${PX_RED}fail${PX_RESET}=${failed}  changed=${ccount}"
}

# 7. parallel_report() -- summary with speedup factor
parallel_report() {
    local wall=0
    [[ "$PX_WALL_END" -gt 0 && "$PX_WALL_START" -gt 0 ]] && wall=$((PX_WALL_END - PX_WALL_START))
    local seq_total=0
    for nid in "${!PX_START_TIMES[@]}"; do
        if [[ -f "${PX_OUTPUT_DIR}/${nid}.status" ]]; then
            seq_total=$((seq_total + PX_WALL_END - PX_START_TIMES[$nid]))
        fi
    done
    PX_SEQUENTIAL_ESTIMATE=$seq_total
    local speedup="1.0"
    if [[ "$wall" -gt 0 && "$seq_total" -gt 0 ]]; then
        speedup=$(awk 'BEGIN{printf "%.1f", '"${seq_total}"'/'"${wall}"'}')
    fi
    echo ""
    echo -e "${PX_CYAN}========================================${PX_RESET}"
    echo -e "${PX_BOLD} Parallel Execution Report${PX_RESET}"
    echo -e "${PX_CYAN}========================================${PX_RESET}"
    echo -e " Session      : ${PX_SESSION_ID}"
    echo -e " Total nodes  : ${PX_TOTAL_NODES}"
    echo -e " Succeeded    : ${PX_GREEN}${PX_SUCCEEDED}${PX_RESET}"
    echo -e " Failed       : ${PX_RED}${PX_FAILED}${PX_RESET}"
    echo -e " Wall time    : ${wall}s"
    echo -e " Est. seq time: ${seq_total}s"
    echo -e " Speedup      : ${PX_BOLD}${speedup}x${PX_RESET}"
    echo -e " Output dir   : ${PX_OUTPUT_DIR}"
    echo -e "${PX_CYAN}========================================${PX_RESET}"
    echo ""
}
