#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v9.0 - Intelligent File Writer
# ============================================================
# Claudeが生成したテキスト出力を解析し、正しいプロジェクトファイルへ
# 自動分割・書き込みを行うブリッジモジュール。
# マルチフォーマット対応 / パストラバーサル防御 / 書き込みレポート
# ============================================================

# カラー定義（source時の重複ガード付き）
: "${FW_GREEN:='\033[0;32m'}"
: "${FW_YELLOW:='\033[0;33m'}"
: "${FW_RED:='\033[0;31m'}"
: "${FW_CYAN:='\033[0;36m'}"
: "${FW_BOLD:='\033[1m'}"
: "${FW_NC:='\033[0m'}"

# モジュール状態
FW_PROJECT_DIR=""
FW_FILES_WRITTEN=0
FW_BYTES_WRITTEN=0
declare -a FW_WRITTEN_LIST=()

# --- ヘルパー: ログ出力 ---
_fw_log() {
    local level="$1" message="$2" color="${FW_NC}"
    case "$level" in
        INFO) color="${FW_CYAN}" ;; OK) color="${FW_GREEN}" ;;
        WARN) color="${FW_YELLOW}" ;; ERROR) color="${FW_RED}" ;;
    esac
    echo -e "  ${color}[FW:${level}]${FW_NC} ${message}"
}

# --- ヘルパー: 拡張子から言語判定 ---
_fw_detect_language() {
    case "${1##*.}" in
        ts|tsx) echo "TypeScript" ;; js|jsx) echo "JavaScript" ;;
        py) echo "Python" ;; sh|bash) echo "Shell" ;; rs) echo "Rust" ;;
        go) echo "Go" ;; rb) echo "Ruby" ;; java) echo "Java" ;;
        cpp|cc) echo "C++" ;; c|h) echo "C" ;; css|scss) echo "CSS" ;;
        html) echo "HTML" ;; json) echo "JSON" ;; yaml|yml) echo "YAML" ;;
        toml) echo "TOML" ;; md) echo "Markdown" ;; sql) echo "SQL" ;;
        *) echo "unknown" ;;
    esac
}

# ============================================================
# 1. fw_init - プロジェクトディレクトリ・状態リセット
# ============================================================
fw_init() {
    local project_dir="${1:-.}"
    project_dir="$(cd "$project_dir" 2>/dev/null && pwd)" || {
        _fw_log "ERROR" "ディレクトリが見つかりません: $1"; return 1
    }
    FW_PROJECT_DIR="$project_dir"
    FW_FILES_WRITTEN=0; FW_BYTES_WRITTEN=0; FW_WRITTEN_LIST=()
    _fw_log "INFO" "FileWriter 初期化完了: ${FW_PROJECT_DIR}"
}

# ============================================================
# 2. fw_write_from_claude - Claude出力から複数ファイルを書き込み
# ============================================================
fw_write_from_claude() {
    local claude_output="$1" project_dir="${2:-$FW_PROJECT_DIR}"
    [[ -z "$claude_output" ]] && { _fw_log "WARN" "空の出力です"; return 0; }
    [[ -z "$project_dir" ]] && { _fw_log "ERROR" "project_dirが未設定"; return 1; }

    local blocks count=0
    blocks="$(fw_parse_file_blocks "$claude_output")"
    [[ -z "$blocks" ]] && { _fw_log "WARN" "ファイルマーカー未検出"; return 0; }

    while IFS= read -r block; do
        [[ -z "$block" ]] && continue
        local filepath="${block%%:::*}" content="${block#*:::}"
        fw_write_file "$filepath" "$content" "$project_dir" && ((count++))
    done <<< "$blocks"

    _fw_log "OK" "合計 ${count} ファイルを書き込みました"
    echo "$count"
}

