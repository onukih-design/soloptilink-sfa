#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v7.0 - DAG Dynamic Pipeline Engine
# ============================================================
# v6.0の静的パイプライン（Quick/Standard/Deep/Hotfix）を拡張し、
# タスク分析に基づいてDAG（有向非巡回グラフ）を動的に構築。
# 依存関係を解析し、並列実行可能なステージを自動判定する。
# ============================================================

# sourceされるライブラリなので set -euo pipefail は設定しない
# カラー定義（readonlyガード付き：他モジュールとの衝突を防止）
[[ -z "${RED:-}" ]]    && RED='\033[0;31m'
[[ -z "${GREEN:-}" ]]  && GREEN='\033[0;32m'
[[ -z "${YELLOW:-}" ]] && YELLOW='\033[0;33m'
[[ -z "${BLUE:-}" ]]   && BLUE='\033[0;34m'
[[ -z "${PURPLE:-}" ]] && PURPLE='\033[0;35m'
[[ -z "${CYAN:-}" ]]   && CYAN='\033[0;36m'
[[ -z "${BOLD:-}" ]]   && BOLD='\033[1m'
[[ -z "${NC:-}" ]]     && NC='\033[0m'

# DAG設定
DAG_DIR="${HOME}/.soloptilink/dag"
DAG_LOG_DIR="docs/chain-logs/dag"
mkdir -p "${DAG_DIR}" "${DAG_LOG_DIR}" 2>/dev/null || true

# ============================================================
# DAGノード定義
# ============================================================
# 各ノードはパイプラインの1ステージを表す
# フォーマット: ノードID|名前|推定時間(分)|依存ノードIDs(カンマ区切り)|実行コマンド

declare -A DAG_NODES=()
declare -A DAG_STATUS=()     # pending / running / completed / failed / skipped
declare -A DAG_RESULTS=()    # 各ノードの実行結果
declare -A DAG_START_TIME=()
declare -A DAG_END_TIME=()

# ============================================================
# タスク分析 → DAG構築
# ============================================================
dag_analyze_task() {
    local task_desc="$1"
    local complexity="${2:-standard}"
    
    echo -e "${BOLD}${PURPLE}[DAG] タスク分析中...${NC}"
    
    # タスクタイプの判定
    local task_type="generic"
    local has_frontend=false
    local has_backend=false
    local has_db=false
    local has_api=false
    local has_test=false
    local has_deploy=false
    local has_docs=false
    
    # キーワードベースのタスク分析
    local task_lower=$(echo "$task_desc" | tr '[:upper:]' '[:lower:]')
    
    [[ "$task_lower" =~ (react|vue|next|html|css|ui|画面|フロント|ランディング|lp) ]] && has_frontend=true
    [[ "$task_lower" =~ (api|backend|サーバ|express|fastapi|node|バック) ]] && has_backend=true
    [[ "$task_lower" =~ (db|database|sql|postgres|mongo|データベース|テーブル) ]] && has_db=true
    [[ "$task_lower" =~ (api|rest|graphql|endpoint|エンドポイント) ]] && has_api=true
    [[ "$task_lower" =~ (test|テスト|spec|jest|pytest) ]] && has_test=true
    [[ "$task_lower" =~ (deploy|デプロイ|vercel|aws|本番) ]] && has_deploy=true
    [[ "$task_lower" =~ (doc|readme|ドキュメント|仕様) ]] && has_docs=true
    
    # SaaS / フルスタック判定
    if [[ "$task_lower" =~ (saas|crm|sfa|管理システム|ツール作) ]]; then
        task_type="fullstack"
        has_frontend=true
        has_backend=true
        has_db=true
        has_api=true
    elif [[ "$task_lower" =~ (lp|ランディング|ページ) ]]; then
        task_type="landing_page"
        has_frontend=true
    elif [[ "$task_lower" =~ (script|スクリプト|自動化|バッチ) ]]; then
        task_type="script"
    fi
    
    echo -e "  タスクタイプ: ${CYAN}${task_type}${NC}"
    echo -e "  フロントエンド: $(bool_icon $has_frontend) | バックエンド: $(bool_icon $has_backend)"
    echo -e "  DB: $(bool_icon $has_db) | API: $(bool_icon $has_api) | テスト: $(bool_icon $has_test)"
    
    # DAGノードを構築
    _build_dag "$task_type" "$complexity" \
        "$has_frontend" "$has_backend" "$has_db" "$has_api" "$has_test" "$has_deploy" "$has_docs"
}

