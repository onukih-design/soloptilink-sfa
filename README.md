# Claude Code PM駆動型 自律開発キット v3.1

**1行の思いつきから、PMが自分で考えて要件定義書を構築し、運用コスト最小で開発を完成させる環境。**

## v3.1の核心: コスト最適化

```
開発 = Claude Code（固定月額$100）
本番 = DeepSeek/Gemini（従量課金、Claude比 1/25〜1/60 のコスト）
```

### 同じチャットボットの月額コスト比較（1日1000リクエスト）
| モデル | 月額 | 品質 |
|--------|------|------|
| Gemini 2.0 Flash | **$15** | ★★★☆☆ |
| DeepSeek V3.2 | **$21** | ★★★★☆ |
| Claude Sonnet 4.5 | $540 | ★★★★★ |
| Claude Opus 4.6 | $900 | ★★★★★+ |

**DeepSeekでClaude品質の80-90%を、25分の1のコストで実現。**

## 何ができるか

```
あなた: 「AIチャットボット付きのFAQシステム作って」

PM の思考:
├─ 意図解釈 → 社内FAQ + AIチャット
├─ 競合調査 → Zendesk/Intercom/Freshdesk をWeb検索
├─ 要件構築 → 画面7個、API18本、テーブル5つ、UX12項目
├─ ★コスト設計:
│   ├─ AI: DeepSeek V3.2（$0.28/M） ← Claude比 1/25
│   ├─ 軽量AI: Gemini Flash（$0.10/M） ← 分類・ルーティング用
│   ├─ DB: Supabase Free（$0）
│   ├─ 認証: Supabase Auth（$0）
│   ├─ ホスト: Vercel Free（$0）
│   └─ 月額見積: $21/月 ← Claude APIなら$540/月
├─ 設計〜実装〜テスト（100体以上のエージェント）
└─ 完成（全テスト通過）
```

## 受け付けるインプットの形式

| 形式 | 例 | PMの対応 |
|------|---|---------|
| 1行の指示 | 「タスク管理ツール作って」 | 全部自分で考えて構築 |
| 箇条書き | 「・日報管理 ・閲覧 ・レポート」 | 不足を補って構築 |
| 既存サービス参照 | 「Trelloみたいなの」 | そのサービスを重点調査 |
| 完成した要件書 | 全セクション記載 | 競合調査+コスト最適化して構築 |

## クイックスタート

```bash
chmod +x setup.sh && ./setup.sh
claude
```

```
@.claude/agents/pm.md
タスク管理ツール作って。全部やって。テスト全パスまで止まらないで。
```

## エージェント構成（19体）

| エージェント | 役割 |
|------------|------|
| **pm** (Opus) | 全体統括。要件構築、コスト設計、Wave管理 |
| **requirements-architect** | 任意インプット→完全な要件定義書を構築 |
| **product-researcher** | 競合サービス調査、MUST/SHOULD機能提案 |
| **cost-optimizer** ★新 | 全設計・コードのコストレビュー、COST_ESTIMATE.md生成 |
| **ux-enhancer** | 検索、ソート、ショートカット等のUX改善 |
| architect〜deployer (14体) | 設計、実装、テスト、品質管理、デプロイ |

## Stop Hook（10項目強制チェック）

1. `ORIGINAL_INPUT.md` 保存
2. `COMPETITIVE_RESEARCH.md` 存在
3. `FULL_REQUIREMENTS.md` 存在+品質
4. 競合調査反映+画面+API定義
5. `GAP_ANALYSIS.md` 存在
6. **`COST_ESTIMATE.md` 存在+具体的な数字** ★新
7. **本番コードにClaude/OpenAI API未使用** ★新
8. `PLAN.md` 全タスク完了
9. `TEST_REPORT.md` 存在
10. `npm run build` 成功

## 前提条件

| ツール | コスト | 用途 |
|--------|--------|------|
| Claude Max 5x | $100/月 | 開発環境（固定月額） |
| Node.js v18+ | 無料 | ビルド、テスト |
| Git v2.x+ | 無料 | バージョン管理 |

## ライセンス

株式会社 SoloptiLink 社内利用
