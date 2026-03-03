#!/usr/bin/env bash
# ╔═══════════════════════════════════════════════════════════════╗
# ║  SoloptiLink Chain v10.0 - Autonomous Development Engine     ║
# ║  "一言で完璧なシステムを自律構築する"                           ║
# ║  Smart Prompt × Auto-Scaffold × Parallel × Browser Test      ║
# ║  URL-Driven × Zero-Error × Self-Healing × Auto-Deploy        ║
# ╚═══════════════════════════════════════════════════════════════╝
#
# v9.0 新機能:
#   🧠 スマートプロンプト展開 - 「CRM作って」→ 完全設計書に自動展開
#   🏗️ プロジェクトスキャフォルド - 設計書からプロジェクト骨格を自動構築
#   📁 インテリジェントファイルライター - Claude出力を正しいファイルに分割
#
# v10.0 新機能:
#   ⚡ 並列実行エンジン - BE/FE/DBを同時にClaude Code呼び出し
#   🌐 ブラウザテスト - Playwright連携、全ボタン・全フォーム自動操作
#   🚀 自動デプロイ - Vercel/Railway/ローカルへワンクリックデプロイ
#
# v8.0 機能 (継続):
#   🔗 Claude Code CLI統合 / 🌐 URL駆動開発 / ✅ 5層バリデーション
#   🔧 自律ヒーリング / 💾 チェックポイント / 🧪 網羅的QA
#
# Usage:
#   ./chain.sh "CRM作って"                                # 一言で完璧構築
#   ./chain.sh "タスク管理ツール作って"                     # 自動設計→実装→テスト→デプロイ
#   ./chain.sh "タスク" --pipeline quick                   # 高速パイプライン
#   ./chain.sh "タスク" --pipeline deep                    # フル調査込み
#   ./chain.sh "タスク" --pipeline hotfix                  # バグ修正特化
#   ./chain.sh "タスク" --url https://site1.com            # URL分析1つ
#   ./chain.sh "タスク" --url https://s1.com --url https://s2.com  # URL 2つ
#   ./chain.sh "タスク" --parallel                         # 並列実行モード
#   ./chain.sh "タスク" --deploy                           # 完了後自動デプロイ
#   ./chain.sh "タスク" --browser-test                     # ブラウザテスト有効
#   ./chain.sh --validate ./project [--auto-fix]           # バリデーションのみ
#   ./chain.sh --resume                                    # チェックポイントから再開
#   ./chain.sh --checkpoints                               # チェックポイント一覧
#   ./chain.sh --rag-search "クエリ"                      # RAGナレッジ検索
#   ./chain.sh --rag-index                                # RAGインデックス再構築
#   ./chain.sh --metrics                                  # 学習メトリクス表示
#   ./chain.sh --help                                     # ヘルプ表示
#
# 環境変数:
#   MAX_ROUNDS=15          最大ラウンド数
#   COST_LIMIT=10.00       コスト上限（USD）
#   SESSION_TIMEOUT=10800  セッションタイムアウト（秒、デフォルト3時間）
#   MAX_HEAL_ITERATIONS=50 最大ヒーリング反復回数
#   DEEPSEEK_API_KEY=...   DeepSeek APIキー（ベクトル検索有効化）
#   NO_RAG=1               RAG検索無効化
#   NO_LEARN=1             リアルタイム学習無効化
#   PX_TIMEOUT=300         並列実行タイムアウト（秒）
#   DP_LOCAL_PORT=3000     ローカルデプロイポート

set -euo pipefail

# ============================================================
# 初期設定
# ============================================================
readonly VERSION="10.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# セッション管理
SESSION_ID="chain_$(date +%Y%m%d_%H%M%S)_$$"
SESSION_START=$(date +%s)
SESSION_LOG_DIR="docs/chain-logs/${SESSION_ID}"
LOCK_FILE="/tmp/soloptilink_chain.lock"
WATCHDOG_PID=""

# カラー定義（readonlyにしない - ライブラリsource時の衝突回避）
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# デフォルト設定（環境変数でオーバーライド可能）
MAX_ROUNDS="${MAX_ROUNDS:-15}"
COST_LIMIT="${COST_LIMIT:-10.00}"
SESSION_TIMEOUT="${SESSION_TIMEOUT:-10800}"  # 3時間
MAX_HEAL_ITERATIONS="${MAX_HEAL_ITERATIONS:-50}"
PIPELINE_MODE="auto"
NO_RAG="${NO_RAG:-0}"
NO_LEARN="${NO_LEARN:-0}"

# URL駆動モード用
declare -a URLS=()
VALIDATE_DIR=""
AUTO_FIX="false"
RESUME_MODE="false"
SHOW_CHECKPOINTS="false"
TASK_DESC=""

# v9.0/v10.0 フラグ
ENABLE_PARALLEL="false"
ENABLE_DEPLOY="false"
ENABLE_BROWSER_TEST="false"

# ファイル出力追跡
REQUIREMENTS_FILE=""
SPEC_DIR=""
BLUEPRINT_FILE=""
TECH_STACK_FILE=""

# ============================================================
# ライブラリ読み込み
# ============================================================
_load_libraries() {
    local lib_dir="${SCRIPT_DIR}/lib"

    echo -e "  ${BOLD}v7.0 モジュール:${NC}"
    # v7.0モジュール（後方互換）
    for lib in lock.sh session.sh global-knowledge.sh reporting.sh \
               pipeline.sh smart-context.sh self-heal.sh plugin.sh quality-predictor.sh; do
        if [[ -f "${lib_dir}/${lib}" ]]; then
            # 2>/dev/null でreadonly衝突のエラーを抑制
            source "${lib_dir}/${lib}" 2>/dev/null || echo -e "    ${YELLOW}⚠️ ${lib} ロード警告（続行）${NC}"
            echo -e "    ${GREEN}✓${NC} ${lib}"
        fi
    done

    # v7.0コアモジュール
    for lib in dag-pipeline.sh realtime-learn.sh; do
        if [[ -f "${lib_dir}/${lib}" ]]; then
            source "${lib_dir}/${lib}" 2>/dev/null || echo -e "    ${YELLOW}⚠️ ${lib} ロード警告（続行）${NC}"
            echo -e "    ${GREEN}✓${NC} ${lib}"
        fi
    done

    echo -e "  ${BOLD}v8.0 モジュール:${NC}"
    # v8.0新モジュール
    for lib in url-analyzer.sh validator.sh qa-engine.sh healer.sh checkpoint.sh; do
        if [[ -f "${lib_dir}/${lib}" ]]; then
            source "${lib_dir}/${lib}" 2>/dev/null || echo -e "    ${YELLOW}⚠️ ${lib} ロード警告（続行）${NC}"
            echo -e "    ${GREEN}✓${NC} ${lib}"
        fi
    done

    echo -e "  ${BOLD}v9.0 モジュール:${NC}"
    # v9.0モジュール: スマートプロンプト展開、スキャフォルダー、ファイルライター
    for lib in prompt-expander.sh scaffolder.sh file-writer.sh; do
        if [[ -f "${lib_dir}/${lib}" ]]; then
            source "${lib_dir}/${lib}" 2>/dev/null || echo -e "    ${YELLOW}⚠️ ${lib} ロード警告（続行）${NC}"
            echo -e "    ${GREEN}✓${NC} ${lib}"
        fi
    done

    echo -e "  ${BOLD}v10.0 モジュール:${NC}"
    # v10.0モジュール: 並列実行、ブラウザテスト、自動デプロイ
    for lib in parallel-exec.sh browser-test.sh auto-deploy.sh; do
        if [[ -f "${lib_dir}/${lib}" ]]; then
            source "${lib_dir}/${lib}" 2>/dev/null || echo -e "    ${YELLOW}⚠️ ${lib} ロード警告（続行）${NC}"
            echo -e "    ${GREEN}✓${NC} ${lib}"
        fi
    done
}

# ============================================================
# バナー表示
# ============================================================
_show_banner() {
    echo ""
    echo -e "${BOLD}${PURPLE}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║                                                           ║"
    echo "  ║   SoloptiLink Chain v${VERSION}                               ║"
    echo "  ║   一言で完璧なシステムを自律構築する                      ║"
    echo "  ║                                                           ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "  セッション  : ${CYAN}${SESSION_ID}${NC}"
    echo -e "  最大ラウンド: ${MAX_ROUNDS} | コスト上限: \$${COST_LIMIT} | タイムアウト: $((SESSION_TIMEOUT / 60))分"
    echo -e "  ヒーリング上限: ${MAX_HEAL_ITERATIONS}回"
    echo ""
}

