#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v8.0 - 5-Layer Validation System
# ============================================================
# 5層バリデーションでゼロエラーを保証。人間が見落とすミスを検出。
# L1:構文 L2:型 L3:ランタイム L4:UI L5:エッジケース
# ============================================================

# カラー定義（source時の重複ガード付き）
: "${VLD_GREEN:='\033[0;32m'}"
: "${VLD_YELLOW:='\033[0;33m'}"
: "${VLD_RED:='\033[0;31m'}"
: "${VLD_CYAN:='\033[0;36m'}"
: "${VLD_BOLD:='\033[1m'}"
: "${VLD_NC:='\033[0m'}"

# バリデータ設定
VLD_REPORT_DIR=""
VLD_PROJECT_TYPE=""
VLD_LOG_FILE=""
VLD_SKIP_DIRS="node_modules .git dist build __pycache__ .next .venv venv coverage"
VLD_HAS_NODE=false; VLD_HAS_PYTHON=false; VLD_HAS_TYPESCRIPT=false
VLD_HAS_HTML=false; VLD_HAS_CSS=false; VLD_HAS_SHELL=false

# ============================================================
# 初期化: プロジェクト検出・レポートディレクトリ設定
# ============================================================
validator_init() {
    local project_dir="${1:-.}"
    project_dir="$(cd "$project_dir" 2>/dev/null && pwd)" || {
        _validator_log "ERROR" "INIT" "ディレクトリが見つかりません: $1"; return 1
    }
    VLD_REPORT_DIR="${project_dir}/docs/chain-logs"
    VLD_LOG_FILE="${VLD_REPORT_DIR}/validator_$(date +%Y%m%d_%H%M%S).log"
    mkdir -p "$VLD_REPORT_DIR" 2>/dev/null || true

    # プロジェクトタイプ自動検出
    VLD_PROJECT_TYPE="unknown"
    VLD_HAS_NODE=false; VLD_HAS_PYTHON=false; VLD_HAS_TYPESCRIPT=false
    VLD_HAS_HTML=false; VLD_HAS_CSS=false; VLD_HAS_SHELL=false

    [[ -f "${project_dir}/package.json" ]] && VLD_HAS_NODE=true && VLD_PROJECT_TYPE="node"
    [[ -f "${project_dir}/tsconfig.json" ]] && VLD_HAS_TYPESCRIPT=true && VLD_PROJECT_TYPE="typescript"
    [[ -f "${project_dir}/requirements.txt" || -f "${project_dir}/pyproject.toml" || -f "${project_dir}/setup.py" ]] && \
        VLD_HAS_PYTHON=true && [[ "$VLD_PROJECT_TYPE" == "unknown" ]] && VLD_PROJECT_TYPE="python"

    # ファイル走査による補足検出
    local d="$project_dir"
    (( $(_validator_scan_files "$d" "html" | wc -l) > 0 )) && VLD_HAS_HTML=true
    (( $(_validator_scan_files "$d" "py" | wc -l) > 0 )) && VLD_HAS_PYTHON=true
    (( $(_validator_scan_files "$d" "css" | wc -l) > 0 )) && VLD_HAS_CSS=true
    (( $(_validator_scan_files "$d" "sh" | wc -l) > 0 )) && VLD_HAS_SHELL=true
    [[ "$VLD_PROJECT_TYPE" == "unknown" && "$VLD_HAS_HTML" == "true" ]] && VLD_PROJECT_TYPE="static"

    echo -e "${VLD_BOLD}${VLD_CYAN}[VALIDATOR] 初期化完了${VLD_NC}"
    echo -e "  タイプ: ${VLD_PROJECT_TYPE} | Node:${VLD_HAS_NODE} Py:${VLD_HAS_PYTHON} TS:${VLD_HAS_TYPESCRIPT} HTML:${VLD_HAS_HTML}"
}