bool_icon() {
    [[ "$1" == "true" ]] && echo -e "${GREEN}✓${NC}" || echo -e "${YELLOW}–${NC}"
}

# ============================================================
# DAG構築ロジック
# ============================================================
_build_dag() {
    local task_type="$1"
    local complexity="$2"
    local has_frontend="$3"
    local has_backend="$4"
    local has_db="$5"
    local has_api="$6"
    local has_test="$7"
    local has_deploy="$8"
    local has_docs="$9"
    
    # 全DAGノードをクリア
    DAG_NODES=()
    DAG_STATUS=()
    
    # ============ 共通ノード ============
    
    # Phase 0: 要件分析（常に最初）
    dag_add_node "REQ" "要件分析・設計" "3" "" "phase_requirements"
    
    # Phase 0.5: RAG検索（v7.0新機能 - REQ完了後）
    dag_add_node "RAG" "RAGナレッジ検索" "1" "REQ" "phase_rag_search"
    
    # Phase 1: 競合調査（complexityがdeepの場合のみ）
    if [[ "$complexity" == "deep" ]]; then
        dag_add_node "COMP" "競合・市場調査" "5" "REQ" "phase_competitive_research"
    fi
    
    # ============ 実装ノード（並列可能） ============
    local impl_deps="RAG"
    [[ "$complexity" == "deep" ]] && impl_deps="RAG,COMP"
    
    if [[ "$has_db" == "true" ]]; then
        dag_add_node "DB" "DB設計・実装" "5" "$impl_deps" "phase_database"
    fi
    
    if [[ "$has_backend" == "true" ]]; then
        local be_deps="$impl_deps"
        [[ "$has_db" == "true" ]] && be_deps="${be_deps},DB"
        dag_add_node "BE" "バックエンド実装" "10" "$be_deps" "phase_backend"
    fi
    
    if [[ "$has_api" == "true" ]]; then
        local api_deps="$impl_deps"
        [[ "$has_backend" == "true" ]] && api_deps="BE"
        dag_add_node "API" "API実装" "8" "$api_deps" "phase_api"
    fi
    
    if [[ "$has_frontend" == "true" ]]; then
        local fe_deps="$impl_deps"
        [[ "$has_api" == "true" ]] && fe_deps="API"
        [[ "$has_backend" == "true" && "$has_api" != "true" ]] && fe_deps="BE"
        dag_add_node "FE" "フロントエンド実装" "10" "$fe_deps" "phase_frontend"
    fi
    
    # 単純なスクリプトタスク
    if [[ "$task_type" == "script" ]]; then
        dag_add_node "IMPL" "実装" "5" "$impl_deps" "phase_implementation"
    fi
    
    # ============ 品質保証ノード ============
    local qa_deps=""
    [[ "$has_frontend" == "true" ]] && qa_deps="FE"
    [[ "$has_backend" == "true" && -z "$qa_deps" ]] && qa_deps="BE"
    [[ "$has_api" == "true" && -z "$qa_deps" ]] && qa_deps="API"
    [[ "$task_type" == "script" ]] && qa_deps="IMPL"
    
    if [[ -n "$qa_deps" ]]; then
        dag_add_node "QA" "品質チェック・修正" "5" "$qa_deps" "phase_quality_check"
        
        if [[ "$has_test" == "true" || "$complexity" == "deep" ]]; then
            dag_add_node "TEST" "テスト実装・実行" "5" "$qa_deps" "phase_testing"
        fi
    fi
    
    # ============ 最終ノード ============
    local final_deps="QA"
    [[ -n "${DAG_NODES[TEST]:-}" ]] && final_deps="${final_deps},TEST"
    
    if [[ "$has_docs" == "true" || "$complexity" == "deep" ]]; then
        dag_add_node "DOC" "ドキュメント生成" "3" "$final_deps" "phase_documentation"
        final_deps="DOC"
    fi
    
    if [[ "$has_deploy" == "true" ]]; then
        dag_add_node "DEPLOY" "デプロイ準備" "3" "$final_deps" "phase_deploy"
        final_deps="DEPLOY"
    fi
    
    # ナレッジ蓄積（常に最後）
    dag_add_node "LEARN" "ナレッジ蓄積" "2" "$final_deps" "phase_knowledge_save"
    
    echo ""
    echo -e "${BOLD}${GREEN}[DAG] パイプライン構築完了: ${#DAG_NODES[@]}ノード${NC}"
    dag_print_graph
}

