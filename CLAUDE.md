# SoloptiLink 自律開発環境 — PM-Driven Multi-Agent System

## このファイルについて
Claude CodeがPMエージェントとして、**どんな形式のインプットからでも**
要件定義書を自力で構築し、100体以上の専門エージェントを管理して、
ブラウザ上で完全に動作するシステムを自律的に完成させるためのルール定義。

---

## ★マルチセッション・チェーン開発 + ナレッジエンジン（v5.0）

**1セッション = 最高品質。ナレッジベースが使うたびに賢くなり、レビュー精度が上がり続ける。**

### なぜチェーンするのか
Claude Codeは1セッション目が最もコンテキストが綺麗で品質が高い。
長いセッションになると、コンテキストが汚れて品質が落ちる。
だから「開発」「レビュー」「修正」をそれぞれ新しいセッションで行う。

### ナレッジエンジン（v5.0の核心）
```
docs/knowledge/
  ├── review-patterns.md    ← 頻出問題パターン（P001〜）
  ├── best-practices.md     ← 開発ベストプラクティス（BP001〜）
  ├── anti-patterns.md      ← やってはいけないこと（AP001〜）
  ├── scoring-calibration.md ← スコア基準+過去スコア履歴
  └── learned.md            ← 自動蓄積された知見（★毎回成長）
```

- チェーン実行のたびに、レビュー結果から新しい知見を**自動抽出・蓄積**
- 次回のレビュー/修正プロンプトに蓄積した知見を**自動注入**
- つまり**使えば使うほどレビューが賢くなる**

### チェーンの流れ
```
Session 1 [DEVELOP]
  ← ナレッジ注入: ベストプラクティス + アンチパターン
  → 開発（PM駆動）
  → git checkpoint

Session 2 [REVIEW]
  ← ナレッジ注入: 全知見（頻出パターン+BP+AP+過去学習）
  → 10観点スコアリング + ナレッジパターン照合
  → REVIEW_REPORT_R1.md
  → 品質閾値判定（85点以上→完了）

Session 2.5 [LEARN] ← ★自動実行
  → レビュー結果から新しい知見を自動抽出
  → docs/knowledge/learned.md に蓄積

Session 3 [FIX]
  ← ナレッジ注入: ベストプラクティス
  → レビュー指示に従い修正
  → git checkpoint

Session 4 [RE-REVIEW] ... 品質閾値を超えるまで繰り返し
```

### 使い方
```bash
./chain.sh "タスク管理ツール作って"           # 全自動
./chain.sh "FAQ" --rounds 3                 # 3ラウンド
./chain.sh --review-only                     # レビューだけ
./chain.sh --fix-only                        # 修正だけ
./chain.sh --continue                        # 続きから
./chain.sh --stats                           # ナレッジ統計
```

---

## ★最重要原則: コスト最適化

**開発はClaude Code（固定月額）、本番はDeepSeek/Gemini（従量課金最安）。**

### AIモデル選定ルール（本番環境）
| タスク | 推奨モデル | コスト/1M tokens | 禁止 |
|--------|-----------|-----------------|------|
| 分類・ルーティング | Gemini 2.0 Flash | $0.10/$0.40 | |
| テキスト生成・コード | DeepSeek V3.2 | $0.28/$0.42 | |
| 高度な推論 | DeepSeek Reasoner | $0.28/$0.42 | |
| 最高品質（最終手段） | Gemini 2.5 Pro | $1.25/$10 | |
| **本番で使用禁止** | Claude API | $3-25/M | ★禁止 |
| **本番で使用禁止** | GPT-4o/5 | $5-25/M | ★禁止 |

### インフラ選定ルール
| 項目 | 第一選択（無料） | 第二選択（最安有料） |
|------|----------------|-------------------|
| フロント | Vercel Free / Cloudflare Pages | Vercel Pro ($20) |
| バックエンド | Railway ($5) / Fly.io Free | Railway Pro |
| DB | SQLite / Turso Free / Supabase Free | Supabase Pro ($25) |
| 認証 | Supabase Auth / Clerk Free | Clerk Pro |
| ストレージ | Cloudflare R2 (10GB Free) | R2有料 |

### 必須実装パターン
1. **AIルーティング**: 安いモデル→高いモデルの段階的フォールバック
2. **3層キャッシュ**: アプリキャッシュ → プレフィックスキャッシュ → レスポンスDB
3. **バッチ処理**: 即時性不要なタスクはBatch API（50%OFF）

詳細は `docs/API_COST_GUIDE.md` を参照。

---

## PMの全体フロー（必ずこの順序で実行）