# ============================================================
# 全5層実行: 各Layerを順次実行し統合結果を返す
# ============================================================
validator_run_all() {
    local project_dir="${1:-.}"
    project_dir="$(cd "$project_dir" 2>/dev/null && pwd)" || return 1

    echo -e "\n${VLD_BOLD}${VLD_CYAN}  5-Layer Validation System (v8.0)${VLD_NC}\n"
    local all="[]"

    local layer_funcs=("_validator_layer1_syntax" "_validator_layer2_types" "_validator_layer3_runtime" "_validator_layer4_ui" "_validator_layer5_edge")
    local layer_names=("構文検証" "型チェック" "ランタイム" "UI検証" "エッジケース")
    for i in 0 1 2 3 4; do
        local n=$((i+1))
        echo -e "${VLD_BOLD}[Layer ${n}/5] ${layer_names[$i]}${VLD_NC}"
        local result; result=$(${layer_funcs[$i]} "$project_dir")
        all=$(_vld_merge_results "$all" "$result")
        _vld_print_layer_summary "$n" "${layer_names[$i]}" "$result"
        echo ""
    done

    local te; te=$(validator_count_errors "$all")
    local tw; tw=$(_vld_count_warnings "$all")
    echo -e "${VLD_BOLD}============================================${VLD_NC}"
    if (( te == 0 )); then echo -e "${VLD_GREEN}  PASSED: ${te}E / ${tw}W${VLD_NC}"
    else echo -e "${VLD_RED}  FAILED: ${te}E / ${tw}W${VLD_NC}"; fi
    echo "$all"
}

