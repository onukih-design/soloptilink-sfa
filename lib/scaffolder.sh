#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v9.0 - Project Scaffolder Module
# ============================================================
# prompt-expanderが生成したブループリントとテックスタック情報を元に、
# プロジェクトの骨格を自動構築。ディレクトリ作成・依存インストール・
# ビルドツール設定を行い、コード生成前に動作する基盤を準備する。
# ============================================================

# sourceされるライブラリなので set -euo pipefail は設定しない

# カラー定義（SC_プレフィックスで他モジュールとの衝突を防止）
SC_GREEN='\033[0;32m'  SC_YELLOW='\033[0;33m' SC_RED='\033[0;31m'
SC_CYAN='\033[0;36m'   SC_PURPLE='\033[0;35m' SC_BOLD='\033[1m'
SC_NC='\033[0m'

# スキャフォルダー設定
SCAFFOLD_PROJECT_DIR=""
SCAFFOLD_LOG_DIR=""
SCAFFOLD_TIMEOUT="${SCAFFOLD_TIMEOUT:-120}"

# ============================================================
# ヘルパー関数群
# ============================================================
_sc_log() {
    local level="$1" message="$2" color="${SC_NC}"
    case "$level" in
        INFO|SUCCESS) color="${SC_GREEN}"  ;; WARN) color="${SC_YELLOW}" ;;
        ERROR|FAIL)   color="${SC_RED}"    ;; STEP) color="${SC_CYAN}"   ;;
        SECTION)      color="${SC_PURPLE}" ;;
    esac
    echo -e "  ${color}[SCAFFOLD:${level}]${SC_NC} ${message}"
    [[ -n "$SCAFFOLD_LOG_DIR" ]] && \
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [${level}] ${message}" >> "${SCAFFOLD_LOG_DIR}/scaffolder.log" 2>/dev/null || true
}

_sc_run_cmd() {
    local cmd="$1" description="${2:-コマンド実行}" timeout_sec="${3:-$SCAFFOLD_TIMEOUT}"
    _sc_log "STEP" "${description}"
    local output exit_code
    if command -v timeout &>/dev/null; then
        output=$(timeout "${timeout_sec}" bash -c "$cmd" 2>&1); exit_code=$?
    elif command -v gtimeout &>/dev/null; then
        output=$(gtimeout "${timeout_sec}" bash -c "$cmd" 2>&1); exit_code=$?
    else
        output=$(bash -c "$cmd" 2>&1); exit_code=$?
    fi
    if [[ $exit_code -eq 0 ]]; then _sc_log "SUCCESS" "${description} 完了"
    elif [[ $exit_code -eq 124 ]]; then _sc_log "WARN" "${description} タイムアウト (${timeout_sec}秒)"
    else _sc_log "ERROR" "${description} 失敗 (exit=${exit_code})"; [[ -n "$output" ]] && _sc_log "ERROR" "出力: ${output:0:500}"
    fi
    return $exit_code
}

# ============================================================
# 初期化
# ============================================================
scaffold_init() {
    local project_dir="${1:-.}"
    SCAFFOLD_PROJECT_DIR="$(cd "$project_dir" 2>/dev/null && pwd)" || {
        mkdir -p "$project_dir" 2>/dev/null || { _sc_log "ERROR" "ディレクトリ作成失敗: $project_dir"; return 1; }
        SCAFFOLD_PROJECT_DIR="$(cd "$project_dir" && pwd)"
    }
    SCAFFOLD_LOG_DIR="${SCAFFOLD_PROJECT_DIR}/docs/chain-logs"
    mkdir -p "$SCAFFOLD_LOG_DIR" 2>/dev/null || true
    _sc_log "INFO" "スキャフォルダー初期化: ${SCAFFOLD_PROJECT_DIR}"
}

