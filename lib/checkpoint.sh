#!/usr/bin/env bash
# =============================================================================
# SoloptiLink Chain v8.0 - Checkpoint & Resume System
# =============================================================================
# Saves state after each DAG stage so work is never lost. If a 3-hour session
# crashes at hour 2, it resumes from the last checkpoint automatically.
# Usage: source lib/checkpoint.sh
# =============================================================================

# Color codes
readonly _CKP_GREEN='\033[0;32m'  _CKP_YELLOW='\033[0;33m'  _CKP_RED='\033[0;31m'
readonly _CKP_CYAN='\033[0;36m'   _CKP_BOLD='\033[1m'        _CKP_NC='\033[0m'

CHECKPOINT_BASE_DIR="docs/chain-logs/checkpoints"

# --- Helper: _checkpoint_log(level, message) --------------------------------

_checkpoint_log() {
  local level="$1" message="$2" ts
  ts="$(date '+%Y-%m-%d %H:%M:%S')"
  case "$level" in
    INFO)  printf "${_CKP_CYAN}[CHECKPOINT %s]${_CKP_NC} %s\n"   "$ts" "$message" ;;
    OK)    printf "${_CKP_GREEN}[CHECKPOINT %s]${_CKP_NC} %s\n"   "$ts" "$message" ;;
    WARN)  printf "${_CKP_YELLOW}[CHECKPOINT %s]${_CKP_NC} %s\n"  "$ts" "$message" ;;
    ERROR) printf "${_CKP_RED}[CHECKPOINT %s]${_CKP_NC} %s\n"     "$ts" "$message" ;;
    *)     printf "[CHECKPOINT %s] %s\n" "$ts" "$message" ;;
  esac
}

# --- checkpoint_init(session_id) --------------------------------------------

checkpoint_init() {
  local session_id="$1"
  [[ -z "$session_id" ]] && { _checkpoint_log ERROR "session_id is required"; return 1; }
  local ckp_dir="${CHECKPOINT_BASE_DIR}/${session_id}"
  mkdir -p "$ckp_dir"
  _checkpoint_log OK "Checkpoint directory initialised: ${ckp_dir}"
}

# --- checkpoint_save(session_id, stage_name, metadata) ----------------------

checkpoint_save() {
  local session_id="$1" stage_name="$2" metadata="$3"
  [[ -z "$session_id" || -z "$stage_name" ]] && {
    _checkpoint_log ERROR "Usage: checkpoint_save <session_id> <stage_name> [metadata]"; return 1
  }

  local ckp_dir="${CHECKPOINT_BASE_DIR}/${session_id}"
  mkdir -p "$ckp_dir"

  # Git commit current state
  git add -A 2>/dev/null
  git commit -m "checkpoint: ${session_id}/${stage_name}" --allow-empty -q 2>/dev/null
  local rev_hash; rev_hash="$(git rev-parse HEAD 2>/dev/null || echo 'no-git')"

  # Collect modified files
  local files_modified
  files_modified="$(git diff --name-only HEAD~1 HEAD 2>/dev/null | head -50 | paste -sd ',' -)"
  [[ -z "$files_modified" ]] && files_modified="none"

  # Write metadata JSON
  local ts; ts="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  cat > "${ckp_dir}/${stage_name}.json" <<ENDJSON
{
  "stage": "${stage_name}",
  "timestamp": "${ts}",
  "rev_hash": "${rev_hash}",
  "dag_status": "${DAG_STATUS:-unknown}",
  "files_modified": "${files_modified}",
  "validation_results": "${VALIDATION_RESULTS:-none}",
  "extra": ${metadata:-"{}"}
}
ENDJSON

  _checkpoint_log OK "Checkpoint saved: ${stage_name}  (rev ${rev_hash:0:8})"
}

# --- checkpoint_restore(session_id, stage_name) -----------------------------