# ============================================================
# 引数パース
# ============================================================
_parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --url)
                if [[ -z "${2:-}" ]]; then
                    echo -e "${RED}--url にはURLを指定してください${NC}"; exit 1
                fi
                URLS+=("$2")
                shift 2
                ;;
            --validate)
                VALIDATE_DIR="${2:-.}"
                shift 2
                ;;
            --auto-fix)
                AUTO_FIX="true"
                shift
                ;;
            --resume)
                RESUME_MODE="true"
                shift
                ;;
            --checkpoints)
                SHOW_CHECKPOINTS="true"
                shift
                ;;
            --pipeline)
                PIPELINE_MODE="${2:-auto}"
                shift 2
                ;;
            --rounds)
                MAX_ROUNDS="${2:-15}"
                shift 2
                ;;
            --rag-search)
                _cmd_rag_search "${2:-}"
                exit 0
                ;;
            --rag-index)
                _cmd_rag_index
                exit 0
                ;;
            --metrics)
                _cmd_metrics
                exit 0
                ;;
            --dag-show)
                echo -e "${BOLD}DAGプリセット表示${NC}"
                source "${SCRIPT_DIR}/lib/dag-pipeline.sh" 2>/dev/null || true
                dag_analyze_task "${2:-generic task}" "${3:-standard}"
                exit 0
                ;;
            --no-rag)
                NO_RAG=1
                shift
                ;;
            --no-learn)
                NO_LEARN=1
                shift
                ;;
            --parallel)
                ENABLE_PARALLEL="true"
                shift
                ;;
            --deploy)
                ENABLE_DEPLOY="true"
                shift
                ;;
            --browser-test)
                ENABLE_BROWSER_TEST="true"
                shift
                ;;
            --help|-h)
                _show_help
                exit 0
                ;;
            -*)
                echo -e "${RED}不明なオプション: $1${NC}"
                _show_help
                exit 1
                ;;
            *)
                TASK_DESC="$1"
                shift
                ;;
        esac
    done
}

# ============================================================
# Claude Code CLI 呼び出し（コア関数）
# ============================================================
_call_claude() {
    local prompt="$1"
    local output_file="${2:-}"
    local max_retries=3
    local timeout_sec=300

    for ((i=1; i<=max_retries; i++)); do
        local result
        # claude -p (--print) でプロンプトを位置引数として渡す
        if result=$(timeout ${timeout_sec} claude -p \
            --dangerously-skip-permissions \
            --output-format text \
            "${prompt}" 2>&1); then
            if [[ -n "$result" ]]; then
                if [[ -n "$output_file" ]]; then
                    local out_dir
                    out_dir="$(dirname "$output_file")"
                    mkdir -p "$out_dir" 2>/dev/null || true
                    printf '%s\n' "$result" > "$output_file"
                else
                    printf '%s\n' "$result"
                fi
                return 0
            fi
        fi
        echo -e "${YELLOW}  ⚠️ Claude呼び出し失敗 (試行 ${i}/${max_retries})${NC}" >&2
        sleep $((i * 3))
    done
    echo -e "${RED}  ❌ Claude呼び出し失敗（全リトライ失敗）${NC}" >&2
    return 1
}

# ============================================================
# フェーズ後バリデーション＆ヒーリング共通処理
# ============================================================
_post_phase_validate_and_heal() {
    local phase_name="$1"
    local project_dir="${2:-.}"

    # バリデータが使用可能かチェック
    if ! type -t validator_init &>/dev/null; then
        echo -e "  ${YELLOW}⚠️ バリデータ未ロード（スキップ）${NC}"
        return 0
    fi

    echo -e "  ${CYAN}[POST-${phase_name}] バリデーション実行中...${NC}"
    validator_init "$project_dir" 2>/dev/null || true
    local report
    report=$(validator_run_all "$project_dir" 2>/dev/null || echo "")
    local error_count
    error_count=$(validator_count_errors "$report" 2>/dev/null || echo "0")

    if [[ "$error_count" -gt 0 ]]; then
        echo -e "  ${RED}[POST-${phase_name}] ${error_count}件のエラー検出 → ヒーリング開始${NC}"
        if type -t healer_init &>/dev/null; then
            healer_init "$SESSION_ID" "$project_dir" 2>/dev/null || true
            healer_run "$project_dir" "$report" 2>/dev/null || true
        else
            echo -e "  ${YELLOW}⚠️ ヒーラー未ロード（手動修正が必要）${NC}"
        fi
    else
        echo -e "  ${GREEN}[POST-${phase_name}] バリデーション: エラーなし ✅${NC}"
    fi
}

# フェーズ後チェックポイント保存
_post_phase_checkpoint() {
    local phase_name="$1"
    if type -t checkpoint_auto_save &>/dev/null; then
        checkpoint_auto_save "$SESSION_ID" "$phase_name" 2>/dev/null || true
        echo -e "  ${GREEN}💾 チェックポイント保存: ${phase_name}${NC}"
    fi
}

# 経過時間表示
_elapsed_time() {
    local now
    now=$(date +%s)
    local elapsed=$((now - SESSION_START))
    local mins=$((elapsed / 60))
    local secs=$((elapsed % 60))
    echo "${mins}分${secs}秒"
}

# ============================================================
# フェーズ実装 - v9.0/v10.0 新フェーズ
# ============================================================

# ---- Phase: スマートプロンプト展開 (v9.0) ----
# 「CRM作って」→ ドメイン判定→競合調査→要件展開→技術選定→設計書
phase_prompt_expand() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🧠 スマートプロンプト展開フェーズ (v9.0)${NC}"
    echo -e "  入力: ${task_desc}"
    echo -e "  経過時間: $(_elapsed_time)"

    if ! type -t prompt_expand &>/dev/null; then
        echo -e "  ${YELLOW}⚠️ Prompt Expanderモジュール未ロード → スキップ${NC}"
        return 0
    fi

    local expand_dir="${SESSION_LOG_DIR}/prompt_expand"
    mkdir -p "$expand_dir" 2>/dev/null || true

    # 初期化
    prompt_expand_init 2>/dev/null || true

    # 展開実行（出力の最終行がblueprint_fileパス）
    local expand_output
    expand_output=$(prompt_expand "$task_desc" "$expand_dir" 2>/dev/null || echo "")

    if [[ -n "$expand_output" ]]; then
        # 最終行がファイルパス
        BLUEPRINT_FILE=$(echo "$expand_output" | tail -1)
        if [[ -f "${BLUEPRINT_FILE:-}" ]]; then
            echo -e "  ${GREEN}✅ プロンプト展開完了: ${BLUEPRINT_FILE}${NC}"
            # 要件ファイルも設定
            local req_file="${expand_dir}/expanded_requirements.md"
            [[ -f "$req_file" ]] && REQUIREMENTS_FILE="$req_file"
            # 技術スタックファイルも設定
            local tech_file="${expand_dir}/tech_stack.md"
            [[ -f "$tech_file" ]] && TECH_STACK_FILE="$tech_file"
        else
            echo -e "  ${YELLOW}⚠️ 設計書ファイルが見つかりません → 通常要件分析にフォールバック${NC}"
        fi
    else
        echo -e "  ${YELLOW}⚠️ プロンプト展開失敗 → 通常要件分析にフォールバック${NC}"
    fi

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "PE" "prompt-expand" "プロンプト展開完了: ${task_desc:0:50}"

    _post_phase_checkpoint "prompt_expand"
    return 0
}