# ============================================================
# テックスタック検出
# ============================================================
scaffold_detect_stack() {
    local tech_stack_file="$1"
    [[ ! -f "$tech_stack_file" ]] && { echo "unknown"; return 1; }
    local c; c=$(tr '[:upper:]' '[:lower:]' < "$tech_stack_file" 2>/dev/null)
    if echo "$c" | grep -qE '\bnext\.?js\b|nextjs'; then echo "nextjs"
    elif echo "$c" | grep -qE '\bvue\b' && echo "$c" | grep -qE '\bfastapi\b'; then echo "vue-fastapi"
    elif echo "$c" | grep -qE '\breact\b' && echo "$c" | grep -qE '\bexpress\b'; then echo "react-express"
    elif echo "$c" | grep -qE '\bvue\b'; then echo "vue"
    elif echo "$c" | grep -qE '\bfastapi\b'; then echo "python-fastapi"
    elif echo "$c" | grep -qE '\bflask\b'; then echo "python-flask"
    elif echo "$c" | grep -qE '\bstatic\b|html.*css.*js|vanilla'; then echo "static"
    elif echo "$c" | grep -qE '\breact\b'; then echo "react-express"
    else echo "static"; fi
    return 0
}

# ============================================================
# メイン: ブループリントからスキャフォルド
# ============================================================
scaffold_from_blueprint() {
    local blueprint_file="$1" tech_stack_file="$2" project_dir="${3:-$SCAFFOLD_PROJECT_DIR}"
    [[ -z "$project_dir" ]] && { _sc_log "ERROR" "プロジェクトディレクトリが未指定"; return 1; }
    scaffold_init "$project_dir" || return 1
    _sc_log "SECTION" "========== プロジェクトスキャフォルド開始 =========="
    local stack; stack=$(scaffold_detect_stack "$tech_stack_file")
    _sc_log "INFO" "検出されたスタック: ${stack}"

    local result=0
    case "$stack" in
        nextjs)          _scaffold_nextjs "$project_dir" "$blueprint_file"         || result=$? ;;
        react-express)   _scaffold_react_express "$project_dir" "$blueprint_file"  || result=$? ;;
        vue|vue-fastapi) _scaffold_vue "$project_dir" "$blueprint_file"            || result=$? ;;
        python-flask)    _scaffold_python_flask "$project_dir" "$blueprint_file"   || result=$? ;;
        python-fastapi)  _scaffold_python_fastapi "$project_dir" "$blueprint_file" || result=$? ;;
        *)               _scaffold_static "$project_dir" "$blueprint_file"         || result=$? ;;
    esac
    _scaffold_custom_dirs "$project_dir" "$blueprint_file"

    if scaffold_verify "$project_dir"; then
        _sc_log "SUCCESS" "スキャフォルド完了・検証成功: ${stack}"; return 0
    else
        _sc_log "WARN" "スキャフォルド完了、ただし検証で問題検出"; return $result
    fi
}

# ============================================================
# スキャフォルド: Next.js
# ============================================================
_scaffold_nextjs() {
    local project_dir="$1" blueprint_file="$2"
    _sc_log "SECTION" "Next.js プロジェクト生成"
    if ! command -v npx &>/dev/null; then
        _sc_log "WARN" "npx未検出。手動構造にフォールバック"; _scaffold_static "$project_dir" "$blueprint_file"; return $?
    fi
    if [[ ! -f "${project_dir}/package.json" ]]; then
        local tmp="${project_dir}_tmp_$$"
        _sc_run_cmd "npx --yes create-next-app@latest '${tmp}' --typescript --tailwind --eslint --app --use-npm --no-import-alias --yes" \
            "create-next-app 実行" 180
        if [[ -f "${tmp}/package.json" ]]; then
            mkdir -p "$project_dir" 2>/dev/null
            cp -rn "${tmp}/"* "${tmp}/".* "$project_dir/" 2>/dev/null || true
            rm -rf "$tmp" 2>/dev/null
        else
            rm -rf "$tmp" 2>/dev/null
            _sc_log "WARN" "create-next-app 失敗。npm install フォールバック"
            mkdir -p "$project_dir" && _sc_run_cmd "cd '${project_dir}' && npm init -y && npm install --save next react react-dom typescript @types/react @types/node tailwindcss" \
                "Next.js パッケージインストール" 120
        fi
    fi
    local d; for d in src/components src/lib src/api src/hooks src/styles src/types public; do
        mkdir -p "${project_dir}/${d}" 2>/dev/null
    done
    return 0
}

