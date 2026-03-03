#!/usr/bin/env bash
# ============================================================
# SoloptiLink Chain v9.0 - Prompt Expander Module
# ============================================================
# 曖昧な一言指示（「家計簿作って」「CRM作って」等）を受け取り、
# ドメイン判定 → 競合調査 → 要件展開 → 技術選定 → 設計書生成
# までを自動実行し、コード生成前に完全なプロジェクト設計書を作る。
#
# これにより「一言言っただけで完璧なものが出来上がる」体験を実現。
# ============================================================
# sourceされるライブラリなので set -euo pipefail は設定しない

# ============================================================
# カラー定義（PE_プレフィックスで他モジュールとの衝突を防止）
# ============================================================
PE_GREEN='\033[0;32m'
PE_YELLOW='\033[0;33m'
PE_RED='\033[0;31m'
PE_BLUE='\033[0;34m'
PE_PURPLE='\033[0;35m'
PE_CYAN='\033[0;36m'
PE_BOLD='\033[1m'
PE_NC='\033[0m'

# 設定
PE_WORK_DIR="${HOME}/.soloptilink/prompt-expander"
PE_CLAUDE_TIMEOUT=300
PE_MAX_RETRIES=3

# ============================================================
# 初期化
# ============================================================
prompt_expand_init() {
    mkdir -p "${PE_WORK_DIR}" 2>/dev/null || true
    _pe_log "INFO" "Prompt Expander v9.0 初期化完了"
    _pe_log "INFO" "作業ディレクトリ: ${PE_WORK_DIR}"
}

# ============================================================
# ログ出力
# ============================================================
_pe_log() {
    local level="$1" message="$2"
    local color="${PE_NC}"
    case "$level" in
        INFO)    color="${PE_CYAN}"   ;;
        SUCCESS) color="${PE_GREEN}"  ;;
        WARN)    color="${PE_YELLOW}" ;;
        ERROR)   color="${PE_RED}"    ;;
        STEP)    color="${PE_PURPLE}" ;;
    esac
    echo -e "  ${color}[PE:${level}]${PE_NC} ${message}"
}

# ============================================================
# Claude CLI呼び出しラッパー（リトライ付き）
# ============================================================
_pe_call_claude() {
    local prompt="$1"
    local output_file="${2:-}"
    local retry=0
    local result=""

    while [[ "$retry" -lt "$PE_MAX_RETRIES" ]]; do
        retry=$((retry + 1))
        result=$(timeout "${PE_CLAUDE_TIMEOUT}" \
            claude -p --dangerously-skip-permissions \
            --output-format text "$prompt" 2>/dev/null || echo "")

        if [[ -n "$result" ]]; then
            # 出力ファイルが指定されていれば書き込み
            if [[ -n "$output_file" ]]; then
                mkdir -p "$(dirname "$output_file")" 2>/dev/null || true
                printf '%s\n' "$result" > "$output_file"
            fi
            echo "$result"
            return 0
        fi
        _pe_log "WARN" "Claude CLI応答なし (試行 ${retry}/${PE_MAX_RETRIES})"
        sleep $((retry * 3))
    done

    _pe_log "ERROR" "Claude CLI: 全リトライ失敗"
    return 1
}

