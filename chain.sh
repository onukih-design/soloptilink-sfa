#!/bin/bash
# ============================================================
# SoloptiLink Chain Development System v5.3
#
# v5.3: レビュー指摘対応
#   - 🔴 MAX_ROUNDS 名前付き引数パース修正（問題2）
#   - 🔴 グローバルナレッジ自動圧縮トリガー実装（問題1）
#   - 🟡 セッションタイムアウト警告アラート（残り5分・1分）
#   - 🟡 --backup-global コマンド追加
#   - 🟡 chain.sh を lib/ に機能分割（約180行化）
#   - 🟡 CLAUDE.md を SSOT として明示的に参照するプロンプト整合
#
# 使い方:
#   ./chain.sh "タスク管理ツール作って"
#   ./chain.sh "AIチャットボット付きFAQ" --rounds 3
#   ./chain.sh --review-only / --fix-only / --continue / --learn
#   ./chain.sh --stats / --global-stats / --sync / --import
#   ./chain.sh --compact-global / --backup-global (v5.3)
# ============================================================

set -uo pipefail

# --- 設定 ---
MAX_ROUNDS=2
MAX_TURNS_DEV=200; MAX_TURNS_REVIEW=30; MAX_TURNS_META=15; MAX_TURNS_FIX=100
QUALITY_THRESHOLD=85; SESSION_TIMEOUT=1800; MAX_RETRIES=2
LOG_DIR="docs/chain-logs"; KNOWLEDGE_DIR="docs/knowledge"
TIMESTAMP=$(date +%Y%m%d-%H%M%S); LOCKFILE="/tmp/soloptilink-chain.lock"
GLOBAL_DIR="${HOME}/.soloptilink"
GLOBAL_KNOWLEDGE_DIR="${GLOBAL_DIR}/knowledge"
GLOBAL_CONFIG="${GLOBAL_DIR}/config.sh"
PROJECT_NAME=$(basename "$(pwd)"); PROJECT_PATH=$(pwd)

# --- 色 & ログ ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; MAGENTA='\033[0;35m'; BOLD='\033[1m'; NC='\033[0m'
log()         { echo -e "${CYAN}[CHAIN]${NC} $1"; }
log_phase()   { echo -e "\n${BOLD}${BLUE}════════════════════════════════════════${NC}\n${BOLD}${BLUE}  $1${NC}\n${BOLD}${BLUE}════════════════════════════════════════${NC}\n"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warn()    { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error()   { echo -e "${RED}❌ $1${NC}"; }
log_brain()   { echo -e "${MAGENTA}🧠 $1${NC}"; }

# --- lib/ モジュール読み込み ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/lock.sh"
source "${SCRIPT_DIR}/lib/session.sh"
source "${SCRIPT_DIR}/lib/global-knowledge.sh"
source "${SCRIPT_DIR}/lib/reporter.sh"

trap 'cleanup' EXIT INT TERM
mkdir -p "$LOG_DIR" "$KNOWLEDGE_DIR"

# ============================================================
# ★ 引数パース（問題2修正: named argument 対応）
# ============================================================
INPUT=""; MODE="full"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --rounds)
      shift
      if [[ "${1:-}" =~ ^[0-9]+$ ]]; then MAX_ROUNDS="$1"; shift
      else log_error "--rounds の後に数値が必要です"; exit 1; fi ;;
    --review-only)    MODE="review";   shift ;;
    --fix-only)       MODE="fix";      shift ;;
    --continue)       MODE="continue"; shift ;;
    --learn)          MODE="learn";    shift ;;
    --stats)          show_stats; exit 0 ;;
    --global-stats)   show_global_stats; exit 0 ;;
    --sync)           register_project; sync_to_global; exit 0 ;;
    --import)         register_project; import_from_global; exit 0 ;;
    --compact-global) compact_global_knowledge; exit 0 ;;
    --backup-global)  backup_global; exit 0 ;;
    --help|-h)
      echo "使い方:"
      echo "  ./chain.sh \"作りたいもの\"              全自動開発"
      echo "  ./chain.sh \"作りたいもの\" --rounds 3   3ラウンド"
      echo "  ./chain.sh --review-only               レビューのみ"
      echo "  ./chain.sh --fix-only                  修正のみ"
      echo "  ./chain.sh --continue                  続きから"
      echo "  ./chain.sh --stats                     ローカル統計"
      echo ""
      echo "  ナレッジ共有:"
      echo "  ./chain.sh --sync                      ローカル→グローバル同期"
      echo "  ./chain.sh --import                    グローバル→ローカル注入"
      echo "  ./chain.sh --global-stats              全プロジェクト横断統計"
      echo "  ./chain.sh --compact-global            グローバルナレッジ圧縮"
      echo "  ./chain.sh --backup-global             バックアップ (v5.3新機能)"
      exit 0 ;;
    -*) log_error "不明なオプション: $1"; exit 1 ;;
    *)  INPUT="$1"; shift ;;
  esac
