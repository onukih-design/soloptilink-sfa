#!/bin/bash
# ============================================================
# lib/global-knowledge.sh — グローバルナレッジ管理
# SoloptiLink Chain Development System v5.3
# ============================================================

# ※ このファイルは chain.sh から source される前提
# 必要な変数: GLOBAL_DIR, GLOBAL_KNOWLEDGE_DIR, GLOBAL_CONFIG,
#             PROJECT_NAME, PROJECT_PATH, TIMESTAMP, LOG_DIR

# グローバルディレクトリの初期化
init_global() {
  if [ ! -d "$GLOBAL_KNOWLEDGE_DIR" ]; then
    mkdir -p "$GLOBAL_KNOWLEDGE_DIR"
    log_brain "グローバルナレッジ初期化: ${GLOBAL_KNOWLEDGE_DIR}"

    cat > "${GLOBAL_KNOWLEDGE_DIR}/global-learned.md" << 'GLEARNEOF'
# SoloptiLink グローバルナレッジ
# 全プロジェクト横断で蓄積された知見

> このファイルは chain.sh が自動管理します。手動編集も可能です。
GLEARNEOF

    cat > "${GLOBAL_KNOWLEDGE_DIR}/global-calibration.md" << 'GCALEOF'
# グローバルスコア履歴
| 日付 | プロジェクト | ラウンド | スコア | 備考 |
|------|------------|---------|--------|------|
GCALEOF

    touch "${GLOBAL_KNOWLEDGE_DIR}/projects.log"

    cat > "$GLOBAL_CONFIG" << 'GCONFIGEOF'
# SoloptiLink グローバル設定（全プロジェクト共有）
AUTO_SYNC=true
GLOBAL_MAX_SIZE=50000
GLOBAL_INJECT_MAX_LINES=150
GCONFIGEOF

    log_success "グローバルナレッジ初期化完了"
  fi

  if [ -f "$GLOBAL_CONFIG" ]; then
    # shellcheck source=/dev/null
    source "$GLOBAL_CONFIG" 2>/dev/null || true
  fi

  AUTO_SYNC="${AUTO_SYNC:-true}"
  GLOBAL_MAX_SIZE="${GLOBAL_MAX_SIZE:-50000}"
  GLOBAL_INJECT_MAX_LINES="${GLOBAL_INJECT_MAX_LINES:-150}"
}

# プロジェクト登録
register_project() {
  init_global
  local entry
  entry="$(date +%Y-%m-%d) | ${PROJECT_NAME} | ${PROJECT_PATH}"
  if ! grep -qF "${PROJECT_PATH}" "${GLOBAL_KNOWLEDGE_DIR}/projects.log" 2>/dev/null; then
    echo "$entry" >> "${GLOBAL_KNOWLEDGE_DIR}/projects.log"
    log_brain "プロジェクト登録: ${PROJECT_NAME}"
  fi
}

# グローバル → ローカル注入
inject_global_knowledge() {
  init_global
  local global_learned="${GLOBAL_KNOWLEDGE_DIR}/global-learned.md"
  [ ! -f "$global_learned" ] || [ ! -s "$global_learned" ] && return
  local global_size
  global_size=$(wc -c < "$global_learned")
  [ "$global_size" -lt 50 ] && return
  log_brain "グローバルナレッジ注入: ${global_size} bytes"
}