# ============================================================
# スキャフォルド: React + Express
# ============================================================
_scaffold_react_express() {
    local project_dir="$1" blueprint_file="$2"
    _sc_log "SECTION" "React + Express プロジェクト生成"
    mkdir -p "${project_dir}/frontend" "${project_dir}/backend" 2>/dev/null
    # フロントエンド
    if command -v npx &>/dev/null && [[ ! -f "${project_dir}/frontend/package.json" ]]; then
        _sc_run_cmd "cd '${project_dir}/frontend' && npm create vite@latest . -- --template react-ts --yes 2>/dev/null || npm init -y" \
            "フロントエンド(Vite+React)生成" 120
    fi
    # バックエンド
    if command -v npm &>/dev/null && [[ ! -f "${project_dir}/backend/package.json" ]]; then
        _sc_run_cmd "cd '${project_dir}/backend' && npm init -y && npm install --save express cors dotenv" \
            "Express バックエンド生成" 120
    fi
    # server.js スケルトン
    [[ ! -f "${project_dir}/backend/server.js" ]] && cat > "${project_dir}/backend/server.js" << 'EOF'
const express = require('express');
const cors = require('cors');
require('dotenv').config();
const app = express();
const PORT = process.env.PORT || 3001;
app.use(cors());
app.use(express.json());
app.get('/api/health', (req, res) => res.json({ status: 'ok', timestamp: new Date().toISOString() }));
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
EOF
    [[ ! -f "${project_dir}/backend/.env.example" ]] && printf 'PORT=3001\nNODE_ENV=development\nDATABASE_URL=\n' > "${project_dir}/backend/.env.example"
    _sc_log "SUCCESS" "React + Express プロジェクト生成完了"
}

# ============================================================
# スキャフォルド: Vue.js
# ============================================================
_scaffold_vue() {
    local project_dir="$1" blueprint_file="$2"
    _sc_log "SECTION" "Vue.js プロジェクト生成"
    if ! command -v npx &>/dev/null; then
        _sc_log "WARN" "npx未検出。手動構造にフォールバック"; _scaffold_static "$project_dir" "$blueprint_file"; return $?
    fi
    if [[ ! -f "${project_dir}/package.json" ]]; then
        local tmp="${project_dir}_vue_$$"
        _sc_run_cmd "npm create vue@latest '${tmp}' -- --typescript --router --pinia --eslint --yes 2>/dev/null || npm create vite@latest '${tmp}' -- --template vue-ts --yes" \
            "Vue.js プロジェクト生成" 120
        if [[ -f "${tmp}/package.json" ]]; then
            mkdir -p "$project_dir" 2>/dev/null
            cp -rn "${tmp}/"* "${tmp}/".* "$project_dir/" 2>/dev/null || true; rm -rf "$tmp" 2>/dev/null
        else
            rm -rf "$tmp" 2>/dev/null
            _sc_run_cmd "cd '${project_dir}' && npm init -y" "npm init フォールバック"
        fi
    fi
    mkdir -p "${project_dir}/src/components" "${project_dir}/src/views" "${project_dir}/src/stores" 2>/dev/null
    _sc_log "SUCCESS" "Vue.js プロジェクト生成完了"
}