done

# ============================================================
# ナレッジエンジン
# ============================================================
load_knowledge() {
  local ctx=""
  [ -f "${KNOWLEDGE_DIR}/review-patterns.md" ] && ctx="${ctx}
## 過去のレビューで頻出した問題パターン
$(grep -A4 "^### P[0-9]" "${KNOWLEDGE_DIR}/review-patterns.md" | head -120)"
  [ -f "${KNOWLEDGE_DIR}/best-practices.md" ] && ctx="${ctx}
## SoloptiLink 開発ベストプラクティス
$(grep -A6 "^### BP[0-9]" "${KNOWLEDGE_DIR}/best-practices.md" | head -120)"
  [ -f "${KNOWLEDGE_DIR}/anti-patterns.md" ] && ctx="${ctx}
## やってはいけないアンチパターン
$(grep -A2 "^### AP[0-9]" "${KNOWLEDGE_DIR}/anti-patterns.md" | head -60)"
  [ -f "${KNOWLEDGE_DIR}/learned.md" ] && ctx="${ctx}
## 過去のプロジェクトから学習した知見
$(tail -100 "${KNOWLEDGE_DIR}/learned.md")"
  local gl="${GLOBAL_KNOWLEDGE_DIR}/global-learned.md"
  if [ -f "$gl" ] && [ "$(wc -c < "$gl")" -gt 50 ]; then
    ctx="${ctx}
## ★ 全プロジェクト横断の知見（グローバルナレッジ）
$(tail -"${GLOBAL_INJECT_MAX_LINES:-150}" "$gl")"
    log_brain "グローバルナレッジ注入（$(wc -c < "$gl") bytes）"
  fi
  echo "$ctx"
}

accumulate_knowledge() {
  local review_file="$1" round="$2"
  [ ! -f "$review_file" ] && return
  log_brain "ナレッジ蓄積中..."
  run_claude_with_retry -p "
あなたはナレッジエンジニアです。以下のレビューから将来に使える汎用知見を抽出して ${KNOWLEDGE_DIR}/learned.md に追記してください。
新規知見がなければ「新規知見なし」と書いてください。
---
$(cat "$review_file")" \
    --dangerously-skip-permissions --max-turns "$MAX_TURNS_META" \
    --allowedTools "Read,Write,Glob,Grep" --output-format text \
    2>&1 | tee "${LOG_DIR}/session-learn-r${round}-${TIMESTAMP}.log"
  log_brain "ナレッジ蓄積完了"
}

# ============================================================
# PHASE 1: 開発
# ============================================================
run_develop() {
  local input="$1"
  log_phase "SESSION 1: 開発"; log "入力: ${input}"
  create_rollback_point "develop"; echo "$input" > docs/ORIGINAL_INPUT.md
  local dev_kn=""
  [ -f "${KNOWLEDGE_DIR}/best-practices.md" ] && dev_kn="
## ★ SoloptiLink開発ベストプラクティス（自動注入）
$(grep -A6 "^### BP[0-9]" "${KNOWLEDGE_DIR}/best-practices.md" | head -80)"
  [ -f "${KNOWLEDGE_DIR}/anti-patterns.md" ] && dev_kn="${dev_kn}
## ★ アンチパターン（自動注入）
$(grep -A2 "^### AP[0-9]" "${KNOWLEDGE_DIR}/anti-patterns.md" | head -40)"
  # ★ 改善1: CLAUDE.md を SSOT として明示参照
  run_claude_with_retry -p "
@.claude/agents/pm.md
【CLAUDE.mdを最初に必ず読んでください。CLAUDE.mdがこのプロジェクトの唯一の真実（SSOT）です。】

以下のシステムを開発してください: ${input}
${dev_kn}
テスト全パスまで止まらないでください。
最後に docs/SESSION_DEVELOP.md に実装概要を記録してください。" \
    --dangerously-skip-permissions --max-turns "$MAX_TURNS_DEV" --output-format text \
    2>&1 | tee "${LOG_DIR}/session-develop-${TIMESTAMP}.log"
  checkpoint "develop-complete"; log_success "開発セッション完了"
}

