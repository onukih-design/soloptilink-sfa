# 3分クイックスタート

## Step 1: セットアップ（1分）

```bash
unzip claude-code-autonomous-dev-kit-v3.1.zip -d my-project
cd my-project
chmod +x setup.sh && ./setup.sh
```

## Step 2: Claude Codeで実行（1分）

```bash
claude
```

## Step 3: 何でもいいから伝える（1分）

### 最も簡単な方法
```
@.claude/agents/pm.md
タスク管理ツール作って。全部やって。テスト全パスまで止まらないで。
```

### もう少し詳しく伝える方法
```
@.claude/agents/pm.md
以下を作ってほしい:
・社内3人チーム用のタスク管理
・カンバンボードでタスクを管理
・担当者と期限が設定できる
全部考えて全部作って。止まらないで。
```

**以上。** 要件定義書を書く必要はありません。コストの心配も不要です。
PMが自分で競合調査→要件構築→コスト最適設計→実装→テストを全て行います。

---

## PMが自動的に行うこと

1. あなたの言葉を `docs/ORIGINAL_INPUT.md` に保存
2. 競合3-5サービスをWeb検索で調査
3. 競合の機能比較表を作成
4. **要件定義書を自分で1から構築**（画面/DB/API/UX含む）
5. **コスト最適設計**（AI API→DeepSeek/Gemini、インフラ→無料枠最大活用）
6. `docs/COST_ESTIMATE.md` に月額ランニングコスト見積もりを作成
7. 設計エージェント x4 を生成（コスト制約付き）
8. 実装エージェント x30+ を生成（無料優先ルール付き）
9. cost-optimizerが設計+実装を2回レビュー
10. テスト/修正エージェント x40+ を生成
11. UX改善エージェント x10+ を生成
12. 全テスト通過+コスト検証合格を確認して完了

## コスト設計の自動適用

| 項目 | 自動選択される技術 | 月額 |
|------|------------------|------|
| AI API（高品質） | DeepSeek V3.2 | $0.28/$0.42 per 1M tokens |
| AI API（軽量） | Gemini 2.0 Flash | $0.10/$0.40 per 1M tokens |
| DB | SQLite（→Turso→Supabase Free） | $0 |
| 認証 | Supabase Auth / Clerk Free | $0 |
| フロントエンド | Vercel Free / Cloudflare Pages | $0 |
| バックエンド | Railway ($5) / Fly.io Free | $0-5 |

**Claude API / OpenAI GPT は本番で自動的に排除されます。**

## うまくいかない場合

| 状況 | 対処 |
|------|------|
| 途中で止まった | `claude --resume` |
| 同じエラーでループ | Ctrl+C → `/clear` → 再指示 |
| 意図と違うものができた | より具体的に伝え直す |
| PMの要件構築が的外れ | 要件定義書を自分で書いてパターンDで渡す |