# ============================================================
# スキャフォルド: Python Flask
# ============================================================
_scaffold_python_flask() {
    local project_dir="$1" blueprint_file="$2"
    _sc_log "SECTION" "Python Flask プロジェクト生成"
    command -v python3 &>/dev/null || { _sc_log "ERROR" "python3が見つかりません"; return 1; }
    mkdir -p "${project_dir}/templates" "${project_dir}/static/css" "${project_dir}/static/js" 2>/dev/null
    [[ ! -d "${project_dir}/venv" ]] && _sc_run_cmd "python3 -m venv '${project_dir}/venv'" "venv作成" 60
    [[ ! -f "${project_dir}/requirements.txt" ]] && printf 'flask>=3.0.0\nflask-cors>=4.0.0\npython-dotenv>=1.0.0\nsqlalchemy>=2.0.0\ngunicorn>=21.2.0\n' > "${project_dir}/requirements.txt"
    if [[ ! -f "${project_dir}/app.py" ]]; then
        cat > "${project_dir}/app.py" << 'EOF'
import os
from flask import Flask, jsonify, render_template
from flask_cors import CORS
from dotenv import load_dotenv
load_dotenv()
app = Flask(__name__)
CORS(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/health')
def health():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    app.run(debug=True, port=int(os.environ.get('PORT', 5000)))
EOF
    fi
    [[ ! -f "${project_dir}/.env.example" ]] && printf 'FLASK_ENV=development\nPORT=5000\nDATABASE_URL=\nSECRET_KEY=\n' > "${project_dir}/.env.example"
    [[ -f "${project_dir}/venv/bin/pip" ]] && _sc_run_cmd "'${project_dir}/venv/bin/pip' install -r '${project_dir}/requirements.txt' -q" "Flask依存インストール" 120
    _sc_log "SUCCESS" "Python Flask プロジェクト生成完了"
}

# ============================================================
# スキャフォルド: Python FastAPI
# ============================================================
_scaffold_python_fastapi() {
    local project_dir="$1" blueprint_file="$2"
    _sc_log "SECTION" "Python FastAPI プロジェクト生成"
    command -v python3 &>/dev/null || { _sc_log "ERROR" "python3が見つかりません"; return 1; }
    mkdir -p "${project_dir}/app/routers" "${project_dir}/app/models" "${project_dir}/app/schemas" "${project_dir}/tests" 2>/dev/null
    [[ ! -d "${project_dir}/venv" ]] && _sc_run_cmd "python3 -m venv '${project_dir}/venv'" "venv作成" 60
    [[ ! -f "${project_dir}/requirements.txt" ]] && printf 'fastapi>=0.110.0\nuvicorn[standard]>=0.27.0\npydantic>=2.5.0\npython-dotenv>=1.0.0\nsqlalchemy>=2.0.0\nhttpx>=0.26.0\n' > "${project_dir}/requirements.txt"
    if [[ ! -f "${project_dir}/app/main.py" ]]; then
        cat > "${project_dir}/app/main.py" << 'EOF'
import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
load_dotenv()
app = FastAPI(title="API", version="0.1.0")
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_credentials=True, allow_methods=["*"], allow_headers=["*"])

@app.get("/")
async def root():
    return {"message": "API is running"}

@app.get("/api/health")
async def health():
    return {"status": "ok"}
EOF
    fi
    touch "${project_dir}/app/__init__.py" 2>/dev/null
    [[ ! -f "${project_dir}/.env.example" ]] && printf 'PORT=8000\nDATABASE_URL=\nSECRET_KEY=\n' > "${project_dir}/.env.example"
    [[ -f "${project_dir}/venv/bin/pip" ]] && _sc_run_cmd "'${project_dir}/venv/bin/pip' install -r '${project_dir}/requirements.txt' -q" "FastAPI依存インストール" 120
    _sc_log "SUCCESS" "Python FastAPI プロジェクト生成完了"
}

# ============================================================
# スキャフォルド: 静的サイト
# ============================================================
_scaffold_static() {
    local project_dir="$1" blueprint_file="$2"
    _sc_log "SECTION" "静的サイト プロジェクト生成"
    mkdir -p "${project_dir}/css" "${project_dir}/js" "${project_dir}/images" 2>/dev/null
    [[ ! -f "${project_dir}/index.html" ]] && cat > "${project_dir}/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project</title><link rel="stylesheet" href="css/styles.css">
</head>
<body>
  <div id="app"><h1>Project</h1></div>
  <script src="js/script.js"></script>
</body>
</html>
EOF
    [[ ! -f "${project_dir}/css/styles.css" ]] && cat > "${project_dir}/css/styles.css" << 'EOF'
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; line-height: 1.6; color: #333; }
#app { max-width: 1200px; margin: 0 auto; padding: 2rem; }
EOF
    [[ ! -f "${project_dir}/js/script.js" ]] && cat > "${project_dir}/js/script.js" << 'EOF'
'use strict';
document.addEventListener('DOMContentLoaded', () => { console.log('Application initialized'); });
EOF
    _sc_log "SUCCESS" "静的サイト プロジェクト生成完了"
}

