#!/bin/bash
# ============================================================
# Stop Hook v3.1: コスト最適化版 — 10項目強制チェック
# exit 0 = 停止許可 / exit 2 + stderr = 停止ブロック
# ============================================================

INPUT=$(cat)

if [ ! -f "docs/PLAN.md" ]; then
  exit 0
fi

ERRORS=""

# --- 1. インプット原文の保存 ---
if [ ! -f "docs/ORIGINAL_INPUT.md" ]; then
  ERRORS="${ERRORS}・docs/ORIGINAL_INPUT.md が存在しません。ユーザーの原文を保存してください。\n"
fi

# --- 2. 競合調査 ---
if [ ! -f "docs/COMPETITIVE_RESEARCH.md" ]; then
  ERRORS="${ERRORS}・docs/COMPETITIVE_RESEARCH.md が存在しません。競合サービスを調査してください。\n"
fi

# --- 3. PMが構築した要件定義書 ---
if [ ! -f "docs/FULL_REQUIREMENTS.md" ]; then
  ERRORS="${ERRORS}・docs/FULL_REQUIREMENTS.md が存在しません。PMが要件定義書を構築してください。\n"
fi

# --- 4. 要件定義書の品質チェック ---
if [ -f "docs/FULL_REQUIREMENTS.md" ]; then
  HAS_COMP=$(grep -ci "競合\|competitive\|MUST\|SHOULD" docs/FULL_REQUIREMENTS.md 2>/dev/null || echo "0")
  if [ "$HAS_COMP" -lt 3 ]; then
    ERRORS="${ERRORS}・docs/FULL_REQUIREMENTS.md に競合調査結果が十分に反映されていません。\n"
  fi
  HAS_SCREEN=$(grep -ci "画面\|screen\|ページ\|page" docs/FULL_REQUIREMENTS.md 2>/dev/null || echo "0")
  if [ "$HAS_SCREEN" -lt 3 ]; then
    ERRORS="${ERRORS}・docs/FULL_REQUIREMENTS.md に画面定義が不十分です（3画面以上必要）。\n"
  fi
  HAS_API=$(grep -ci "API\|endpoint\|エンドポイント\|GET\|POST\|PUT\|DELETE" docs/FULL_REQUIREMENTS.md 2>/dev/null || echo "0")
  if [ "$HAS_API" -lt 5 ]; then
    ERRORS="${ERRORS}・docs/FULL_REQUIREMENTS.md にAPI定義が不十分です。\n"
  fi
fi

# --- 5. ギャップ分析 ---
if [ ! -f "docs/GAP_ANALYSIS.md" ]; then
  ERRORS="${ERRORS}・docs/GAP_ANALYSIS.md が存在しません。\n"
fi

# --- 6. コスト見積もり（★新規） ---
if [ ! -f "docs/COST_ESTIMATE.md" ]; then
  ERRORS="${ERRORS}・docs/COST_ESTIMATE.md が存在しません。月額ランニングコスト見積もりを作成してください。\n"
fi

# --- 7. コスト設計検証（★新規） ---
if [ -f "docs/COST_ESTIMATE.md" ]; then
  HAS_COST_DATA=$(grep -ci "月額\|monthly\|\$[0-9]\|DeepSeek\|Gemini\|無料" docs/COST_ESTIMATE.md 2>/dev/null || echo "0")
  if [ "$HAS_COST_DATA" -lt 3 ]; then
    ERRORS="${ERRORS}・docs/COST_ESTIMATE.md の内容が不十分です。AI API/インフラ/月額の具体的な数字を記載してください。\n"
  fi
fi

# --- 8. 高額API使用チェック（★新規） ---
if [ -d "src" ]; then
  CLAUDE_API_USAGE=$(grep -ri "api\.anthropic\.com\|claude-3\|claude-sonnet\|claude-opus\|openai\.com\|gpt-4\|gpt-5" src/ 2>/dev/null | grep -v "node_modules\|\.test\.\|\.spec\.\|comment\|//" | wc -l)
  if [ "$CLAUDE_API_USAGE" -gt 0 ]; then
    ERRORS="${ERRORS}・本番コードにClaude/OpenAI APIの直接呼び出しが ${CLAUDE_API_USAGE} 箇所あります。DeepSeek/Geminiに切り替えてください。docs/API_COST_GUIDE.md を参照。\n"
  fi

  # 有料サービスの検出
  PAID_SVC=$(grep -ri "aws-sdk\|@aws-sdk\|firebase-admin\|@google-cloud/\|@azure/\|sendgrid\|@sendgrid\|@sentry/\|datadoghq\|newrelic\|@auth0/" src/ package.json 2>/dev/null | grep -v "node_modules\|\.test\.\|\.spec\.\|//" | wc -l)
  if [ "$PAID_SVC" -gt 0 ]; then
    ERRORS="${ERRORS}・有料サービスのSDKが ${PAID_SVC} 箇所で検出されました。無料代替（Supabase/Cloudflare/Resend等）を使用してください。\n"
  fi
fi

# --- 9. 未完了タスク ---
UNCHECKED=$(grep -c '\- \[ \]' docs/PLAN.md 2>/dev/null || echo "0")
if [ "$UNCHECKED" -gt 0 ]; then
  ERRORS="${ERRORS}・docs/PLAN.md に未完了タスクが ${UNCHECKED} 件あります。\n"
fi

# --- 10. テストレポート + ビルド ---
if [ ! -f "docs/TEST_REPORT.md" ]; then
  ERRORS="${ERRORS}・docs/TEST_REPORT.md が存在しません。\n"
fi

if [ -f "package.json" ]; then
  HAS_BUILD=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.build ? 'yes' : 'no')" 2>/dev/null || echo "no")
  if [ "$HAS_BUILD" = "yes" ]; then
    npm run build > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      ERRORS="${ERRORS}・npm run build が失敗しています。\n"
    fi
  fi
fi

# --- 結果判定 ---
if [ -n "$ERRORS" ]; then
  echo -e "完了条件を満たしていません:\n${ERRORS}\nこれらを全て解決してから完了してください。" >&2
  exit 2
fi

exit 0
