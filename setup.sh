#!/usr/bin/env bash
# ╔═══════════════════════════════════════════════════════════╗
# ║  SoloptiLink Chain v10.0 - One-Click Setup               ║
# ║  Smart Prompt × Scaffold × Parallel × Browser × Deploy   ║
# ╚═══════════════════════════════════════════════════════════╝
set -euo pipefail

readonly VERSION="10.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# カラー定義
readonly RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m'
readonly BOLD='\033[1m' DIM='\033[2m' NC='\033[0m'

# 結果トラッカー
declare -a CHECK_RESULTS=()
WARN_COUNT=0; FAIL_COUNT=0

_result_ok()   { CHECK_RESULTS+=("${GREEN}OK${NC}  $1"); }
_result_warn() { CHECK_RESULTS+=("${YELLOW}WARN${NC} $1"); WARN_COUNT=$((WARN_COUNT + 1)); }
_result_fail() { CHECK_RESULTS+=("${RED}FAIL${NC} $1"); FAIL_COUNT=$((FAIL_COUNT + 1)); }

# バナー
echo ""
echo -e "${BOLD}${PURPLE}"
echo "  ╔════════════════════════════════════════════════════════╗"
echo "  ║                                                        ║"
echo "  ║   SoloptiLink Chain v${VERSION} - Setup                  ║"
echo "  ║   一言で完璧なシステムを自律構築する                  ║"
echo "  ║                                                        ║"
echo "  ╚════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# [1/10] Claude Code CLI チェック
echo -e "${BOLD}[1/10] Claude Code CLI チェック...${NC}"
if command -v claude &>/dev/null; then
    claude_ver=$(claude --version 2>/dev/null || echo "installed")
    echo -e "  ${GREEN}OK${NC} Claude Code: ${claude_ver}"
    _result_ok "Claude Code CLI"
else
    echo -e "  ${YELLOW}WARN${NC} Claude Code CLI が見つかりません"
    echo -e "  ${DIM}  インストール: npm install -g @anthropic-ai/claude-code${NC}"
    _result_warn "Claude Code CLI (未インストール)"
fi

# [2/10] Python3 チェック
echo -e "${BOLD}[2/10] Python3 チェック...${NC}"
if command -v python3 &>/dev/null; then
    py_ver=$(python3 --version 2>&1 | awk '{print $2}')
    py_major=$(echo "$py_ver" | cut -d. -f1)
    py_minor=$(echo "$py_ver" | cut -d. -f2)
    if (( py_major >= 3 && py_minor >= 8 )); then
        echo -e "  ${GREEN}OK${NC} Python ${py_ver}"
        _result_ok "Python3 (${py_ver})"
    else
        echo -e "  ${YELLOW}WARN${NC} Python ${py_ver} (3.8+ 推奨)"
        _result_warn "Python3 (${py_ver}, 3.8+ 推奨)"
    fi
else
    echo -e "  ${YELLOW}WARN${NC} Python3 未検出 (RAGエンジンに必要)"
    echo -e "  ${DIM}  --no-rag モードで動作可能${NC}"
    _result_warn "Python3 (未インストール)"
fi

# [3/10] Git チェック
echo -e "${BOLD}[3/10] Git チェック...${NC}"
if command -v git &>/dev/null; then
    git_ver=$(git --version | head -1)
    echo -e "  ${GREEN}OK${NC} ${git_ver}"
    _result_ok "Git"
else
    echo -e "  ${RED}FAIL${NC} Git が見つかりません (必須)"
    _result_fail "Git (未インストール)"
fi

# [4/10] Bash バージョンチェック
echo -e "${BOLD}[4/10] Bash バージョンチェック...${NC}"
bash_ver="${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}"
if (( BASH_VERSINFO[0] >= 4 )); then
    echo -e "  ${GREEN}OK${NC} Bash ${bash_ver}"
    _result_ok "Bash (${bash_ver})"