# ============================================================
# カスタムディレクトリ作成（ブループリント解析）
# ============================================================
_scaffold_custom_dirs() {
    local project_dir="$1" blueprint_file="$2"
    [[ ! -f "$blueprint_file" ]] && return 0
    _sc_log "INFO" "ブループリントからカスタムディレクトリを解析"
    local in_dir_section=false dirs_created=0
    while IFS= read -r line; do
        if echo "$line" | grep -qiE '(directory|ディレクトリ|structure|構造|folder|フォルダ)'; then
            in_dir_section=true; continue
        fi
        [[ "$in_dir_section" == true && -z "${line// /}" ]] && { in_dir_section=false; continue; }
        if [[ "$in_dir_section" == true ]]; then
            local dir_path
            dir_path=$(echo "$line" | sed -E 's/^[[:space:]]*[-*#│├└|]+[[:space:]]*//' | sed 's/[[:space:]]*#.*//' | sed 's|/$||' | tr -d '`')
            if [[ -n "$dir_path" && "$dir_path" =~ ^[a-zA-Z0-9_./-]+$ && ! "$dir_path" =~ \.\. ]]; then
                mkdir -p "${project_dir}/${dir_path}" 2>/dev/null && ((dirs_created++))
            fi
        fi
    done < "$blueprint_file"
    _sc_log "INFO" "カスタムディレクトリ ${dirs_created}個 作成"
}

# ============================================================
# プロジェクト検証
# ============================================================
scaffold_verify() {
    local project_dir="${1:-$SCAFFOLD_PROJECT_DIR}"
    [[ -z "$project_dir" || ! -d "$project_dir" ]] && { _sc_log "ERROR" "検証対象ディレクトリが存在しません"; return 1; }
    _sc_log "SECTION" "プロジェクト構造を検証中"
    local checks_passed=0 checks_total=0

    if [[ -f "${project_dir}/package.json" ]]; then
        ((checks_total++)); ((checks_passed++))
        _sc_log "INFO" "package.json 検出 - Node.jsプロジェクト"
        if [[ ! -d "${project_dir}/node_modules" ]] && command -v npm &>/dev/null; then
            ((checks_total++))
            _sc_run_cmd "cd '${project_dir}' && npm install --no-audit --no-fund 2>&1" "npm install 検証" "$SCAFFOLD_TIMEOUT" && ((checks_passed++))
        fi
    elif [[ -f "${project_dir}/requirements.txt" ]]; then
        ((checks_total++)); ((checks_passed++))
        _sc_log "INFO" "requirements.txt 検出 - Pythonプロジェクト"
        if [[ -f "${project_dir}/venv/bin/python" ]]; then
            ((checks_total++))
            _sc_run_cmd "'${project_dir}/venv/bin/pip' check 2>&1" "pip依存関係チェック" 30 && ((checks_passed++))
        fi
    elif [[ -f "${project_dir}/index.html" ]]; then
        ((checks_total++)); ((checks_passed++))
        _sc_log "INFO" "index.html 検出 - 静的サイト"
    else
        _sc_log "WARN" "主要ファイルが見つかりません (package.json / requirements.txt / index.html)"; return 1
    fi

    local file_count
    file_count=$(find "$project_dir" -maxdepth 3 -type f ! -path "*/node_modules/*" ! -path "*/.git/*" ! -path "*/venv/*" ! -path "*/__pycache__/*" 2>/dev/null | wc -l | tr -d ' ')
    _sc_log "INFO" "プロジェクトファイル数: ${file_count}"
    if [[ $checks_total -gt 0 && $checks_passed -eq $checks_total ]]; then
        _sc_log "SUCCESS" "検証完了: ${checks_passed}/${checks_total} チェック通過"; return 0
    else
        _sc_log "WARN" "検証結果: ${checks_passed}/${checks_total} チェック通過"; return 1
    fi
}

# ============================================================
_sc_log "INFO" "scaffolder.sh v9.0 ロード完了"
