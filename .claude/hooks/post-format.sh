#!/bin/bash
# PostToolUse Hook: ファイル変更後に自動リント・フォーマット
# Write|Edit|MultiEdit 後に発火する

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# ファイルパスがなければ何もしない
if [ -z "$FILE" ]; then
  exit 0
fi

# ファイルが存在しなければ何もしない（削除された場合）
if [ ! -f "$FILE" ]; then
  exit 0
fi

# 拡張子に応じたフォーマット
case "$FILE" in
  *.ts|*.tsx|*.js|*.jsx|*.css|*.html|*.json)
    # Prettierが入っていればフォーマット
    if command -v npx &> /dev/null && [ -f "node_modules/.bin/prettier" ]; then
      npx prettier --write "$FILE" 2>/dev/null
    fi
    ;;
  *.py)
    # blackが入っていればフォーマット
    if command -v black &> /dev/null; then
      black --quiet "$FILE" 2>/dev/null
    fi
    ;;
esac

# 常に成功を返す（フォーマット失敗でもブロックしない）
exit 0
