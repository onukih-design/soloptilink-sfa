#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v7.0 - Real-time Learning System
# ============================================================
# v6.0のナレッジ蓄積を拡張し、セッション中のリアルタイム学習を実現。
# 成功/失敗パターンを即座にキャプチャし、同セッション内の後続ステージに反映。
# グローバルナレッジとの双方向同期も自動実行。
# ============================================================

# sourceされるライブラリなので set -euo pipefail は設定しない
# カラー定義（プレフィクス付きでreadonly衝突を回避）
RT_RED='\033[0;31m'
RT_GREEN='\033[0;32m'
RT_YELLOW='\033[0;33m'
RT_CYAN='\033[0;36m'
RT_PURPLE='\033[0;35m'
RT_BOLD='\033[1m'
RT_NC='\033[0m'

# 学習設定
LEARN_DIR="${HOME}/.soloptilink/knowledge"
LEARN_SESSION_DIR=""  # セッション開始時に設定
LEARN_BUFFER_FILE=""  # セッション内バッファ
LEARN_GLOBAL_FILE="${LEARN_DIR}/global_patterns.json"
LEARN_METRICS_FILE="${LEARN_DIR}/learning_metrics.json"

# 最大保持パターン数
MAX_SESSION_PATTERNS=50
MAX_GLOBAL_PATTERNS=500

mkdir -p "${LEARN_DIR}" 2>/dev/null || true

# ============================================================
# セッション学習の初期化
# ============================================================
rt_learn_init() {
    local session_id="$1"
    
    LEARN_SESSION_DIR="docs/chain-logs/learn_${session_id}"
    LEARN_BUFFER_FILE="${LEARN_SESSION_DIR}/session_buffer.json"
    
    mkdir -p "${LEARN_SESSION_DIR}" 2>/dev/null || true
    
    # セッションバッファの初期化
    if [[ ! -f "$LEARN_BUFFER_FILE" ]]; then
        cat > "$LEARN_BUFFER_FILE" <<EOF
{
  "session_id": "${session_id}",
  "started_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "patterns": [],
  "errors": [],
  "decisions": [],
  "metrics": {
    "total_captures": 0,
    "success_patterns": 0,
    "error_patterns": 0,
    "applied_learnings": 0
  }
}
EOF
    fi
    
    echo -e "${RT_PURPLE}[LEARN] リアルタイム学習システム初期化完了${RT_NC}"
    echo -e "  バッファ: ${LEARN_BUFFER_FILE}"
    
    # グローバルパターンのロード
    _rt_load_global_patterns
}

# ============================================================
# パターンキャプチャ
# ============================================================

# 成功パターンをキャプチャ
rt_capture_success() {
    local stage="$1"      # ステージ名（例: "FE", "BE", "QA"）
    local category="$2"   # カテゴリ（例: "react-setup", "api-design"）
    local description="$3" # パターンの説明
    local context="${4:-}" # 追加コンテキスト（オプション）
    
    local pattern_json=$(cat <<EOF
{
  "type": "success",
  "stage": "${stage}",
  "category": "${category}",
  "description": "${description}",
  "context": "${context}",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "confidence": 0.8
}
EOF
)
    
    _rt_append_pattern "$pattern_json"
    echo -e "  ${RT_GREEN}📗 学習キャプチャ [成功]: ${category} @ ${stage}${RT_NC}"
}

# エラーパターンをキャプチャ
rt_capture_error() {
    local stage="$1"
    local error_type="$2"   # エラータイプ（例: "syntax", "runtime", "logic"）
    local description="$3"
    local resolution="${4:-}" # 解決策（セルフヒール後に追加）
    
    local pattern_json=$(cat <<EOF
{
  "type": "error",
  "stage": "${stage}",
  "error_type": "${error_type}",
  "description": "${description}",
  "resolution": "${resolution}",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "recurrence_count": 1
}
EOF
)
    
    _rt_append_pattern "$pattern_json"
    echo -e "  ${RT_RED}📕 学習キャプチャ [エラー]: ${error_type} @ ${stage}${RT_NC}"
}