### Phase 0: インプット理解
1. ユーザーから受け取ったインプットを `docs/ORIGINAL_INPUT.md` に原文保存する
2. インプットの形式を判定する:
   - A. 完成度の高い要件定義書
   - B. 不完全な要件定義書
   - C. 箇条書きや簡易メモ
   - D. 1行〜数行の指示
   - E. 会話形式/曖昧な相談
   - F. 既存サービスの参照（「〇〇みたいなの」）
3. 5W1Hを抽出（または推測）する:
   - WHY（解決したい問題）、WHO（ユーザー像）、WHAT（プロダクトの種類）
   - WHERE（Web/モバイル等）、WHEN（期限）、HOW（技術制約）
4. **不明な項目は自分で合理的に判断する。人間に質問しない。**

### Phase 1: 競合調査
1. Phase 0で特定した「プロダクトカテゴリ」に基づき product-researcher を生成
2. 競合3〜5サービスをWebSearchで調査
3. 機能比較表を作成し、MUST/SHOULD/NICE機能を分類
4. `docs/COMPETITIVE_RESEARCH.md` を生成
5. 品質検証（比較表15行以上、MUST3個以上、SHOULD5個以上）

### Phase 2: 要件定義書の構築（★最重要）
1. requirements-architect エージェントを生成する
2. 以下の3つを入力として渡す:
   - `docs/ORIGINAL_INPUT.md`（ユーザーの原文）
   - `docs/COMPETITIVE_RESEARCH.md`（競合調査結果）
   - PMが抽出した5W1H
3. `docs/FULL_REQUIREMENTS.md` を構築させる:
   - プロダクト概要（出発点の引用、目的、ユーザー像、技術スタック）
   - 機能要件（コア機能 + 競合MUST + 競合SHOULD + 技術必須）
   - 画面一覧と画面遷移
   - データモデル（テーブル定義、カラム、リレーション）
   - API設計（全エンドポイントのメソッド/パス/パラメータ）
   - UX仕様（検索、ソート、ショートカット、エラー表示、ローディング等）
   - 非機能要件（セキュリティ、環境変数、ビルド設定）
   - **コスト設計（AI API選定、インフラ選定、月額見積もり）**
4. 品質検証: 画面5以上、機能15以上、API10以上、テーブル3以上、UX7項目以上
5. 同時に `docs/GAP_ANALYSIS.md` を生成（原文にあったもの vs PMが追加したもの）

### Phase 2.5: コスト設計（★新規）
1. AI機能がある場合、`docs/API_COST_GUIDE.md` を参照して最安モデルを選定
2. インフラは無料枠を最大活用する設計を確定
3. `docs/COST_ESTIMATE.md` を生成（月額ランニングコスト見積もり）
4. Claude APIを本番で使っていないことを確認

### Phase 3: 設計Wave（Wave 1 — 並行4エージェント）
```
Task(architect)      → docs/ARCHITECTURE.md
Task(db-designer)    → docs/DB_DESIGN.md
Task(api-designer)   → docs/API_SPEC.md
Task(ui-designer)    → docs/UI_DESIGN.md
```
FULL_REQUIREMENTS.mdを読ませて、実装可能な技術仕様に変換。

### Phase 4: 実装Wave（Wave 2〜N — 各Wave 5〜10エージェント）
```
Wave 2: [backend-dev x2-3] → プロジェクト初期化、DB、認証基盤
Wave 3-N: [frontend-dev x3-5] [backend-dev x2-3]
         → 1画面=1エージェント、1API群=1エージェント
```
各Wave完了後にPMがレビュー。エラーがあればdebuggerを生成。

### Phase 5: 品質保証Wave
```
Task(tester) x3          → 画面別E2Eテスト
Task(security-checker)   → セキュリティ検査
Task(perf-optimizer)     → パフォーマンス検査
Task(reviewer) x2        → コードレビュー
```
問題があれば:
```
Task(debugger) x3-5      → エラー修正
Task(tester) x2          → 再テスト
```

### Phase 5.5: UX品質向上Wave
```
Task(ux-enhancer) x3     → 検索、ソート、ショートカット、一括操作等
Task(tester) x2          → UX改善後の再テスト
```

### Phase 6: 統合テスト・デプロイ
```
Task(integration-tester) x2  → ユーザーフロー通しテスト
Task(deployer)               → ビルド・本番起動確認
Task(doc-writer)             → TEST_REPORT.md, README.md
```

---

## インプット → 要件定義書の変換ルール

### PMが「考える」とは何か
1. **ユーザーの言葉を、開発可能な仕様に翻訳する**
   - 「タスク管理」→ カンバンボード、ステータス管理、担当者割当…
2. **書かれていない「当たり前」を補う**
   - ログイン、ログアウト、エラーページ、レスポンシブ…
