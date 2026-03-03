# SoloptiLink SFA/CRM コスト見積もり

## 1. 開発環境コスト

| 項目 | サービス | 月額 |
|------|---------|------|
| 開発AI | Claude Max 5x (Opus/Sonnet) | $100/月 |
| 合計 | | $100/月 |

## 2. 本番環境コスト（月額ランニング）

| 項目 | サービス | プラン | 月額 |
|------|---------|-------|------|
| フロントエンド/ホスティング | Vercel | Hobby (Free) | ¥0 |
| データベース | Supabase PostgreSQL | Free (500MB) | ¥0 |
| 認証 | Supabase Auth | Free (50,000 MAU) | ¥0 |
| ストレージ | Supabase Storage | Free (1GB) | ¥0 |
| SSL証明書 | Vercel自動付与 | 無料 | ¥0 |
| ドメイン | *.vercel.app | 無料 | ¥0 |
| AI API | 不使用 | — | ¥0 |
| 合計 | | | **¥0/月** |

## 3. AI APIコスト分析（本システムでは不使用）

このシステムにはAI機能がないため、AI APIは一切使用しない。

参考として競合SFAのAI機能コストを記載:

- Salesforce Einstein: $50/user/月
- Mazrica AI: 月額プランに含まれる
- SoloptiLinkは将来的にAI機能追加時、DeepSeek V3.2 ($0.28/M tokens)を使用予定

## 4. 競合SFAとのコスト比較

| サービス | 10ユーザー月額 | 年額 |
|---------|--------------|------|
| Salesforce Sales Cloud | ¥375,000 | ¥4,500,000 |
| GENIEE SFA/CRM | ¥34,800 | ¥417,600 |
| Mazrica Sales | ¥27,500 | ¥330,000 |
| kintone | ¥15,000 | ¥180,000 |
| **SoloptiLink** | **¥0** | **¥0** |

## 5. スケールアップ時のコスト見通し

| フェーズ | 条件 | 月額 |
|---------|------|------|
| 初期運用 | 500案件/年、10ユーザー | ¥0 |
| 拡大期 | DB 500MB超過 | ~¥3,750 (Supabase Pro $25) |
| 本格運用 | Vercel Pro + Supabase Pro | ~¥7,000 ($47) |

## 6. Claude API比コスト削減率

本番環境でClaude APIは使用しないため、削減率は100%。