# ローカル → グローバル同期
# ★ 修正: サイズ超過時に自動圧縮 → 再注入（問題1対応）
sync_to_global() {
  init_global

  local local_learned="${KNOWLEDGE_DIR}/learned.md"
  local global_learned="${GLOBAL_KNOWLEDGE_DIR}/global-learned.md"
  local local_calibration="${KNOWLEDGE_DIR}/scoring-calibration.md"
  local global_calibration="${GLOBAL_KNOWLEDGE_DIR}/global-calibration.md"

  if [ ! -f "$local_learned" ]; then
    log_warn "ローカルナレッジなし（同期スキップ）"
    return
  fi

  local global_size
  global_size=$(wc -c < "$global_learned" 2>/dev/null || echo 0)

  {
    echo ""
    echo "---"
    echo "## [${PROJECT_NAME}] 同期日: $(date +%Y-%m-%d) | ソース: ${PROJECT_PATH}"
    tail -n +3 "$local_learned" 2>/dev/null
  } >> "$global_learned"

  local new_global_size
  new_global_size=$(wc -c < "$global_learned")
  log_brain "グローバル同期完了: ${global_size} → ${new_global_size} bytes"

  # スコア履歴同期
  if [ -f "$local_calibration" ]; then
    grep "^|.*20[0-9][0-9]" "$local_calibration" 2>/dev/null >> "$global_calibration" || true
    log_brain "スコア履歴をグローバルに同期"
  fi

  # ★ 自動圧縮トリガー（問題1 修正）
  if [ "$new_global_size" -ge "$GLOBAL_MAX_SIZE" ]; then
    log_warn "グローバルナレッジ上限超過 (${new_global_size}/${GLOBAL_MAX_SIZE} bytes) → 自動圧縮実行"
    compact_global_knowledge
    # 圧縮後に再注入
    inject_global_knowledge
    log_success "自動圧縮 & 再注入完了"
  fi

  log_success "グローバル同期完了"
}

# グローバル → ローカルインポート（新プロジェクト開始時）
import_from_global() {
  init_global

  local global_learned="${GLOBAL_KNOWLEDGE_DIR}/global-learned.md"
  local local_learned="${KNOWLEDGE_DIR}/learned.md"

  if [ ! -f "$global_learned" ] || [ ! -s "$global_learned" ]; then
    log "グローバルナレッジなし（スキップ）"
    return
  fi

  local global_size
  global_size=$(wc -c < "$global_learned")
  [ "$global_size" -lt 50 ] && return

  local local_size
  local_size=$(wc -c < "$local_learned" 2>/dev/null || echo 0)
  if [ "$local_size" -gt 500 ]; then
    log "ローカルに既存ナレッジあり（グローバルインポートをスキップ）"
    return
  fi

  {
    echo "# 学習済みナレッジ"
    echo ""
    echo "---"
    echo "## [グローバルインポート] $(date +%Y-%m-%d)"
    echo "以下は過去の全プロジェクトから蓄積された知見です。"
    echo ""
    tail -n +3 "$global_learned" | head -"${GLOBAL_INJECT_MAX_LINES}"
  } > "$local_learned"

  log_brain "グローバルからインポート: $(wc -c < "$local_learned") bytes (${GLOBAL_INJECT_MAX_LINES}行上限)"
  log_success "過去の全プロジェクトの知見を注入しました"
}

# グローバルナレッジ圧縮（LLMでサマリー化）
compact_global_knowledge() {
  init_global

  local global_learned="${GLOBAL_KNOWLEDGE_DIR}/global-learned.md"
  local global_size
  global_size=$(wc -c < "$global_learned" 2>/dev/null || echo 0)

  if [ "$global_size" -lt "$GLOBAL_MAX_SIZE" ]; then
    log "グローバルナレッジは上限内 (${global_size}/${GLOBAL_MAX_SIZE} bytes)。圧縮不要。"
    return
  fi

  log_brain "グローバルナレッジ圧縮中... (${global_size} bytes → 目標: ${GLOBAL_MAX_SIZE} bytes以下)"

  # バックアップ
  cp "$global_learned" "${global_learned}.bak.${TIMESTAMP}"

  run_claude_with_retry -p "
あなたはナレッジエンジニアです。
以下のナレッジベースを圧縮してください。

## 現在のナレッジ (${global_size} bytes)
$(cat "$global_learned")

## 圧縮ルール
1. 重複する知見を統合する（同じパターンが複数プロジェクトで出ていたらまとめる）
2. 古いプロジェクト固有の情報は削除し、汎用的な知見のみ残す
3. パターン番号（P001, BP001等）は維持する
4. 最終出力は ${GLOBAL_MAX_SIZE} bytes 以下にする
5. 出力形式は現在と同じMarkdown形式

圧縮結果を直接 ${global_learned} に書き込んでください。
" \
    --dangerously-skip-permissions \
    --max-turns 10 \
    --allowedTools "Read,Write" \
    --output-format text \
    2>&1 | tee "${LOG_DIR}/session-compact-${TIMESTAMP}.log"

  local new_size
  new_size=$(wc -c < "$global_learned")
  log_brain "圧縮完了: ${global_size} → ${new_size} bytes"
  log "バックアップ: ${global_learned}.bak.${TIMESTAMP}"
}