checkpoint_restore() {
  local session_id="$1" stage_name="$2"
  local meta_file="${CHECKPOINT_BASE_DIR}/${session_id}/${stage_name}.json"
  [[ ! -f "$meta_file" ]] && { _checkpoint_log ERROR "Checkpoint not found: ${meta_file}"; return 1; }

  local rev_hash; rev_hash="$(grep '"rev_hash"' "$meta_file" | sed 's/.*: *"\([^"]*\)".*/\1/')"
  if [[ "$rev_hash" != "no-git" && -n "$rev_hash" ]]; then
    _checkpoint_log INFO "Restoring git state to ${rev_hash:0:8} ..."
    git checkout "$rev_hash" -q 2>/dev/null
  fi

  # Export DAG_STATUS so callers can resume
  local dag_status; dag_status="$(grep '"dag_status"' "$meta_file" | sed 's/.*: *"\([^"]*\)".*/\1/')"
  export DAG_STATUS="$dag_status"

  _checkpoint_log OK "Restored checkpoint: ${stage_name}"
  cat "$meta_file"
}

# --- checkpoint_list(session_id) --------------------------------------------

checkpoint_list() {
  local session_id="$1"
  local ckp_dir="${CHECKPOINT_BASE_DIR}/${session_id}"
  [[ ! -d "$ckp_dir" ]] && { _checkpoint_log WARN "No checkpoints for session: ${session_id}"; return 1; }

  printf "${_CKP_BOLD}%-30s %-26s %-12s${_CKP_NC}\n" "STAGE" "TIMESTAMP" "REV"
  printf '%s\n' "----------------------------------------------------------------------"
  for f in "$ckp_dir"/*.json; do
    [[ -f "$f" ]] || continue
    local stage ts rev
    stage="$(grep '"stage"' "$f"    | sed 's/.*: *"\([^"]*\)".*/\1/')"
    ts="$(grep '"timestamp"' "$f"   | sed 's/.*: *"\([^"]*\)".*/\1/')"
    rev="$(grep '"rev_hash"' "$f"   | sed 's/.*: *"\([^"]*\)".*/\1/')"
    printf "%-30s %-26s %-12s\n" "$stage" "$ts" "${rev:0:8}"
  done
}

# --- checkpoint_latest() ---------------------------------------------------

checkpoint_latest() {
  local latest_file="" latest_ts="0"
  for f in "${CHECKPOINT_BASE_DIR}"/*/*.json; do
    [[ -f "$f" ]] || continue
    local ts; ts="$(grep '"timestamp"' "$f" | sed 's/.*: *"\([^"]*\)".*/\1/')"
    if [[ "$ts" > "$latest_ts" ]]; then
      latest_ts="$ts"; latest_file="$f"
    fi
  done
  [[ -z "$latest_file" ]] && { _checkpoint_log WARN "No checkpoints found"; return 1; }
  _checkpoint_log INFO "Latest checkpoint: ${latest_file}  (${latest_ts})"
  cat "$latest_file"
}

# --- checkpoint_cleanup(session_id, keep_last_n) ----------------------------

checkpoint_cleanup() {
  local session_id="$1" keep="${2:-5}"
  local ckp_dir="${CHECKPOINT_BASE_DIR}/${session_id}"
  [[ ! -d "$ckp_dir" ]] && return 0

  local total; total="$(find "$ckp_dir" -name '*.json' | wc -l | tr -d ' ')"
  if (( total <= keep )); then
    _checkpoint_log INFO "Only ${total} checkpoint(s); nothing to clean"
    return 0
  fi

  local to_remove=$(( total - keep ))
  find "$ckp_dir" -name '*.json' -print0 \
    | xargs -0 ls -1t \
    | tail -n "$to_remove" \
    | while read -r old; do
        rm -f "$old"
        _checkpoint_log INFO "Removed: $(basename "$old")"
      done
  _checkpoint_log OK "Cleanup complete. Kept last ${keep} checkpoints."
}

# --- checkpoint_auto_save(session_id, stage_name) ---------------------------

checkpoint_auto_save() {
  local session_id="$1" stage_name="$2"
  checkpoint_save "$session_id" "$stage_name" '{"auto":true}'
}