# ============================================================
# PHASE 2: レビュー
# ============================================================
run_review() {
  local round="$1"
  log_phase "SESSION R${round}: レビュー"
  local kn rf mf penalty obj_data score cs pn
  kn=$(load_knowledge); rf="docs/REVIEW_REPORT_R${round}.md"; mf="docs/OBJECTIVE_METRICS_R${round}.md"
  penalty=$(collect_objective_metrics "$mf")
  obj_data=""; [ -f "$mf" ] && obj_data="
## ★★★ 客観的品質指標 ★★★
$(cat "$mf")"
  run_claude_with_retry -p "
あなたはシニアコードレビュアーです。
【CLAUDE.mdを最初に必ず読んでください。CLAUDE.mdがこのプロジェクトの唯一の真実（SSOT）です。】

## ナレッジベース
${kn}
${obj_data}

レビュー手順: 1.CLAUDE.md → 2.docs/FULL_REQUIREMENTS.md → 3.src/ → 4.テスト・ビルド → 5.ナレッジ照合
各10点・計100点で採点し ${rf} に出力してください。正直に厳しくレビューしてください。" \
    --dangerously-skip-permissions --max-turns "$MAX_TURNS_REVIEW" \
    --allowedTools "Read,Glob,Grep,Bash" --output-format text \
    2>&1 | tee "${LOG_DIR}/session-review-r${round}-${TIMESTAMP}.log"
  checkpoint "review-r${round}-complete"; accumulate_knowledge "$rf" "$round"
  score=$(extract_score "$rf"); cs=$((score - penalty)); [ $cs -lt 0 ] && cs=0
  pn=$(head -1 docs/ORIGINAL_INPUT.md 2>/dev/null | cut -c1-30 || echo "unknown")
  echo "| $(date +%Y-%m-%d) | ${pn} | R${round}: ${score}/${cs} | -${penalty} |" >> "${KNOWLEDGE_DIR}/scoring-calibration.md"
  log "スコア: ${score}/100（補正後: ${cs}, ペナルティ: -${penalty}）"
  [ "$cs" -ge "$QUALITY_THRESHOLD" ] && { log_success "品質閾値達成！"; return 0; } || { log_warn "品質閾値未達 → 修正へ"; return 1; }
}

# ============================================================
# PHASE 3: 修正
# ============================================================
run_fix() {
  local round="$1"
  log_phase "SESSION F${round}: 修正"; create_rollback_point "fix-r${round}"
  local rf="docs/REVIEW_REPORT_R${round}.md"
  [ ! -f "$rf" ] && { log_error "${rf} が見つかりません"; return 1; }
  local fkn="" minfo=""
  [ -f "${KNOWLEDGE_DIR}/best-practices.md" ] && fkn="
## ★ 修正時ベストプラクティス
$(grep -A6 "^### BP[0-9]" "${KNOWLEDGE_DIR}/best-practices.md" | head -80)"
  local mf="docs/OBJECTIVE_METRICS_R${round}.md"
  [ -f "$mf" ] && minfo="
## ★ 客観的品質指標
$(cat "$mf")"
  run_claude_with_retry -p "
あなたはシニア開発者です。
【CLAUDE.mdを最初に必ず読んでください。CLAUDE.mdがこのプロジェクトの唯一の真実（SSOT）です。】

${fkn}
${minfo}

${rf} を読んで全問題を修正してください。
手順: CLAUDE.md → ${rf} → 優先度高→中→低 → npm run build → テスト全pass
ルール: AI APIはDeepSeek/Geminiのみ（Claude/OpenAI禁止）・DBはSQLite優先
完了後 docs/SESSION_FIX_R${round}.md に記録してください。" \
    --dangerously-skip-permissions --max-turns "$MAX_TURNS_FIX" --output-format text \
    2>&1 | tee "${LOG_DIR}/session-fix-r${round}-${TIMESTAMP}.log"
  checkpoint "fix-r${round}-complete"; log_success "修正セッション Round ${round} 完了"
}

# ============================================================
# メインフロー
# ============================================================
init_global
[ "$MODE" = "full" ] && [ -z "$INPUT" ] && { log_error "開発するものを指定してください"; exit 1; }
acquire_lock
register_project
[ "${AUTO_SYNC:-true}" = "true" ] && import_from_global

