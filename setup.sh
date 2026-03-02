#!/bin/bash
# ============================================================
# SoloptiLink 自律開発環境 セットアップスクリプト v5.2
# 
# 使い方:
#   chmod +x setup.sh && ./setup.sh
#
# 新しいプロジェクトを始めるとき、最初に1回だけ実行する。
# これにより以下がセットアップされる:
#   - Node.js / Playwright のインストール確認
#   - .claude/ ディレクトリとhooksの配置
#   - Playwrightテストの雛形生成
#   - Git初期化
#   - グローバルナレッジの初期化・インポート（v5.2）
# ============================================================

set -e

echo "========================================"
echo "  自律開発環境セットアップ v5.2"
echo "========================================"
echo ""

# --- 1. 前提条件チェック ---
echo "[1/6] 前提条件チェック..."

# Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js が見つかりません。インストールしてください。"
    echo "   https://nodejs.org/"
    exit 1
fi
echo "  ✅ Node.js $(node --version)"

# npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm が見つかりません。"
    exit 1
fi
echo "  ✅ npm $(npm --version)"

# Claude Code
if ! command -v claude &> /dev/null; then
    echo "⚠️  Claude Code が見つかりません。以下でインストール:"
    echo "   npm install -g @anthropic-ai/claude-code"
fi

# git
if ! command -v git &> /dev/null; then
    echo "❌ git が見つかりません。"
    exit 1
fi
echo "  ✅ git $(git --version | cut -d' ' -f3)"

# jq (hooks で使用)
if ! command -v jq &> /dev/null; then
    echo "⚠️  jq が見つかりません。hooks の動作に必要です。"
    echo "   brew install jq  (macOS)"
    echo "   sudo apt install jq  (Ubuntu)"
fi

echo ""

# --- 2. ディレクトリ構造作成 ---
echo "[2/6] ディレクトリ構造を作成..."

mkdir -p docs
mkdir -p src
mkdir -p tests/e2e
mkdir -p .claude/hooks

echo "  ✅ ディレクトリ作成完了"
echo ""

# --- 3. Hooks 実行権限付与 ---
echo "[3/6] Hooks に実行権限を付与..."

if [ -f ".claude/hooks/stop-check.sh" ]; then
    chmod +x .claude/hooks/stop-check.sh
    echo "  ✅ stop-check.sh に実行権限付与"
else
    echo "  ⚠️  .claude/hooks/stop-check.sh が見つかりません"
fi

if [ -f "chain.sh" ]; then
    chmod +x chain.sh
    echo "  ✅ chain.sh に実行権限付与（チェーン開発）"
fi

echo ""

# --- 4. Playwright セットアップ ---
echo "[4/6] Playwright をセットアップ..."

# package.json がなければ初期化
if [ ! -f "package.json" ]; then
    npm init -y > /dev/null 2>&1
    echo "  ✅ package.json を初期化"
fi

# Playwright インストール
if ! npx playwright --version &> /dev/null 2>&1; then
    echo "  📦 Playwright をインストール中..."
    npm install -D @playwright/test > /dev/null 2>&1
    npx playwright install chromium > /dev/null 2>&1
    echo "  ✅ Playwright インストール完了"
else
    echo "  ✅ Playwright $(npx playwright --version 2>/dev/null) インストール済み"
fi

# playwright.config.ts 生成
if [ ! -f "playwright.config.ts" ]; then
    cat > playwright.config.ts << 'PLAYWRIGHT_CONFIG'
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 1,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  timeout: 30000,

  use: {
    baseURL: process.env.BASE_URL || 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],

  // 開発サーバーを自動起動
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
    timeout: 30000,
  },
});
PLAYWRIGHT_CONFIG
    echo "  ✅ playwright.config.ts を生成"
fi

# サンプルテスト生成
if [ ! -f "tests/e2e/health.spec.ts" ]; then
    cat > tests/e2e/health.spec.ts << 'HEALTH_TEST'
import { test, expect } from '@playwright/test';

test.describe('ヘルスチェック', () => {
  test('トップページが正常に表示される', async ({ page }) => {
    // コンソールエラーを収集
    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // ページにアクセス
    const response = await page.goto('/');
    
    // HTTPステータスが正常
    expect(response?.status()).toBeLessThan(400);
    
    // ページが表示される
    await expect(page.locator('body')).toBeVisible();
    
    // コンソールエラーがない
    expect(errors).toEqual([]);
  });
});
HEALTH_TEST
    echo "  ✅ テスト雛形を生成: tests/e2e/health.spec.ts"
fi

echo ""

# --- 5. Playwright MCP セットアップ ---
echo "[5/7] Playwright MCP を確認..."

if [ -f ".mcp.json" ]; then
    echo "  ✅ .mcp.json 設定済み（Playwright MCP）"
    echo "  ℹ️  Claude Codeが直接ブラウザを操作してテストできます"
else
    echo "  ⚠️  .mcp.json が見つかりません。手動でPlaywright MCPを追加:"
    echo '     claude mcp add playwright -- npx @playwright/mcp@latest'
fi

echo ""

# --- 6. Git 初期化 ---
echo "[6/8] Git を初期化..."

if [ ! -d ".git" ]; then
    git init > /dev/null 2>&1
    echo "  ✅ git init 完了"
fi

# .gitignore
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'GITIGNORE'
node_modules/
dist/
build/
.env
*.log
test-results/
playwright-report/
.DS_Store
__pycache__/
*.pyc
GITIGNORE
    echo "  ✅ .gitignore を生成"