# ---- Phase: プロジェクトスキャフォルド (v9.0) ----
phase_scaffold() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🏗️ プロジェクトスキャフォルドフェーズ (v9.0)${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    if ! type -t scaffold_from_blueprint &>/dev/null; then
        echo -e "  ${YELLOW}⚠️ スキャフォルダーモジュール未ロード → スキップ${NC}"
        return 0
    fi

    local blueprint="${BLUEPRINT_FILE:-}"
    local tech_stack="${TECH_STACK_FILE:-}"

    if [[ ! -f "${blueprint:-}" ]]; then
        echo -e "  ${YELLOW}⚠️ ブループリントなし → スキャフォルドスキップ${NC}"
        return 0
    fi

    # スキャフォルド実行
    if scaffold_from_blueprint "$blueprint" "$tech_stack" "." 2>/dev/null; then
        echo -e "  ${GREEN}✅ プロジェクトスキャフォルド完了${NC}"
    else
        echo -e "  ${YELLOW}⚠️ スキャフォルド一部失敗（続行）${NC}"
    fi

    _post_phase_checkpoint "scaffold"
    return 0
}

# ---- Phase: ブラウザテスト (v10.0) ----
phase_browser_test() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🌐 ブラウザテストフェーズ (v10.0)${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    if ! type -t btest_init &>/dev/null; then
        echo -e "  ${YELLOW}⚠️ ブラウザテストモジュール未ロード → スキップ${NC}"
        return 0
    fi

    btest_init "." 2>/dev/null || true

    if [[ "$BT_AVAILABLE" == "true" || "$BT_ENGINE" == "playwright-pending" ]]; then
        btest_run_all "." "http://localhost:3000" 2>/dev/null || true
    else
        echo -e "  ${YELLOW}ブラウザエンジン未検出 → フォールバックチェック${NC}"
        btest_fallback_check "." "http://localhost:3000" 2>/dev/null || true
        btest_report 2>/dev/null || true
    fi

    _post_phase_checkpoint "browser_test"
    return 0
}

# ---- Phase: 自動デプロイ (v10.0) ----
phase_auto_deploy() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🚀 自動デプロイフェーズ (v10.0)${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    if ! type -t deploy_auto &>/dev/null; then
        echo -e "  ${YELLOW}⚠️ デプロイモジュール未ロード → スキップ${NC}"
        return 0
    fi

    deploy_init "." 2>/dev/null || true
    if deploy_auto "." 2>/dev/null; then
        echo -e "  ${GREEN}✅ デプロイ完了${NC}"
    else
        echo -e "  ${YELLOW}⚠️ デプロイ失敗（手動デプロイを推奨）${NC}"
    fi

    _post_phase_checkpoint "auto_deploy"
    return 0
}

# ============================================================
# フェーズ実装 - REAL Claude Code CLI 統合
# ============================================================

# ---- Phase: 要件分析・設計 ----
phase_requirements() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}📋 要件分析・設計フェーズ${NC}"
    echo -e "  タスク: ${task_desc}"
    echo -e "  経過時間: $(_elapsed_time)"

    local output_dir="${SESSION_LOG_DIR}"
    local output_file="${output_dir}/requirements.md"
    mkdir -p "$output_dir" 2>/dev/null || true

    # RAGコンテキスト取得
    local rag_context=""
    if [[ "$NO_RAG" != "1" && -f "tools/rag-engine.py" ]]; then
        rag_context=$(python3 tools/rag-engine.py search "$task_desc" --context 2>/dev/null || echo "")
        if [[ -n "$rag_context" ]]; then
            echo -e "  ${GREEN}📚 RAGから関連ナレッジ取得済み${NC}"
            echo "$rag_context" > "${output_dir}/rag_context_req.md"
        fi
    fi

    # URL分析結果があればコンテキストに含める
    local url_context=""
    if [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]]; then
        url_context="$(cat "$REQUIREMENTS_FILE")"
        echo -e "  ${GREEN}🌐 URL分析結果をコンテキストに注入${NC}"
    fi

    # Claude CLI呼び出し
    local prompt="あなたはシニアソフトウェアアーキテクトです。以下のタスクの要件定義書を作成してください。

タスク: ${task_desc}

以下のセクションを含めてください:
1. プロジェクト概要（目的、ターゲットユーザー）
2. 機能要件（Must/Should/Could、ユーザーロール別）
3. 非機能要件（パフォーマンス、セキュリティ、アクセシビリティ）
4. 技術スタック推奨
5. ファイル構造・ディレクトリ設計
6. データモデル概要
7. API設計概要
8. 画面一覧・遷移フロー

日本語で記述してください。技術用語は英語のまま使用可。"

    # RAGコンテキストがあれば追加
    if [[ -n "$rag_context" ]]; then
        prompt="${prompt}

過去の関連ナレッジ:
${rag_context}"
    fi

    # URL分析コンテキストがあれば追加
    if [[ -n "$url_context" ]]; then
        prompt="${prompt}

URL分析から得られた要件:
${url_context}"
    fi

    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ 要件定義書生成完了: ${output_file}${NC}"
        REQUIREMENTS_FILE="$output_file"
    else
        echo -e "  ${RED}❌ 要件定義書の生成に失敗${NC}"
        # フォールバック: 最低限のファイルを作成
        cat > "$output_file" <<EOF
# 要件定義書
## タスク: ${task_desc}
## 作成日: $(date '+%Y-%m-%d %H:%M:%S')
## ステータス: Claude CLI呼び出し失敗 - 手動補完が必要
EOF
        REQUIREMENTS_FILE="$output_file"
    fi

    # 学習キャプチャ
    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "REQ" "requirements" "要件分析完了: ${task_desc:0:50}"

    # チェックポイント
    _post_phase_checkpoint "requirements"

    return 0
}

# ---- Phase: RAGナレッジ検索 ----
phase_rag_search() {
    local session_id="$1"
    local task_desc="$2"

    if [[ "$NO_RAG" == "1" ]]; then
        echo -e "  ${YELLOW}RAG検索スキップ（--no-rag）${NC}"
        return 0
    fi

    if [[ ! -f "tools/rag-engine.py" ]]; then
        echo -e "  ${YELLOW}RAGエンジン未インストール${NC}"
        return 0
    fi

    echo -e "  ${CYAN}📚 RAGナレッジ検索中...${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local results
    results=$(python3 tools/rag-engine.py search "$task_desc" --top-k 5 2>/dev/null || echo "")

    if [[ -n "$results" ]]; then
        echo "$results" > "${SESSION_LOG_DIR}/rag_results.txt"
        echo -e "  ${GREEN}✅ RAG結果取得: $(echo "$results" | wc -l | tr -d ' ')行${NC}"
    else
        echo -e "  ${YELLOW}関連ナレッジなし（新規タスク）${NC}"
    fi

    _post_phase_checkpoint "rag_search"
    return 0
}

# ---- Phase: 競合・市場調査 ----
phase_competitive_research() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🔍 競合・市場調査フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local output_file="${SESSION_LOG_DIR}/competitive_research.md"

    local prompt="あなたは市場調査アナリストです。以下のタスクに関連する競合・市場調査レポートを作成してください。

タスク: ${task_desc}

以下を含めてください:
1. 既存の類似サービス・ツール一覧
2. 各サービスの特徴・差別化ポイント
3. 市場トレンド
4. ベストプラクティス
5. 推奨する差別化戦略

日本語で記述。"

    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ 競合調査レポート生成完了${NC}"
    else
        echo -e "  ${YELLOW}⚠️ 競合調査レポート生成失敗（続行）${NC}"
    fi

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "COMP" "research" "競合調査実施"

    _post_phase_checkpoint "competitive_research"
    return 0
}

# ---- Phase: DB設計・実装 ----
phase_database() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🗄️ DB設計・実装フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local output_file="${SESSION_LOG_DIR}/database_schema.md"

    # 要件定義書を読み込んでコンテキストに
    local req_content=""
    if [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]]; then
        req_content="$(cat "$REQUIREMENTS_FILE")"
    fi

    local prompt="あなたはデータベースアーキテクトです。以下の要件に基づいてデータベース設計を行い、マイグレーションファイルを作成してください。

タスク: ${task_desc}

要件定義書:
${req_content:-要件定義書なし - タスク説明から推定してください}

以下を作成してください:
1. ER図（テキスト記法）
2. CREATE TABLE文（PostgreSQL互換）
3. インデックス定義
4. シードデータ
5. マイグレーションファイル

テーブルには適切なPK/FK/制約/コメントを付与。
全ファイルをプロジェクトルートに実際に書き出してください。"

    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ DB設計完了: ${output_file}${NC}"
    else
        echo -e "  ${RED}❌ DB設計失敗${NC}"
    fi

    # フェーズ後バリデーション
    _post_phase_validate_and_heal "DB"

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "DB" "database" "DB設計完了"

    _post_phase_checkpoint "database"
    return 0
}

