#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v8.0 - Continuous Self-Healing System
# ============================================================
# バリデーションで検出されたエラーを自動修復し、再検証を繰り返す。
# ゼロエラーに到達するまでループし、長時間の自律的品質改善を実現。
# ============================================================

# カラー定義
readonly HEAL_GREEN='\033[0;32m'  HEAL_YELLOW='\033[0;33m' HEAL_RED='\033[0;31m'
readonly HEAL_PURPLE='\033[0;35m' HEAL_CYAN='\033[0;36m'   HEAL_BOLD='\033[1m'
readonly HEAL_NC='\033[0m'

# ヒーラー設定
MAX_HEAL_ITERATIONS="${MAX_HEAL_ITERATIONS:-50}"
MAX_FIX_ATTEMPTS_PER_ERROR=3
CLAUDE_CALL_TIMEOUT=120
HEAL_LOG_DIR="" HEAL_SESSION_ID="" HEAL_PROJECT_DIR=""
HEAL_ITERATION=0 HEAL_START_TIME=0
HEAL_TOTAL_FIXES=0 HEAL_SUCCESSFUL_FIXES=0 HEAL_FAILED_FIXES=0 HEAL_SKIPPED_ERRORS=0

# 修正履歴（同じ修正の繰り返しを防止）
declare -A HEAL_FIX_HISTORY=()
declare -A HEAL_BACKUP_MAP=()

# ============================================================
# ヘルパー関数群
# ============================================================
_healer_log() {
    local level="$1" message="$2"
    local color="${HEAL_NC}"
    case "$level" in
        INFO|SUCCESS) color="${HEAL_GREEN}" ;; WARN) color="${HEAL_YELLOW}" ;;
        ERROR|FAIL)   color="${HEAL_RED}"   ;; ESCALATE) color="${HEAL_PURPLE}" ;;
    esac
    echo -e "  ${color}[HEAL:${level}]${HEAL_NC} ${message}"
    [[ -n "$HEAL_LOG_DIR" ]] && \
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [${level}] ${message}" >> "${HEAL_LOG_DIR}/healer.log" 2>/dev/null || true
}

_healer_backup_file() {
    local filepath="$1"
    [[ ! -f "$filepath" ]] && return 1
    local backup_path="${HEAL_LOG_DIR}/backups/$(basename "$filepath").$(date +%s).bak"
    cp "$filepath" "$backup_path" 2>/dev/null || { _healer_log "ERROR" "バックアップ失敗: ${filepath}"; return 1; }
    HEAL_BACKUP_MAP[$filepath]="$backup_path"
    return 0
}

_healer_revert_file() {
    local filepath="$1" backup_path="${HEAL_BACKUP_MAP[$1]:-}"
    if [[ -n "$backup_path" && -f "$backup_path" ]]; then
        cp "$backup_path" "$filepath" 2>/dev/null && return 0
    fi
    _healer_log "WARN" "リバート失敗: ${filepath}"
    return 1
}

_healer_error_hash() {
    echo "${1}:${2:0:60}" | md5sum 2>/dev/null | cut -d' ' -f1 || echo "${1}:${2:0:60}"
}

_healer_count_errors() {
    local report="$1"
    [[ -z "$report" ]] && { echo "0"; return; }
    [[ -f "$report" ]] && report=$(cat "$report")
    local count
    count=$(echo "$report" | grep -icE '(error|fail|critical)' 2>/dev/null | head -1 || echo "0")
    echo "${count:-0}"
}

# Claude CLI呼び出し（リトライ付き、タイムアウト120秒）
_healer_call_claude() {
    local prompt="$1" retry=0
    while [[ "$retry" -lt 3 ]]; do
        retry=$((retry + 1))
        local result
        result=$(timeout "${CLAUDE_CALL_TIMEOUT}" \
            claude -p --dangerously-skip-permissions \
            --output-format text "$prompt" 2>/dev/null || echo "")
        [[ -n "$result" ]] && { echo "$result"; return 0; }
        _healer_log "WARN" "Claude CLI応答なし (試行 ${retry}/3)"
        sleep $((retry * 2))
    done
    _healer_log "ERROR" "Claude CLI: 全リトライ失敗"
    return 1
}