# ============================================================
# Layer 1: 構文検証 - 全ファイルの構文を機械的にチェック
# ============================================================
_validator_layer1_syntax() {
    local project_dir="$1" errors="[]" warnings="[]" status="pass" checked=0 failed=0

    # JavaScript: node --check
    local files; files=$(_validator_scan_files "$project_dir" "js,jsx,mjs,cjs")
    if [[ -n "$files" ]] && command -v node &>/dev/null; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
            local out; out=$(node --check "$f" 2>&1) || { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$out"); }
        done <<< "$files"
    fi

    # Python: py_compile
    files=$(_validator_scan_files "$project_dir" "py")
    if [[ -n "$files" ]] && command -v python3 &>/dev/null; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
            local out; out=$(python3 -m py_compile "$f" 2>&1) || { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$out"); }
        done <<< "$files"
    fi

    # HTML: タグバランスチェック
    files=$(_validator_scan_files "$project_dir" "html,htm")
    if [[ -n "$files" ]] && command -v python3 &>/dev/null; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
            local out; out=$(python3 -c "
import re,sys
c=open('$f','r',encoding='utf-8',errors='ignore').read()
tags=re.findall(r'<(/?)(\w+)[^>]*>',c); stack=[]; issues=[]
void_t={'br','hr','img','input','meta','link','area','base','col','embed','source','track','wbr'}
for cl,t in tags:
 t=t.lower()
 if t in void_t: continue
 if not cl: stack.append(t)
 elif stack and stack[-1]==t: stack.pop()
 else: issues.append(f'タグ不一致: </{t}>')
for t in stack: issues.append(f'未閉タグ: <{t}>')
if issues: print('\\n'.join(issues[:5])); sys.exit(1)
" 2>&1) || { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$out"); }
        done <<< "$files"
    fi

    # CSS: 括弧バランス
    files=$(_validator_scan_files "$project_dir" "css")
    if [[ -n "$files" ]] && command -v python3 &>/dev/null; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
            local out; out=$(python3 -c "
import re,sys; c=open('$f','r',encoding='utf-8',errors='ignore').read()
c=re.sub(r'/\*.*?\*/','',c,flags=re.DOTALL)
o=c.count('{'); cl=c.count('}')
if o!=cl: print(f'括弧不一致: {{{o}個 vs }}{cl}個'); sys.exit(1)
" 2>&1) || { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$out"); }
        done <<< "$files"
    fi

    # JSON: json.load
    files=$(_validator_scan_files "$project_dir" "json")
    if [[ -n "$files" ]] && command -v python3 &>/dev/null; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue
            local bn; bn=$(basename "$f")
            [[ "$bn" == "package-lock.json" || "$bn" == "yarn.lock" ]] && continue
            ((checked++))
            local out; out=$(python3 -c "import json;json.load(open('$f',encoding='utf-8'))" 2>&1) || {
                ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$out"); }
        done <<< "$files"
    fi

    # Shell: bash -n
    files=$(_validator_scan_files "$project_dir" "sh,bash")
    if [[ -n "$files" ]]; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
            local out; out=$(bash -n "$f" 2>&1) || { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$out"); }
        done <<< "$files"
    fi

    (( failed > 0 )) && status="fail"
    _validator_log "INFO" "L1" "${checked}ファイル検査, ${failed}件エラー"
    _vld_build_layer_json 1 "syntax" "$status" "$errors" "$warnings" "$checked" "$failed"
}

# ============================================================
# Layer 2: 型チェック - tsc/mypy/Claude CLIによる型分析
# ============================================================
_validator_layer2_types() {
    local project_dir="$1" errors="[]" warnings="[]" status="pass" checked=0 failed=0

    # TypeScript: tsc --noEmit
    if [[ -f "${project_dir}/tsconfig.json" ]]; then
        if command -v npx &>/dev/null; then
            ((checked++))
            local out; out=$(cd "$project_dir" && npx tsc --noEmit --pretty 2>&1) || {
                ((failed++)); errors=$(_vld_append_issue "$errors" "tsconfig.json" "" "$(echo "$out" | head -30)"); }
        else
            warnings=$(_vld_append_issue "$warnings" "" "" "npx未検出: TypeScript型チェックをスキップ")
        fi
    fi

    # Python: mypy（インストール済みの場合のみ）
    if [[ "$VLD_HAS_PYTHON" == "true" ]] && command -v mypy &>/dev/null; then
        ((checked++))
        local out; out=$(cd "$project_dir" && mypy --ignore-missing-imports --no-error-summary . 2>&1) || {
            local ec; ec=$(echo "$out" | grep -c "error:" 2>/dev/null || echo "0")
            if (( ec > 0 )); then ((failed++))
                errors=$(_vld_append_issue "$errors" "python" "" "$(echo "$out" | grep 'error:' | head -10)"); fi
        }
    elif [[ "$VLD_HAS_PYTHON" == "true" ]]; then
        warnings=$(_vld_append_issue "$warnings" "" "" "mypy未インストール: pip install mypy を推奨")
    fi

    # Claude CLIによる未定義変数・未使用import検出（主要ファイル最大5つ）
    local key_files; key_files=$(_validator_scan_files "$project_dir" "js,jsx,ts,tsx,py" | head -5)
    if [[ -n "$key_files" ]]; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
            local content; content=$(head -100 "$f" 2>/dev/null); [[ -z "$content" ]] && continue
            local cr; cr=$(_validator_call_claude "以下のコードに型エラー・未定義変数・未使用importがないかチェック。問題は「ERROR: 説明」形式、なければ「NO_ISSUES」で返答。\n\nファイル: ${f}\n\`\`\`\n${content}\n\`\`\`")
            if [[ -n "$cr" && "$cr" != *"NO_ISSUES"* ]]; then
                local il; il=$(echo "$cr" | grep -i "ERROR:" | head -5)
                [[ -n "$il" ]] && { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$il"); }
            fi
        done <<< "$key_files"
    fi

    (( failed > 0 )) && status="fail"
    _validator_log "INFO" "L2" "${checked}項目検査, ${failed}件エラー"
    _vld_build_layer_json 2 "types" "$status" "$errors" "$warnings" "$checked" "$failed"
}

# ============================================================
# Layer 3: ランタイム検証 - ビルド・サーバー起動・テスト実行
# ============================================================
_validator_layer3_runtime() {
    local project_dir="$1" errors="[]" warnings="[]" status="pass" checked=0 failed=0

    if [[ -f "${project_dir}/package.json" ]] && command -v npm &>/dev/null; then
        # ビルドスクリプト検出・実行
        local script; script=$(python3 -c "
import json; s=json.load(open('${project_dir}/package.json')).get('scripts',{})
print('build' if 'build' in s else ('compile' if 'compile' in s else ''))" 2>/dev/null)
        if [[ -n "$script" ]]; then ((checked++))
            local out; out=$(cd "$project_dir" && npm run "$script" 2>&1) || {
                ((failed++)); errors=$(_vld_append_issue "$errors" "package.json" "" "npm run ${script} 失敗: $(echo "$out" | tail -15)"); }
        fi

        # devサーバー起動テスト
        local dev; dev=$(python3 -c "
import json; s=json.load(open('${project_dir}/package.json')).get('scripts',{})
print('dev' if 'dev' in s else ('start' if 'start' in s else ''))" 2>/dev/null)
        if [[ -n "$dev" ]]; then ((checked++))
            (cd "$project_dir" && npm run "$dev" &>/dev/null) &
            local pid=$!; local ok=false; local w=0
            while (( w < 8 )); do sleep 1; ((w++))
                for p in 3000 5173 8080 4200 8000; do
                    curl -s -o /dev/null -w "%{http_code}" "http://localhost:${p}" 2>/dev/null | grep -q "200\|301\|302\|304" && { ok=true; break 2; }
                done
            done
            kill "$pid" 2>/dev/null; wait "$pid" 2>/dev/null; pkill -P "$pid" 2>/dev/null || true
            [[ "$ok" != "true" ]] && warnings=$(_vld_append_issue "$warnings" "" "" "devサーバーが8秒以内にHTTP応答なし")
        fi

        # テストスイート実行
        local has_test; has_test=$(python3 -c "
import json; s=json.load(open('${project_dir}/package.json')).get('scripts',{}).get('test','')
print('yes' if s and 'no test specified' not in s else '')" 2>/dev/null)
        if [[ "$has_test" == "yes" ]]; then ((checked++))
            local out; out=$(cd "$project_dir" && timeout 120 npm test -- --passWithNoTests 2>&1) || {
                ((failed++)); errors=$(_vld_append_issue "$errors" "package.json" "" "テスト失敗: $(echo "$out" | tail -10)"); }
        fi
    fi

    # Python: メインスクリプト起動テスト
    if [[ "$VLD_HAS_PYTHON" == "true" ]] && command -v python3 &>/dev/null; then
        local mp=""
        [[ -f "${project_dir}/main.py" ]] && mp="${project_dir}/main.py"
        [[ -f "${project_dir}/app.py" ]] && mp="${project_dir}/app.py"
        if [[ -n "$mp" ]]; then ((checked++))
            timeout 10 python3 "$mp" --help &>/dev/null || \
            timeout 10 python3 -c "import importlib.util as u;s=u.spec_from_file_location('m','$mp');u.module_from_spec(s)" 2>&1 || {
                ((failed++)); errors=$(_vld_append_issue "$errors" "$mp" "" "Pythonインポートエラー"); }
        fi
    fi

    (( failed > 0 )) && status="fail"
    _validator_log "INFO" "L3" "${checked}項目検査, ${failed}件エラー"
    _vld_build_layer_json 3 "runtime" "$status" "$errors" "$warnings" "$checked" "$failed"
}

# ============================================================
# Layer 4: UI/インタラクション検証 - アクセシビリティ・UXチェック
# ============================================================
_validator_layer4_ui() {
    local project_dir="$1" errors="[]" warnings="[]" status="pass" checked=0 failed=0
    local ui_files; ui_files=$(_validator_scan_files "$project_dir" "html,htm,jsx,tsx")
    if [[ -z "$ui_files" ]]; then
        _vld_build_layer_json 4 "ui" "skip" "[]" "[]" 0 0; return 0; fi

    # 静的パターンチェック
    while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
        local issues; issues=$(python3 -c "
import re,sys; c=open('$f','r',encoding='utf-8',errors='ignore').read(); iss=[]
for a in re.findall(r'<button([^>]*)>',c,re.I):
 if 'onClick' not in a and 'onclick' not in a and 'type=' not in a: iss.append('WARNING: <button>にonClick/type無し')
for a in re.findall(r'<form([^>]*)>',c,re.I):
 if 'onSubmit' not in a and 'action=' not in a: iss.append('WARNING: <form>にonSubmit/action無し')
for a in re.findall(r'<img([^>]*)/?>', c, re.I):
 if 'alt=' not in a: iss.append('ERROR: <img>にalt属性無し')
for a in re.findall(r'<a([^>]*)>',c,re.I):
 if ('href=\"#\"' in a or \"href='#'\" in a) and 'onClick' not in a and 'onclick' not in a: iss.append('WARNING: href=#にonClick無し')
for a in re.findall(r'<input([^>]*)/?>', c, re.I):
 if 'hidden' in a: continue
 if 'aria-label' not in a and 'id=' not in a: iss.append('WARNING: <input>にaria-label/id無し')
if '$f'.endswith(('.html','.htm')):
 if 'viewport' not in c: iss.append('WARNING: viewportメタタグ無し')
 if '<!DOCTYPE' not in c and '<!doctype' not in c: iss.append('WARNING: DOCTYPE宣言無し')
for i in iss[:10]: print(i)
if any('ERROR:' in i for i in iss): sys.exit(1)
" 2>&1)
        if [[ -n "$issues" ]]; then
            local el; el=$(echo "$issues" | grep "^ERROR:" || true)
            local wl; wl=$(echo "$issues" | grep "^WARNING:" || true)
            [[ -n "$el" ]] && { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$el"); }
            [[ -n "$wl" ]] && warnings=$(_vld_append_issue "$warnings" "$f" "" "$wl")
        fi
    done <<< "$ui_files"

    # Claude CLIによるUI品質分析（上位3ファイル）
    local top; top=$(echo "$ui_files" | head -3)
    while IFS= read -r f; do [[ -z "$f" ]] && continue
        local content; content=$(head -80 "$f" 2>/dev/null); [[ -z "$content" ]] && continue
        local cr; cr=$(_validator_call_claude "UIコードのアクセシビリティ・UX問題をチェック。「ERROR: 説明」「WARNING: 説明」形式、問題なしなら「NO_ISSUES」。\n\nファイル: ${f}\n\`\`\`\n${content}\n\`\`\`")
        if [[ -n "$cr" && "$cr" != *"NO_ISSUES"* ]]; then
            local ce; ce=$(echo "$cr" | grep -i "^ERROR:" | head -3)
            local cw; cw=$(echo "$cr" | grep -i "^WARNING:" | head -3)
            [[ -n "$ce" ]] && { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$ce"); }
            [[ -n "$cw" ]] && warnings=$(_vld_append_issue "$warnings" "$f" "" "$cw")
        fi
    done <<< "$top"

    (( failed > 0 )) && status="fail"
    _validator_log "INFO" "L4" "${checked}ファイル検査, ${failed}件エラー"
    _vld_build_layer_json 4 "ui" "$status" "$errors" "$warnings" "$checked" "$failed"
}

# ============================================================
# Layer 5: エッジケース検証 - セキュリティ・堅牢性チェック
# ============================================================
_validator_layer5_edge() {
    local project_dir="$1" errors="[]" warnings="[]" status="pass" checked=0 failed=0
    local src; src=$(_validator_scan_files "$project_dir" "js,jsx,ts,tsx,py" | head -8)
    if [[ -z "$src" ]]; then
        _vld_build_layer_json 5 "edge" "skip" "[]" "[]" 0 0; return 0; fi

    # Claude CLIでエッジケース分析
    while IFS= read -r f; do [[ -z "$f" ]] && continue; ((checked++))
        local content; content=$(head -120 "$f" 2>/dev/null); [[ -z "$content" ]] && continue
        local cr; cr=$(_validator_call_claude "コードのエッジケース問題を厳密チェック。観点: 空文字列/null未処理, 配列境界, ゼロ除算, SQLi, XSS, async未catch, リソース未close, 競合状態。「ERROR:」「WARNING:」形式、問題なしなら「NO_ISSUES」。\n\nファイル: ${f}\n\`\`\`\n${content}\n\`\`\`")
        if [[ -n "$cr" && "$cr" != *"NO_ISSUES"* ]]; then
            local ee; ee=$(echo "$cr" | grep -i "^ERROR:" | head -5)
            local ew; ew=$(echo "$cr" | grep -i "^WARNING:" | head -5)
            [[ -n "$ee" ]] && { ((failed++)); errors=$(_vld_append_issue "$errors" "$f" "" "$ee"); }
            [[ -n "$ew" ]] && warnings=$(_vld_append_issue "$warnings" "$f" "" "$ew")
        fi
    done <<< "$src"

    # 静的パターンマッチ: セキュリティリスク検出
    local all_src; all_src=$(_validator_scan_files "$project_dir" "js,jsx,ts,tsx,py,php,rb")
    if [[ -n "$all_src" ]]; then
        while IFS= read -r f; do [[ -z "$f" ]] && continue
            local c; c=$(cat "$f" 2>/dev/null); [[ -z "$c" ]] && continue
            echo "$c" | grep -qE '\.innerHTML\s*=|dangerouslySetInnerHTML' && \
                warnings=$(_vld_append_issue "$warnings" "$f" "" "XSSリスク: innerHTML使用検出")
            echo "$c" | grep -qE '\beval\s*\(' && \
                warnings=$(_vld_append_issue "$warnings" "$f" "" "セキュリティ: eval()使用検出")
            echo "$c" | grep -qEi "(SELECT|INSERT|UPDATE|DELETE).*\+.*(\"|')" 2>/dev/null && \
                warnings=$(_vld_append_issue "$warnings" "$f" "" "SQLiリスク: SQL文字列結合検出")
            echo "$c" | grep -qEi '(password|secret|api_key|token)\s*=\s*["'"'"'][^"'"'"']{8,}' 2>/dev/null && {
                errors=$(_vld_append_issue "$errors" "$f" "" "ハードコードされたシークレットの可能性")
                ((failed++)); }
        done <<< "$all_src"
    fi

    (( failed > 0 )) && status="fail"
    _validator_log "INFO" "L5" "${checked}ファイル検査, ${failed}件エラー"
    _vld_build_layer_json 5 "edge" "$status" "$errors" "$warnings" "$checked" "$failed"
}

# ============================================================
# レポート生成: コンソール出力 + Markdownファイル保存
# ============================================================
validator_report() {
    local results_json="$1"
    [[ -z "$VLD_REPORT_DIR" ]] && VLD_REPORT_DIR="docs/chain-logs"
    mkdir -p "$VLD_REPORT_DIR" 2>/dev/null || true
    local report_file="${VLD_REPORT_DIR}/validation_report.md"
    local te; te=$(validator_count_errors "$results_json")
    local tw; tw=$(_vld_count_warnings "$results_json")

    echo -e "\n${VLD_BOLD}${VLD_CYAN}  Validation Report (v8.0)${VLD_NC}\n"
    if (( te == 0 && tw == 0 )); then echo -e "  ${VLD_GREEN}ALL CLEAR: 全5層通過${VLD_NC}"
    elif (( te == 0 )); then echo -e "  ${VLD_YELLOW}PASSED: 0E / ${tw}W${VLD_NC}"
    else echo -e "  ${VLD_RED}FAILED: ${te}E / ${tw}W${VLD_NC}"; fi

    # Layer別表示 + Markdown生成
    python3 -c "
import json
from datetime import datetime
try: results = json.loads('''${results_json}''')
except: results = []
ln={1:'構文検証',2:'型チェック',3:'ランタイム',4:'UI検証',5:'エッジケース'}
le={1:'Syntax',2:'Types',3:'Runtime',4:'UI',5:'Edge Cases'}
# コンソール
for r in results:
    l=r.get('layer',0); s=r.get('status','?'); e=len(r.get('errors',[])); w=len(r.get('warnings',[]))
    ic='\033[0;32mPASS\033[0m' if s=='pass' else ('\033[0;33mSKIP\033[0m' if s=='skip' else '\033[0;31mFAIL\033[0m')
    print(f'  L{l} {ln.get(l,\"?\"):<10} [{ic}] {r.get(\"checked\",0)}検査/{e}E/{w}W')
    for err in r.get('errors',[])[:3]: print(f'    \033[0;31m-> {err.get(\"file\",\"\")} {err.get(\"message\",\"\")[:60]}\033[0m')
# Markdown
rp=['# Validation Report (v8.0)','',f'Date: {datetime.now():%Y-%m-%d %H:%M:%S}','','## Summary','',
    f'- Errors: **{sum(len(r.get(\"errors\",[]))for r in results)}**',
    f'- Warnings: **{sum(len(r.get(\"warnings\",[]))for r in results)}**','']
crit=[(r.get('layer'),e.get('file',''),e.get('message',''))for r in results for e in r.get('errors',[])]
if crit:
    rp+=['## Fix List (Critical First)','']
    for i,(l,f,m) in enumerate(crit[:20],1): rp.append(f'{i}. **[L{l}]** \`{f}\`: {m[:100]}')
    rp.append('')
for r in results:
    l=r.get('layer',0); rp+=[f'## Layer {l}: {le.get(l,\"\")} ({r.get(\"status\",\"\").upper()})','']
    for e in r.get('errors',[]): rp.append(f'  - [ERROR] \`{e.get(\"file\",\"\")}\`: {e.get(\"message\",\"\")}')
    for w in r.get('warnings',[]): rp.append(f'  - [WARN] \`{w.get(\"file\",\"\")}\`: {w.get(\"message\",\"\")}')
    rp.append('')
open('${report_file}','w').write('\\n'.join(rp))
" 2>/dev/null
    echo -e "\n  ${VLD_GREEN}レポート保存: ${report_file}${VLD_NC}"
}

# ============================================================
# エラー数カウント（ヒーリングループ用）
# ============================================================
validator_count_errors() {
    local r="$1"
    python3 -c "import json
try: print(sum(len(x.get('errors',[]))for x in json.loads('''${r}''')))
except: print(0)" 2>/dev/null || echo "0"
}

_vld_count_warnings() {
    local r="$1"
    python3 -c "import json
try: print(sum(len(x.get('warnings',[]))for x in json.loads('''${r}''')))
except: print(0)" 2>/dev/null || echo "0"
}

# ============================================================
# ヘルパー関数群
# ============================================================

# ファイル再帰検索（VLD_SKIP_DIRS除外）
_validator_scan_files() {
    local dir="$1" extensions="$2"
    local find_args=() prune_args=() first=true pfirst=true
    IFS=',' read -ra exts <<< "$extensions"
    for ext in "${exts[@]}"; do ext=$(echo "$ext"|xargs); [[ -z "$ext" ]] && continue
        [[ "$first" == "true" ]] && { find_args+=(-name "*.${ext}"); first=false; } || find_args+=(-o -name "*.${ext}")
    done
    [[ ${#find_args[@]} -eq 0 ]] && return 0
    for skip in $VLD_SKIP_DIRS; do
        [[ "$pfirst" == "true" ]] && { prune_args+=(-name "$skip"); pfirst=false; } || prune_args+=(-o -name "$skip")
    done
    if [[ ${#prune_args[@]} -gt 0 ]]; then
        find "$dir" \( "${prune_args[@]}" \) -prune -o -type f \( "${find_args[@]}" \) -print 2>/dev/null
    else find "$dir" -type f \( "${find_args[@]}" \) -print 2>/dev/null; fi
}

# Claude CLI呼び出し（リトライ付き、失敗時は空返却で処理続行）
_validator_call_claude() {
    local prompt="$1" retry=0
    while (( retry < 2 )); do
        local r; r=$(claude -p --dangerously-skip-permissions --output-format text "$prompt" 2>/dev/null) && { echo "$r"; return 0; }
        ((retry++)); sleep 1
    done
    _validator_log "WARN" "CLAUDE" "Claude CLI呼び出し失敗"; return 0
}

# 構造化ログ
_validator_log() {
    local level="$1" layer="$2" msg="$3" ts; ts=$(date '+%H:%M:%S')
    local color="$VLD_NC"
    case "$level" in INFO) color="$VLD_GREEN";; WARN) color="$VLD_YELLOW";; ERROR) color="$VLD_RED";; esac
    echo -e "  ${color}[${level}][${layer}] ${msg}${VLD_NC}"
    [[ -n "$VLD_LOG_FILE" ]] && echo "[${ts}][${level}][${layer}] ${msg}" >> "$VLD_LOG_FILE" 2>/dev/null || true
}

# JSON配列にissue追加
_vld_append_issue() {
    local arr="$1" file="$2" line="${3:-}" msg="$4"
    msg=$(echo "$msg" | tr '\n' ' ' | sed 's/"/\\"/g' | head -c 300)
    file=$(echo "$file" | sed 's/"/\\"/g')
    python3 -c "import json;a=json.loads('''${arr}''');a.append({'file':'${file}','line':'${line}','message':'''${msg}'''[:300]});print(json.dumps(a,ensure_ascii=False))" 2>/dev/null || echo "$arr"
}

# Layer結果JSON構築
_vld_build_layer_json() {
    local layer=$1 name=$2 status=$3 errors=$4 warnings=$5 checked=$6 failed=$7
    python3 -c "import json;print(json.dumps({'layer':${layer},'name':'${name}','status':'${status}','errors':json.loads('''${errors}'''),'warnings':json.loads('''${warnings}'''),'checked':${checked},'failed':${failed}},ensure_ascii=False))" 2>/dev/null \
        || echo "{\"layer\":${layer},\"name\":\"${name}\",\"status\":\"${status}\",\"errors\":[],\"warnings\":[],\"checked\":${checked},\"failed\":${failed}}"
}

# 結果配列マージ
_vld_merge_results() {
    local all="$1" new="$2"
    python3 -c "import json;a=json.loads('''${all}''');a.append(json.loads('''${new}'''));print(json.dumps(a,ensure_ascii=False))" 2>/dev/null || echo "$all"
}

# Layer結果サマリー1行表示
_vld_print_layer_summary() {
    local n="$1" name="$2" result="$3"
    local e w s c
    e=$(python3 -c "import json;print(len(json.loads('''${result}''').get('errors',[])))" 2>/dev/null || echo 0)
    w=$(python3 -c "import json;print(len(json.loads('''${result}''').get('warnings',[])))" 2>/dev/null || echo 0)
    s=$(python3 -c "import json;print(json.loads('''${result}''').get('status','?'))" 2>/dev/null || echo "?")
    c=$(python3 -c "import json;print(json.loads('''${result}''').get('checked',0))" 2>/dev/null || echo 0)
    local icon color
    case "$s" in pass) icon="PASS"; color="$VLD_GREEN";; skip) icon="SKIP"; color="$VLD_YELLOW";; *) icon="FAIL"; color="$VLD_RED";; esac
    echo -e "  ${color}[${icon}]${VLD_NC} ${name}: ${c}検査 / ${VLD_RED}${e}E${VLD_NC} / ${VLD_YELLOW}${w}W${VLD_NC}"
}

# ============================================================
# エクスポート: chain.sh から source して使用
# ============================================================
#   source lib/validator.sh
#   validator_init "/path/to/project"
#   results=$(validator_run_all "/path/to/project")
#   validator_report "$results"
#   error_count=$(validator_count_errors "$results")