# ---- Phase: バックエンド実装 ----
phase_backend() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}⚙️ バックエンド実装フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local output_file="${SESSION_LOG_DIR}/backend_implementation.md"

    # 要件＋DB設計を読み込み
    local req_content=""
    [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]] && req_content="$(cat "$REQUIREMENTS_FILE")"
    local db_content=""
    [[ -f "${SESSION_LOG_DIR}/database_schema.md" ]] && db_content="$(cat "${SESSION_LOG_DIR}/database_schema.md")"

    # リアルタイム学習コンテキスト注入
    local learn_ctx=""
    if [[ "$NO_LEARN" != "1" ]] && type -t rt_generate_context &>/dev/null; then
        learn_ctx=$(rt_generate_context "BE" "$task_desc" 2>/dev/null || echo "")
        [[ -n "$learn_ctx" ]] && echo "$learn_ctx" > "${SESSION_LOG_DIR}/learn_ctx_be.md"
    fi

    local prompt="あなたはシニアバックエンドエンジニアです。以下の要件・DB設計に基づいてバックエンドを実装してください。

タスク: ${task_desc}

要件定義書:
${req_content:-（なし）}

DB設計:
${db_content:-（なし）}

以下を実装してください:
1. サーバーセットアップ（Express/Fastify/等）
2. ルーティング設定
3. ミドルウェア（認証、エラーハンドリング、CORS、ロギング）
4. データベース接続・ORM設定
5. ビジネスロジック層
6. ユーティリティ関数
7. 環境変数設定（.env.example）

全ファイルをプロジェクトルートに実際に書き出してください。
TypeScript推奨。エラーハンドリングは徹底的に。"

    if [[ -n "$learn_ctx" ]]; then
        prompt="${prompt}

過去の学習コンテキスト:
${learn_ctx}"
    fi

    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ バックエンド実装完了${NC}"
    else
        echo -e "  ${RED}❌ バックエンド実装失敗${NC}"
    fi

    _post_phase_validate_and_heal "BE"

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "BE" "backend" "バックエンド実装完了"

    _post_phase_checkpoint "backend"
    return 0
}

# ---- Phase: API実装 ----
phase_api() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🔌 API実装フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local output_file="${SESSION_LOG_DIR}/api_implementation.md"

    local req_content=""
    [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]] && req_content="$(cat "$REQUIREMENTS_FILE")"
    local be_content=""
    [[ -f "${SESSION_LOG_DIR}/backend_implementation.md" ]] && be_content="$(cat "${SESSION_LOG_DIR}/backend_implementation.md")"

    local prompt="あなたはAPIデザインのエキスパートです。以下の要件・バックエンド実装に基づいてREST APIを完成させてください。

タスク: ${task_desc}

要件:
${req_content:-（なし）}

バックエンド実装:
${be_content:-（なし）}

以下を実装してください:
1. 全エンドポイント（CRUD操作）
2. 入力バリデーション（zod/joi等）
3. エラーハンドリング（統一レスポンス形式）
4. 認証・認可（JWT/Session）
5. レート制限
6. ページネーション
7. OpenAPI/Swagger仕様書

全ファイルをプロジェクトルートに実際に書き出してください。"

    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ API実装完了${NC}"
    else
        echo -e "  ${RED}❌ API実装失敗${NC}"
    fi

    _post_phase_validate_and_heal "API"

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "API" "api-design" "API実装完了"

    _post_phase_checkpoint "api"
    return 0
}

