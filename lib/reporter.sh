#!/bin/bash
# ============================================================
# lib/reporter.sh — スコア集計・レポート出力
# SoloptiLink Chain Development System v5.3
# ============================================================

# スコア抽出（macOS互換）
extract_score() {
  local file="$1"
  if [ -f "$file" ]; then
    local score=""
    score=$(grep -Eo '総合スコア[：:][[:space:]]*[0-9]+' "$file" 2>/dev/null | grep -Eo '[0-9]+' | head -1)
    [ -z "$score" ] && score=$(grep -Eo 'Overall[：: ]*[0-9]+' "$file" 2>/dev/null | grep -Eo '[0-9]+' | head -1)
    [ -z "$score" ] && score=$(grep -Eo '[0-9]+[[:space:]]*/[[:space:]]*100' "$file" 2>/dev/null | grep -Eo '^[0-9]+' | head -1)
    echo "${score:-0}"
  else
    echo "0"
  fi
}

# 客観的品質指標収集
collect_objective_metrics() {
  local report_file="${1:-docs/OBJECTIVE_METRICS.md}"
  log "客観的品質指標を収集中..."

  local build_status="N/A" test_pass_rate="N/A" eslint_warnings="N/A"
  local ts_errors="N/A" api_violations="N/A"

  if [ -f "package.json" ]; then
    if npm run build > /tmp/chain-build.log 2>&1; then
      build_status="✅ 成功"
    else
      build_status="❌ 失敗"
    fi
  fi

  if [ -f "package.json" ] && grep -q '"test"' package.json 2>/dev/null; then
    if npx playwright test --reporter=json > /tmp/chain-test.json 2>/dev/null; then
      local total passed
      total=$(grep -Eo '"total":[0-9]+' /tmp/chain-test.json | head -1 | grep -Eo '[0-9]+')
      passed=$(grep -Eo '"passed":[0-9]+' /tmp/chain-test.json | head -1 | grep -Eo '[0-9]+')
      [ -n "$total" ] && [ "$total" -gt 0 ] && test_pass_rate="${passed}/${total} ($((passed * 100 / total))%)"
    fi
  fi

  if command -v npx &>/dev/null && [ -d "src" ]; then
    eslint_warnings=$(npx eslint src/ --format json 2>/dev/null | grep -Eo '"warningCount":[0-9]+' | grep -Eo '[0-9]+' | awk '{sum+=$1} END {print sum+0}')
    eslint_warnings="${eslint_warnings:-N/A}"
  fi

  if [ -f "tsconfig.json" ]; then
    ts_errors=$(npx tsc --noEmit 2>&1 | grep -c "error TS" || echo "0")
  fi

  if [ -d "src" ]; then
    api_violations=$(grep -r 'anthropic\|openai\|ANTHROPIC_API\|OPENAI_API' src/ 2>/dev/null \
      | grep -v 'node_modules\|\.test\.\|\.spec\.\|// allowed' | wc -l || echo "0")
    api_violations="${api_violations//[[:space:]]/}"
  fi

  cat > "$report_file" << METRICS
# 客観的品質指標レポート
生成日時: $(date '+%Y-%m-%d %H:%M:%S')

| 指標 | 結果 | 基準 |
|------|------|------|
| ビルド | ${build_status} | 成功必須 |
| テストpass率 | ${test_pass_rate} | 80%以上推奨 |
| ESLint警告 | ${eslint_warnings} | 0が理想 |
| TypeScriptエラー | ${ts_errors} | 0必須 |
| 禁止API使用 | ${api_violations} 件 | 0必須 |
METRICS

  log_success "客観的指標収集完了 → ${report_file}"

  local penalty=0
  [ "$build_status" = "❌ 失敗" ] && penalty=$((penalty + 20))
  [ "$api_violations" != "N/A" ] && [ "${api_violations:-0}" -gt 0 ] 2>/dev/null && penalty=$((penalty + 10))
  [ "$ts_errors" != "N/A" ] && [ "${ts_errors:-0}" -gt 0 ] 2>/dev/null && penalty=$((penalty + 5))
  echo "$penalty"
}

# 統計表示（ローカル）
show_stats() {
  init_global
  log_phase "ナレッジベース統計（ローカル）"

  echo -e "${BOLD}ナレッジファイル:${NC}"
  for f in "${KNOWLEDGE_DIR}"/*.md; do
    [ -f "$f" ] && echo "  $(basename "$f"): $(wc -c < "$f") bytes, $(grep -c "^### [A-Z]P[0-9]" "$f" 2>/dev/null || echo 0) patterns"
  done

  echo -e "\n${BOLD}品質スコア推移:${NC}"
  if [ -f "${KNOWLEDGE_DIR}/scoring-calibration.md" ]; then
    grep "^|.*20[0-9][0-9]" "${KNOWLEDGE_DIR}/scoring-calibration.md" | tail -20
  else
    echo "  （データなし）"
  fi

  echo -e "\n${BOLD}学習済み知見:${NC}"
  if [ -f "${KNOWLEDGE_DIR}/learned.md" ]; then
    echo "  サイズ: $(wc -c < "${KNOWLEDGE_DIR}/learned.md") bytes"
    echo "  知見数: $(grep -c "^###" "${KNOWLEDGE_DIR}/learned.md" 2>/dev/null || echo 0) items"
  else
    echo "  （学習データなし）"
  fi

  echo -e "\n${BOLD}ロールバックポイント:${NC}"
  git tag -l "pre-*" 2>/dev/null | tail -10 || echo "  （なし）"

  echo -e "\n${BOLD}セッションログ:${NC}"
  echo "  $(ls "${LOG_DIR}"/session-*.log 2>/dev/null | wc -l)回実行"

  echo ""
  local global_size proj_count
  global_size=$(wc -c < "${GLOBAL_KNOWLEDGE_DIR}/global-learned.md" 2>/dev/null || echo 0)
  proj_count=$(wc -l < "${GLOBAL_KNOWLEDGE_DIR}/projects.log" 2>/dev/null || echo 0)
  echo -e "${BOLD}🌐 グローバルナレッジ:${NC} ${global_size} bytes / ${proj_count} プロジェクト"
  echo "  詳細: ./chain.sh --global-stats"
}