# ★ バックアップ機能（改善4）
backup_global() {
  init_global

  local backup_name="soloptilink-knowledge-$(date +%Y%m%d-%H%M%S).tar.gz"
  local backup_path="/tmp/${backup_name}"

  log_brain "グローバルナレッジをバックアップ中..."
  tar -czf "$backup_path" -C "${HOME}" ".soloptilink" 2>/dev/null
  log_success "アーカイブ作成: ${backup_path}"

  # GitHub プライベートリポジトリへ push（設定済みの場合）
  local backup_repo="${SOLOPTILINK_BACKUP_REPO:-}"
  if [ -n "$backup_repo" ]; then
    local tmp_dir
    tmp_dir=$(mktemp -d)
    git clone "$backup_repo" "$tmp_dir" --depth 1 --quiet 2>/dev/null && {
      cp "$backup_path" "$tmp_dir/"
      git -C "$tmp_dir" add -A
      git -C "$tmp_dir" commit -m "backup: ${backup_name}" --quiet
      git -C "$tmp_dir" push --quiet
      rm -rf "$tmp_dir"
      log_success "GitHub へ push 完了: ${backup_repo}"
    } || log_warn "GitHub push 失敗（ローカルバックアップは保存済み）"
  else
    log_warn "SOLOPTILINK_BACKUP_REPO が未設定のためローカルのみ保存"
    log "  設定例: export SOLOPTILINK_BACKUP_REPO=git@github.com:yourname/soloptilink-backup.git"
  fi

  log "バックアップ先: ${backup_path}"
}

# グローバル統計表示
show_global_stats() {
  init_global
  log_phase "グローバルナレッジ統計（全プロジェクト横断）"

  echo -e "${BOLD}グローバルディレクトリ:${NC} ${GLOBAL_DIR}"
  echo ""

  echo -e "${BOLD}登録プロジェクト:${NC}"
  if [ -f "${GLOBAL_KNOWLEDGE_DIR}/projects.log" ] && [ -s "${GLOBAL_KNOWLEDGE_DIR}/projects.log" ]; then
    local proj_count
    proj_count=$(wc -l < "${GLOBAL_KNOWLEDGE_DIR}/projects.log")
    echo "  ${proj_count} プロジェクト登録済み"
    while IFS= read -r line; do
      echo "    ${line}"
    done < "${GLOBAL_KNOWLEDGE_DIR}/projects.log"
  else
    echo "  （まだなし）"
  fi

  echo ""
  echo -e "${BOLD}グローバルナレッジ:${NC}"
  for f in "${GLOBAL_KNOWLEDGE_DIR}"/*.md; do
    [ -f "$f" ] && echo "  $(basename "$f"): $(wc -c < "$f") bytes"
  done

  echo ""
  echo -e "${BOLD}グローバルスコア推移（全プロジェクト）:${NC}"
  if [ -f "${GLOBAL_KNOWLEDGE_DIR}/global-calibration.md" ]; then
    grep "^|.*20[0-9][0-9]" "${GLOBAL_KNOWLEDGE_DIR}/global-calibration.md" 2>/dev/null | tail -20
  else
    echo "  （データなし）"
  fi

  echo ""
  echo -e "${BOLD}設定:${NC}"
  echo "  自動同期: ${AUTO_SYNC:-true}"
  echo "  最大サイズ: ${GLOBAL_MAX_SIZE:-50000} bytes"
  echo "  注入行数上限: ${GLOBAL_INJECT_MAX_LINES:-150} lines"
}