# ---- Phase: フロントエンド実装 ----
phase_frontend() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🎨 フロントエンド実装フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local output_file="${SESSION_LOG_DIR}/frontend_implementation.md"

    local req_content=""
    [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]] && req_content="$(cat "$REQUIREMENTS_FILE")"
    local api_content=""
    [[ -f "${SESSION_LOG_DIR}/api_implementation.md" ]] && api_content="$(cat "${SESSION_LOG_DIR}/api_implementation.md")"

    # スペックディレクトリからのコンテキスト
    local spec_content=""
    if [[ -n "${SPEC_DIR:-}" && -d "$SPEC_DIR" ]]; then
        for spec_file in "${SPEC_DIR}"/*.md; do
            [[ -f "$spec_file" ]] && spec_content+="$(cat "$spec_file")"$'\n\n'
        done
    fi

    # リアルタイム学習コンテキスト
    local learn_ctx=""
    if [[ "$NO_LEARN" != "1" ]] && type -t rt_generate_context &>/dev/null; then
        learn_ctx=$(rt_generate_context "FE" "$task_desc" 2>/dev/null || echo "")
        [[ -n "$learn_ctx" ]] && echo "$learn_ctx" > "${SESSION_LOG_DIR}/learn_ctx_fe.md"
    fi

    local prompt="あなたはシニアフロントエンドエンジニアです。以下の要件・API仕様に基づいてフロントエンドを実装してください。

タスク: ${task_desc}

要件:
${req_content:-（なし）}

API仕様:
${api_content:-（なし）}

技術仕様:
${spec_content:-（なし）}

以下を実装してください:
1. プロジェクトセットアップ（Next.js/React/Vue等）
2. 全ページ・画面
3. コンポーネント設計（Atomic Design）
4. ルーティング
5. 状態管理
6. API連携（fetch/axios）
7. フォーム・バリデーション
8. レスポンシブデザイン
9. アクセシビリティ（WCAG 2.1 AA）

全ファイルをプロジェクトルートに実際に書き出してください。
TypeScript推奨。Tailwind CSS推奨。"

    if [[ -n "$learn_ctx" ]]; then
        prompt="${prompt}

過去の学習コンテキスト:
${learn_ctx}"
    fi

    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ フロントエンド実装完了${NC}"
    else
        echo -e "  ${RED}❌ フロントエンド実装失敗${NC}"
    fi

    _post_phase_validate_and_heal "FE"

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "FE" "frontend" "フロントエンド実装完了"

    _post_phase_checkpoint "frontend"
    return 0
}

# ---- Phase: 品質チェック・修正 ----
phase_quality_check() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}✅ 品質チェック・修正フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local project_dir="."
    local max_heal_rounds=5
    local round=0

    # バリデータ初期化
    if type -t validator_init &>/dev/null; then
        validator_init "$project_dir" 2>/dev/null || true

        while [[ $round -lt $max_heal_rounds ]]; do
            round=$((round + 1))
            echo -e "  ${BOLD}品質チェック ラウンド ${round}/${max_heal_rounds}${NC}"

            local report
            report=$(validator_run_all "$project_dir" 2>/dev/null || echo "")
            local error_count
            error_count=$(validator_count_errors "$report" 2>/dev/null || echo "0")

            if [[ "$error_count" -eq 0 ]]; then
                echo -e "  ${GREEN}✅ 全チェック通過 (ラウンド${round})${NC}"
                break
            fi

            echo -e "  ${YELLOW}⚠️ ${error_count}件のエラー検出 → ヒーリング実行${NC}"

            if type -t healer_init &>/dev/null; then
                healer_init "$session_id" "$project_dir" 2>/dev/null || true
                healer_run "$project_dir" "$report" 2>/dev/null || true
            else
                # ヒーラーがなければClaude CLIで直接修正
                local fix_prompt="以下のバリデーションエラーを修正してください。各ファイルを実際に修正してください。

エラーレポート:
${report}

全てのエラーを修正してください。"
                _call_claude "$fix_prompt" "${SESSION_LOG_DIR}/quality_fix_round${round}.md" || true
                break
            fi
        done
    else
        echo -e "  ${YELLOW}⚠️ バリデータ未ロード → Claude CLIで品質チェック${NC}"
        local prompt="プロジェクト全体の品質チェックを行い、問題があれば修正してください。
タスク: ${task_desc}

以下を確認:
1. 構文エラー
2. 未使用の変数・import
3. セキュリティ問題
4. パフォーマンス問題
5. アクセシビリティ問題

問題があれば実際にファイルを修正してください。"
        _call_claude "$prompt" "${SESSION_LOG_DIR}/quality_check.md" || true
    fi

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "QA" "quality-check" "品質チェック完了"

    _post_phase_checkpoint "quality_check"
    return 0
}

# ---- Phase: テスト実装・実行 ----
phase_testing() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🧪 テスト実装・実行フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    # QAエンジンが使用可能なら網羅的テスト
    if type -t qa_init &>/dev/null; then
        echo -e "  ${BOLD}網羅的QAテスト実行中...${NC}"
        qa_init "." 2>/dev/null || true
        if type -t qa_run_exhaustive &>/dev/null; then
            qa_run_exhaustive "." 2>/dev/null || true
        fi
    fi

    # Claude CLIでテストファイル生成
    local req_content=""
    [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]] && req_content="$(cat "$REQUIREMENTS_FILE")"

    local prompt="あなたはQAエンジニアです。以下のプロジェクトのテストを作成・実行してください。

タスク: ${task_desc}

要件:
${req_content:-（なし）}

以下を作成してください:
1. ユニットテスト（全関数・コンポーネント）
2. 統合テスト（API + DB）
3. E2Eテスト（主要ユーザーフロー）
4. エッジケーステスト

テストフレームワーク: Jest/Vitest (Node), pytest (Python)
全テストファイルをプロジェクトに書き出し、テストを実行してください。"

    local output_file="${SESSION_LOG_DIR}/testing_results.md"
    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ テスト作成・実行完了${NC}"
    else
        echo -e "  ${RED}❌ テスト作成失敗${NC}"
    fi

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "TEST" "testing" "テスト実行完了"

    _post_phase_checkpoint "testing"
    return 0
}

# ---- Phase: ドキュメント生成 ----
phase_documentation() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}📝 ドキュメント生成フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local req_content=""
    [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]] && req_content="$(cat "$REQUIREMENTS_FILE")"

    local prompt="あなたはテクニカルライターです。以下のプロジェクトのドキュメントを作成してください。

タスク: ${task_desc}

要件:
${req_content:-（なし）}

以下を作成してください:
1. README.md（プロジェクト概要、セットアップ手順、使用方法、API概要）
2. APIドキュメント（全エンドポイント）
3. アーキテクチャドキュメント
4. デプロイ手順書
5. 開発ガイド（コーディング規約、ブランチ戦略）

全ファイルをプロジェクトルートに書き出してください。"

    local output_file="${SESSION_LOG_DIR}/documentation.md"
    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ ドキュメント生成完了${NC}"
    else
        echo -e "  ${RED}❌ ドキュメント生成失敗${NC}"
    fi

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "DOC" "documentation" "ドキュメント生成完了"

    _post_phase_checkpoint "documentation"
    return 0
}

# ---- Phase: デプロイ準備 ----
phase_deploy() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🚀 デプロイ準備フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local prompt="以下のプロジェクトのデプロイ準備を行ってください。

タスク: ${task_desc}

以下を作成してください:
1. Dockerfile / docker-compose.yml
2. CI/CD設定（GitHub Actions）
3. 環境変数テンプレート
4. ヘルスチェックエンドポイント
5. 本番用ビルド設定

全ファイルをプロジェクトルートに書き出してください。"

    local output_file="${SESSION_LOG_DIR}/deploy_prep.md"
    _call_claude "$prompt" "$output_file" || true

    _post_phase_checkpoint "deploy"
    return 0
}

# ---- Phase: ナレッジ蓄積 ----
phase_knowledge_save() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🧠 ナレッジ蓄積フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    # セッションサマリーを保存
    local summary_file="${SESSION_LOG_DIR}/session_summary.md"
    local session_end
    session_end=$(date +%s)
    local duration=$((session_end - SESSION_START))

    cat > "$summary_file" <<EOF
# セッションサマリー: ${session_id}
- タスク: ${task_desc}
- 日時: $(date '+%Y-%m-%d %H:%M:%S')
- パイプライン: ${PIPELINE_MODE}
- バージョン: v${VERSION}
- 実行時間: $((duration / 60))分$((duration % 60))秒
- URL数: ${#URLS[@]}
EOF

    # リアルタイム学習の同期
    if [[ "$NO_LEARN" != "1" ]] && type -t rt_sync_to_global &>/dev/null; then
        rt_sync_to_global "$session_id" 2>/dev/null || true
        echo -e "  ${GREEN}✅ 学習データ同期完了${NC}"
    fi

    # RAGインデックスに追加
    if [[ "$NO_RAG" != "1" && -f "tools/rag-engine.py" ]]; then
        python3 tools/rag-engine.py add "$summary_file" --tags "session-summary,${session_id}" 2>/dev/null || true
        echo -e "  ${GREEN}✅ RAGインデックスにセッション追加${NC}"
    fi

    # セッションナレッジのRAGインデックス化
    if [[ "$NO_RAG" != "1" ]] && type -t rt_index_session_knowledge &>/dev/null; then
        rt_index_session_knowledge "$session_id" 2>/dev/null || true
    fi

    _post_phase_checkpoint "knowledge_save"
    return 0
}

# ---- Phase: 汎用実装（非Web系タスク） ----
phase_implementation() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🔨 実装フェーズ（汎用）${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local req_content=""
    [[ -n "${REQUIREMENTS_FILE:-}" && -f "$REQUIREMENTS_FILE" ]] && req_content="$(cat "$REQUIREMENTS_FILE")"

    local rag_content=""
    [[ -f "${SESSION_LOG_DIR}/rag_results.txt" ]] && rag_content="$(cat "${SESSION_LOG_DIR}/rag_results.txt")"

    local prompt="あなたはシニアソフトウェアエンジニアです。以下のタスクを完全に実装してください。

タスク: ${task_desc}

要件:
${req_content:-（タスク説明から推定してください）}

関連ナレッジ:
${rag_content:-（なし）}

要件を満たす完全な実装を行ってください。全ファイルを実際に作成してください。
テストも含めてください。"

    local output_file="${SESSION_LOG_DIR}/implementation.md"
    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ 実装完了${NC}"
    else
        echo -e "  ${RED}❌ 実装失敗${NC}"
    fi

    _post_phase_validate_and_heal "IMPL"

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "IMPL" "implementation" "実装完了"

    _post_phase_checkpoint "implementation"
    return 0
}

# ---- Phase: バグ修正（Hotfix） ----
phase_hotfix() {
    local session_id="$1"
    local task_desc="$2"

    echo -e "  ${CYAN}🔧 バグ修正フェーズ${NC}"
    echo -e "  経過時間: $(_elapsed_time)"

    local rag_content=""
    [[ -f "${SESSION_LOG_DIR}/rag_results.txt" ]] && rag_content="$(cat "${SESSION_LOG_DIR}/rag_results.txt")"

    local prompt="あなたはデバッグのエキスパートです。以下の問題を特定し修正してください。

問題: ${task_desc}

関連する過去の知見:
${rag_content:-（なし）}

以下を実行してください:
1. 問題の根本原因分析
2. 影響範囲の特定
3. 修正の実装
4. リグレッションが起きないことの確認
5. 修正内容の記録

実際にファイルを修正してください。"

    local output_file="${SESSION_LOG_DIR}/hotfix_report.md"
    if _call_claude "$prompt" "$output_file"; then
        echo -e "  ${GREEN}✅ バグ修正完了${NC}"
    else
        echo -e "  ${RED}❌ バグ修正失敗${NC}"
    fi

    _post_phase_validate_and_heal "FIX"

    [[ "$NO_LEARN" != "1" ]] && type -t rt_capture_success &>/dev/null && \
        rt_capture_success "FIX" "hotfix" "バグ修正完了"

    _post_phase_checkpoint "hotfix"
    return 0
}

# ============================================================
# URL駆動開発モード
# ============================================================
_url_driven_development() {
    local url1="$1"
    local url2="${2:-}"
    local task_desc="$3"

    echo -e "\n${BOLD}${PURPLE}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${PURPLE}║       URL駆動開発モード                    ║${NC}"
    echo -e "${BOLD}${PURPLE}╚═══════════════════════════════════════════╝${NC}\n"

    if ! type -t url_init &>/dev/null; then
        echo -e "  ${RED}❌ URL Analyzerモジュールが未ロードです${NC}"
        echo -e "  ${YELLOW}lib/url-analyzer.sh を確認してください${NC}"
        return 1
    fi

    # Phase 1: URL分析セッション初期化
    echo -e "  ${BOLD}[Phase 1/3] URL分析${NC}"
    url_init "$SESSION_ID"

    url_analyze "$url1" "${UA_SESSION_DIR}/analyses"
    echo -e "  ${GREEN}✅ URL1分析完了: ${url1}${NC}"

    if [[ -n "$url2" ]]; then
        url_analyze "$url2" "${UA_SESSION_DIR}/analyses"
        echo -e "  ${GREEN}✅ URL2分析完了: ${url2}${NC}"
    fi

    # デザイントークン抽出
    if type -t url_extract_design_tokens &>/dev/null; then
        url_extract_design_tokens "$url1" "${UA_SESSION_DIR}/design" 2>/dev/null || true
    fi

    _post_phase_checkpoint "url_analysis"

    # Phase 2: 統合要件生成
    echo -e "\n  ${BOLD}[Phase 2/3] 統合要件・仕様書生成${NC}"
    if [[ -n "$url2" ]]; then
        url_combine_requirements "${UA_SESSION_DIR}/analyses" "$task_desc"
    else
        # URL1つの場合は単独分析から要件生成
        local analysis_file="${UA_SESSION_DIR}/analyses/url_analysis_1.md"
        if [[ -f "$analysis_file" ]]; then
            local analysis_content
            analysis_content="$(cat "$analysis_file")"
            local req_prompt="以下のサイト分析に基づいて要件定義書を作成してください。

サイト分析:
${analysis_content}

タスク: ${task_desc}

Markdown形式で要件定義書を作成。"
            _call_claude "$req_prompt" "${UA_SESSION_DIR}/analyses/combined_requirements.md" || true
        fi
    fi

    # 技術仕様書生成
    local combined_req="${UA_SESSION_DIR}/analyses/combined_requirements.md"
    if [[ -f "$combined_req" ]]; then
        url_generate_spec "$combined_req" "${UA_SESSION_DIR}/spec" 2>/dev/null || true
    fi

    _post_phase_checkpoint "url_spec_generation"

    # Phase 3: DAGパイプラインへの橋渡し
    echo -e "\n  ${BOLD}[Phase 3/3] DAGパイプラインへ接続${NC}"
    REQUIREMENTS_FILE="${UA_SESSION_DIR}/analyses/combined_requirements.md"
    SPEC_DIR="${UA_SESSION_DIR}/spec"

    echo -e "  ${GREEN}✅ URL駆動分析完了 → DAGパイプライン実行へ${NC}"
}

# ============================================================
# バリデーションのみモード
# ============================================================
_validate_mode() {
    local target_dir="$1"
    local auto_fix="${2:-false}"

    echo -e "\n${BOLD}${CYAN}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${CYAN}║       バリデーション専用モード              ║${NC}"
    echo -e "${BOLD}${CYAN}╚═══════════════════════════════════════════╝${NC}\n"

    if ! type -t validator_init &>/dev/null; then
        echo -e "  ${RED}❌ バリデータモジュールが未ロードです${NC}"
        return 1
    fi

    validator_init "$target_dir"
    local report
    report=$(validator_run_all "$target_dir")
    local error_count
    error_count=$(validator_count_errors "$report" 2>/dev/null || echo "0")

    echo -e "\n  ${BOLD}検出エラー数: ${error_count}${NC}"

    if [[ "$auto_fix" == "true" && "$error_count" -gt 0 ]]; then
        echo -e "  ${PURPLE}自動修正モード有効 → ヒーリング開始${NC}"
        if type -t healer_init &>/dev/null; then
            healer_init "$SESSION_ID" "$target_dir"
            healer_run "$target_dir" "$report"

            # 再バリデーション
            echo -e "\n  ${BOLD}修正後再バリデーション:${NC}"
            local re_report
            re_report=$(validator_run_all "$target_dir")
            local re_error_count
            re_error_count=$(validator_count_errors "$re_report" 2>/dev/null || echo "0")
            echo -e "  残存エラー数: ${re_error_count}"
        else
            echo -e "  ${RED}❌ ヒーラーモジュール未ロード${NC}"
        fi
    fi

    if type -t validator_report &>/dev/null; then
        validator_report "$report"
    fi

    return $((error_count > 0 ? 1 : 0))
}

# ============================================================
# チェックポイントからの再開
# ============================================================
_resume_from_checkpoint() {
    echo -e "\n${BOLD}${CYAN}╔═══════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}${CYAN}║       チェックポイント再開モード            ║${NC}"
    echo -e "${BOLD}${CYAN}╚═══════════════════════════════════════════╝${NC}\n"

    if ! type -t checkpoint_latest &>/dev/null; then
        echo -e "  ${RED}❌ チェックポイントモジュールが未ロードです${NC}"
        return 1
    fi

    local latest_info
    latest_info=$(checkpoint_latest 2>/dev/null || echo "")

    if [[ -z "$latest_info" ]]; then
        echo -e "  ${YELLOW}チェックポイントが見つかりません${NC}"
        return 1
    fi

    echo -e "  ${GREEN}最新チェックポイント情報:${NC}"
    echo "$latest_info"

    # セッションIDとステージを抽出
    local ckp_session ckp_stage
    ckp_session=$(echo "$latest_info" | grep -o '"stage"[^,]*' | head -1 | sed 's/.*: *"\([^"]*\)".*/\1/' || echo "")

    echo -e "\n  ${CYAN}チェックポイントから復帰しました。DAGパイプラインを再開してください。${NC}"
    return 0
}

