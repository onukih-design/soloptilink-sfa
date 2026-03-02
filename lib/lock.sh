#!/bin/bash
# ============================================================
# lib/lock.sh — ロックファイル管理
# SoloptiLink Chain Development System v5.3
# ============================================================

# ※ LOCKFILE は呼び出し元で定義済みの前提

cleanup() {
  local exit_code=$?
  rm -f "$LOCKFILE"
  _stop_timeout_watcher 2>/dev/null || true
  if [ $exit_code -ne 0 ]; then
    log_error "チェーンが異常終了しました（exit code: ${exit_code}）"
    log "ロールバック可能: git tag -l 'pre-*' で確認"
  fi
}

acquire_lock() {
  if [ -f "$LOCKFILE" ]; then
    local lock_pid
    lock_pid=$(cat "$LOCKFILE" 2>/dev/null)
    if kill -0 "$lock_pid" 2>/dev/null; then
      log_error "別のchain.shが実行中 (PID: ${lock_pid})。強制解除: rm ${LOCKFILE}"
      exit 1
    else
      log_warn "古いロック削除（PID ${lock_pid} は存在しない）"
      rm -f "$LOCKFILE"
    fi
  fi
  echo $$ > "$LOCKFILE"
}