# 設計判断をキャプチャ
rt_capture_decision() {
    local stage="$1"
    local decision="$2"      # 判断内容
    local alternatives="$3"  # 検討した代替案
    local rationale="$4"     # 理由
    
    local decision_json=$(cat <<EOF
{
  "type": "decision",
  "stage": "${stage}",
  "decision": "${decision}",
  "alternatives": "${alternatives}",
  "rationale": "${rationale}",
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
)
    
    _rt_append_pattern "$decision_json"
    echo -e "  ${RT_CYAN}📘 学習キャプチャ [判断]: ${decision} @ ${stage}${RT_NC}"
}

# ============================================================
# リアルタイムコンテキスト生成
# ============================================================

# 現在のセッションで学習した内容を、次のステージ向けにコンテキスト化
rt_generate_context() {
    local target_stage="$1"
    local task_desc="${2:-}"
    
    [[ ! -f "$LEARN_BUFFER_FILE" ]] && return
    
    local context=""
    
    # セッション内パターンを取得
    local patterns=$(python3 -c "
import json, sys
try:
    with open('${LEARN_BUFFER_FILE}', 'r') as f:
        data = json.load(f)
    
    relevant = []
    for p in data.get('patterns', []):
        relevant.append(p)
    
    if relevant:
        print('# 📚 セッション内学習コンテキスト')
        print()
        
        # 成功パターン
        successes = [p for p in relevant if p.get('type') == 'success']
        if successes:
            print('## ✅ 成功パターン（本セッション）')
            for s in successes[-5:]:
                print(f\"- [{s.get('stage','')}] {s.get('category','')}: {s.get('description','')}\")
            print()
        
        # エラーパターン（回避すべき）
        errors = [p for p in relevant if p.get('type') == 'error']
        if errors:
            print('## ⚠️ 回避すべきパターン（本セッション）')
            for e in errors[-5:]:
                resolution = e.get('resolution', '未解決')
                print(f\"- [{e.get('stage','')}] {e.get('error_type','')}: {e.get('description','')}\")
                if resolution and resolution != '未解決':
                    print(f\"  → 解決策: {resolution}\")
            print()
        
        # 設計判断
        decisions = [p for p in relevant if p.get('type') == 'decision']
        if decisions:
            print('## 🎯 設計判断（本セッション）')
            for d in decisions[-3:]:
                print(f\"- [{d.get('stage','')}] {d.get('decision','')}\")
                print(f\"  理由: {d.get('rationale','')}\")
            print()
except Exception as e:
    pass
" 2>/dev/null)
    
    [[ -n "$patterns" ]] && context="$patterns"
    
    # グローバルパターンも追加
    local global_context=$(_rt_get_global_context "$target_stage" "$task_desc")
    [[ -n "$global_context" ]] && context="${context}\n${global_context}"
    
    echo -e "$context"
}

# ============================================================
# グローバルパターン管理
# ============================================================
_rt_load_global_patterns() {
    if [[ ! -f "$LEARN_GLOBAL_FILE" ]]; then
        cat > "$LEARN_GLOBAL_FILE" <<EOF
{
  "version": "7.0",
  "total_sessions": 0,
  "patterns": [],
  "error_frequencies": {},
  "success_rates": {},
  "updated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
        echo -e "  ${RT_YELLOW}グローバルパターンDB初期化${RT_NC}"
    else
        local count=$(python3 -c "
import json
with open('${LEARN_GLOBAL_FILE}', 'r') as f:
    data = json.load(f)
print(len(data.get('patterns', [])))
" 2>/dev/null || echo "0")
        echo -e "  ${RT_GREEN}グローバルパターン: ${count}件ロード済み${RT_NC}"
    fi
}

_rt_get_global_context() {
    local target_stage="$1"
    local task_desc="${2:-}"
    
    [[ ! -f "$LEARN_GLOBAL_FILE" ]] && return
    
    python3 -c "
import json
try:
    with open('${LEARN_GLOBAL_FILE}', 'r') as f:
        data = json.load(f)
    
    patterns = data.get('patterns', [])
    if not patterns:
        exit()
    
    # ステージに関連するパターンをフィルタ
    relevant = [p for p in patterns if p.get('stage', '') == '${target_stage}' or p.get('confidence', 0) > 0.9]
    
    if relevant:
        print('## 🌐 グローバルナレッジ（過去のセッションから）')
        for p in relevant[-3:]:
            ptype = p.get('type', 'unknown')
            desc = p.get('description', '')
            sessions = p.get('session_count', 1)
            if ptype == 'success':
                print(f'- ✅ {desc} (確認済み: {sessions}セッション)')
            elif ptype == 'error':
                resolution = p.get('resolution', '')
                print(f'- ⚠️ {desc}')
                if resolution:
                    print(f'  → 推奨解決策: {resolution}')
        print()
except Exception:
    pass
" 2>/dev/null
}

# ============================================================
# セッション終了時のグローバル同期
# ============================================================
rt_sync_to_global() {
    local session_id="$1"
    
    [[ ! -f "$LEARN_BUFFER_FILE" ]] && return
    
    echo -e "\n${RT_BOLD}${RT_PURPLE}[LEARN] グローバルナレッジ同期中...${RT_NC}"
    
    python3 -c "
import json
from datetime import datetime

# セッションバッファ読み込み
with open('${LEARN_BUFFER_FILE}', 'r') as f:
    session = json.load(f)

# グローバルパターン読み込み
global_file = '${LEARN_GLOBAL_FILE}'
try:
    with open(global_file, 'r') as f:
        global_data = json.load(f)
except:
    global_data = {'version': '7.0', 'total_sessions': 0, 'patterns': [], 'error_frequencies': {}, 'success_rates': {}, 'updated_at': ''}

# セッションパターンをグローバルにマージ
session_patterns = session.get('patterns', [])
global_patterns = global_data.get('patterns', [])

for sp in session_patterns:
    # 重複チェック（同じカテゴリ+説明のパターン）
    merged = False
    for i, gp in enumerate(global_patterns):
        if (gp.get('category', '') == sp.get('category', '') and 
            gp.get('description', '')[:50] == sp.get('description', '')[:50]):
            # 既存パターンの信頼度を上げる
            gp['confidence'] = min(gp.get('confidence', 0.5) + 0.1, 1.0)
            gp['session_count'] = gp.get('session_count', 1) + 1
            gp['last_seen'] = datetime.utcnow().isoformat() + 'Z'
            # 解決策が新しければ更新
            if sp.get('resolution') and sp.get('resolution') != '未解決':
                gp['resolution'] = sp['resolution']
            merged = True
            break
    
    if not merged:
        sp['session_count'] = 1
        sp['first_seen'] = datetime.utcnow().isoformat() + 'Z'
        sp['last_seen'] = sp['first_seen']
        global_patterns.append(sp)

# パターン数の制限
if len(global_patterns) > ${MAX_GLOBAL_PATTERNS}:
    # 信頼度が低く古いパターンを削除
    global_patterns.sort(key=lambda p: (p.get('confidence', 0), p.get('session_count', 0)), reverse=True)
    global_patterns = global_patterns[:${MAX_GLOBAL_PATTERNS}]

# エラー頻度を更新
error_freq = global_data.get('error_frequencies', {})
for sp in session_patterns:
    if sp.get('type') == 'error':
        key = sp.get('error_type', 'unknown')
        error_freq[key] = error_freq.get(key, 0) + 1

# 成功率を更新
success_rates = global_data.get('success_rates', {})
for sp in session_patterns:
    stage = sp.get('stage', 'unknown')
    if stage not in success_rates:
        success_rates[stage] = {'total': 0, 'success': 0}
    success_rates[stage]['total'] += 1
    if sp.get('type') == 'success':
        success_rates[stage]['success'] += 1

# 保存
global_data['patterns'] = global_patterns
global_data['error_frequencies'] = error_freq
global_data['success_rates'] = success_rates
global_data['total_sessions'] = global_data.get('total_sessions', 0) + 1
global_data['updated_at'] = datetime.utcnow().isoformat() + 'Z'

with open(global_file, 'w') as f:
    json.dump(global_data, f, ensure_ascii=False, indent=2)

new_count = len([p for p in session_patterns if not any(
    gp.get('category','') == p.get('category','') for gp in global_data['patterns'][:len(global_data['patterns'])-len(session_patterns)]
)])

print(f'  同期完了: {len(session_patterns)}パターン → グローバル ({len(global_patterns)}件)')
print(f'  新規パターン: {new_count}件')
print(f'  累計セッション: {global_data[\"total_sessions\"]}')
" 2>/dev/null
    
    echo -e "${RT_GREEN}  ✅ グローバルナレッジ同期完了${RT_NC}"
}

# ============================================================
# 学習メトリクス
# ============================================================
rt_print_metrics() {
    echo -e "\n${RT_BOLD}  ┌─────────────────────────────────────────┐${RT_NC}"
    echo -e "${RT_BOLD}  │       Learning Metrics (v7.0)            │${RT_NC}"
    echo -e "${RT_BOLD}  └─────────────────────────────────────────┘${RT_NC}"
    
    if [[ -f "$LEARN_BUFFER_FILE" ]]; then
        python3 -c "
import json
with open('${LEARN_BUFFER_FILE}', 'r') as f:
    data = json.load(f)
m = data.get('metrics', {})
patterns = data.get('patterns', [])
print(f'  セッション内キャプチャ: {len(patterns)}')
print(f'  ├ 成功パターン: {len([p for p in patterns if p.get(\"type\")==\"success\"])}')
print(f'  ├ エラーパターン: {len([p for p in patterns if p.get(\"type\")==\"error\"])}')
print(f'  └ 設計判断: {len([p for p in patterns if p.get(\"type\")==\"decision\"])}')
" 2>/dev/null
    fi
    
    if [[ -f "$LEARN_GLOBAL_FILE" ]]; then
        python3 -c "
import json
with open('${LEARN_GLOBAL_FILE}', 'r') as f:
    data = json.load(f)
patterns = data.get('patterns', [])
print(f'  グローバルパターン: {len(patterns)}')
print(f'  累計セッション: {data.get(\"total_sessions\", 0)}')

# ステージ別成功率
sr = data.get('success_rates', {})
if sr:
    print('  ステージ別成功率:')
    for stage, stats in sorted(sr.items()):
        total = stats.get('total', 0)
        success = stats.get('success', 0)
        rate = (success / total * 100) if total > 0 else 0
        bar = '█' * int(rate / 5) + '░' * (20 - int(rate / 5))
        print(f'    {stage:<8} {bar} {rate:.0f}% ({success}/{total})')

# トップエラー
ef = data.get('error_frequencies', {})
if ef:
    print('  頻出エラー:')
    for err_type, count in sorted(ef.items(), key=lambda x: x[1], reverse=True)[:5]:
        print(f'    {err_type:<20} {count}回')
" 2>/dev/null
    fi
}

# ============================================================
# 内部ヘルパー
# ============================================================
_rt_append_pattern() {
    local pattern_json="$1"
    
    [[ ! -f "$LEARN_BUFFER_FILE" ]] && return
    
    python3 -c "
import json
with open('${LEARN_BUFFER_FILE}', 'r') as f:
    data = json.load(f)

pattern = json.loads('''${pattern_json}''')
data['patterns'].append(pattern)
data['metrics']['total_captures'] = len(data['patterns'])

ptype = pattern.get('type', '')
if ptype == 'success':
    data['metrics']['success_patterns'] = data['metrics'].get('success_patterns', 0) + 1
elif ptype == 'error':
    data['metrics']['error_patterns'] = data['metrics'].get('error_patterns', 0) + 1

# セッション内パターン数制限
if len(data['patterns']) > ${MAX_SESSION_PATTERNS}:
    # 古い低信頼度パターンを削除
    data['patterns'] = data['patterns'][-${MAX_SESSION_PATTERNS}:]

with open('${LEARN_BUFFER_FILE}', 'w') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
" 2>/dev/null
}

# ============================================================
# RAGとの連携（v7.0統合ポイント）
# ============================================================
rt_index_session_knowledge() {
    local session_id="$1"
    
    # セッションの学習結果をRAGインデックスに追加
    if [[ -f "tools/rag-engine.py" && -f "$LEARN_BUFFER_FILE" ]]; then
        # セッションバッファをナレッジファイルに変換
        local knowledge_file="${LEARN_SESSION_DIR}/knowledge_${session_id}.md"
        
        python3 -c "
import json
with open('${LEARN_BUFFER_FILE}', 'r') as f:
    data = json.load(f)

with open('${knowledge_file}', 'w') as f:
    f.write(f'# セッション ${session_id} ナレッジ\n\n')
    f.write(f'日時: {data.get(\"started_at\", \"N/A\")}\n\n')
    
    for p in data.get('patterns', []):
        ptype = p.get('type', '')
        if ptype == 'success':
            f.write(f'## ✅ {p.get(\"category\", \"\")} ({p.get(\"stage\", \"\")})\n')
            f.write(f'{p.get(\"description\", \"\")}\n\n')
        elif ptype == 'error':
            f.write(f'## ⚠️ エラー: {p.get(\"error_type\", \"\")} ({p.get(\"stage\", \"\")})\n')
            f.write(f'{p.get(\"description\", \"\")}\n')
            if p.get('resolution'):
                f.write(f'解決策: {p.get(\"resolution\")}\n')
            f.write('\n')
        elif ptype == 'decision':
            f.write(f'## 🎯 判断: {p.get(\"decision\", \"\")} ({p.get(\"stage\", \"\")})\n')
            f.write(f'理由: {p.get(\"rationale\", \"\")}\n\n')
" 2>/dev/null
        
        # RAGエンジンにインデックス追加
        if [[ -f "$knowledge_file" ]]; then
            python3 tools/rag-engine.py add "$knowledge_file" --tags "session-learning,${session_id}" 2>/dev/null || true
            echo -e "  ${RT_GREEN}📚 セッションナレッジをRAGインデックスに追加${RT_NC}"
        fi
    fi
}

# ============================================================
# エクスポート（chain.shから使用）
# ============================================================
# このファイルは chain.sh から source される
# 使用例:
#   source lib/realtime-learn.sh
#   rt_learn_init "session_001"
#   rt_capture_success "FE" "react-setup" "Vite + React 初期化成功"
#   rt_capture_error "BE" "syntax" "import文の循環参照" "モジュール分割で解決"
#   rt_generate_context "QA"
#   rt_sync_to_global "session_001"