fi

echo ""

# --- 7. グローバルナレッジ初期化（v5.2） ---
echo "[7/8] グローバルナレッジを初期化..."

GLOBAL_DIR="${HOME}/.soloptilink"
GLOBAL_KNOWLEDGE_DIR="${GLOBAL_DIR}/knowledge"

if [ ! -d "$GLOBAL_KNOWLEDGE_DIR" ]; then
    mkdir -p "$GLOBAL_KNOWLEDGE_DIR"
    
    # 初期ファイル
    cat > "${GLOBAL_KNOWLEDGE_DIR}/global-learned.md" << 'GLEARNEOF'
# SoloptiLink グローバルナレッジ
# 全プロジェクト横断で蓄積された知見
GLEARNEOF

    cat > "${GLOBAL_KNOWLEDGE_DIR}/global-calibration.md" << 'GCALEOF'
# グローバルスコア履歴
| 日付 | プロジェクト | ラウンド | スコア | 備考 |
|------|------------|---------|--------|------|
GCALEOF

    touch "${GLOBAL_KNOWLEDGE_DIR}/projects.log"
    
    cat > "${GLOBAL_DIR}/config.sh" << 'GCONFIGEOF'
# SoloptiLink グローバル設定
AUTO_SYNC=true
GLOBAL_MAX_SIZE=50000
GLOBAL_INJECT_MAX_LINES=150
GCONFIGEOF

    echo "  ✅ グローバルナレッジ初期化完了: ${GLOBAL_DIR}"
    echo "  ℹ️  全プロジェクトの知見が ~/.soloptilink/ に蓄積されます"
else
    echo "  ✅ グローバルナレッジ既存: ${GLOBAL_DIR}"
    GLOBAL_SIZE=$(wc -c < "${GLOBAL_KNOWLEDGE_DIR}/global-learned.md" 2>/dev/null || echo 0)
    PROJ_COUNT=$(wc -l < "${GLOBAL_KNOWLEDGE_DIR}/projects.log" 2>/dev/null || echo 0)
    echo "  🧠 蓄積済み: ${GLOBAL_SIZE} bytes / ${PROJ_COUNT} プロジェクト"
    
    # 既存のグローバルナレッジをインポート
    if [ "$GLOBAL_SIZE" -gt 50 ]; then
        echo ""
        echo "  📥 過去のプロジェクトの知見を検出しました。"
        echo "     このプロジェクトに注入しますか？"
        read -p "     [Y/n]: " import_answer
        import_answer="${import_answer:-Y}"
        if [[ "$import_answer" =~ ^[Yy]$ ]]; then
            # chain.sh --import を使用
            if [ -f "chain.sh" ] && [ -x "chain.sh" ]; then
                ./chain.sh --import
            else
                # 直接インポート
                local_learned="docs/knowledge/learned.md"
                mkdir -p docs/knowledge
                {
                    echo "# 学習済みナレッジ"
                    echo ""
                    echo "---"
                    echo "## [グローバルインポート] $(date +%Y-%m-%d)"
                    tail -n +3 "${GLOBAL_KNOWLEDGE_DIR}/global-learned.md" | head -150
                } > "$local_learned"
                echo "  ✅ グローバルナレッジをインポートしました"
            fi
        else
            echo "  ⏭️  スキップ（後で ./chain.sh --import でインポート可能）"
        fi
    fi
fi

# プロジェクト登録
PROJECT_PATH=$(pwd)
PROJECT_NAME=$(basename "$PROJECT_PATH")
ENTRY="$(date +%Y-%m-%d) | ${PROJECT_NAME} | ${PROJECT_PATH}"
if ! grep -qF "${PROJECT_PATH}" "${GLOBAL_KNOWLEDGE_DIR}/projects.log" 2>/dev/null; then
    echo "$ENTRY" >> "${GLOBAL_KNOWLEDGE_DIR}/projects.log"
    echo "  ✅ プロジェクト登録: ${PROJECT_NAME}"
fi

echo ""

# --- 8. 確認 ---
echo "[8/8] セットアップ完了!"
echo ""
echo "========================================"
echo "  📁 ファイル構成"
echo "========================================"
echo ""

# ツリー表示（treeがなければfind）
if command -v tree &> /dev/null; then
    tree -L 2 -a --dirsfirst -I 'node_modules|.git'
else
    find . -maxdepth 2 -not -path '*/node_modules/*' -not -path '*/.git/*' -not -name '.git' | sort | head -30
fi

echo ""
echo "========================================"
echo "  🚀 使い方"
echo "========================================"
echo ""
echo "  1. 要件定義書を docs/REQUIREMENTS.md に配置"
echo ""
echo "  2. Claude Code を起動:"
echo "     claude"
echo ""
echo "  3. 以下を入力:"
echo '     @docs/REQUIREMENTS.md を読んで、このシステムを完成させてください。'
echo '     CLAUDE.md に従って自律的に進めて。テスト全パスまで止まらないで。'
echo ""
echo "  ※ チェーン開発（推奨）:"
echo '     ./chain.sh "タスク管理ツール作って"'
echo ""
echo "  ※ ナレッジ共有コマンド:"
echo "     ./chain.sh --stats           ローカル統計"
echo "     ./chain.sh --global-stats    全プロジェクト統計"
echo "     ./chain.sh --sync            グローバルへ手動同期"
echo "     ./chain.sh --import          グローバルからインポート"
echo ""