# ============================================================
# 初期化
# ============================================================
healer_init() {
    local session_id="$1" project_dir="$2"
    HEAL_SESSION_ID="$session_id"
    HEAL_PROJECT_DIR="$project_dir"
    HEAL_LOG_DIR="docs/chain-logs/heal_${session_id}"
    HEAL_ITERATION=0 HEAL_START_TIME=$(date +%s)
    HEAL_TOTAL_FIXES=0 HEAL_SUCCESSFUL_FIXES=0 HEAL_FAILED_FIXES=0 HEAL_SKIPPED_ERRORS=0
    HEAL_FIX_HISTORY=() HEAL_BACKUP_MAP=()
    mkdir -p "${HEAL_LOG_DIR}/backups" "${HEAL_LOG_DIR}/fixes" 2>/dev/null || true
    _healer_log "INFO" "ヒーラー初期化: ${session_id} | max=${MAX_HEAL_ITERATIONS}"
    echo -e "${HEAL_BOLD}${HEAL_PURPLE}[HEALER] 自動修復システム初期化完了${HEAL_NC}"
    echo -e "  セッション: ${HEAL_CYAN}${session_id}${HEAL_NC} | 最大: ${MAX_HEAL_ITERATIONS}回"
}

# ============================================================
# メイン修復ループ - エラーゼロまで繰り返す
# ============================================================
healer_run() {
    local project_dir="$1" validation_report="$2"
    echo -e "\n${HEAL_BOLD}${HEAL_PURPLE}[HEALER] 自動修復ループ開始${HEAL_NC}"

    local iteration=0 current_report="$validation_report"
    local error_count
    error_count=$(_healer_count_errors "$current_report")

    while [[ "$error_count" -gt 0 && "$iteration" -lt "$MAX_HEAL_ITERATIONS" ]]; do
        iteration=$((iteration + 1))
        HEAL_ITERATION=$iteration
        echo -e "${HEAL_BOLD}── 修復 ${iteration}/${MAX_HEAL_ITERATIONS} (残エラー: ${error_count}) ──${HEAL_NC}"

        # 優先度ソート → カスケード検出
        local prioritized cascade_groups
        prioritized=$(healer_prioritize_errors "$current_report")
        cascade_groups=$(healer_detect_cascade "$prioritized")

        # 各エラーを修復
        local fixed_count=0
        while IFS= read -r error_line; do
            [[ -z "$error_line" ]] && continue
            local e_file e_msg e_sev
            e_file=$(echo "$error_line" | cut -d'|' -f1)
            e_msg=$(echo "$error_line" | cut -d'|' -f2)
            e_sev=$(echo "$error_line" | cut -d'|' -f3)

            # 試行回数チェック（同一エラー3回で諦め）
            local ehash attempts
            ehash=$(_healer_error_hash "$e_file" "$e_msg")
            attempts="${HEAL_FIX_HISTORY[$ehash]:-0}"
            if [[ "$attempts" -ge "$MAX_FIX_ATTEMPTS_PER_ERROR" ]]; then
                HEAL_SKIPPED_ERRORS=$((HEAL_SKIPPED_ERRORS + 1)); continue
            fi

            # 生成 → 適用 → 検証
            local fix_info
            fix_info=$(healer_generate_fix "$e_file" "$e_msg" "$e_sev" "$attempts")
            if [[ -z "$fix_info" ]]; then
                HEAL_FIX_HISTORY[$ehash]=$((attempts + 1)); continue
            fi
            if healer_apply_fix "$fix_info" && healer_verify_fix "$e_file" "$e_msg" "$fix_info"; then
                fixed_count=$((fixed_count + 1))
                HEAL_SUCCESSFUL_FIXES=$((HEAL_SUCCESSFUL_FIXES + 1))
                # 学習システム連携
                type -t rt_capture_success &>/dev/null && \
                    rt_capture_success "HEAL" "auto-fix" "修復成功: ${e_file##*/}" "${e_msg:0:80}"
            else
                HEAL_FAILED_FIXES=$((HEAL_FAILED_FIXES + 1))
                HEAL_FIX_HISTORY[$ehash]=$((attempts + 1))
            fi
            HEAL_TOTAL_FIXES=$((HEAL_TOTAL_FIXES + 1))
        done <<< "$cascade_groups"

        # 進展なし → ループ脱出
        if [[ "$fixed_count" -eq 0 ]]; then
            _healer_log "WARN" "進展なし - ループ終了"
            break
        fi

        # 再バリデーション
        echo -e "  ${HEAL_CYAN}再バリデーション...${HEAL_NC}"
        if type -t validator_run_all &>/dev/null; then
            current_report=$(validator_run_all "$project_dir" 2>/dev/null || echo "")
        else
            current_report=$(_healer_basic_validate "$project_dir")
        fi
        error_count=$(_healer_count_errors "$current_report")

        # チェックポイント
        type -t checkpoint_save &>/dev/null && checkpoint_save "$iteration" 2>/dev/null || true
        _healer_save_checkpoint "$iteration" "$error_count" "$fixed_count"
        echo -e "  完了: 修正=${fixed_count}, 残エラー=${error_count}"
    done

    # 終了処理
    if [[ "$error_count" -gt 0 ]]; then
        echo -e "\n${HEAL_YELLOW}[HEALER] 最大イテレーション到達。残: ${error_count}${HEAL_NC}"
        healer_escalate "$current_report"
    else
        echo -e "\n${HEAL_GREEN}[HEALER] 全エラー修復完了!${HEAL_NC}"
    fi
    healer_report
    echo "$current_report"
}