else
    echo -e "  ${YELLOW}WARN${NC} Bash ${bash_ver} (4.0+ 推奨)"
    if [[ -x /opt/homebrew/bin/bash ]]; then
        hb_ver=$(/opt/homebrew/bin/bash --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
        echo -e "  ${CYAN}TIP${NC}  /opt/homebrew/bin/bash (${hb_ver}) が利用可能です"
        echo -e "  ${DIM}  /opt/homebrew/bin/bash ./chain.sh で実行してください${NC}"
    else
        echo -e "  ${DIM}  アップグレード: brew install bash${NC}"
    fi
    _result_warn "Bash (${bash_ver}, 4.0+ 推奨)"
fi

# [5/10] Node.js チェック (v8.0 新規)
echo -e "${BOLD}[5/10] Node.js チェック...${NC}"
if command -v node &>/dev/null; then
    node_ver=$(node --version 2>/dev/null)
    echo -e "  ${GREEN}OK${NC} Node.js ${node_ver}"
    _result_ok "Node.js (${node_ver})"
else
    echo -e "  ${YELLOW}WARN${NC} Node.js 未検出 (Web開発プロジェクトで推奨)"
    _result_warn "Node.js (未インストール)"
fi
if command -v npm &>/dev/null; then
    npm_ver=$(npm --version 2>/dev/null)
    echo -e "  ${GREEN}OK${NC} npm ${npm_ver}"
    _result_ok "npm (${npm_ver})"
else
    echo -e "  ${YELLOW}WARN${NC} npm 未検出"
    _result_warn "npm (未インストール)"
fi

# [6/10] ディレクトリ構造の初期化
echo -e "${BOLD}[6/10] ディレクトリ構造の初期化...${NC}"
dirs_created=0
for dir in docs/knowledge docs/chain-logs docs/chain-logs/checkpoints \
    plugins/agents plugins/rules plugins/hooks plugins/templates plugins/pipelines; do
    if [[ ! -d "${SCRIPT_DIR}/${dir}" ]]; then
        mkdir -p "${SCRIPT_DIR}/${dir}"
        dirs_created=$((dirs_created + 1))
    fi
done
if [[ ! -d "${HOME}/.soloptilink/knowledge" ]]; then
    mkdir -p "${HOME}/.soloptilink/knowledge"
    dirs_created=$((dirs_created + 1))
fi
if (( dirs_created > 0 )); then
    echo -e "  ${GREEN}OK${NC} ${dirs_created} ディレクトリ作成"
else
    echo -e "  ${GREEN}OK${NC} ディレクトリ構造は既存"
fi
_result_ok "ディレクトリ構造"

# [7/10] 実行権限の設定
echo -e "${BOLD}[7/10] 実行権限の設定...${NC}"
[[ -f "${SCRIPT_DIR}/chain.sh" ]] && chmod +x "${SCRIPT_DIR}/chain.sh"
chmod +x "${SCRIPT_DIR}"/tools/*.py 2>/dev/null || true
chmod +x "${SCRIPT_DIR}"/lib/*.sh   2>/dev/null || true
echo -e "  ${GREEN}OK${NC} chain.sh, tools/*.py, lib/*.sh"
_result_ok "実行権限"

# [8/10] Git リポジトリ チェック
echo -e "${BOLD}[8/10] Git リポジトリ チェック...${NC}"
cd "${SCRIPT_DIR}"
if [[ ! -d ".git" ]]; then
    git init -q
    git add -A
    git commit -q -m "initial: SoloptiLink Chain v${VERSION} setup" --allow-empty
    echo -e "  ${GREEN}OK${NC} Git リポジトリを初期化しました"
    _result_ok "Git リポジトリ (新規初期化)"
else
    echo -e "  ${GREEN}OK${NC} Git リポジトリ既存"
    _result_ok "Git リポジトリ (既存)"
fi

# [9/10] RAG初期インデックス構築
echo -e "${BOLD}[9/10] RAG初期インデックス構築...${NC}"
if command -v python3 &>/dev/null && [[ -f "${SCRIPT_DIR}/tools/rag-engine.py" ]]; then
    if python3 "${SCRIPT_DIR}/tools/rag-engine.py" index 2>/dev/null; then
        echo -e "  ${GREEN}OK${NC} RAGインデックス構築完了"
        _result_ok "RAGインデックス"
    else
        echo -e "  ${YELLOW}WARN${NC} RAGインデックス構築スキップ (後で --rag-index で実行可能)"
        _result_warn "RAGインデックス"
    fi
else
    echo -e "  ${YELLOW}WARN${NC} Python3 または rag-engine.py 未検出 → RAG無効"
    _result_warn "RAGインデックス (スキップ)"
fi
if [[ -n "${DEEPSEEK_API_KEY:-}" ]]; then
    echo -e "  ${GREEN}OK${NC} DEEPSEEK_API_KEY: 設定済み (ベクトル検索有効)"
else
    echo -e "  ${DIM}  DEEPSEEK_API_KEY 未設定 → BM25フォールバック検索${NC}"
    echo -e "  ${DIM}  有効化: export DEEPSEEK_API_KEY=your_key${NC}"
fi

# [10/10] v7-v10 全モジュール検証
echo -e "${BOLD}[10/10] v7.0〜v10.0 全モジュール検証...${NC}"
v8_modules=(
    "dag-pipeline.sh:DAG動的パイプライン:v7.0"
    "realtime-learn.sh:リアルタイム学習:v7.0"
    "url-analyzer.sh:URL解析エンジン:v8.0"
    "validator.sh:5層バリデーション:v8.0"
    "qa-engine.sh:網羅的QAエンジン:v8.0"
    "healer.sh:継続的自動修復:v8.0"
    "checkpoint.sh:チェックポイント管理:v8.0"
    "prompt-expander.sh:スマートプロンプト展開:v9.0"
    "scaffolder.sh:プロジェクトスキャフォルダー:v9.0"
    "file-writer.sh:インテリジェントファイルライター:v9.0"
    "parallel-exec.sh:並列実行エンジン:v10.0"
    "browser-test.sh:ブラウザテスト:v10.0"
    "auto-deploy.sh:自動デプロイ:v10.0"
)
mod_ok=0; mod_fail=0
for entry in "${v8_modules[@]}"; do
    IFS=':' read -r file label ver <<< "$entry"
    filepath="${SCRIPT_DIR}/lib/${file}"
    if [[ -f "$filepath" ]]; then
        if bash -n "$filepath" 2>/dev/null; then
            echo -e "  ${GREEN}OK${NC} [${ver}] ${label} (${file})"
            mod_ok=$((mod_ok + 1))
        else
            echo -e "  ${RED}FAIL${NC} [${ver}] ${label} - 構文エラー"
            mod_fail=$((mod_fail + 1))
        fi
    else
        echo -e "  ${RED}FAIL${NC} [${ver}] ${label} - ファイル未検出"
        mod_fail=$((mod_fail + 1))
    fi
done
if (( mod_fail == 0 )); then
    echo -e "  ${GREEN}全 ${mod_ok} モジュール正常${NC}"
    _result_ok "v8.0 モジュール (${mod_ok}/${mod_ok})"
else
    echo -e "  ${YELLOW}${mod_ok} 正常 / ${mod_fail} 失敗${NC}"
    _result_warn "v8.0 モジュール (${mod_ok}/$((mod_ok + mod_fail)))"
fi

# 最終サマリー
echo ""
echo -e "${BOLD}${PURPLE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${PURPLE}║          SoloptiLink Chain v${VERSION} - Setup Result         ║${NC}"
echo -e "${BOLD}${PURPLE}╠════════════════════════════════════════════════════════╣${NC}"
for r in "${CHECK_RESULTS[@]}"; do
    printf "  ${PURPLE}║${NC} %-60b${PURPLE}║${NC}\n" "$r"
done
echo -e "${BOLD}${PURPLE}╠════════════════════════════════════════════════════════╣${NC}"
if (( FAIL_COUNT == 0 && WARN_COUNT == 0 )); then
    echo -e "${BOLD}${PURPLE}║${NC}  ${GREEN}ALL CLEAR - セットアップ完了${NC}                          ${PURPLE}║${NC}"
elif (( FAIL_COUNT == 0 )); then
    echo -e "${BOLD}${PURPLE}║${NC}  ${YELLOW}WARN x${WARN_COUNT} - 一部警告あり（動作可能）${NC}                   ${PURPLE}║${NC}"
else
    echo -e "${BOLD}${PURPLE}║${NC}  ${RED}FAIL x${FAIL_COUNT} / WARN x${WARN_COUNT} - 要確認${NC}                        ${PURPLE}║${NC}"
fi
echo -e "${BOLD}${PURPLE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}v10.0 使い方:${NC}"
echo ""
echo -e "  ${CYAN}# 一言で完璧構築 (v9.0+ メイン機能)${NC}"
echo -e "  ./chain.sh \"CRM作って\""
echo -e "  ./chain.sh \"家計簿アプリ作って\""
echo -e "  ./chain.sh \"タスク管理ツール作って\" --deploy"
echo ""
echo -e "  ${CYAN}# URL駆動開発 (v8.0)${NC}"
echo -e "  ./chain.sh --url \"https://example.com\" \"このサイトを参考にシステム構築\""
echo -e "  ./chain.sh --url \"https://a.com\" --url \"https://b.com\" \"2サイト統合\""
echo ""
echo -e "  ${CYAN}# v10.0 新機能${NC}"
echo -e "  ./chain.sh \"チャットアプリ\" --parallel           # 並列実行"
echo -e "  ./chain.sh \"ECサイト\" --browser-test             # ブラウザテスト"
echo -e "  ./chain.sh \"ブログ\" --deploy                     # 自動デプロイ"
echo ""
echo -e "  ${CYAN}# バリデーション & 自動修復${NC}"
echo -e "  ./chain.sh --validate ./src"
echo -e "  ./chain.sh --validate ./src --auto-fix"
echo ""
echo -e "  ${CYAN}# チェックポイント再開${NC}"
echo -e "  ./chain.sh --resume"
echo -e "  ./chain.sh --checkpoints"
echo ""
echo -e "  ${CYAN}# RAG / メトリクス${NC}"
echo -e "  ./chain.sh --rag-search \"認証 エラー\""
echo -e "  ./chain.sh --metrics"
echo -e "  ./chain.sh --help"
echo ""
echo -e "${PURPLE}SoloptiLink Chain v${VERSION}${NC} | ${DIM}一言で完璧なシステムを自律構築${NC}"
echo ""