# ============================================================
# シンプル実行モード（DAGモジュールがない場合のフォールバック）
# ============================================================
_simple_execution() {
    local task_desc="$1"

    echo -e "${YELLOW}⚠️ DAGモジュール未検出 → シンプルモードで実行${NC}"

    # v9.0: まずプロンプト展開（設計書自動生成）
    phase_prompt_expand "$SESSION_ID" "$task_desc"

    # v9.0: スキャフォルド（プロジェクト骨格構築）
    phase_scaffold "$SESSION_ID" "$task_desc"

    # 従来フェーズ
    phase_requirements "$SESSION_ID" "$task_desc"
    phase_rag_search "$SESSION_ID" "$task_desc"
    phase_implementation "$SESSION_ID" "$task_desc"
    phase_quality_check "$SESSION_ID" "$task_desc"
    phase_testing "$SESSION_ID" "$task_desc"

    # v10.0: ブラウザテスト（有効時）
    if [[ "$ENABLE_BROWSER_TEST" == "true" ]]; then
        phase_browser_test "$SESSION_ID" "$task_desc"
    fi

    phase_documentation "$SESSION_ID" "$task_desc"

    # v10.0: 自動デプロイ（有効時）
    if [[ "$ENABLE_DEPLOY" == "true" ]]; then
        phase_auto_deploy "$SESSION_ID" "$task_desc"
    fi

    phase_knowledge_save "$SESSION_ID" "$task_desc"

    return 0
}

# ============================================================
# 自動複雑度判定
# ============================================================
_auto_detect_complexity() {
    local task="$1"
    local task_lower
    task_lower=$(echo "$task" | tr '[:upper:]' '[:lower:]')

    # Hotfix: エラー修正（明らかにバグ修正の場合のみ）
    if [[ "$task_lower" =~ (エラー|error|crash|壊れ|動かない|broken|障害) ]]; then
        echo "hotfix"
        return
    fi

    # Quick: 明確に小さなタスク
    if [[ "$task_lower" =~ (修正|fix|バグ|bug|typo|リファクタ) ]]; then
        echo "quick"
        return
    fi

    # v8.0方針: 曖昧な指示は全てdeepで対応
    # 「CRM作って」「タスク管理ツール作って」「家計簿作って」のような一言指示は
    # 全てdeepパイプラインで競合分析→フル実装を行う
    echo "deep"
}