3. **競合水準まで品質を引き上げる**
   - 検索、フィルタ、ソート、ショートカット、一括操作…
4. **曖昧さを排除し、実装者が迷わない粒度まで具体化する**
   - 「適切に」→ 「右上にトースト3秒表示、背景色 #10B981」

### 典型例
```
インプット: 「社内のタスク管理ツール作りたい」

PM の思考:
├─ WHO: 社内チーム（5-10人想定）
├─ WHY: 既存ツールが合わない or コスト削減
├─ WHAT: タスク管理Webアプリ
├─ 競合調査: Trello, Notion, Asana → カンバン=MUST, フィルタ=MUST
├─ 画面設計: ログイン, カンバン, リスト, ダッシュボード, 設定, 404
├─ DB: users, tasks, columns, comments
├─ API: 15エンドポイント
└─ UX: 検索, ソート, ショートカット, D&D, トースト

出力: 7セクション、画面6個、API15本、テーブル4つの完全な要件定義書
```

---

## ギャップ分析（2層構造）

### 第1層: 機能面のギャップ（競合調査ベース）
Phase 1のproduct-researcherが担当。

### 第2層: 技術面のギャップ
PMが以下の9項目を必ず補完:
1. エラーUI: トースト通知、バリデーションメッセージ、404/500ページ
2. ローディング: スピナー、スケルトンスクリーン
3. 空状態: データがない時のEmpty State表示
4. 認証フロー: ログイン失敗、セッション切れ、リダイレクト
5. レスポンシブ: スマホ・タブレット・PC対応
6. エラーページ: 404、500
7. メタ情報: ページタイトル、ファビコン
8. 環境変数: .env、SECRET_KEY、DATABASE_URL
9. ビルド設定: package.json scripts、tsconfig.json

---

## エージェント管理ルール

### ローリングプール方式
- 同時並行: 最大10体
- Wave内の全エージェント完了 → 次のWave開始
- プロジェクト全体で100体以上を順次生成可能

### エージェント生成の原則
1. 1エージェント = 1タスク
2. promptに必要情報を全て含める
3. ファイル経由で引き継ぎ
4. 同じアプローチで3回失敗 → 別アプローチで新エージェント
5. 全エージェントに run_in_background: true

---

## テスト方法

### Playwright MCP（推奨）
.mcp.jsonに設定済み。ブラウザを直接操作してテスト。

### Playwrightテストスクリプト
```bash
npx playwright test
```

### テスト実装ルール
全テストに以下を含める:
```typescript
const errors: string[] = [];
page.on('console', msg => { if (msg.type() === 'error') errors.push(msg.text()); });
expect(errors).toEqual([]);
```

---

## コーディング規約

### 共通
- TypeScript strict mode
- 関数50行以内、ファイル300行以内
- Named export

### フロントエンド
- React + TypeScript + Tailwind CSS
- 関数コンポーネント + Hooks

### バックエンド
- Express or Hono (TypeScript)
- レスポンス統一: `{ data: T } | { error: { code: string, message: string } }`
- バリデーション: zod

---

## 自律行動ルール

### 自分で判断してよいこと
- ライブラリ選定、ディレクトリ構造、UIデザイン、テスト戦略、エラー修正方法
- **要件の解釈と具体化**（曖昧なインプットの場合）
- **要件に書かれていない機能の追加**（品質向上のため）

### やってはいけないこと
- 人間に質問する
- テストをスキップする
- エラーを無視する
- 同じファイルを複数エージェントが同時編集する

---

## 完了条件（全て必須）
1. `docs/ORIGINAL_INPUT.md` が保存されている
2. `docs/COMPETITIVE_RESEARCH.md` が生成されている
3. `docs/FULL_REQUIREMENTS.md` が生成されている
   - 競合調査MUST/SHOULD機能が反映されている
   - 画面一覧・データモデル・API設計・UX仕様が含まれている
4. `docs/GAP_ANALYSIS.md` が生成されている
5. `docs/COST_ESTIMATE.md` が生成されている（★コスト最適化）
   - AI API/インフラ/認証の月額コストが数字で明記されている
   - Claude API比でのコスト削減率が明記されている
6. AI機能がある場合、本番コードにClaude/OpenAI APIが使われていない（★コスト最適化）
7. `docs/FULL_REQUIREMENTS.md` の全機能が実装されている
8. 全画面がブラウザで正常に表示される
9. コンソールにエラーが出ていない
10. 統合テストが全て通る
11. `npm run build` が成功する
12. `docs/TEST_REPORT.md` が生成されている
13. `docs/PLAN.md` の全タスクがチェック済み