# ============================================================
# メイン関数: prompt_expand(task_desc, output_dir)
# ============================================================
# 曖昧なタスク指示を完全なプロジェクト設計書に展開する
# 戻り値: project_blueprint.md のパス
prompt_expand() {
    local task_desc="${1:-}"
    local output_dir="${2:-}"

    if [[ -z "$task_desc" ]]; then
        _pe_log "ERROR" "タスク説明が空です"
        return 1
    fi

    # 出力ディレクトリが未指定ならデフォルト
    if [[ -z "$output_dir" ]]; then
        output_dir="${PE_WORK_DIR}/expand_$(date +%Y%m%d_%H%M%S)_$$"
    fi
    mkdir -p "$output_dir" 2>/dev/null || true

    echo ""
    echo -e "${PE_BOLD}${PE_PURPLE}╔═══════════════════════════════════════════════════════╗${PE_NC}"
    echo -e "${PE_BOLD}${PE_PURPLE}║   Prompt Expander v9.0 - 設計書自動生成               ║${PE_NC}"
    echo -e "${PE_BOLD}${PE_PURPLE}╚═══════════════════════════════════════════════════════╝${PE_NC}"
    echo -e "  タスク: ${PE_CYAN}${task_desc}${PE_NC}"
    echo -e "  出力先: ${PE_CYAN}${output_dir}${PE_NC}"
    echo ""

    local start_time
    start_time=$(date +%s)

    # ── Step 1: ドメイン判定 ──────────────────────────────
    _pe_log "STEP" "[1/5] ドメイン判定中..."
    local domain
    domain=$(_pe_detect_domain "$task_desc")
    if [[ -z "$domain" ]]; then
        _pe_log "ERROR" "ドメイン判定に失敗"
        return 1
    fi
    _pe_log "SUCCESS" "ドメイン: ${domain}"
    echo "$domain" > "${output_dir}/domain.txt"

    # ── Step 2: 競合調査 ──────────────────────────────────
    _pe_log "STEP" "[2/5] 競合・市場調査中..."
    local competitor_file="${output_dir}/competitor_analysis.md"
    if ! _pe_research_competitors "$task_desc" "$domain" "$competitor_file"; then
        _pe_log "WARN" "競合調査に一部失敗（続行します）"
    fi
    _pe_log "SUCCESS" "競合調査完了 → $(basename "$competitor_file")"

    # ── Step 3: 要件展開 ──────────────────────────────────
    _pe_log "STEP" "[3/5] 要件仕様書を生成中..."
    local requirements_file="${output_dir}/expanded_requirements.md"
    if ! _pe_expand_requirements "$task_desc" "$domain" "$competitor_file" "$requirements_file"; then
        _pe_log "ERROR" "要件展開に失敗"
        return 1
    fi
    _pe_log "SUCCESS" "要件仕様書完了 → $(basename "$requirements_file")"

    # ── Step 4: 技術選定 ──────────────────────────────────
    _pe_log "STEP" "[4/5] 最適技術スタックを選定中..."
    local tech_stack_file="${output_dir}/tech_stack.md"
    if ! _pe_select_tech_stack "$task_desc" "$domain" "$requirements_file" "$tech_stack_file"; then
        _pe_log "WARN" "技術選定に一部失敗（続行します）"
    fi
    _pe_log "SUCCESS" "技術スタック選定完了 → $(basename "$tech_stack_file")"

    # ── Step 5: プロジェクト設計書生成 ────────────────────
    _pe_log "STEP" "[5/5] プロジェクト設計書を生成中..."
    local blueprint_file="${output_dir}/project_blueprint.md"
    if ! _pe_generate_blueprint "$requirements_file" "$tech_stack_file" "$blueprint_file"; then
        _pe_log "ERROR" "設計書生成に失敗"
        return 1
    fi
    _pe_log "SUCCESS" "プロジェクト設計書完了 → $(basename "$blueprint_file")"

    # ── 完了サマリー ──────────────────────────────────────
    local end_time elapsed_sec
    end_time=$(date +%s)
    elapsed_sec=$((end_time - start_time))

    echo ""
    echo -e "${PE_BOLD}${PE_GREEN}╔═══════════════════════════════════════════════════════╗${PE_NC}"
    echo -e "${PE_BOLD}${PE_GREEN}║   Prompt Expansion 完了                               ║${PE_NC}"
    echo -e "${PE_BOLD}${PE_GREEN}╠═══════════════════════════════════════════════════════╣${PE_NC}"
    echo -e "  ドメイン      : ${PE_CYAN}${domain}${PE_NC}"
    echo -e "  所要時間      : ${elapsed_sec}秒"
    echo -e "  生成ファイル  :"
    echo -e "    ${PE_BLUE}1.${PE_NC} competitor_analysis.md   (競合調査)"
    echo -e "    ${PE_BLUE}2.${PE_NC} expanded_requirements.md (要件仕様)"
    echo -e "    ${PE_BLUE}3.${PE_NC} tech_stack.md            (技術選定)"
    echo -e "    ${PE_BLUE}4.${PE_NC} project_blueprint.md     (設計書)"
    echo -e "${PE_BOLD}${PE_GREEN}╚═══════════════════════════════════════════════════════╝${PE_NC}"
    echo ""

    # 設計書パスを返す（呼び出し元がキャプチャ可能）
    echo "${blueprint_file}"
    return 0
}