# ============================================================
# 修正生成 - Claude CLIでエラーを修復
# ============================================================
healer_generate_fix() {
    local error_file="$1" error_msg="$2" error_severity="${3:-unknown}" attempt="${4:-0}"
    [[ ! -f "$error_file" ]] && return 1

    local file_content
    file_content=$(cat "$error_file" 2>/dev/null || echo "")
    [[ -z "$file_content" ]] && return 1

    # 試行回数に応じてプロンプト変更（繰り返し回避）
    local prompt
    case "$attempt" in
        0) prompt="以下のファイルにエラーがあります:
エラー: ${error_msg} (重要度: ${error_severity})

${file_content}

修正後のコード全体のみを返してください。説明不要。" ;;
        1) prompt="前回の修正が失敗。別アプローチで修正してください。
エラー: ${error_msg}

${file_content}

根本原因を分析し異なるアプローチで。コード全体のみ返してください。" ;;
        *) prompt="${attempt}回修正失敗。完全に異なる解決策で修正してください。
エラー: ${error_msg}

${file_content}

ロジック再構築も検討。コード全体のみ返してください。" ;;
    esac

    local fixed_code
    fixed_code=$(_healer_call_claude "$prompt" "$error_file")
    [[ -z "$fixed_code" ]] && return 1

    # コードブロックマーカー除去
    fixed_code=$(echo "$fixed_code" | sed '/^```[a-zA-Z]*/d; /^```$/d')

    # 修正コードをファイル保存（ユニークID付きで競合防止）
    local fix_id="fix_$(date +%s)_${RANDOM}_$$"
    local fix_file="${HEAL_LOG_DIR}/fixes/${fix_id}.tmp"
    mkdir -p "${HEAL_LOG_DIR}/fixes" 2>/dev/null || true
    printf '%s\n' "$fixed_code" > "$fix_file"

    # 修正情報を返却（パイプ区切り：ファイル|説明|修正コードパス）
    echo "${error_file}|[${error_severity}] ${error_msg:0:80}|${fix_file}"
}