KNOWLEDGE_SIZE=0
for f in "${KNOWLEDGE_DIR}"/*.md; do [ -f "$f" ] && KNOWLEDGE_SIZE=$((KNOWLEDGE_SIZE + $(wc -c < "$f"))); done
GLOBAL_KB_SIZE=$(wc -c < "${GLOBAL_KNOWLEDGE_DIR}/global-learned.md" 2>/dev/null || echo 0)

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║  SoloptiLink Chain Development System v5.3          ║${NC}"
echo -e "${BOLD}║  ナレッジ搭載マルチセッション自動開発                  ║${NC}"
echo -e "${BOLD}╠══════════════════════════════════════════════════════╣${NC}"
echo -e "${BOLD}║  モード: ${MODE}  |  ラウンド: ${MAX_ROUNDS}  |  閾値: ${QUALITY_THRESHOLD}           ║${NC}"
echo -e "${BOLD}║  タイムアウト: ${SESSION_TIMEOUT}秒  |  リトライ: ${MAX_RETRIES}回              ║${NC}"
echo -e "${BOLD}║  ${MAGENTA}🧠 ローカル: ${KNOWLEDGE_SIZE} bytes  🌐 グローバル: ${GLOBAL_KB_SIZE} bytes${NC}${BOLD}  ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

case "$MODE" in
  full)
    run_develop "$INPUT"
    for round in $(seq 1 "$MAX_ROUNDS"); do
      log "━━━ ラウンド ${round}/${MAX_ROUNDS} ━━━"
      run_review "$round" && { log_success "品質OK！チェーン完了"; break; }
      run_fix "$round"
    done ;;
  review)  run_review 1 ;;
  fix)
    latest=$(ls -t docs/REVIEW_REPORT_R*.md 2>/dev/null | head -1)
    [ -z "$latest" ] && { log_error "レビューレポートなし"; exit 1; }
    run_fix "$(echo "$latest" | grep -Eo 'R[0-9]+' | grep -Eo '[0-9]+')" ;;
  continue)
    lr=$(ls -t docs/REVIEW_REPORT_R*.md 2>/dev/null | head -1)
    lf=$(ls -t docs/SESSION_FIX_R*.md 2>/dev/null | head -1)
    if [ -z "$lr" ]; then run_review 1; run_fix 1
    elif [ -z "$lf" ]; then run_fix "$(echo "$lr" | grep -Eo 'R[0-9]+' | grep -Eo '[0-9]+')"
    else
      fr=$(echo "$lf" | grep -Eo 'R[0-9]+' | grep -Eo '[0-9]+')
      for round in $(seq $((fr + 1)) "$MAX_ROUNDS"); do
        run_review "$round" && { log_success "品質OK！チェーン完了"; break; }
        run_fix "$round"
      done
    fi ;;
  learn)
    lr=$(ls -t docs/REVIEW_REPORT_R*.md 2>/dev/null | head -1)
    [ -n "$lr" ] && accumulate_knowledge "$lr" "$(echo "$lr" | grep -Eo 'R[0-9]+' | grep -Eo '[0-9]+')" || log_error "レビューレポートなし" ;;
esac

# --- 最終サマリー ---
log_phase "チェーン完了サマリー"
for f in docs/REVIEW_REPORT_R*.md; do
  [ -f "$f" ] || continue
  s=$(extract_score "$f"); r=$(echo "$f" | grep -Eo 'R[0-9]+' | grep -Eo '[0-9]+')
  bar=""; for i in $(seq 1 $((s / 5))); do bar="${bar}█"; done
  echo -e "  Round ${r}: ${s}/100 ${GREEN}${bar}${NC}"
done

FINAL_KNOWLEDGE_SIZE=0
for f in "${KNOWLEDGE_DIR}"/*.md; do [ -f "$f" ] && FINAL_KNOWLEDGE_SIZE=$((FINAL_KNOWLEDGE_SIZE + $(wc -c < "$f"))); done
echo -e "\n🧠 ナレッジ: ${KNOWLEDGE_SIZE} → ${FINAL_KNOWLEDGE_SIZE} bytes"

[ "${AUTO_SYNC:-true}" = "true" ] && { log_brain "グローバル自動同期中..."; sync_to_global; }
log_success "全セッション完了"