# ============================================================
# DAGノード操作
# ============================================================
dag_add_node() {
    local id="$1"
    local name="$2"
    local est_minutes="$3"
    local dependencies="$4"
    local command="$5"
    
    DAG_NODES[$id]="${name}|${est_minutes}|${dependencies}|${command}"
    DAG_STATUS[$id]="pending"
}

dag_get_name() { echo "${DAG_NODES[$1]}" | cut -d'|' -f1; }
dag_get_est()  { echo "${DAG_NODES[$1]}" | cut -d'|' -f2; }
dag_get_deps() { echo "${DAG_NODES[$1]}" | cut -d'|' -f3; }
dag_get_cmd()  { echo "${DAG_NODES[$1]}" | cut -d'|' -f4; }

# ============================================================
# DAGグラフ表示
# ============================================================
dag_print_graph() {
    echo ""
    echo -e "${BOLD}  ┌─────────────────────────────────────────┐${NC}"
    echo -e "${BOLD}  │          DAG Pipeline Graph              │${NC}"
    echo -e "${BOLD}  └─────────────────────────────────────────┘${NC}"
    echo ""
    
    # トポロジカルソートしてレベル別に表示
    local -A levels=()
    local -A visited=()
    
    _compute_level() {
        local node="$1"
        [[ -n "${visited[$node]:-}" ]] && return
        visited[$node]=1
        
        local deps=$(dag_get_deps "$node")
        local max_dep_level=-1
        
        if [[ -n "$deps" ]]; then
            IFS=',' read -ra dep_arr <<< "$deps"
            for dep in "${dep_arr[@]}"; do
                dep=$(echo "$dep" | xargs)
                [[ -z "$dep" ]] && continue
                [[ -z "${DAG_NODES[$dep]:-}" ]] && continue
                _compute_level "$dep"
                local dep_level="${levels[$dep]:-0}"
                (( dep_level > max_dep_level )) && max_dep_level=$dep_level
            done
        fi
        
        levels[$node]=$((max_dep_level + 1))
    }
    
    for node_id in "${!DAG_NODES[@]}"; do
        _compute_level "$node_id"
    done
    
    # レベル別にグループ化して表示
    local max_level=0
    for level in "${levels[@]}"; do
        (( level > max_level )) && max_level=$level
    done
    
    local total_est=0
    
    for (( lvl=0; lvl<=max_level; lvl++ )); do
        local nodes_at_level=()
        for node_id in "${!levels[@]}"; do
            [[ "${levels[$node_id]}" == "$lvl" ]] && nodes_at_level+=("$node_id")
        done
        
        if [[ ${#nodes_at_level[@]} -gt 0 ]]; then
            local parallel_label=""
            (( ${#nodes_at_level[@]} > 1 )) && parallel_label=" ${YELLOW}(並列実行可)${NC}"
            
            echo -e "  ${BOLD}Stage $lvl${parallel_label}${NC}"
            
            local stage_max_est=0
            for nid in "${nodes_at_level[@]}"; do
                local name=$(dag_get_name "$nid")
                local est=$(dag_get_est "$nid")
                local deps=$(dag_get_deps "$nid")
                local status="${DAG_STATUS[$nid]:-pending}"
                
                # ステータスアイコン
                local icon="⬜"
                case "$status" in
                    completed) icon="✅" ;;
                    running)   icon="🔄" ;;
                    failed)    icon="❌" ;;
                    skipped)   icon="⏭️" ;;
                esac
                
                local dep_str=""
                [[ -n "$deps" ]] && dep_str=" ← [${deps}]"
                
                echo -e "    ${icon} ${CYAN}${nid}${NC}: ${name} (~${est}min)${dep_str}"
                
                (( est > stage_max_est )) && stage_max_est=$est
            done
            
            total_est=$((total_est + stage_max_est))
            
            if (( lvl < max_level )); then
                echo -e "    ${BLUE}│${NC}"
                echo -e "    ${BLUE}▼${NC}"
            fi
        fi
    done
    
    echo ""
    echo -e "  ${BOLD}推定総実行時間: ~${total_est}分（並列実行時）${NC}"
    echo ""
}

# ============================================================
# DAG実行エンジン
# ============================================================
dag_execute() {
    local session_id="$1"
    local task_desc="$2"
    
    echo -e "\n${BOLD}${PURPLE}[DAG] パイプライン実行開始${NC}"
    echo -e "  セッションID: ${session_id}"
    echo -e "  タスク: ${task_desc}"
    echo ""
    
    local dag_start=$(date +%s)
    local execution_order=()
    local failed_nodes=()
    
    # トポロジカルソート順に実行
    while true; do
        local runnable_nodes=()
        local all_done=true
        
        for node_id in "${!DAG_NODES[@]}"; do
            local status="${DAG_STATUS[$node_id]}"
            
            # 完了・失敗・スキップ済みはスキップ
            [[ "$status" != "pending" ]] && continue
            all_done=false
            
            # 依存関係チェック
            local deps=$(dag_get_deps "$node_id")
            local deps_satisfied=true
            
            if [[ -n "$deps" ]]; then
                IFS=',' read -ra dep_arr <<< "$deps"
                for dep in "${dep_arr[@]}"; do
                    dep=$(echo "$dep" | xargs)
                    [[ -z "$dep" ]] && continue
                    [[ -z "${DAG_NODES[$dep]:-}" ]] && continue
                    
                    local dep_status="${DAG_STATUS[$dep]:-pending}"
                    if [[ "$dep_status" == "pending" || "$dep_status" == "running" ]]; then
                        deps_satisfied=false
                        break
                    elif [[ "$dep_status" == "failed" ]]; then
                        # 依存ノードが失敗 → このノードもスキップ
                        DAG_STATUS[$node_id]="skipped"
                        echo -e "  ⏭️ ${YELLOW}スキップ: $(dag_get_name $node_id)（依存ノード ${dep} が失敗）${NC}"
                        deps_satisfied=false
                        break
                    fi
                done
            fi
            
            [[ "$deps_satisfied" == "true" ]] && runnable_nodes+=("$node_id")
        done
        
        # 全て完了チェック
        [[ "$all_done" == "true" ]] && break
        [[ ${#runnable_nodes[@]} -eq 0 ]] && { echo -e "  ${RED}❌ デッドロック検出: 実行可能なノードがありません${NC}"; break; }
        
        # 実行可能ノードを順次実行（v7.0ではシーケンシャル、将来的に並列化）
        for node_id in "${runnable_nodes[@]}"; do
            local name=$(dag_get_name "$node_id")
            local cmd=$(dag_get_cmd "$node_id")
            
            echo -e "\n${BOLD}═══════════════════════════════════════════════${NC}"
            echo -e "${BOLD}  🔄 [${node_id}] ${name}${NC}"
            echo -e "${BOLD}═══════════════════════════════════════════════${NC}"
            
            DAG_STATUS[$node_id]="running"
            DAG_START_TIME[$node_id]=$(date +%s)
            
            # ノードのコマンドを実行
            if type -t "$cmd" &>/dev/null; then
                if $cmd "$session_id" "$task_desc" 2>&1; then
                    DAG_STATUS[$node_id]="completed"
                    echo -e "  ${GREEN}✅ [${node_id}] 完了${NC}"
                else
                    DAG_STATUS[$node_id]="failed"
                    failed_nodes+=("$node_id")
                    echo -e "  ${RED}❌ [${node_id}] 失敗${NC}"
                    
                    # セルフヒール試行
                    if _dag_self_heal "$node_id" "$session_id" "$task_desc"; then
                        DAG_STATUS[$node_id]="completed"
                        echo -e "  ${GREEN}🔧 [${node_id}] セルフヒールで回復${NC}"
                    fi
                fi
            else
                echo -e "  ${YELLOW}⚠️ コマンド未定義: ${cmd}（スキップ）${NC}"
                DAG_STATUS[$node_id]="completed"
            fi
            
            DAG_END_TIME[$node_id]=$(date +%s)
            execution_order+=("$node_id")
        done
    done
    
    local dag_end=$(date +%s)
    local dag_duration=$((dag_end - dag_start))
    
    # 実行サマリー
    _dag_print_summary "$session_id" "$task_desc" "$dag_duration" "${execution_order[*]}" "${failed_nodes[*]}"
    
    # DAGログ保存
    _dag_save_log "$session_id" "$task_desc" "$dag_duration"
    
    return $(( ${#failed_nodes[@]} > 0 ? 1 : 0 ))
}

# ============================================================
# セルフヒール（v6.0から継承 + DAG対応）
# ============================================================
_dag_self_heal() {
    local node_id="$1"
    local session_id="$2"
    local task_desc="$3"
    local max_retries=2
    
    echo -e "  ${YELLOW}🔧 セルフヒール試行中 (最大${max_retries}回)...${NC}"
    
    for (( retry=1; retry<=max_retries; retry++ )); do
        echo -e "    試行 ${retry}/${max_retries}..."
        
        local cmd=$(dag_get_cmd "$node_id")
        if type -t "$cmd" &>/dev/null && $cmd "$session_id" "$task_desc" 2>&1; then
            return 0
        fi
        
        sleep 2
    done
    
    return 1
}

# ============================================================
# 実行サマリー
# ============================================================
_dag_print_summary() {
    local session_id="$1"
    local task_desc="$2"
    local duration="$3"
    local execution_order="$4"
    local failed_nodes="$5"
    
    local completed=0
    local failed=0
    local skipped=0
    
    for node_id in "${!DAG_STATUS[@]}"; do
        case "${DAG_STATUS[$node_id]}" in
            completed) ((completed++)) ;;
            failed)    ((failed++)) ;;
            skipped)   ((skipped++)) ;;
        esac
    done
    
    local total=${#DAG_NODES[@]}
    local minutes=$((duration / 60))
    local seconds=$((duration % 60))
    
    echo ""
    echo -e "${BOLD}╔═══════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD}║          DAG Pipeline 実行結果                ║${NC}"
    echo -e "${BOLD}╠═══════════════════════════════════════════════╣${NC}"
    echo -e "║ セッション  : ${session_id}"
    echo -e "║ 実行時間    : ${minutes}分${seconds}秒"
    echo -e "║ ノード数    : ${total} (✅${completed} ❌${failed} ⏭️${skipped})"
    
    if [[ $failed -eq 0 ]]; then
        echo -e "║ ステータス  : ${GREEN}SUCCESS${NC}"
    else
        echo -e "║ ステータス  : ${RED}PARTIAL FAILURE${NC}"
        echo -e "║ 失敗ノード  : ${failed_nodes}"
    fi
    
    echo -e "${BOLD}╚═══════════════════════════════════════════════╝${NC}"
}

# ============================================================
# DAGログ保存
# ============================================================
_dag_save_log() {
    local session_id="$1"
    local task_desc="$2"
    local duration="$3"
    local log_file="${DAG_LOG_DIR}/dag_${session_id}.json"
    
    local nodes_json="{"
    local first=true
    for node_id in "${!DAG_NODES[@]}"; do
        [[ "$first" != "true" ]] && nodes_json+=","
        first=false
        local name=$(dag_get_name "$node_id")
        local status="${DAG_STATUS[$node_id]}"
        local start="${DAG_START_TIME[$node_id]:-0}"
        local end="${DAG_END_TIME[$node_id]:-0}"
        nodes_json+="\"${node_id}\":{\"name\":\"${name}\",\"status\":\"${status}\",\"start\":${start},\"end\":${end}}"
    done
    nodes_json+="}"
    
    cat > "$log_file" <<EOF
{
  "session_id": "${session_id}",
  "task": "${task_desc}",
  "duration_seconds": ${duration},
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "dag_version": "7.0",
  "nodes": ${nodes_json}
}
EOF
    
    echo -e "  📝 DAGログ保存: ${log_file}"
}

# ============================================================
# DAGテンプレート（プリセット）
# ============================================================
dag_preset_quick() {
    # Quick: 最小限のノードで高速実行
    DAG_NODES=()
    DAG_STATUS=()
    dag_add_node "REQ" "要件分析" "2" "" "phase_requirements"
    dag_add_node "RAG" "RAG検索" "1" "REQ" "phase_rag_search"
    dag_add_node "IMPL" "実装" "5" "RAG" "phase_implementation"
    dag_add_node "QA" "品質チェック" "3" "IMPL" "phase_quality_check"
    dag_add_node "LEARN" "ナレッジ蓄積" "1" "QA" "phase_knowledge_save"
}

dag_preset_hotfix() {
    # Hotfix: 最小のバグ修正パイプライン
    DAG_NODES=()
    DAG_STATUS=()
    dag_add_node "RAG" "RAG検索（エラーパターン）" "1" "" "phase_rag_search"
    dag_add_node "FIX" "バグ修正" "5" "RAG" "phase_hotfix"
    dag_add_node "TEST" "修正テスト" "3" "FIX" "phase_testing"
    dag_add_node "LEARN" "ナレッジ蓄積" "1" "TEST" "phase_knowledge_save"
}

# ============================================================
# エクスポート（chain.shから使用）
# ============================================================
# このファイルは chain.sh から source される
# 使用例:
#   source lib/dag-pipeline.sh
#   dag_analyze_task "SaaS CRM作って" "deep"
#   dag_execute "session_001" "SaaS CRM作って"