# ============================================================
# Step 1: ドメイン判定
# ============================================================
# 正規表現による高速判定 → 不明な場合はClaudeに委任
_pe_detect_domain() {
    local task_desc="$1"
    local task_lower
    task_lower=$(echo "$task_desc" | tr '[:upper:]' '[:lower:]')

    # 正規表現によるキーワードマッチング（日本語 + 英語）
    if [[ "$task_lower" =~ (家計簿|会計|支出|収入|経費|finance|accounting|budget|expense|income|ledger) ]]; then
        echo "finance"; return 0
    fi
    if [[ "$task_lower" =~ (crm|顧客管理|顧客|営業管理|営業|商談|リード|customer|sales|lead) ]]; then
        echo "crm"; return 0
    fi
    if [[ "$task_lower" =~ (チャット|メッセージ|dm|chat|messenger|messaging|リアルタイム通信) ]]; then
        echo "chat"; return 0
    fi
    if [[ "$task_lower" =~ (ec|ecommerce|ショップ|通販|商品|カート|決済|shop|store|cart|payment) ]]; then
        echo "ecommerce"; return 0
    fi
    if [[ "$task_lower" =~ (タスク|todo|プロジェクト管理|進捗|カンバン|task|kanban|project.management|issue.tracker) ]]; then
        echo "task-management"; return 0
    fi
    if [[ "$task_lower" =~ (sns|ソーシャル|投稿|フォロー|タイムライン|social|feed|timeline|follow|post) ]]; then
        echo "social"; return 0
    fi
    if [[ "$task_lower" =~ (ブログ|記事|コンテンツ|cms|blog|article|content|publish|editor) ]]; then
        echo "content"; return 0
    fi
    if [[ "$task_lower" =~ (ダッシュボード|分析|レポート|analytics|dashboard|report|metrics|bi|visualization) ]]; then
        echo "analytics"; return 0
    fi
    if [[ "$task_lower" =~ (lp|ランディング|landing.page|ランディングページ|集客|サービス紹介) ]]; then
        echo "landing-page"; return 0
    fi
    if [[ "$task_lower" =~ (予約|booking|reservation|スケジュール|カレンダー|calendar|appointment) ]]; then
        echo "booking"; return 0
    fi
    if [[ "$task_lower" =~ (在庫|inventory|倉庫|warehouse|物流|logistics|stock) ]]; then
        echo "inventory"; return 0
    fi

    # 正規表現で判定不能 → Claudeに委任
    _pe_log "INFO" "キーワードマッチ不一致 → Claudeで分類中..."
    local claude_domain
    claude_domain=$(_pe_call_claude "以下のタスク説明を読んで、最も適切なドメインカテゴリを1単語で答えてください。
選択肢: finance, crm, chat, ecommerce, task-management, social, content, analytics, landing-page, booking, inventory, general

タスク: ${task_desc}

カテゴリ名のみを返してください。余分な説明は不要です。")

    # Claudeの応答をクリーンアップ（改行・空白除去、小文字化）
    claude_domain=$(echo "$claude_domain" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]' | head -c 30)

    # 有効なドメインか確認
    case "$claude_domain" in
        finance|crm|chat|ecommerce|task-management|social|content|analytics|landing-page|booking|inventory|general)
            echo "$claude_domain"
            return 0
            ;;
        *)
            _pe_log "WARN" "Claude判定結果不明: '${claude_domain}' → generalにフォールバック"
            echo "general"
            return 0
            ;;
    esac
}

# ============================================================
# Step 2: 競合調査
# ============================================================
_pe_research_competitors() {
    local task_desc="$1"
    local domain="$2"
    local output_file="$3"

    local prompt="あなたは市場調査のプロフェッショナルアナリストです。

ドメイン「${domain}」における既存アプリ/サービスを調査し、以下のフォーマットでMarkdownレポートを作成してください。

# 競合分析レポート: ${domain}

## タスクコンテキスト
${task_desc}

## 調査内容

### 1. トップ5 競合アプリ/サービス
各サービスについて以下を記載:
- **名前**: サービス名
- **概要**: 1-2文の説明
- **主要機能**: 箇条書き（5-8個）
- **ユニークセリングポイント**: 他との差別化要素
- **技術アプローチ**: 推定される技術スタック（分かる範囲で）
- **料金体系**: フリーミアム/有料等

### 2. ユーザーが期待するトップ10機能
このドメインのアプリに対してユーザーが最も期待する機能を優先度順に10個リストアップ。
各機能に「必須/推奨/あると嬉しい」のラベルを付与。

### 3. 業界ベストプラクティス
- UX/UIのベストプラクティス（3-5個）
- データ設計のベストプラクティス（3-5個）
- セキュリティ要件（3-5個）

### 4. 差別化の機会
既存サービスに欠けている機能や改善点で、差別化が図れるポイントを3-5個。

網羅的かつ実用的なレポートを作成してください。"

    _pe_call_claude "$prompt" "$output_file" > /dev/null
    [[ -f "$output_file" && -s "$output_file" ]]
}