# ============================================================
# 3. fw_parse_file_blocks - ファイルブロック抽出（複数フォーマット対応）
#    戻り値: "filepath:::content" ペア（改行区切り）
# ============================================================
fw_parse_file_blocks() {
    local text="$1"
    [[ -z "$text" ]] && return 0

    local results="" current_path="" current_content="" in_block=false in_fenced=false

    # 前ブロック保存用の内部関数（サブシェル回避のためインライン処理）
    while IFS= read -r line; do
        local new_path=""

        # パターン1: // filename: path  または  # filename: path
        if [[ "$line" =~ ^[[:space:]]*(//|#)[[:space:]]*[Ff]ile(name)?:[[:space:]]*(.+)$ ]]; then
            new_path="${BASH_REMATCH[3]}"
        # パターン2: ```language:path/to/file.ext
        elif [[ "$line" =~ ^\`\`\`[a-zA-Z]*:(.+)$ ]]; then
            new_path="${BASH_REMATCH[1]}"; in_fenced=true
        # パターン3: --- path/to/file.ext ---
        elif [[ "$line" =~ ^---[[:space:]]+(.+[^[:space:]])[[:space:]]+---[[:space:]]*$ ]]; then
            new_path="${BASH_REMATCH[1]}"
        # パターン4: /* path/to/file.ext */
        elif [[ "$line" =~ ^/\*[[:space:]]+(.+\..+)[[:space:]]+\*/[[:space:]]*$ ]]; then
            new_path="${BASH_REMATCH[1]}"
        fi

        # 新しいファイルマーカーを検出した場合
        if [[ -n "$new_path" ]]; then
            # 前ブロックを保存
            [[ -n "$current_path" && "$in_block" == true ]] && \
                results+="${current_path}:::${current_content}"$'\n'
            # トリム処理して新パス設定
            new_path="${new_path#"${new_path%%[![:space:]]*}"}"
            new_path="${new_path%"${new_path##*[![:space:]]}"}"
            current_path="$new_path"; current_content=""; in_block=true
            continue
        fi

        # フェンスドブロック終端 ```
        if [[ "$in_fenced" == true && "$line" =~ ^\`\`\`[[:space:]]*$ ]]; then
            in_fenced=false; continue
        fi

        # コンテンツ蓄積
        if [[ "$in_block" == true ]]; then
            [[ -n "$current_content" ]] && current_content+=$'\n'
            current_content+="$line"
        fi
    done <<< "$text"

    # 最後のブロック保存
    [[ -n "$current_path" && "$in_block" == true ]] && \
        results+="${current_path}:::${current_content}"$'\n'
    echo "$results"
}

# ============================================================
# 4. fw_write_file - 単一ファイル書き込み（パス検証・mkdir付き）
# ============================================================
fw_write_file() {
    local filepath="$1" content="$2" project_dir="${3:-$FW_PROJECT_DIR}"
    [[ -z "$filepath" ]] && { _fw_log "ERROR" "ファイルパスが空です"; return 1; }
    [[ -z "$project_dir" ]] && { _fw_log "ERROR" "project_dir未設定"; return 1; }

    # セキュリティ: パストラバーサル防止
    if [[ "$filepath" == *".."* ]]; then
        _fw_log "ERROR" "不正なパス（トラバーサル検出）: ${filepath}"; return 1
    fi

    # 先頭スラッシュ除去 → 相対パスとして結合
    filepath="${filepath#/}"
    local full_path="${project_dir}/${filepath}"
    local parent_dir
    parent_dir="$(dirname "$full_path")"
    [[ ! -d "$parent_dir" ]] && mkdir -p "$parent_dir" 2>/dev/null

    # 書き込み実行
    if printf '%s\n' "$content" > "$full_path" 2>/dev/null; then
        local bytes
        bytes="$(wc -c < "$full_path" 2>/dev/null || echo 0)"
        # 実行権限付与（シェルスクリプト・Python）
        case "$filepath" in *.sh|*.bash|*.py) chmod +x "$full_path" 2>/dev/null ;; esac
        FW_FILES_WRITTEN=$((FW_FILES_WRITTEN + 1))
        FW_BYTES_WRITTEN=$((FW_BYTES_WRITTEN + bytes))
        FW_WRITTEN_LIST+=("$filepath")
        _fw_log "OK" "書込完了: ${filepath} (${bytes}B, $(_fw_detect_language "$filepath"))"
        return 0
    else
        _fw_log "ERROR" "書き込み失敗: ${full_path}"; return 1
    fi
}

# ============================================================
# 5. fw_write_single - 単一ファイル直接書き込み
# ============================================================
fw_write_single() {
    local prompt_result="$1" target_file="$2" project_dir="${3:-$FW_PROJECT_DIR}"
    [[ -z "$prompt_result" ]] && { _fw_log "WARN" "出力が空です"; return 1; }
    [[ -z "$target_file" ]] && { _fw_log "ERROR" "target_file未指定"; return 1; }
    local cleaned
    cleaned="$(fw_cleanup_code "$prompt_result")"
    fw_write_file "$target_file" "$cleaned" "$project_dir"
}

# ============================================================
# 6. fw_smart_write - マルチ/シングル自動判定書き込み
# ============================================================
fw_smart_write() {
    local claude_output="$1" project_dir="${2:-$FW_PROJECT_DIR}" expected_file="${3:-}"
    [[ -z "$claude_output" ]] && { _fw_log "WARN" "出力が空です"; return 0; }
    [[ -z "$project_dir" ]] && { _fw_log "ERROR" "project_dir未設定"; return 1; }

    # ファイルマーカー検出
    local has_markers=false
    if echo "$claude_output" | grep -qE '(//|#)[[:space:]]*[Ff]ile(name)?:' 2>/dev/null ||
       echo "$claude_output" | grep -qE '```[a-zA-Z]+:.+' 2>/dev/null ||
       echo "$claude_output" | grep -qE '^--- .+ ---$' 2>/dev/null ||
       echo "$claude_output" | grep -qE '^/\* .+\..+ \*/$' 2>/dev/null; then
        has_markers=true
    fi

    if [[ "$has_markers" == true ]]; then
        _fw_log "INFO" "マルチファイル出力を検出 → 分割書き込み"
        fw_write_from_claude "$claude_output" "$project_dir"; return $?
    elif [[ -n "$expected_file" ]]; then
        _fw_log "INFO" "シングルファイル → ${expected_file}"
        fw_write_single "$claude_output" "$expected_file" "$project_dir"; return $?
    else
        _fw_log "WARN" "マーカーも期待ファイルも未検出。スキップ"; return 1
    fi
}

# ============================================================
# 7. fw_cleanup_code - Claude出力のアーティファクト除去
# ============================================================
fw_cleanup_code() {
    local text="$1"
    [[ -z "$text" ]] && return 0

    # 先頭/末尾のmarkdownフェンス除去
    text="$(echo "$text" | sed '1{/^```[a-zA-Z]*/d}' | sed '${/^```[[:space:]]*$/d}')"
    # 先頭のプリアンブル除去（英語・日本語）
    text="$(echo "$text" | sed '1,3{/^[Hh]ere.*\(code\|file\|implementation\).*:/d;/^以下.*コード.*:/d;/^Below is/d}')"
    # 末尾の説明テキスト除去
    text="$(echo "$text" | awk '
        { lines[NR] = $0 }
        END {
            e = NR
            for (i = NR; i >= 1; i--) {
                if (lines[i] ~ /^(This |この|Note:|注意:|The above|上記)/) e = i - 1
                else if (lines[i] ~ /^[[:space:]]*$/ && i == e) e = i - 1
                else break
            }
            for (i = 1; i <= e; i++) print lines[i]
        }')"
    echo "$text"
}

# ============================================================
# 8. fw_report - 書き込みサマリー表示
# ============================================================
fw_report() {
    echo ""
    echo -e "${FW_BOLD}${FW_CYAN}━━━ FileWriter レポート ━━━${FW_NC}"
    echo -e "  ファイル数: ${FW_BOLD}${FW_FILES_WRITTEN}${FW_NC}"
    echo -e "  バイト合計: ${FW_BOLD}${FW_BYTES_WRITTEN}${FW_NC} bytes"
    if [[ ${#FW_WRITTEN_LIST[@]} -gt 0 ]]; then
        echo -e "  ${FW_CYAN}一覧:${FW_NC}"
        local f; for f in "${FW_WRITTEN_LIST[@]}"; do
            echo -e "    ${FW_GREEN}+${FW_NC} ${f}  ($(_fw_detect_language "$f"))"
        done
    else
        echo -e "  ${FW_YELLOW}書き込みファイルなし${FW_NC}"
    fi
    echo -e "${FW_BOLD}${FW_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━${FW_NC}"
    echo ""
}