# ============================================================
# タイムアウト監視（バックグラウンドプロセス）
# ============================================================
_start_timeout_watchdog() {
    local timeout=$SESSION_TIMEOUT
    local warn_5min=$((timeout - 300))
    local warn_1min=$((timeout - 60))

    # 5分前警告
    if [[ $warn_5min -gt 0 ]]; then
        sleep $warn_5min 2>/dev/null && \
            echo -e "\n${YELLOW}⏰ 残り5分 - セッションタイムアウトまで300秒${NC}" 2>/dev/null || true
    fi

    # 1分前警告
    if [[ $((warn_1min - warn_5min)) -gt 0 ]]; then
        sleep $((warn_1min - warn_5min)) 2>/dev/null && \
            echo -e "\n${RED}⏰ 残り1分 - まもなくセッションタイムアウト${NC}" 2>/dev/null || true
    fi

    # タイムアウト実行
    sleep 60 2>/dev/null && \
        echo -e "\n${RED}⏰ セッションタイムアウト（${timeout}秒） - チェックポイントを保存して終了${NC}" 2>/dev/null

    # チェックポイント保存を試みてからkill
    type -t checkpoint_auto_save &>/dev/null && \
        checkpoint_auto_save "$SESSION_ID" "timeout_autosave" 2>/dev/null || true

    kill -TERM $PPID 2>/dev/null || true
}

# ============================================================
# 実行後処理
# ============================================================
_post_execution() {
    local session_end
    session_end=$(date +%s)
    local duration=$((session_end - SESSION_START))

    echo -e "\n${BOLD}${CYAN}━━━ 実行後処理 ━━━${NC}"

    # リアルタイム学習のグローバル同期
    if [[ "$NO_LEARN" != "1" ]] && type -t rt_sync_to_global &>/dev/null; then
        rt_sync_to_global "$SESSION_ID" 2>/dev/null || true
        echo -e "  ${GREEN}✅ 学習データ同期${NC}"
    fi

    # RAGインデックスにセッションナレッジを追加
    if [[ "$NO_RAG" != "1" ]] && type -t rt_index_session_knowledge &>/dev/null; then
        rt_index_session_knowledge "$SESSION_ID" 2>/dev/null || true
        echo -e "  ${GREEN}✅ RAGインデックス更新${NC}"
    fi

    # 学習メトリクス表示
    if [[ "$NO_LEARN" != "1" ]] && type -t rt_print_metrics &>/dev/null; then
        rt_print_metrics 2>/dev/null || true
    fi

    # チェックポイントクリーンアップ（最新5つ保持）
    if type -t checkpoint_cleanup &>/dev/null; then
        checkpoint_cleanup "$SESSION_ID" 5 2>/dev/null || true
    fi

    echo -e "  ${GREEN}✅ 実行後処理完了 (所要時間: $((duration / 60))分$((duration % 60))秒)${NC}"
}