# ============================================================
# 修正適用 - バックアップ→書き込み→Gitコミット
# ============================================================
healer_apply_fix() {
    local fix_info="$1"
    local target_file fix_desc fix_code_path
    target_file=$(echo "$fix_info" | cut -d'|' -f1)
    fix_desc=$(echo "$fix_info" | cut -d'|' -f2)
    fix_code_path=$(echo "$fix_info" | cut -d'|' -f3)
    [[ ! -f "$target_file" ]] && return 1

    _healer_backup_file "$target_file"

    [[ -z "$fix_code_path" || ! -f "$fix_code_path" ]] && return 1

    cp "$fix_code_path" "$target_file" 2>/dev/null || {
        _healer_revert_file "$target_file"; return 1
    }

    # 個別コミット（ロールバック容易化）
    if command -v git &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
        git add "$target_file" 2>/dev/null || true
        git commit -m "fix(healer): ${fix_desc}" --no-verify 2>/dev/null || true
    fi

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] APPLIED | ${target_file} | ${fix_desc}" \
        >> "${HEAL_LOG_DIR}/fix_history.log"
    echo -e "  ${HEAL_GREEN}適用: ${target_file##*/}${HEAL_NC}"
    return 0
}

# ============================================================
# 修正検証 - 構文チェック＋バリデータ
# ============================================================
healer_verify_fix() {
    local error_file="$1" error_msg="$2" fix_info="$3"
    local target_file
    target_file=$(echo "$fix_info" | cut -d'|' -f1)
    local ext="${target_file##*.}" ok=true

    # 言語別構文チェック
    case "$ext" in
        py)       python3 -c "import ast; ast.parse(open('${target_file}').read())" 2>/dev/null || ok=false ;;
        js|jsx)   command -v node &>/dev/null && { node --check "$target_file" 2>/dev/null || ok=false; } ;;
        ts|tsx)   [[ -f "node_modules/.bin/tsc" ]] && { npx tsc --noEmit "$target_file" 2>/dev/null || ok=false; } ;;
        sh|bash)  bash -n "$target_file" 2>/dev/null || ok=false ;;
        rb)       command -v ruby &>/dev/null && { ruby -c "$target_file" 2>/dev/null || ok=false; } ;;
        go)       command -v gofmt &>/dev/null && { gofmt -e "$target_file" >/dev/null 2>&1 || ok=false; } ;;
    esac

    # バリデータ連携
    [[ "$ok" == "true" ]] && type -t validator_check_file &>/dev/null && \
        { validator_check_file "$target_file" 2>/dev/null || ok=false; }

    if [[ "$ok" == "true" ]]; then
        echo -e "  ${HEAL_GREEN}検証OK${HEAL_NC}"
        return 0
    fi

    # 失敗 → ロールバック
    echo -e "  ${HEAL_RED}検証NG - ロールバック${HEAL_NC}"
    _healer_revert_file "$target_file"
    command -v git &>/dev/null && git checkout -- "$target_file" 2>/dev/null || true
    type -t rt_capture_error &>/dev/null && \
        rt_capture_error "HEAL" "fix-failed" "修復失敗: ${target_file##*/}" "${error_msg:0:80}"
    return 1
}

# ============================================================
# エラー優先度ソート（構文>依存>型>ランタイム>UI>エッジ）
# ============================================================
healer_prioritize_errors() {
    local input="$1"
    [[ -f "$input" ]] && input=$(cat "$input")

    echo "$input" | while IFS= read -r line; do
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        local p=99 low=$(echo "$line" | tr '[:upper:]' '[:lower:]')

        [[ "$low" =~ (syntax.error|syntaxerror|parse.error|unexpected.token) ]] && p=1
        [[ "$low" =~ (import.error|module.not.found|cannot.find.module|no.module.named) ]] && p=2
        [[ "$low" =~ (type.error|typeerror|type.mismatch) ]] && p=3
        [[ "$low" =~ (runtime.error|reference.error|null.pointer|undefined.is.not) ]] && p=4
        [[ "$low" =~ (warning|style|css|layout|render) ]] && p=5
        [[ "$low" =~ (potential|edge.case|deprecated|unused) ]] && p=6

        # ファイルパスの抽出
        local fpath="unknown" msg="$line"
        [[ "$line" =~ ^([^:]+):[0-9]+: ]] && fpath="${BASH_REMATCH[1]}"
        [[ "$line" =~ ^([^|]+)\| ]] && fpath="${BASH_REMATCH[1]}"

        local sev="other"
        case "$p" in 1) sev="syntax";; 2) sev="import";; 3) sev="type";;
                     4) sev="runtime";; 5) sev="ui";; 6) sev="edge";; esac

        echo "${p}|${fpath}|${msg}|${sev}"
    done | sort -t'|' -k1 -n | while IFS='|' read -r _ f m s; do
        echo "${f}|${m}|${s}"
    done
}

