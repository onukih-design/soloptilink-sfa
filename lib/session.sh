#!/bin/bash
# ============================================================
# lib/session.sh — セッション実行・タイムアウト制御
# SoloptiLink Chain Development System v5.3
# ============================================================
# ★ 改善3: タイムアウト警告アラート機能を追加

# タイムアウト監視プロセスのPID
_TIMEOUT_WATCHER_PID=""

# バックグラウンドでカウントダウン監視を起動
# 残り5分・1分でターミナル通知
_start_timeout_watcher() {
  local total_secs="${SESSION_TIMEOUT:-1800}"
  (
    sleep "$((total_secs - 300))"  # 残り5分
    echo -e "\n\033[1;33m⚠️  [CHAIN] セッションタイムアウトまで残り 5分 です！\033[0m" >&2
    sleep 240  # 残り1分
    echo -e "\n\033[0;31m🚨 [CHAIN] セッションタイムアウトまで残り 1分 です！\033[0m" >&2
  ) &
  _TIMEOUT_WATCHER_PID=$!
}

# 監視プロセスを停止
_stop_timeout_watcher() {
  if [ -n "$_TIMEOUT_WATCHER_PID" ] && kill -0 "$_TIMEOUT_WATCHER_PID" 2>/dev/null; then
    kill "$_TIMEOUT_WATCHER_PID" 2>/dev/null || true
    _TIMEOUT_WATCHER_PID=""
  fi
}

# リトライ付き claude 実行（タイムアウト警告対応）
run_claude_with_retry() {
  local retry=0 exit_code=1

  while [ $retry -le $MAX_RETRIES ]; do
    [ $retry -gt 0 ] && { log_warn "リトライ ${retry}/${MAX_RETRIES}..."; sleep 5; }

    # ★ タイムアウト監視を起動（5分前・1分前に警告）
    _start_timeout_watcher

    if timeout "$SESSION_TIMEOUT" claude "$@"; then
      _stop_timeout_watcher
      return 0
    else
      exit_code=$?
      _stop_timeout_watcher
      if [ $exit_code -eq 124 ]; then
        log_error "タイムアウト（${SESSION_TIMEOUT}秒）"
      else
        log_error "claude失敗（exit: ${exit_code}）"
      fi
    fi

    retry=$((retry + 1))
  done

  return $exit_code
}

# ロールバックポイント作成
create_rollback_point() {
  local label="$1"
  git add -A 2>/dev/null || true
  git commit -m "chain: ${label} [${TIMESTAMP}]" --allow-empty 2>/dev/null || true
  git tag "pre-${label}-${TIMESTAMP}" 2>/dev/null || true
  log "ロールバックポイント: pre-${label}-${TIMESTAMP}"
}

# Git チェックポイント
checkpoint() {
  local label="$1"
  git add -A 2>/dev/null || true
  git commit -m "chain: ${label} [${TIMESTAMP}]" --allow-empty 2>/dev/null || true
  log "Git checkpoint: ${label}"
}
