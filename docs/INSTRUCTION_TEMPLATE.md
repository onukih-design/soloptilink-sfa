# PMエージェントへの指示テンプレート

## 重要: 要件定義書は不要です。コストの指定も不要です。

PMは**どんな形式のインプットでも受け付けます**。
1行の思いつきでも、箇条書きでも、既存サービスの名前だけでも、
PMが自分で考えて要件定義書を構築し、**無料優先で最安コスト設計**を行い、
開発を完成まで進めます。

---

## パターンA: 1行で伝える

```
@.claude/agents/pm.md
社内チーム用のタスク管理ツール作って。全部やって。テスト全パスまで止まらないで。
```

## パターンB: 箇条書きで伝える

```
@.claude/agents/pm.md
以下を作ってほしい:
・日報管理ツール
・社員が毎日の作業内容を記録
・マネージャーが全員分を閲覧
・週次レポート自動生成
CLAUDE.md に従って全部やって。止まらないで。
```

## パターンC: 既存サービスを参照

```
@.claude/agents/pm.md
Notionみたいなタスク管理ツールを作って。
ただしもっとシンプルで、3人チーム向け。
CLAUDE.md に従って全部やって。止まらないで。
```

## パターンD: 要件定義書がある場合

```
@.claude/agents/pm.md
@docs/REQUIREMENTS.md のシステムを作って。
この要件をベースに、足りない部分はPMが自分で考えて補完して。
CLAUDE.md に従って全部やって。テスト全パスまで止まらないで。
```

## パターンE: 最も曖昧なケース

```
@.claude/agents/pm.md
最近チームのタスク管理がうまくいってなくて、
みんなが何やってるか見えない。なんとかしたい。
これをWebアプリで解決して。全部考えて全部作って。
```

## パターンF: AI機能を含むシステム

```
@.claude/agents/pm.md
AIチャットボット付きのFAQシステムを作って。
社員が質問するとAIが回答する。管理者がFAQを登録できる。
コストは最小で。全部やって。止まらないで。
```
※ AI APIは自動的にDeepSeek/Geminiが選択されます。Claude APIは使いません。

---

## 実行方法

### 通常モード（初回はこちらで様子を見る）
```bash
claude
```

### 自律モード（権限確認をスキップ）
```bash
git add -A && git commit -m 'checkpoint'
claude --dangerously-skip-permissions
```

### 再開
```bash
claude --resume
# → 「docs/PLAN.md を読んで未完了タスクから再開して」
```

---

## PMが自分で考えて構築するもの

| PMが構築するドキュメント | 内容 |
|------------------------|------|
| ORIGINAL_INPUT.md | ユーザーの原文保存（参照用） |
| COMPETITIVE_RESEARCH.md | 競合3-5サービスの機能比較表 |
| FULL_REQUIREMENTS.md | 完全な要件定義書（画面/DB/API/UX/コスト設計） |
| GAP_ANALYSIS.md | 原文→完成版で何を追加したかの記録 |
| COST_ESTIMATE.md | 月額ランニングコスト見積もり（★v3.1新規） |
| PLAN.md | タスクDAG（全タスクと進捗） |
| TEST_REPORT.md | テスト結果レポート |

## 前提条件

| ツール | コスト | インストール方法 |
|--------|--------|----------------|
| Claude Max 5x | $100/月 | claude.ai でサブスクリプション |
| Claude Code | 無料（Max含む） | `npm install -g @anthropic-ai/claude-code` |
| Node.js v18+ | 無料 | https://nodejs.org/ |
| Git v2.x+ | 無料 | `apt install git` or https://git-scm.com/ |