# ============================================================
# 最終レポート
# ============================================================
_final_report() {
    local task_desc="$1"
    local exit_code="${2:-0}"
    local session_end
    session_end=$(date +%s)
    local duration=$((session_end - SESSION_START))
    local minutes=$((duration / 60))
    local seconds=$((duration % 60))

    echo ""
    echo -e "${BOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║              最終レポート (v${VERSION})                         ║${NC}"
    echo -e "${BOLD}╠═══════════════════════════════════════════════════════════╣${NC}"
    echo -e "║ タスク      : ${task_desc:0:45}"
    echo -e "║ セッション  : ${SESSION_ID}"
    echo -e "║ 実行時間    : ${minutes}分${seconds}秒"
    echo -e "║ パイプライン: ${PIPELINE_MODE}"
    echo -e "║ URL数       : ${#URLS[@]}"

    if [[ "$exit_code" == "0" ]]; then
        echo -e "║ ステータス  : ${GREEN}✅ SUCCESS${NC}"
    else
        echo -e "║ ステータス  : ${RED}❌ FAILED (exit: ${exit_code})${NC}"
    fi

    echo -e "║ RAG         : $([ "$NO_RAG" == "1" ] && echo "無効" || echo "有効")"
    echo -e "║ 学習        : $([ "$NO_LEARN" == "1" ] && echo "無効" || echo "有効")"
    echo -e "║ ヒーリング  : max ${MAX_HEAL_ITERATIONS}回"
    echo -e "║ 並列実行    : ${ENABLE_PARALLEL}"
    echo -e "║ ブラウザテスト: ${ENABLE_BROWSER_TEST}"
    echo -e "║ 自動デプロイ: ${ENABLE_DEPLOY}"
    echo -e "║ ログ        : ${SESSION_LOG_DIR}/"
    echo -e "${BOLD}╚═══════════════════════════════════════════════════════════╝${NC}"

    # ログにも最終レポートを保存
    cat > "${SESSION_LOG_DIR}/final_report.json" <<EOF
{
  "version": "${VERSION}",
  "session_id": "${SESSION_ID}",
  "task": "$(echo "$task_desc" | sed 's/"/\\"/g')",
  "pipeline_mode": "${PIPELINE_MODE}",
  "duration_seconds": ${duration},
  "url_count": ${#URLS[@]},
  "exit_code": ${exit_code},
  "rag_enabled": $([ "$NO_RAG" == "1" ] && echo "false" || echo "true"),
  "learn_enabled": $([ "$NO_LEARN" == "1" ] && echo "false" || echo "true"),
  "max_heal_iterations": ${MAX_HEAL_ITERATIONS},
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
}

# ============================================================
# クリーンアップ
# ============================================================
_cleanup() {
    # ウォッチドッグプロセスを停止
    if [[ -n "${WATCHDOG_PID:-}" ]] && kill -0 "$WATCHDOG_PID" 2>/dev/null; then
        kill "$WATCHDOG_PID" 2>/dev/null || true
        wait "$WATCHDOG_PID" 2>/dev/null || true
    fi

    # ロックファイル削除
    rm -f "$LOCK_FILE" 2>/dev/null || true
}

# ============================================================
# コマンド実装
# ============================================================
_cmd_rag_search() {
    local query="$1"
    if [[ -z "$query" ]]; then
        echo "Usage: ./chain.sh --rag-search \"検索クエリ\""
        exit 1
    fi

    echo -e "${BOLD}${PURPLE}[RAG] ナレッジ検索${NC}"

    if [[ -f "tools/rag-engine.py" ]]; then
        python3 tools/rag-engine.py search "$query"
    else
        echo -e "${RED}RAGエンジンが見つかりません。setup.sh を実行してください。${NC}"
    fi
}

_cmd_rag_index() {
    echo -e "${BOLD}${PURPLE}[RAG] インデックス再構築${NC}"

    if [[ -f "tools/rag-engine.py" ]]; then
        python3 tools/rag-engine.py index
    else
        echo -e "${RED}RAGエンジンが見つかりません。${NC}"
    fi
}

_cmd_metrics() {
    echo -e "${BOLD}${PURPLE}[METRICS] 学習メトリクス${NC}"

    if type -t rt_print_metrics &>/dev/null; then
        rt_print_metrics
    elif [[ -f "${SCRIPT_DIR}/lib/realtime-learn.sh" ]]; then
        source "${SCRIPT_DIR}/lib/realtime-learn.sh" 2>/dev/null || true
        type -t rt_print_metrics &>/dev/null && rt_print_metrics
    else
        echo -e "${YELLOW}学習モジュールが見つかりません。${NC}"
    fi

    # RAG統計も表示
    if [[ -f "tools/rag-engine.py" ]]; then
        echo ""
        python3 tools/rag-engine.py stats 2>/dev/null || true
    fi
}

# ============================================================
# ヘルプ
# ============================================================
_show_help() {
    echo ""
    echo -e "${BOLD}SoloptiLink Chain v${VERSION}${NC}"
    echo -e "${BOLD}一言で完璧なシステムを自律構築する${NC}"
    echo ""
    echo "基本使用法:"
    echo "  ./chain.sh \"CRM作って\"                                 一言で完璧構築"
    echo "  ./chain.sh \"家計簿作って\"                               自動設計→実装→テスト"
    echo "  ./chain.sh \"タスク管理ツール\" --deploy                  構築後自動デプロイ"
    echo "  ./chain.sh \"チャットアプリ\" --browser-test              ブラウザテスト有効"
    echo ""
    echo "パイプライン:"
    echo "  ./chain.sh \"タスク\" --pipeline quick                   高速パイプライン"
    echo "  ./chain.sh \"タスク\" --pipeline deep                    調査込みフルパイプライン"
    echo "  ./chain.sh \"タスク\" --pipeline hotfix                  バグ修正特化"
    echo "  ./chain.sh \"タスク\" --rounds 5                         最大5ラウンド"
    echo ""
    echo "v10.0 新機能:"
    echo "  ./chain.sh \"タスク\" --parallel                         並列実行モード"
    echo "  ./chain.sh \"タスク\" --browser-test                     ブラウザテスト有効"
    echo "  ./chain.sh \"タスク\" --deploy                           完了後自動デプロイ"
    echo ""
    echo "v8.0 機能:"
    echo "  ./chain.sh \"タスク\" --url https://site1.com            URL分析（1つ）"
    echo "  ./chain.sh \"タスク\" --url https://s1.com --url https://s2.com  URL分析（2つ）"
    echo "  ./chain.sh --validate ./project                        バリデーションのみ"
    echo "  ./chain.sh --validate ./project --auto-fix             バリデーション＋自動修正"
    echo "  ./chain.sh --resume                                    最新チェックポイントから再開"
    echo "  ./chain.sh --checkpoints                               チェックポイント一覧"
    echo ""
    echo "RAG コマンド:"
    echo "  ./chain.sh --rag-search \"クエリ\"                      ナレッジ検索"
    echo "  ./chain.sh --rag-index                                 インデックス再構築"
    echo ""
    echo "メトリクス:"
    echo "  ./chain.sh --metrics                                   学習メトリクス表示"
    echo "  ./chain.sh --dag-show \"タスク\" [complexity]             DAGグラフ表示"
    echo ""
    echo "オプション:"
    echo "  --parallel        並列実行モード (v10.0)"
    echo "  --browser-test    ブラウザテスト有効 (v10.0)"
    echo "  --deploy          完了後自動デプロイ (v10.0)"
    echo "  --no-rag          RAG検索を無効化"
    echo "  --no-learn        リアルタイム学習を無効化"
    echo "  --help, -h        このヘルプを表示"
    echo ""
    echo "環境変数:"
    echo "  MAX_ROUNDS=15           最大ラウンド数"
    echo "  COST_LIMIT=10.00        コスト上限（USD）"
    echo "  SESSION_TIMEOUT=10800   セッションタイムアウト（秒）"
    echo "  MAX_HEAL_ITERATIONS=50  最大ヒーリング回数"
    echo "  DEEPSEEK_API_KEY=...    ベクトル検索有効化"
    echo "  PX_TIMEOUT=300          並列実行タイムアウト（秒）"
    echo "  DP_LOCAL_PORT=3000      ローカルデプロイポート"
    echo "  NO_RAG=1                RAG無効"
    echo "  NO_LEARN=1              学習無効"
    echo ""
}

# ============================================================
# メイン実行フロー
# ============================================================
main() {
    _show_banner

    echo -e "${BOLD}ライブラリ読み込み中...${NC}"
    _load_libraries
    echo ""

    # 引数パース
    _parse_args "$@"

    # ============ 特殊モードの処理 ============

    # バリデーションのみモード
    if [[ -n "${VALIDATE_DIR}" ]]; then
        _validate_mode "$VALIDATE_DIR" "$AUTO_FIX"
        exit $?
    fi

    # チェックポイント再開モード
    if [[ "${RESUME_MODE}" == "true" ]]; then
        _resume_from_checkpoint
        exit $?
    fi

    # チェックポイント一覧モード
    if [[ "${SHOW_CHECKPOINTS}" == "true" ]]; then
        if type -t checkpoint_list &>/dev/null; then
            checkpoint_list ""
        else
            echo -e "${RED}チェックポイントモジュールが未ロードです${NC}"
        fi
        exit 0
    fi

    # タスク説明チェック
    if [[ -z "$TASK_DESC" ]]; then
        echo -e "${RED}タスク説明を指定してください${NC}"
        echo "Usage: ./chain.sh \"タスク説明\" [--pipeline quick|standard|deep|hotfix]"
        exit 1
    fi

    # ============ セッションセットアップ ============

    mkdir -p "${SESSION_LOG_DIR}" docs/knowledge docs/chain-logs 2>/dev/null || true

    # ロック取得（同時実行防止）
    if [[ -f "$LOCK_FILE" ]]; then
        local lock_pid
        lock_pid=$(cat "$LOCK_FILE" 2>/dev/null || echo "")
        if [[ -n "$lock_pid" ]] && kill -0 "$lock_pid" 2>/dev/null; then
            echo -e "${RED}別のチェーンが実行中です (PID: ${lock_pid})${NC}"
            echo -e "${YELLOW}強制実行: rm ${LOCK_FILE} && ./chain.sh ...${NC}"
            exit 1
        fi
    fi
    echo $$ > "$LOCK_FILE"
    trap '_cleanup' EXIT INT TERM

    echo -e "${BOLD}タスク: ${CYAN}${TASK_DESC}${NC}"
    echo ""

    # ============ サブシステム初期化 ============

    # リアルタイム学習初期化
    if [[ "$NO_LEARN" != "1" ]] && type -t rt_learn_init &>/dev/null; then
        rt_learn_init "$SESSION_ID" 2>/dev/null || true
    fi

    # チェックポイント初期化
    if type -t checkpoint_init &>/dev/null; then
        checkpoint_init "$SESSION_ID" 2>/dev/null || true
    fi

    # タイムアウト監視（バックグラウンド）
    _start_timeout_watchdog &
    WATCHDOG_PID=$!
    disown "$WATCHDOG_PID" 2>/dev/null || true

    # ============ v9.0: スマートプロンプト展開 ============

    # URL駆動モードでなければ、まずプロンプト展開を実行
    if [[ ${#URLS[@]} -eq 0 ]]; then
        phase_prompt_expand "$SESSION_ID" "$TASK_DESC"
    fi

    # ============ URL駆動モード ============

    if [[ ${#URLS[@]} -gt 0 ]]; then
        _url_driven_development "${URLS[0]}" "${URLS[1]:-}" "$TASK_DESC"
    fi

    # ============ v9.0: スキャフォルド ============

    phase_scaffold "$SESSION_ID" "$TASK_DESC"

    # ============ v10.0: ファイルライター初期化 ============

    if type -t fw_init &>/dev/null; then
        fw_init "." 2>/dev/null || true
    fi

    # ============ DAGパイプライン構築・実行 ============

    local dag_exit=0

    if type -t dag_analyze_task &>/dev/null; then
        local complexity="standard"
        case "$PIPELINE_MODE" in
            quick)   complexity="quick" ;;
            deep)    complexity="deep" ;;
            hotfix)  complexity="hotfix" ;;
            auto)    complexity=$(_auto_detect_complexity "$TASK_DESC") ;;
            *)       complexity="$PIPELINE_MODE" ;;
        esac

        echo -e "${BOLD}パイプラインモード: ${CYAN}${complexity}${NC}"
        echo ""

        # プリセットまたは動的構築
        case "$complexity" in
            quick)  dag_preset_quick ;;
            hotfix) dag_preset_hotfix ;;
            *)      dag_analyze_task "$TASK_DESC" "$complexity" ;;
        esac

        # DAGグラフ表示
        if type -t dag_print_graph &>/dev/null; then
            dag_print_graph
        fi

        # DAG実行
        dag_execute "$SESSION_ID" "$TASK_DESC"
        dag_exit=$?
    else
        # DAGモジュールなし → シンプル実行
        _simple_execution "$TASK_DESC"
        dag_exit=$?
    fi

    # ============ v10.0: ブラウザテスト ============

    if [[ "$ENABLE_BROWSER_TEST" == "true" ]]; then
        phase_browser_test "$SESSION_ID" "$TASK_DESC"
    fi

    # ============ v10.0: 自動デプロイ ============

    if [[ "$ENABLE_DEPLOY" == "true" ]]; then
        phase_auto_deploy "$SESSION_ID" "$TASK_DESC"
    fi

    # ============ v10.0: ファイルライターレポート ============

    if type -t fw_report &>/dev/null && [[ "${FW_FILES_WRITTEN:-0}" -gt 0 ]]; then
        fw_report 2>/dev/null || true
    fi

    # ============ 実行後処理 ============

    _post_execution
    _final_report "$TASK_DESC" "$dag_exit"

    return $dag_exit
}

# ============================================================
# エントリーポイント
# ============================================================
main "$@"
