#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v8.0 - URL Analyzer Module
# ============================================================
# ユーザーが提供した2つのURLを解析し、両サイトの長所を組み合わせた
# 統合要件定義書・技術仕様書を自動生成するライブラリモジュール。
# Claude Code CLIを使用してURL分析・要件生成を行う。
# ============================================================

# sourceされるライブラリなので set -euo pipefail は設定しない

# カラー定義（プレフィックス付きで他モジュールと衝突回避）
readonly UA_RED='\033[0;31m'
readonly UA_GREEN='\033[0;32m'
readonly UA_YELLOW='\033[0;33m'
readonly UA_CYAN='\033[0;36m'
readonly UA_BOLD='\033[1m'
readonly UA_NC='\033[0m'

# URL Analyzerの設定
UA_WORK_DIR="${HOME}/.soloptilink/url-analyzer"
UA_SESSION_DIR=""
UA_LOG_FILE=""
UA_MAX_RETRIES=3
UA_RETRY_DELAY=5
UA_TIMEOUT=120

# ============================================================
# 構造化ログ出力
# ============================================================
_url_log() {
    local level="$1" message="$2"
    local timestamp; timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
    local color="${UA_NC}" label="INFO"
    case "$level" in
        info)    color="${UA_CYAN}";   label="INFO"  ;;
        success) color="${UA_GREEN}";  label="OK"    ;;
        warn)    color="${UA_YELLOW}"; label="WARN"  ;;
        error)   color="${UA_RED}";    label="ERROR" ;;
    esac
    local formatted="[${timestamp}] [${label}] ${message}"
    echo -e "  ${color}[URL-ANALYZER] ${formatted}${UA_NC}"
    # セッション開始後のみログファイルに書き込み
    if [[ -n "${UA_LOG_FILE:-}" && -d "$(dirname "${UA_LOG_FILE}")" ]]; then
        echo "${formatted}" >> "${UA_LOG_FILE}"
    fi
}

# ============================================================
# Claude CLI呼び出しラッパー（リトライ・タイムアウト付き）
# ============================================================
_url_call_claude() {
    local prompt="$1" output_file="$2"
    if [[ -z "$prompt" || -z "$output_file" ]]; then
        _url_log error "プロンプトまたは出力パスが未指定です"; return 1
    fi
    local output_dir; output_dir="$(dirname "$output_file")"
    [[ -d "$output_dir" ]] || mkdir -p "$output_dir" 2>/dev/null || {
        _url_log error "出力ディレクトリ作成不可: ${output_dir}"; return 1
    }

    local attempt=0
    while (( attempt < UA_MAX_RETRIES )); do
        attempt=$((attempt + 1))
        _url_log info "Claude CLI呼び出し (試行 ${attempt}/${UA_MAX_RETRIES})..."
        if timeout "${UA_TIMEOUT}" \
            claude -p --dangerously-skip-permissions \
                --output-format text "${prompt}" \
            > "${output_file}" 2>/dev/null && [[ -s "$output_file" ]]; then
            _url_log success "Claude CLI応答取得成功 (${attempt}回目)"
            return 0
        fi
        _url_log warn "Claude CLI呼び出し失敗 (試行 ${attempt}/${UA_MAX_RETRIES})"
        (( attempt < UA_MAX_RETRIES )) && sleep "${UA_RETRY_DELAY}"
    done
    _url_log error "Claude CLI呼び出しが${UA_MAX_RETRIES}回とも失敗"
    return 1
}

# ============================================================
# セッション初期化
# ============================================================
url_init() {
    local session_id="${1:-url_$(date +%Y%m%d_%H%M%S)_$$}"
    _url_log info "URL分析セッション初期化中..."

    UA_SESSION_DIR="${UA_WORK_DIR}/sessions/${session_id}"
    UA_LOG_FILE="${UA_SESSION_DIR}/session.log"
    mkdir -p "${UA_SESSION_DIR}"/{analyses,spec,design} 2>/dev/null || {
        _url_log error "セッションディレクトリ作成失敗: ${UA_SESSION_DIR}"; return 1
    }
    cat > "${UA_LOG_FILE}" <<EOF
# URL Analyzer Session Log | ID: ${session_id}
# Started: $(date -u +%Y-%m-%dT%H:%M:%SZ) | Version: v8.0
EOF
    _url_log success "セッション初期化完了: ${session_id}"
    echo "${session_id}"
}