# ============================================================
# カスケード検出 - 同一ファイル5+エラーは根本原因のみ修正
# ============================================================
healer_detect_cascade() {
    local input="$1"
    declare -A counts=() firsts=() seen=()

    # 1パス: ファイル別カウント
    while IFS='|' read -r f m s; do
        [[ -z "$f" ]] && continue
        counts[$f]=$(( ${counts[$f]:-0} + 1 ))
        [[ -z "${firsts[$f]:-}" ]] && firsts[$f]="${f}|${m}|${s}"
    done <<< "$input"

    # 2パス: カスケードグループまたは個別出力
    while IFS='|' read -r f m s; do
        [[ -z "$f" ]] && continue
        local c="${counts[$f]:-0}"
        if [[ "$c" -ge 5 && -z "${seen[$f]:-}" ]]; then
            _healer_log "INFO" "カスケード: ${f} (${c}エラー)"
            echo "${firsts[$f]}"
            seen[$f]=1
        elif [[ "$c" -lt 5 && -z "${seen[${f}:${m}]:-}" ]]; then
            echo "${f}|${m}|${s}"
            seen["${f}:${m}"]=1
        fi
    done <<< "$input"
}

# ============================================================
# エスカレーション - 修復限界到達時のレポート生成
# ============================================================
healer_escalate() {
    local remaining="$1"
    mkdir -p "docs/chain-logs" 2>/dev/null || true
    local rpt="docs/chain-logs/escalation_report.md"
    local mins=$(( ($(date +%s) - HEAL_START_TIME) / 60 ))

    {
        echo "# Escalation Report - 自動修復限界到達"
        echo ""
        echo "**セッション**: ${HEAL_SESSION_ID} | **経過**: ${mins}分 | **イテレーション**: ${HEAL_ITERATION}/${MAX_HEAL_ITERATIONS}"
        echo ""
        echo "## 統計"
        echo "| 項目 | 値 |"
        echo "|------|---:|"
        echo "| 総修正試行 | ${HEAL_TOTAL_FIXES} |"
        echo "| 成功 | ${HEAL_SUCCESSFUL_FIXES} |"
        echo "| 失敗 | ${HEAL_FAILED_FIXES} |"
        echo "| スキップ | ${HEAL_SKIPPED_ERRORS} |"
        echo ""
        echo "## 未解決エラー"
        echo '```'
        echo "$remaining"
        echo '```'
        echo ""
        echo "## 推奨手動対応"
        local guide
        guide=$(_healer_call_claude "以下のエラーの手動修正方法を簡潔に提案:
${remaining}" "")
        echo "${guide:-エラーメッセージを確認して手動対応してください。}"
    } > "$rpt"

    _healer_log "ESCALATE" "レポート: ${rpt}"
    echo -e "  ${HEAL_YELLOW}エスカレーション: ${rpt}${HEAL_NC}"
}

# ============================================================
# 修復サマリーレポート
# ============================================================
healer_report() {
    local elapsed=$(( $(date +%s) - HEAL_START_TIME ))
    local rate=0
    [[ "$HEAL_TOTAL_FIXES" -gt 0 ]] && rate=$(( (HEAL_SUCCESSFUL_FIXES * 100) / HEAL_TOTAL_FIXES ))

    echo ""
    echo -e "${HEAL_BOLD}${HEAL_PURPLE}╔═══════════════════════════════════════════════╗${HEAL_NC}"
    echo -e "${HEAL_BOLD}${HEAL_PURPLE}║          Self-Healing Report (v8.0)           ║${HEAL_NC}"
    echo -e "${HEAL_BOLD}${HEAL_PURPLE}╠═══════════════════════════════════════════════╣${HEAL_NC}"
    echo -e "  イテレーション: ${HEAL_ITERATION}/${MAX_HEAL_ITERATIONS}"
    echo -e "  修正試行: ${HEAL_TOTAL_FIXES} | 成功: ${HEAL_GREEN}${HEAL_SUCCESSFUL_FIXES}${HEAL_NC} | 失敗: ${HEAL_RED}${HEAL_FAILED_FIXES}${HEAL_NC} | Skip: ${HEAL_YELLOW}${HEAL_SKIPPED_ERRORS}${HEAL_NC}"
    echo -e "  成功率: ${rate}% | 経過: $((elapsed/60))分$((elapsed%60))秒"

    local status="HEALING FAILED"
    [[ "$HEAL_FAILED_FIXES" -eq 0 && "$HEAL_SKIPPED_ERRORS" -eq 0 ]] && status="FULLY HEALED"
    [[ "$HEAL_SUCCESSFUL_FIXES" -gt 0 && "$status" == "HEALING FAILED" ]] && status="PARTIALLY HEALED"
    local sc="${HEAL_RED}"
    [[ "$status" == "FULLY HEALED" ]] && sc="${HEAL_GREEN}"
    [[ "$status" == "PARTIALLY HEALED" ]] && sc="${HEAL_YELLOW}"
    echo -e "  ステータス: ${sc}${status}${HEAL_NC}"
    echo -e "${HEAL_BOLD}${HEAL_PURPLE}╚═══════════════════════════════════════════════╝${HEAL_NC}"

    _healer_save_report "$elapsed" "$rate"
}

# ============================================================
# 内部: 簡易バリデーション（validator未定義時フォールバック）
# ============================================================
_healer_basic_validate() {
    local dir="$1" errors=""
    # Python
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        python3 -c "import ast; ast.parse(open('${f}').read())" 2>/dev/null || \
            errors+="${f}|SyntaxError|syntax\n"
    done < <(find "$dir" -name "*.py" -not -path "*/node_modules/*" -not -path "*/.venv/*" 2>/dev/null)
    # JavaScript
    if command -v node &>/dev/null; then
        while IFS= read -r f; do
            [[ -z "$f" ]] && continue
            node --check "$f" 2>/dev/null || errors+="${f}|SyntaxError: JS|syntax\n"
        done < <(find "$dir" -name "*.js" -not -path "*/node_modules/*" 2>/dev/null)
    fi
    # Shell
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        bash -n "$f" 2>/dev/null || errors+="${f}|SyntaxError: Bash|syntax\n"
    done < <(find "$dir" -name "*.sh" -not -path "*/node_modules/*" 2>/dev/null)
    echo -e "$errors"
}

# チェックポイント・レポートJSON保存
_healer_save_checkpoint() {
    [[ -z "$HEAL_LOG_DIR" ]] && return
    cat > "${HEAL_LOG_DIR}/checkpoint_${1}.json" <<EOF
{"iteration":${1},"timestamp":"$(date -u +%Y-%m-%dT%H:%M:%SZ)","remaining_errors":${2},"fixes_this_round":${3},"total":${HEAL_TOTAL_FIXES},"ok":${HEAL_SUCCESSFUL_FIXES},"ng":${HEAL_FAILED_FIXES},"skip":${HEAL_SKIPPED_ERRORS}}
EOF
}

_healer_save_report() {
    [[ -z "$HEAL_LOG_DIR" ]] && return
    cat > "${HEAL_LOG_DIR}/heal_report.json" <<EOF
{"session_id":"${HEAL_SESSION_ID}","version":"8.0","timestamp":"$(date -u +%Y-%m-%dT%H:%M:%SZ)","iterations":${HEAL_ITERATION},"max":${MAX_HEAL_ITERATIONS},"elapsed_sec":${1},"total":${HEAL_TOTAL_FIXES},"ok":${HEAL_SUCCESSFUL_FIXES},"ng":${HEAL_FAILED_FIXES},"skip":${HEAL_SKIPPED_ERRORS},"rate":${2},"project":"${HEAL_PROJECT_DIR}"}
EOF
    _healer_log "INFO" "レポート保存: ${HEAL_LOG_DIR}/heal_report.json"
}

# ============================================================
# エクスポート（chain.shから source して使用）
# ============================================================
#   source lib/healer.sh
#   healer_init "session_001" "/path/to/project"
#   healer_run "/path/to/project" "validation_report.txt"
#   healer_report