# ============================================================
# Step 3: 要件展開
# ============================================================
_pe_expand_requirements() {
    local task_desc="$1"
    local domain="$2"
    local competitor_file="$3"
    local output_file="$4"

    # 競合調査ファイルを読み込む（存在チェック付き）
    local competitor_analysis=""
    if [[ -f "$competitor_file" && -s "$competitor_file" ]]; then
        competitor_analysis=$(cat "$competitor_file" 2>/dev/null || echo "")
        # 長すぎる場合は先頭部分のみ（Claudeのコンテキスト節約）
        if [[ ${#competitor_analysis} -gt 8000 ]]; then
            competitor_analysis="${competitor_analysis:0:8000}

...(以下省略)"
        fi
    else
        _pe_log "WARN" "競合調査ファイルなし - 競合情報なしで要件展開"
    fi

    local prompt="あなたはシニアプロダクトマネージャーです。
以下のユーザーの要望と競合調査結果に基づいて、完全な要件仕様書を作成してください。

## ユーザーの要望
「${task_desc}」

## ドメイン
${domain}

## 競合調査結果
${competitor_analysis:-（競合調査データなし）}

---

以下のフォーマットで要件仕様書を作成してください:

# 要件仕様書: ${task_desc}

## 1. 機能要件（Functional Requirements）

### Must（必須 - MVP）
少なくとも10個の必須機能を記載。各機能は:
- **FR-M-001**: 機能名 - 詳細説明（ユーザーストーリー形式を含む）

### Should（推奨 - v1.0）
少なくとも8個の推奨機能。

### Could（あると嬉しい - v2.0以降）
少なくとも5個の将来機能。

## 2. 非機能要件（Non-Functional Requirements）

### パフォーマンス
- レスポンスタイム目標
- 同時接続数
- データ量見積もり

### セキュリティ
- 認証/認可要件
- データ暗号化
- 入力バリデーション
- OWASP Top 10 対策

### アクセシビリティ
- WCAG 2.1 レベルAA準拠項目
- レスポンシブデザイン要件
- 多言語対応の要否

### 運用性
- ログ/モニタリング要件
- バックアップ/リカバリ
- CI/CD要件

## 3. ユーザーストーリー（少なくとも10個）
形式: 「[ユーザー種別]として、[機能]したい。なぜなら[理由]。」
受け入れ基準も各ストーリーに付与。

## 4. 画面一覧（Screen List）
各画面について:
- 画面名
- URL/ルート
- 主要コンポーネント
- 遷移先
- 備考

## 5. データモデル概要
主要エンティティとその関連を記載。

すべての項目を網羅的に、プロフェッショナル品質で記載してください。"

    _pe_call_claude "$prompt" "$output_file" > /dev/null
    [[ -f "$output_file" && -s "$output_file" ]]
}

# ============================================================
# Step 4: 技術スタック選定
# ============================================================
_pe_select_tech_stack() {
    local task_desc="$1"
    local domain="$2"
    local requirements_file="$3"
    local output_file="$4"

    # 要件ファイルを読み込み（要約付き）
    local requirements_summary=""
    if [[ -f "$requirements_file" && -s "$requirements_file" ]]; then
        requirements_summary=$(cat "$requirements_file" 2>/dev/null || echo "")
        if [[ ${#requirements_summary} -gt 6000 ]]; then
            requirements_summary="${requirements_summary:0:6000}

...(以下省略)"
        fi
    fi

    local prompt="あなたはフルスタックのテックリードです。
以下の要件に基づいて、最適な技術スタックを提案してください。

## タスク
${task_desc}

## ドメイン
${domain}

## 要件仕様（抜粋）
${requirements_summary:-（要件データなし）}

---

以下のフォーマットでMarkdownを生成:

# 技術スタック選定: ${task_desc}

## 推奨技術スタック

### フロントエンド
- **フレームワーク**: (React/Next.js/Vue/Nuxt/Svelte等)
- **選定理由**: なぜこのフレームワークが最適か
- **UIライブラリ**: (shadcn/ui, Tailwind CSS, MUI等)
- **状態管理**: (Zustand, Redux, Jotai等)
- **フォーム**: (React Hook Form, Zod等)

### バックエンド
- **フレームワーク**: (Express/Fastify/FastAPI/Django/Hono等)
- **選定理由**: なぜこのフレームワークが最適か
- **言語**: (TypeScript/Python/Go等)
- **バリデーション**: (Zod, class-validator等)

### データベース
- **メインDB**: (PostgreSQL/MySQL/SQLite/MongoDB等)
- **選定理由**: なぜこのDBが最適か
- **ORM/クエリビルダ**: (Prisma/Drizzle/SQLAlchemy/TypeORM等)
- **キャッシュ**: (Redis等、必要であれば)

### 認証・認可
- **方式**: (JWT/Session/OAuth2/NextAuth/Clerk/Supabase Auth等)
- **選定理由**: 要件に基づく判断

### インフラ・デプロイ
- **ホスティング**: (Vercel/Netlify/Railway/AWS/GCP等)
- **CI/CD**: (GitHub Actions等)
- **コンテナ**: (Docker、必要であれば)

### 開発ツール
- **パッケージマネージャ**: (npm/pnpm/yarn)
- **テスト**: (Vitest/Jest/Playwright/Pytest等)
- **リンター**: (ESLint/Prettier/Biome等)

## 技術選定の理由サマリー
ドメイン特性と要件に対して、なぜこの組み合わせが最適かを3-5文で簡潔に。

## 代替案
もし要件が変わった場合の代替スタックを1-2パターン簡潔に。

## 互換性・依存関係マトリクス
主要ライブラリ間の互換性を確認した結果を記載。"

    _pe_call_claude "$prompt" "$output_file" > /dev/null
    [[ -f "$output_file" && -s "$output_file" ]]
}

# ============================================================
# Step 5: プロジェクト設計書（ブループリント）生成
# ============================================================
_pe_generate_blueprint() {
    local requirements_file="$1"
    local tech_stack_file="$2"
    local output_file="$3"

    # 両ファイルを読み込み
    local requirements_content="" tech_stack_content=""

    if [[ -f "$requirements_file" && -s "$requirements_file" ]]; then
        requirements_content=$(cat "$requirements_file" 2>/dev/null || echo "")
        if [[ ${#requirements_content} -gt 6000 ]]; then
            requirements_content="${requirements_content:0:6000}
...(以下省略)"
        fi
    else
        _pe_log "ERROR" "要件ファイルが見つかりません: ${requirements_file}"
        return 1
    fi

    if [[ -f "$tech_stack_file" && -s "$tech_stack_file" ]]; then
        tech_stack_content=$(cat "$tech_stack_file" 2>/dev/null || echo "")
        if [[ ${#tech_stack_content} -gt 4000 ]]; then
            tech_stack_content="${tech_stack_content:0:4000}
...(以下省略)"
        fi
    else
        _pe_log "WARN" "技術スタックファイルなし - デフォルトで設計書生成"
    fi

    local prompt="あなたはシニアソフトウェアアーキテクトです。
以下の要件仕様と技術スタックに基づいて、開発チームがすぐにコーディングを開始できる完全なプロジェクト設計書を作成してください。

## 要件仕様
${requirements_content}

## 技術スタック
${tech_stack_content:-（技術スタック未定 - 要件から最適なものを推定して記載）}

---

以下のフォーマットでMarkdownを生成:

# プロジェクト設計書（Blueprint）

## 1. ディレクトリ構造
プロジェクトの完全なディレクトリツリーを記載。
\`\`\`
project-root/
├── src/
│   ├── ...
\`\`\`
全ディレクトリと主要ファイルを含める。各ディレクトリにコメントで役割を付記。

## 2. パッケージ定義
### package.json（またはrequirements.txt/pyproject.toml）
完全な内容をコードブロックで記載。依存パッケージはバージョン付き。
scripts にdev/build/test/lint/format を含める。

## 3. データベーススキーマ
### SQL DDL
\`\`\`sql
CREATE TABLE ...
\`\`\`
全テーブルの定義、インデックス、外部キー制約を含む。
テーブルごとにコメントで説明。

### ER図（テキスト表現）
主要エンティティの関連図をASCIIで表現。

## 4. API エンドポイント一覧
テーブル形式で記載:
| Method | Path | Description | Auth | Request Body | Response |
|--------|------|-------------|------|-------------|----------|

全エンドポイントを網羅（CRUD + 認証 + ユーティリティ）。

## 5. フロントエンド コンポーネントツリー
\`\`\`
App
├── Layout
│   ├── Header
│   ├── Sidebar
│   └── ...
\`\`\`
各コンポーネントの責務を簡潔に付記。

## 6. ルート定義
| Route Path | Component | Auth Required | Description |
|------------|-----------|---------------|-------------|

## 7. 環境変数定義
\`\`\`env
# .env.example
DATABASE_URL=...
\`\`\`

## 8. 実装優先順序
Phase 1（MVP）→ Phase 2 → Phase 3 の順でどの機能から実装するか。
各Phaseの見積もり工数も記載。

すべてのセクションを具体的かつ実装可能なレベルで記載してください。
抽象的な記述は避け、実際のコード構造・テーブル名・API パスを具体的に書いてください。"

    _pe_call_claude "$prompt" "$output_file" > /dev/null
    [[ -f "$output_file" && -s "$output_file" ]]
}

# ============================================================
# ユーティリティ: 設計書ファイル一覧を表示
# ============================================================
prompt_expand_list_outputs() {
    local output_dir="${1:-${PE_WORK_DIR}}"

    if [[ ! -d "$output_dir" ]]; then
        _pe_log "WARN" "出力ディレクトリが見つかりません: ${output_dir}"
        return 1
    fi

    echo -e "${PE_BOLD}${PE_CYAN}[PE] 生成済みファイル一覧:${PE_NC}"
    local count=0
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        local size
        size=$(wc -c < "$f" 2>/dev/null | tr -d ' ')
        local lines
        lines=$(wc -l < "$f" 2>/dev/null | tr -d ' ')
        echo -e "  ${PE_BLUE}-${PE_NC} $(basename "$f") (${size}B, ${lines}行)"
        count=$((count + 1))
    done < <(find "$output_dir" -maxdepth 1 -name "*.md" -o -name "*.txt" 2>/dev/null | sort)

    if [[ "$count" -eq 0 ]]; then
        echo -e "  ${PE_YELLOW}(ファイルなし)${PE_NC}"
    fi
}

# ============================================================
# ユーティリティ: 要約表示（設計書のダイジェスト）
# ============================================================
prompt_expand_summary() {
    local blueprint_file="${1:-}"

    if [[ -z "$blueprint_file" || ! -f "$blueprint_file" ]]; then
        _pe_log "ERROR" "設計書ファイルが見つかりません: ${blueprint_file}"
        return 1
    fi

    echo -e "${PE_BOLD}${PE_PURPLE}[PE] 設計書ダイジェスト:${PE_NC}"

    # セクション見出しを抽出して表示
    local section_count=0
    while IFS= read -r line; do
        if [[ "$line" =~ ^##\  ]]; then
            echo -e "  ${PE_CYAN}${line}${PE_NC}"
            section_count=$((section_count + 1))
        fi
    done < "$blueprint_file"

    local total_lines
    total_lines=$(wc -l < "$blueprint_file" 2>/dev/null | tr -d ' ')
    echo -e "  ${PE_GREEN}セクション数: ${section_count} | 総行数: ${total_lines}${PE_NC}"
}

# ============================================================
# クイックモード: ドメイン判定のみ（高速テスト用）
# ============================================================
prompt_expand_detect_only() {
    local task_desc="${1:-}"
    if [[ -z "$task_desc" ]]; then
        _pe_log "ERROR" "タスク説明が空です"
        return 1
    fi
    local domain
    domain=$(_pe_detect_domain "$task_desc")
    echo -e "${PE_BOLD}[PE]${PE_NC} ドメイン判定: ${PE_CYAN}${task_desc}${PE_NC} → ${PE_GREEN}${domain}${PE_NC}"
    echo "$domain"
}

# ============================================================
# エクスポート（chain.shから source して使用）
# ============================================================
# 使用例:
#   source lib/prompt-expander.sh
#   prompt_expand_init
#   blueprint=$(prompt_expand "家計簿アプリ作って" "./output")
#   echo "設計書: $blueprint"
#
# クイックテスト:
#   source lib/prompt-expander.sh
#   prompt_expand_detect_only "CRM作って"