# ============================================================
# 単一URL分析
# ============================================================
url_analyze() {
    local url="${1:-}" output_dir="${2:-${UA_SESSION_DIR}/analyses}"
    if [[ -z "$url" ]]; then
        _url_log error "URLが指定されていません"; return 1
    fi
    [[ "$url" =~ ^https?:// ]] || { _url_log warn "https://を付与"; url="https://${url}"; }
    [[ -d "$output_dir" ]] || mkdir -p "$output_dir" 2>/dev/null || { _url_log error "ディレクトリ作成不可"; return 1; }

    # 分析ファイルのインデックス決定
    local existing_count
    existing_count=$(find "$output_dir" -maxdepth 1 -name 'url_analysis_*.md' 2>/dev/null | wc -l | tr -d ' ')
    local idx=$((existing_count + 1))
    local output_file="${output_dir}/url_analysis_${idx}.md"

    _url_log info "URL分析開始: ${url}"
    local prompt="Analyze this URL and describe: 1) Page structure/layout 2) Key features/functions 3) UI components (buttons, forms, navigation) 4) Technology stack guess 5) API endpoints visible 6) User flows. URL: ${url}
Provide analysis in structured Markdown with clear sections."

    if _url_call_claude "$prompt" "$output_file"; then
        # YAML front matterでメタ情報を付与
        local tmp="${output_file}.tmp"
        { echo -e "---\nurl: ${url}\nanalyzed_at: $(date -u +%Y-%m-%dT%H:%M:%SZ)\nindex: ${idx}\n---\n"; cat "$output_file"; } > "$tmp" && mv "$tmp" "$output_file"
        _url_log success "URL分析完了: ${output_file}"
        return 0
    fi
    _url_log error "URL分析失敗: ${url}"; return 1
}

# ============================================================
# 2つのURL分析結果を統合 → 要件定義書生成
# ============================================================
url_combine_requirements() {
    local analysis_dir="${1:-${UA_SESSION_DIR}/analyses}"
    local task_desc="${2:-統合Webシステムの開発}"
    local a1="${analysis_dir}/url_analysis_1.md" a2="${analysis_dir}/url_analysis_2.md"
    [[ -f "$a1" ]] || { _url_log error "分析ファイル未検出: ${a1}"; return 1; }
    [[ -f "$a2" ]] || { _url_log error "分析ファイル未検出: ${a2}"; return 1; }

    local output_file="${analysis_dir}/combined_requirements.md"
    _url_log info "統合要件定義書を生成中..."
    local s1; s1="$(cat "$a1")"
    local s2; s2="$(cat "$a2")"

    local prompt="Given these two site analyses, create a combined system taking the best of both.
=== Site 1 ===${s1}
=== Site 2 ===${s2}
Task: ${task_desc}

Generate requirements document (Markdown) with sections:
1. Project Overview (name, purpose, target users)
2. Functional Requirements (Must/Should/Could, user roles)
3. Database Schema (tables, columns, types, constraints, ER description)
4. API Design (endpoints, methods, request/response schemas)
5. Screen List (all screens, navigation flow)
6. UI Component List (hierarchy, props/state)
7. Non-Functional Requirements (performance, security, a11y)
8. Technology Stack Recommendation
Japanese for descriptions, English for technical terms."

    if _url_call_claude "$prompt" "$output_file"; then
        _url_log success "統合要件定義書生成完了: ${output_file}"; return 0
    fi
    _url_log error "統合要件定義書の生成に失敗"; return 1
}

# ============================================================
# 技術仕様書生成（要件定義書 → 5つの詳細スペックファイル）
# ============================================================
url_generate_spec() {
    local req_file="${1:-}" output_dir="${2:-${UA_SESSION_DIR}/spec}"
    if [[ -z "$req_file" || ! -f "$req_file" ]]; then
        _url_log error "要件定義ファイル未検出: ${req_file:-未指定}"; return 1
    fi
    mkdir -p "$output_dir" 2>/dev/null || true
    local req; req="$(cat "$req_file")"
    _url_log info "技術仕様書を生成中（5ファイル）..."
    local failed=0

    # 各スペックファイルの定義: (ファイル名, ラベル, プロンプト補足)
    local -a spec_names=("db_schema" "api_endpoints" "screen_wireframes" "component_hierarchy" "directory_structure")
    local -a spec_labels=("DBテーブル設計" "APIエンドポイント" "画面ワイヤーフレーム" "コンポーネント階層" "ディレクトリ構造")
    local -a spec_instructions=(
        "Generate SQL CREATE TABLE statements with columns, types, PK/FK, indexes, constraints, and table comments."
        "Generate API endpoint spec: method, path, request/response JSON schemas, status codes, auth requirements."
        "Describe wireframes: screen name, URL path, layout, component placement, interactive elements, responsive notes."
        "Design component tree: hierarchy, props, state, events, shared components, data flow, state management approach. Include TypeScript interfaces."
        "Plan directory structure: tree with file names, purpose comments, config files. Follow best practices for the tech stack."
    )

    for i in "${!spec_names[@]}"; do
        local step=$((i + 1))
        _url_log info "[${step}/5] ${spec_labels[$i]}を生成中..."
        local p="Based on these requirements:\n${req}\n\n${spec_instructions[$i]}\nFormat as Markdown."
        _url_call_claude "$p" "${output_dir}/${spec_names[$i]}.md" || ((failed++))
    done

    local ok=$((5 - failed))
    if (( failed == 0 )); then
        _url_log success "技術仕様書生成完了: 全5ファイル (${output_dir}/)"
    else
        _url_log warn "技術仕様書: ${ok}/5成功 (${failed}件失敗)"
    fi
    return $((failed > 0 ? 1 : 0))
}

# ============================================================
# デザイントークン抽出
# ============================================================
url_extract_design_tokens() {
    local url="${1:-}" output_dir="${2:-${UA_SESSION_DIR}/design}"
    if [[ -z "$url" ]]; then
        _url_log error "URLが指定されていません"; return 1
    fi
    mkdir -p "$output_dir" 2>/dev/null || true
    local output_file="${output_dir}/design_tokens.md"
    _url_log info "デザイントークン抽出中: ${url}"

    local prompt="Analyze the visual design of this URL and extract design tokens.
URL: ${url}

Provide analysis in Markdown:
1. Color Palette - primary, secondary, accent, background, text, status colors (hex codes)
2. Typography - font families, size scale, weights, line-heights
3. Spacing System - base unit, scale (xs-3xl), padding/margin patterns
4. Layout Patterns - grid, breakpoints, container widths, compositions
5. Component Styles - border-radius, shadows, button/input/card styles
6. CSS Variables - all tokens as --custom-properties

Include CSS code blocks for variable definitions."

    if _url_call_claude "$prompt" "$output_file"; then
        _url_log success "デザイントークン抽出完了: ${output_file}"; return 0
    fi
    _url_log error "デザイントークン抽出失敗: ${url}"; return 1
}

# ============================================================
# エクスポート（chain.shから使用）
# ============================================================
# このファイルは chain.sh から source される
# 使用例:
#   source lib/url-analyzer.sh
#   session_id=$(url_init "my_session")
#   url_analyze "https://example.com" "${UA_SESSION_DIR}/analyses"
#   url_analyze "https://example2.com" "${UA_SESSION_DIR}/analyses"
#   url_combine_requirements "${UA_SESSION_DIR}/analyses" "SaaS CRM開発"
#   url_generate_spec "${UA_SESSION_DIR}/analyses/combined_requirements.md"
#   url_extract_design_tokens "https://example.com" "${UA_SESSION_DIR}/design"
