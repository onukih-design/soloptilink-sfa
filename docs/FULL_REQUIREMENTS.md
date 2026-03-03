# SoloptiLink 案件進捗管理 / 売上管理システム
# 完全要件定義書（FULL REQUIREMENTS）

Version 2.0 | 2026-02-28
株式会社SoloptiLink 代表取締役 小貫 太秀

---

## 目次

1. [プロダクト概要](#1-プロダクト概要)
2. [機能要件](#2-機能要件)
3. [画面一覧と画面遷移](#3-画面一覧と画面遷移)
4. [データモデル](#4-データモデル)
5. [API設計](#5-api設計)
6. [UX仕様](#6-ux仕様)
7. [非機能要件](#7-非機能要件)
8. [ヨミ定義・ビジネスロジック](#8-ヨミ定義ビジネスロジック)

---

## 1. プロダクト概要

### 1.1 出発点

株式会社SoloptiLinkでは現在、Excelベースの「AI商社_案件管理表」により営業案件のパイプライン管理、受注管理、売上管理、営業分析を行っている。しかし、データ量の増加に伴い、複数シート間の整合性維持、リアルタイムな分析、チーム間の情報共有、モバイルアクセスにおいて課題が顕在化している。

現行Excelの主な課題:

- 複数シート（13シート / 65列以上）の管理が複雑化し、入力ミス・データ不整合が頻発
- 商談の5段階フォロー（最新〜5回目）の追跡が視覚的に困難
- 受注管理表（AIツール/営業代行）の月次売上集計が手動かつ煩雑
- クローザー/アポインター/決裁者/リスト別の受注率分析が静的でリアルタイム集計不可
- ヨミ定義（受注/A/B/C/ネタ/没ネタ/失注/消滅）のパイプライン可視化が不十分
- 営業代行案件獲得抽出シートとの二重入力が発生

### 1.2 目的

ExcelベースのAI商社案件管理をWebアプリケーション化し、現行Excelの全機能を完全に再現しつつ、営業効率の最大化と経営判断の高速化を実現する。

### 1.3 ターゲットユーザー

| ユーザー種別 | 人数 | 主な利用シーン |
|-------------|------|--------------|
| 代表取締役（小貫） | 1名 | 全案件の俯瞰管理、売上/利益のリアルタイム把握、KPI分析 |
| クローザー | 2-3名 | 商談記録の入力、フォロー状況の更新、NextAction管理 |
| アポインター | 3-5名 | アポイント登録、架電結果の記録、リスト管理 |
| マネージャー | 1-2名 | チーム実績の集計、受注率の分析、営業戦略立案 |

### 1.4 技術スタック

| レイヤー | 技術 | 選定理由 |
|---------|------|---------|
| フロントエンド | Next.js 14 (App Router) | SSR/SSG対応、TypeScript標準、Vercelとの親和性が高い |
| UIライブラリ | shadcn/ui + Tailwind CSS | 高品質なUIコンポーネント、カスタマイズ性が高い |
| 状態管理 | Zustand + TanStack Query | 軽量で直感的、サーバー状態の管理に最適 |
| バックエンド | Supabase (Free) | PostgreSQL + Auth + Realtime + Storage を統合提供 |
| 認証 | Supabase Auth | メール/パスワード認証、RLS対応 |
| テーブル表示 | TanStack Table v8 | Excel的なソート/フィルタ/列固定/仮想スクロール対応 |
| グラフ | Recharts | React向けの宣言的チャートライブラリ |
| デプロイ | Vercel (Hobby/Free) | Next.js最適化、自動CI/CD、月額0円運用 |
| Excel連携 | SheetJS (xlsx) | Excel形式でのインポート/エクスポート対応 |

### 1.5 開発スケジュール

| Phase | 期間 | 内容 |
|-------|------|------|
| Phase 1 | Week 1-2 | 基盤構築（認証・DB設計・案件管理CRUD） |
| Phase 2 | Week 3-4 | 商談フォロー機能・受注管理表・売上集計 |
| Phase 3 | Week 5-6 | 分析ダッシュボード・KPIレポート・通知機能 |
| Phase 4 | Week 7-8 | Excel連携・データ移行・テスト・本番デプロイ |

---

## 2. 機能要件

### 2.1 コア機能（F1-F16）

#### Phase 1: 案件管理機能（MVP）

**F1: 案件一覧画面（当月案件管理表の再現）**
- Excelの「当月案件管理表」と同等のスプレッドシート的UIを実装
- TanStack Table v8による高性能テーブル表示（仮想スクロール対応で500行以上でも快適動作）
- 列の固定表示: A-E列（番号/企業名/電話/携帯/氏名）を左固定
- ヨミステータスによる色分け表示: 受注=青, A=赤, B=オレンジ, C=黄, ネタ=緑, 没ネタ=グレー, 失注=灰色
- インラインセル編集機能（クリックで即座に編集可能、Excelと同じ操作感）
- プルダウン項目はExcelのプルダウンシートの値をマスタとして動的に表示

**F2: 案件詳細画面**
- 案件の全情報を1画面で俯瞰表示
- フォロー履歴（1-5回目）をタイムライン形式で表示
- 商談サマリーをリッチテキスト表示
- ステータス遷移の履歴ログ表示

**F3: 案件登録・編集**
- 新規案件の登録フォーム（全フィールド対応）
- 企業マスタ・担当者マスタとの連携（既存企業は自動補完、新規は即時登録）
- フォローアップの追加（最大5回まで）
- ヨミステータスの変更時に自動ログ記録

**F4: フィルタ・検索・ソート**
- 全列でのソート対応
- ヨミステータスによるフィルタ（複数選択可）
- クローザー/アポインター別フィルタ
- リスト別フィルタ / 月別フィルタ / フリーワード検索

#### Phase 2: 受注管理・売上管理機能

**F5: AIツール受注管理表**
- Excelの「AIツール受注管理表」を完全再現
- 11種類の商材別月額料金の入力
- マージン率の自動計算（商材別: 20%-50%）
- ショット報酬（初期費用50%）の自動計算
- 解約月を設定すると翌月以降のストック収益が自動的に0になる計算ロジック

**F6: 営業代行受注管理表**
- Excelの「営業代行受注管理表」を完全再現
- 初期費用/月額費用の管理
- プロジェクト準備ステータスの進捗管理

**F7: 統合受注管理表**
- 全受注案件の一覧（AIツール+営業代行を統合）
- ショット(初期)/ストック(月額)の分離集計
- 年間合計の自動算出

**F8: 売上ダッシュボード**
- 月次MRRのリアルタイム表示
- ショット売上 vs ストック売上の推移グラフ
- 商材別売上構成比の円グラフ/棒グラフ
- 年間売上/利益の予測（現在の契約ベース）

#### Phase 3: 分析・レポート機能

**F9: クローザー別受注率分析**
- 月別×クローザー別のマトリクス表示
- 想定受注の計算ロジック: A案件x0.8 + Bx0.5 + Cx0.2 + ネタx0.1

**F10: アポインター別受注率分析**
- アポインター別の成果分析（質の高いアポの可視化）

**F11: 決裁者別受注率分析**
- アポ先×クローザー別のクロス分析

**F12: リスト別受注率分析**
- 営業リスト/紹介元別の成果分析（費用対効果の可視化）

**F13: 営業代行案件獲得抽出ビュー**
- 案件管理表から営業代行関連の案件のみを自動フィルタ抽出

#### Phase 4: データ連携・運用機能

**F14: Excelインポート**
- 既存Excelからの一括データ移行
- バリデーション＋エラーレポート表示

**F15: Excelエクスポート**
- 各管理表のExcel形式でのエクスポート
- 現行Excelと同一フォーマットでの出力

**F16: 通知・リマインド機能**
- NextActionの期日アラート（当日/前日）
- ヨミステータスが一定期間変化しない案件のアラート
- 商談日前日のリマインド通知

---

### 2.2 競合調査で追加したMUST機能（5機能）

競合サービス（Salesforce、HubSpot、Mazrica Sales、GENIEE SFA/CRM、kintone）との比較調査により、業界標準として必須と判断した機能。

**F17: ダッシュボードKPIカード**
- 全競合が実装しているダッシュボード上のKPI即時把握機能
- 表示項目: 本日のアクション数、パイプライン金額合計、月次受注率、今月の受注件数、MRR（月間経常収益）
- Phase 1で実装

**F18: 活動ログ/ステータス変更履歴**
- Salesforce/HubSpotの標準機能に相当
- ヨミステータス変更、案件編集、フォロー追加などの操作を自動記録
- 「誰が」「いつ」「何を」「どう変更したか」を追跡可能
- 案件詳細画面およびグローバルな活動フィードで表示
- Phase 1で実装

**F19: トースト通知/操作フィードバック**
- 全競合が実装している操作結果の即時フィードバック機能
- 成功時: 緑色トースト（3秒で自動消去）
- エラー時: 赤色トースト（手動消去）
- 警告時: 黄色トースト（5秒で自動消去）
- 画面右上に表示、スタック表示対応（最大3件）
- Phase 1で実装

**F20: バルク操作（一括編集/一括削除）**
- 案件一覧でのチェックボックスによる複数選択
- 一括ステータス変更（ヨミステータスの一括更新）
- 一括クローザー/アポインター変更
- 一括削除（確認ダイアログ付き）
- Phase 2で実装

**F21: データバリデーション**
- 全入力フォームでのリアルタイムバリデーション
- 必須フィールドの未入力チェック
- 日付の整合性チェック（商談日 > アポ取得日 等）
- 金額フィールドの数値チェック（正の整数のみ）
- 電話番号の形式チェック
- メールアドレスの形式チェック
- エラーメッセージはフィールド直下に赤字で表示
- Phase 1で実装

---

### 2.3 競合調査で追加したSHOULD機能（7機能）

差別化および品質向上のために追加した機能。

**F22: キーボードショートカット**
- Excelユーザーの操作感向上のためのショートカット実装
- Tab: 次のセルへ移動
- Shift+Tab: 前のセルへ移動
- Enter: セル編集確定 + 下のセルへ移動
- Esc: セル編集キャンセル
- 矢印キー: セル間移動（上下左右）
- Ctrl+C / Ctrl+V: コピー/ペースト
- Ctrl+Z: 元に戻す（直前の操作）
- Ctrl+S: 変更を保存
- Ctrl+N: 新規案件作成ダイアログ
- Phase 1で実装

**F23: 列の表示/非表示切替**
- 65列以上あるため必要な列だけを表示する機能
- ヘッダー右クリックまたはツールバーから列の表示/非表示を切替
- 列の表示設定はユーザーごとにローカルストレージに保存
- プリセット機能: 「アポインター用」「クローザー用」「管理者用」等のカラムセット
- Phase 1で実装

**F24: 列幅のドラッグ調整**
- Excel操作感を再現する列幅調整機能
- ヘッダー境界線をドラッグして列幅を変更
- ダブルクリックで列幅を内容に合わせて自動調整
- 列幅設定はユーザーごとにローカルストレージに保存
- Phase 1で実装

**F25: 空状態（Empty State）表示**
- データが存在しない時の案内表示
- 各テーブル/リストで固有のイラストとメッセージを表示
- 例: 案件一覧 → 「まだ案件がありません。最初の案件を登録しましょう」+ 新規登録ボタン
- フィルタ結果が0件の場合 → 「条件に一致する案件がありません。フィルタを変更してください」
- Phase 1で実装

**F26: スケルトンローディング**
- データ読込中のUX向上のためのスケルトンスクリーン
- テーブル表示時: テーブルヘッダーは表示 + ボディ部分にスケルトン行を10行表示
- ダッシュボード: KPIカードのスケルトン + グラフエリアのスケルトン
- 詳細画面: 各セクションのスケルトン
- Phase 1で実装

**F27: フリーワード検索（グローバル）**
- ヘッダーバーに常設の検索ボックス
- 企業名/担当者名/備考/メモを横断検索
- インクリメンタルサーチ（300msデバウンス）
- 検索結果はドロップダウンでプレビュー表示（最大10件）
- クリックで該当案件の詳細画面に遷移
- Phase 2で実装

**F28: CSV/PDFエクスポート**
- Excel以外の出力形式対応
- CSV: UTF-8(BOM付き)でのエクスポート（Excel互換）
- PDF: A4横向き、テーブルレイアウトでの帳票出力
- エクスポート対象: 案件一覧、受注管理表、分析レポート
- Phase 4で実装

---

### 2.4 技術的に必要な機能（5機能）

**F29: 認証（ログイン/ログアウト）**
- Supabase Auth によるメール/パスワード認証
- ログイン画面: メールアドレス + パスワード入力フォーム
- ログアウト: サイドバーのユーザーメニューから実行
- セッション有効期限: 7日間（自動更新あり）
- 未認証ユーザーは全ページをログイン画面にリダイレクト
- パスワードリセット機能（メールによるリセットリンク送信）

**F30: エラーページ（404/500）**
- 404ページ: 存在しないURLにアクセスした場合の表示
  - メッセージ: 「ページが見つかりません」
  - ダッシュボードへの戻るリンク
- 500ページ: サーバーエラー発生時の表示
  - メッセージ: 「サーバーエラーが発生しました。しばらく経ってから再度お試しください」
  - リロードボタン + ダッシュボードへの戻るリンク

**F31: セッション管理**
- Supabase Auth のJWTトークンによるセッション管理
- アクセストークンの自動リフレッシュ（有効期限前に自動更新）
- 複数タブ間でのセッション同期
- セッション失効時は自動的にログイン画面へリダイレクト

**F32: Row Level Security（RLS）**
- Supabase RLS によるロールベースアクセス制御
- ロール定義:
  - `admin`: 全データの読み書き、ユーザー管理、マスタ管理
  - `closer`: 案件の読み書き、自担当案件の編集
  - `appointer`: 案件の閲覧、自担当アポの登録・編集
  - `manager`: 全データの読み取り、分析レポートへのアクセス
- RLSポリシー:
  - `deals`: 全ロールが閲覧可、`admin`/`closer`が編集可
  - `ai_tool_orders`: `admin`のみ編集可、他は閲覧のみ
  - `users`: `admin`のみ管理可

**F33: レスポンシブ対応**
- PC（1280px以上）: フル機能、スプレッドシートUI表示
- タブレット（768px-1279px）: サイドバー折りたたみ、テーブルは横スクロール対応
- スマートフォン（767px以下）: 閲覧のみ対応、カード型レイアウトに切替、編集機能は非対応

---

## 3. 画面一覧と画面遷移

### 3.1 全画面一覧（13画面）

| # | 画面名 | URL | 概要 | 認証要否 |
|---|--------|-----|------|---------|
| 1 | ログイン | `/login` | メール/パスワードによるログインフォーム | 不要 |
| 2 | ダッシュボード | `/dashboard` | KPIサマリー、本日のアクション、パイプライン概要 | 必要 |
| 3 | 案件一覧 | `/deals` | 全案件のスプレッドシート表示 | 必要 |
| 4 | 案件詳細 | `/deals/:id` | 案件の全情報 + フォロー履歴タイムライン | 必要 |
| 5 | AIツール受注管理 | `/orders/ai-tools` | AIツール受注管理スプレッドシート | 必要 |
| 6 | 営業代行受注管理 | `/orders/outsourcing` | 営業代行受注管理スプレッドシート | 必要 |
| 7 | 統合受注管理 | `/orders/all` | 全受注の統合ビュー + 月次売上表 | 必要 |
| 8 | 売上ダッシュボード | `/revenue` | グラフ・KPIによる売上/利益の可視化 | 必要 |
| 9 | 分析レポート | `/analytics` | クローザー/アポインター/決裁者/リスト別分析 | 必要 |
| 10 | 営業代行案件抽出 | `/leads/outsourcing` | 営業代行案件の抽出ビュー | 必要 |
| 11 | マスタ管理 | `/settings` | ユーザー/リスト/プルダウン値の管理 | 必要(admin) |
| 12 | 404エラー | `/not-found` | 存在しないURLの案内ページ | 不要 |
| 13 | 500エラー | `/error` | サーバーエラーの案内ページ | 不要 |

### 3.2 画面遷移図

```
[ログイン] ──認証成功──→ [ダッシュボード]
     │                        │
     │                  ┌─────┼─────────────────────────┐
     │                  │     │                         │
     │                  ▼     ▼                         ▼
     │            [案件一覧] [売上ダッシュボード]   [分析レポート]
     │                │
     │                ▼
     │           [案件詳細]
     │
     │         ┌──────────────────────────┐
     │         │                          │
     │         ▼                          ▼
     │   [AIツール受注]            [営業代行受注]
     │         │                          │
     │         └──────┬───────────────────┘
     │                ▼
     │         [統合受注管理]
     │
     │         [営業代行案件抽出]
     │
     │         [マスタ管理]  ← admin のみ
     │
     └──認証失敗/セッション切れ──→ [ログイン]

任意のページ ──存在しないURL──→ [404エラー]
任意のページ ──サーバーエラー──→ [500エラー]
```

### 3.3 共通レイアウト構成

```
┌─────────────────────────────────────────────────┐
│ ヘッダーバー                                      │
│ [ロゴ] [グローバル検索] [通知ベル] [ユーザーメニュー] │
├──────────┬──────────────────────────────────────┤
│          │                                      │
│ サイド    │  メインコンテンツエリア                  │
│ バー     │                                      │
│          │                                      │
│ - ダッシュ │                                     │
│ - 案件管理 │                                     │
│ - 受注管理 │                                     │
│   - AIツール│                                    │
│   - 営業代行│                                    │
│   - 統合   │                                     │
│ - 売上     │                                     │
│ - 分析     │                                     │
│ - 抽出     │                                     │
│ - 設定     │                                     │
│          │                                      │
└──────────┴──────────────────────────────────────┘
```

---

## 4. データモデル

### 4.1 テーブル一覧（12テーブル）

| # | テーブル名 | 対応Excelシート | 概要 |
|---|-----------|---------------|------|
| 1 | `companies` | -- | 企業マスタ（企業名/電話/住所/URL等を一元管理） |
| 2 | `contacts` | -- | 担当者マスタ（企業に紐づく先方担当者情報） |
| 3 | `deals` | 当月案件管理表 | 案件マスタ（アポ情報/商談情報/ヨミステータス） |
| 4 | `deal_followups` | 当月案件管理表(AC-BM列) | 商談フォロー履歴（最大5回分の追跡レコード） |
| 5 | `ai_tool_orders` | AIツール受注管理表 | AIツール商材別の受注・売上管理 |
| 6 | `sales_outsourcing_orders` | 営業代行受注管理表 | 営業代行案件の受注・プロジェクト管理 |
| 7 | `monthly_revenue` | 受注管理表(月別列) | 月次売上・利益の集計テーブル |
| 8 | `sales_outsourcing_leads` | 営業代行案件獲得抽出 | 営業代行案件のリード情報・商談備考 |
| 9 | `users` | プルダウン(担当者) | システムユーザー（アポインター/クローザー/マネージャー） |
| 10 | `lists` | プルダウン(リスト) | 営業リストマスタ（リスト名/種別の管理） |
| 11 | `dropdown_options` | プルダウン | 各種プルダウン値の一元管理 |
| 12 | `activity_logs` | -- (新規追加) | 操作ログ/ステータス変更履歴の自動記録 |

### 4.2 ER図（概要）

```
companies ─────< contacts
    │
    ├─────< deals ─────< deal_followups
    │         │
    │         ├── appointer_id → users
    │         ├── closer_id → users
    │         └── list_id → lists
    │
    ├─────< ai_tool_orders ─────< monthly_revenue
    │
    └─────< sales_outsourcing_orders
                  │
                  └─────< sales_outsourcing_leads

users ─────< activity_logs

dropdown_options（独立マスタ）
lists（独立マスタ）
```

### 4.3 deals テーブル

案件マスタ。現行Excelの「当月案件管理表」の列A-AB（主要情報）をマッピングする。

| カラム名 | 型 | 必須 | 説明 / Excel対応列 |
|---------|---|------|------------------|
| `id` | uuid | PK | 自動生成 |
| `deal_number` | serial | YES | 案件番号（A列） |
| `company_id` | uuid FK | YES | 企業マスタへの参照（B列） |
| `contact_id` | uuid FK | -- | 担当者マスタへの参照（E列） |
| `gender` | text | -- | I列: 性別 |
| `appointer_id` | uuid FK | YES | J列: アポ獲得者 |
| `appo_date` | date | YES | K列: アポ取得日 |
| `meeting_date` | date | -- | L列: 商談日 |
| `meeting_time` | time | -- | M列: 商談時間 |
| `appo_type` | text | -- | N列: アポ種別（確定アポ/アポ調） |
| `appo_target` | text | -- | O列: アポ先（社長/責任者/担当者） |
| `list_id` | uuid FK | -- | P列: リスト（営業リストへの参照） |
| `memo` | text | -- | Q列: 備考 |
| `reminder_status` | text | -- | R列: リマインド（済/未） |
| `closer_id` | uuid FK | -- | S列: クローザー |
| `meeting_result` | text | -- | T列: 商談可否（商談可/商談不可） |
| `order_result` | text | -- | U列: 受注可否（受注/失注） |
| `yomi_status` | text | YES | ヨミステータス: 受注/A/B/C/ネタ/没ネタ/失注/消滅 |
| `loss_reason` | text | -- | Z列: 失注理由 |
| `next_action` | text | -- | AA列: nextアクション |
| `next_action_date` | date | -- | AB列: アクション日 |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |
| `created_by` | uuid FK | YES | 作成者 |
| `updated_by` | uuid FK | YES | 最終更新者 |

### 4.4 deal_followups テーブル

商談フォロー履歴。現行Excelの「フォロー1回目〜5回目」（AC-BM列）に対応する。1案件につき最大5レコード。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `deal_id` | uuid FK | YES | 案件への参照 |
| `followup_number` | int | YES | フォロー回数（1-5） |
| `followup_date` | date | -- | フォロー日付（AC/AL/AS/AZ/BG列） |
| `assignee_id` | uuid FK | -- | 担当者（AD/AM/AT/BA/BH列） |
| `status` | text | -- | ステータス（AE/AN/AU/BB/BI列） |
| `note` | text | -- | 備考（AF/AO/AV/BC/BJ列） |
| `email_content` | text | -- | メール内容（AG列: フォロー1回目のみ） |
| `email_attachment` | text | -- | メール添付資料（AH列: フォロー1回目のみ） |
| `loss_reason` | text | -- | 失注理由（AI/AP/AW/BD/BK列） |
| `next_action` | text | -- | nextアクション（AJ/AQ/AX/BE/BL列） |
| `next_action_date` | date | -- | アクション日（AK/AR/AY/BF/BM列） |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.5 ai_tool_orders テーブル

AIツール商材別の受注・売上管理。「AIツール受注管理表」シートに対応。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `company_id` | uuid FK | YES | B列: 企業名への参照 |
| `list_source` | text | -- | C列: リスト（獲得経路） |
| `verbal_agreement_date` | date | -- | D列: 口頭合意日 |
| `status` | text | -- | E列: ステータス（契約完了/送信済み） |
| `cancellation_month` | date | -- | F列: 解約月 |
| `initial_payment_date` | date | -- | G列: 初期費用入金日 |
| `monthly_payment_start` | date | -- | H列: 月額入金開始日 |
| `initial_fee_lightup` | int | -- | K列: 初期費用（ライトアップ） |
| `initial_fee_ai_teleapo` | int | -- | L列: 初期費用（AIテレアポ） |
| `monthly_fees` | jsonb | -- | M-W列: 各商材の月額料金を格納 |
| `margin_amounts` | jsonb | -- | X-AH列: 各商材のマージン金額を格納 |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

`monthly_fees` JSONB構造:
```json
{
  "ai_teleapo": 200000,
  "form_sales_ai": 50000,
  "l_sync": 10000,
  "sales_list_ai": 30000,
  "ceo_copy_ai": 0,
  "business_card_ai": 30000,
  "ai_cfo": 0,
  "meo": 0,
  "recruitment_ai": 30000,
  "hachidori_ai": 0,
  "ai_training": 0
}
```

`margin_amounts` JSONB構造:
```json
{
  "ai_teleapo": 40000,
  "form_sales_ai": 15000,
  "l_sync": 3000,
  "sales_list_ai": 15000,
  "ceo_copy_ai": 0,
  "business_card_ai": 15000,
  "ai_cfo": 0,
  "meo": 0,
  "recruitment_ai": 15000,
  "hachidori_ai": 0,
  "ai_training": 0
}
```

### 4.6 sales_outsourcing_orders テーブル

営業代行案件の受注・プロジェクト管理。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `company_id` | uuid FK | YES | 企業名への参照 |
| `initial_fee` | int | -- | 初期費用 |
| `monthly_fee` | int | -- | 月額費用 |
| `contract_start_date` | date | -- | 契約開始日 |
| `contract_end_date` | date | -- | 契約終了日 |
| `project_status` | text | -- | プロジェクト準備ステータス |
| `notes` | text | -- | 備考 |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.7 monthly_revenue テーブル

月次売上・利益の集計テーブル。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `order_id` | uuid FK | YES | 受注（ai_tool_orders / sales_outsourcing_orders）への参照 |
| `order_type` | text | YES | 受注種別: `ai_tool` / `outsourcing` |
| `year_month` | date | YES | 対象年月（月初日） |
| `shot_revenue` | int | -- | ショット売上（初期費用マージン） |
| `stock_revenue` | int | -- | ストック売上（月額マージン） |
| `total_revenue` | int | -- | 合計売上（shot + stock） |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.8 sales_outsourcing_leads テーブル

営業代行案件のリード情報・商談備考。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `deal_id` | uuid FK | YES | 案件への参照 |
| `outsourcing_order_id` | uuid FK | -- | 営業代行受注への参照 |
| `lead_status` | text | -- | リードステータス |
| `meeting_notes` | text | -- | 商談備考 |
| `extracted_at` | timestamptz | -- | 抽出日時 |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.9 users テーブル

システムユーザー管理。Supabase Auth と連携。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | Supabase Auth の uid と同一 |
| `email` | text | YES | メールアドレス |
| `name` | text | YES | 表示名 |
| `role` | text | YES | ロール: `admin` / `closer` / `appointer` / `manager` |
| `is_active` | boolean | YES | 有効/無効フラグ（デフォルト: true） |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.10 lists テーブル

営業リストマスタ。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `name` | text | YES | リスト名 |
| `type` | text | -- | リスト種別（テレアポ/紹介/Web等） |
| `is_active` | boolean | YES | 有効/無効フラグ（デフォルト: true） |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.11 dropdown_options テーブル

各種プルダウン値の一元管理。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `category` | text | YES | カテゴリ（例: `yomi_status`, `appo_type`, `meeting_result`） |
| `value` | text | YES | プルダウン値 |
| `sort_order` | int | YES | 表示順 |
| `is_active` | boolean | YES | 有効/無効フラグ（デフォルト: true） |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |

### 4.12 companies テーブル

企業マスタ。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `name` | text | YES | 企業名（B列） |
| `phone` | text | -- | 電話番号（C列） |
| `mobile` | text | -- | 携帯電話（D列） |
| `address` | text | -- | 住所 |
| `url` | text | -- | WebサイトURL |
| `industry` | text | -- | 業種 |
| `notes` | text | -- | 備考 |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.13 contacts テーブル

担当者マスタ。企業に紐づく先方担当者情報。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `company_id` | uuid FK | YES | 企業への参照 |
| `name` | text | YES | 担当者名（E列） |
| `position` | text | -- | 役職（F列） |
| `department` | text | -- | 部署（G列） |
| `email` | text | -- | メールアドレス（H列） |
| `phone` | text | -- | 電話番号 |
| `created_at` | timestamptz | YES | レコード作成日時（自動） |
| `updated_at` | timestamptz | YES | レコード更新日時（自動） |

### 4.14 activity_logs テーブル（新規追加）

操作ログ/ステータス変更履歴の自動記録。競合調査でMUST機能として追加。

| カラム名 | 型 | 必須 | 説明 |
|---------|---|------|------|
| `id` | uuid | PK | 自動生成 |
| `user_id` | uuid FK | YES | 操作したユーザー |
| `action_type` | text | YES | 操作種別: `create` / `update` / `delete` / `status_change` / `bulk_update` |
| `target_table` | text | YES | 対象テーブル名（例: `deals`, `ai_tool_orders`） |
| `target_id` | uuid | YES | 対象レコードのID |
| `changes` | jsonb | -- | 変更内容（変更前/変更後の値） |
| `description` | text | -- | 操作の説明文（例: 「ヨミステータスを B → A に変更」） |
| `ip_address` | text | -- | アクセス元IPアドレス |
| `created_at` | timestamptz | YES | 操作日時（自動） |

`changes` JSONB構造の例:
```json
{
  "field": "yomi_status",
  "old_value": "B",
  "new_value": "A"
}
```

---

## 5. API設計

### 5.1 設計方針

- Supabase Client SDK を使用した直接DB操作（REST API自動生成）を基本とする
- 複雑な集計処理は Supabase RPC（PostgreSQL Functions）として実装する
- 全APIは TanStack Query でラップし、キャッシュ管理と自動再取得を行う
- エラーハンドリングは統一的に処理し、トースト通知で表示する

### 5.2 CRUD API一覧

#### Deals（案件管理）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 1 | GET | `/deals` | 案件一覧取得（フィルタ/ソート/ページネーション対応） |
| 2 | GET | `/deals/:id` | 案件詳細取得（フォロー履歴含む） |
| 3 | POST | `/deals` | 案件新規登録 |
| 4 | PATCH | `/deals/:id` | 案件更新（インラインセル編集含む） |
| 5 | DELETE | `/deals/:id` | 案件削除 |
| 6 | PATCH | `/deals/bulk` | 案件一括更新（バルク操作） |

#### Deal Followups（フォロー履歴）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 7 | GET | `/deals/:id/followups` | 案件のフォロー履歴取得 |
| 8 | POST | `/deals/:id/followups` | フォロー履歴追加 |
| 9 | PATCH | `/deal-followups/:id` | フォロー履歴更新 |
| 10 | DELETE | `/deal-followups/:id` | フォロー履歴削除 |

#### AI Tool Orders（AIツール受注管理）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 11 | GET | `/ai-tool-orders` | AIツール受注一覧取得 |
| 12 | GET | `/ai-tool-orders/:id` | AIツール受注詳細取得 |
| 13 | POST | `/ai-tool-orders` | AIツール受注新規登録 |
| 14 | PATCH | `/ai-tool-orders/:id` | AIツール受注更新 |
| 15 | DELETE | `/ai-tool-orders/:id` | AIツール受注削除 |

#### Sales Outsourcing Orders（営業代行受注管理）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 16 | GET | `/sales-outsourcing-orders` | 営業代行受注一覧取得 |
| 17 | GET | `/sales-outsourcing-orders/:id` | 営業代行受注詳細取得 |
| 18 | POST | `/sales-outsourcing-orders` | 営業代行受注新規登録 |
| 19 | PATCH | `/sales-outsourcing-orders/:id` | 営業代行受注更新 |
| 20 | DELETE | `/sales-outsourcing-orders/:id` | 営業代行受注削除 |

#### Sales Outsourcing Leads（営業代行リード）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 21 | GET | `/sales-outsourcing-leads` | 営業代行リード一覧取得 |
| 22 | POST | `/sales-outsourcing-leads` | 営業代行リード登録 |

#### Master Data（マスタデータ）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 23 | GET | `/companies` | 企業マスタ一覧取得（自動補完用） |
| 24 | POST | `/companies` | 企業マスタ新規登録 |
| 25 | GET | `/contacts` | 担当者マスタ一覧取得 |
| 26 | POST | `/contacts` | 担当者マスタ新規登録 |
| 27 | GET | `/users` | ユーザー一覧取得 |
| 28 | GET | `/lists` | 営業リスト一覧取得 |
| 29 | GET | `/dropdown-options` | プルダウン値一覧取得（カテゴリ別） |
| 30 | POST | `/dropdown-options` | プルダウン値登録 |

#### Activity Logs（活動ログ）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 31 | GET | `/activity-logs` | 活動ログ一覧取得（フィルタ対応） |
| 32 | GET | `/activity-logs/deal/:id` | 案件別活動ログ取得 |

#### Auth（認証）

| # | メソッド | エンドポイント | 説明 |
|---|---------|-------------|------|
| 33 | POST | `/auth/login` | ログイン（メール/パスワード） |
| 34 | POST | `/auth/logout` | ログアウト |
| 35 | POST | `/auth/reset-password` | パスワードリセットメール送信 |
| 36 | GET | `/auth/session` | 現在のセッション情報取得 |

### 5.3 RPC（PostgreSQL Functions）一覧

複雑な集計処理を Supabase RPC として実装する。

| # | RPC名 | 引数 | 説明 |
|---|-------|------|------|
| 1 | `rpc_get_dashboard_kpi` | `year_month: date` | ダッシュボードKPI集計（パイプライン金額、受注率、MRR、アクション数） |
| 2 | `rpc_get_pipeline_summary` | `year_month: date` | ヨミステータス別の案件数・金額集計 |
| 3 | `rpc_get_monthly_revenue` | `year: int` | 月次売上集計（ショット/ストック分離、12ヶ月分） |
| 4 | `rpc_get_revenue_by_product` | `year: int, month: int` | 商材別売上構成比の集計 |
| 5 | `rpc_get_closer_analysis` | `year: int, month: int` | クローザー別受注率分析 |
| 6 | `rpc_get_appointer_analysis` | `year: int, month: int` | アポインター別受注率分析 |
| 7 | `rpc_get_decision_maker_analysis` | `year: int, month: int` | 決裁者別受注率分析 |
| 8 | `rpc_get_list_analysis` | `year: int, month: int` | リスト別受注率分析 |
| 9 | `rpc_get_expected_revenue` | `year_month: date` | 想定受注金額計算（A*0.8 + B*0.5 + C*0.2 + ネタ*0.1） |
| 10 | `rpc_get_mrr_trend` | `start_month: date, end_month: date` | MRR推移データ取得 |
| 11 | `rpc_get_today_actions` | `user_id: uuid` | 本日のアクション一覧取得 |
| 12 | `rpc_get_stale_deals` | `days_threshold: int` | 一定期間ステータス変化なしの案件取得 |
| 13 | `rpc_calculate_margins` | `order_id: uuid` | AIツール受注のマージン自動計算 |
| 14 | `rpc_get_annual_summary` | `year: int` | 年間売上/利益サマリー |
| 15 | `rpc_search_global` | `query: text` | グローバル検索（企業名/担当者名/備考を横断） |
| 16 | `rpc_get_outsourcing_leads_view` | `filters: jsonb` | 営業代行案件獲得抽出ビューの集計 |

### 5.4 TanStack Query キー設計

```typescript
// Query Key の命名規則
const queryKeys = {
  deals: {
    all: ['deals'] as const,
    lists: () => [...queryKeys.deals.all, 'list'] as const,
    list: (filters: DealFilters) => [...queryKeys.deals.lists(), filters] as const,
    details: () => [...queryKeys.deals.all, 'detail'] as const,
    detail: (id: string) => [...queryKeys.deals.details(), id] as const,
    followups: (dealId: string) => [...queryKeys.deals.detail(dealId), 'followups'] as const,
  },
  aiToolOrders: {
    all: ['ai-tool-orders'] as const,
    lists: () => [...queryKeys.aiToolOrders.all, 'list'] as const,
    list: (filters: OrderFilters) => [...queryKeys.aiToolOrders.lists(), filters] as const,
    detail: (id: string) => [...queryKeys.aiToolOrders.all, 'detail', id] as const,
  },
  outsourcingOrders: {
    all: ['sales-outsourcing-orders'] as const,
    lists: () => [...queryKeys.outsourcingOrders.all, 'list'] as const,
    detail: (id: string) => [...queryKeys.outsourcingOrders.all, 'detail', id] as const,
  },
  revenue: {
    monthly: (year: number) => ['revenue', 'monthly', year] as const,
    byProduct: (year: number, month: number) => ['revenue', 'product', year, month] as const,
    mrr: (start: string, end: string) => ['revenue', 'mrr', start, end] as const,
    annual: (year: number) => ['revenue', 'annual', year] as const,
  },
  analytics: {
    closer: (year: number, month: number) => ['analytics', 'closer', year, month] as const,
    appointer: (year: number, month: number) => ['analytics', 'appointer', year, month] as const,
    decisionMaker: (year: number, month: number) => ['analytics', 'decision-maker', year, month] as const,
    list: (year: number, month: number) => ['analytics', 'list', year, month] as const,
  },
  dashboard: {
    kpi: (yearMonth: string) => ['dashboard', 'kpi', yearMonth] as const,
    pipeline: (yearMonth: string) => ['dashboard', 'pipeline', yearMonth] as const,
    todayActions: (userId: string) => ['dashboard', 'today-actions', userId] as const,
  },
  master: {
    companies: ['companies'] as const,
    contacts: (companyId?: string) => ['contacts', companyId] as const,
    users: ['users'] as const,
    lists: ['lists'] as const,
    dropdownOptions: (category?: string) => ['dropdown-options', category] as const,
  },
  activityLogs: {
    all: ['activity-logs'] as const,
    byDeal: (dealId: string) => ['activity-logs', 'deal', dealId] as const,
  },
} as const;
```

---

## 6. UX仕様

### 6.1 検索・フィルタ仕様

#### グローバル検索
- ヘッダーバーに常設の検索ボックス（幅: 300px、プレースホルダー: 「企業名・担当者名・備考で検索...」）
- 入力開始から300msのデバウンス後にインクリメンタルサーチ実行
- 検索対象: `companies.name`, `contacts.name`, `deals.memo`, `deals.next_action`
- 結果はドロップダウンでプレビュー表示（最大10件）
- 各結果に企業名、ヨミステータスバッジ、担当者名を表示
- クリック/Enterで案件詳細画面に遷移
- Escでドロップダウンを閉じる

#### テーブルフィルタ
- フィルタバーはテーブル上部に常設
- フィルタ項目:
  - ヨミステータス: マルチセレクト（チェックボックス付きドロップダウン）
  - クローザー: シングルセレクト
  - アポインター: シングルセレクト
  - リスト: シングルセレクト
  - 月: 年月ピッカー
  - フリーワード: テキスト入力（300msデバウンス）
- 「フィルタをクリア」ボタンで全フィルタをリセット
- アクティブなフィルタ数をバッジで表示
- フィルタ条件はURLクエリパラメータに反映（共有可能）

### 6.2 ソート仕様

- テーブルヘッダークリックでソート切替（なし → 昇順 → 降順 → なし）
- ソート中のカラムヘッダーにアイコン表示（▲昇順 / ▼降順）
- マルチソート対応: Shiftキー押しながらヘッダークリックで第2ソートキーを追加
- デフォルトソート: 案件番号の降順（最新が上）
- ソート条件はURLクエリパラメータに反映

### 6.3 キーボードショートカット仕様

#### テーブル操作

| キー | 動作 |
|------|------|
| Tab | 次のセル（右方向）にフォーカス移動 |
| Shift + Tab | 前のセル（左方向）にフォーカス移動 |
| Enter | セルが編集中: 確定して下のセルに移動 / 非編集中: 編集モードに入る |
| Esc | セル編集をキャンセル（変更を破棄して閲覧モードに戻る） |
| 矢印キー（上下左右） | フォーカスを隣接セルに移動（編集中は無効） |
| Ctrl + C | 選択セルの値をクリップボードにコピー |
| Ctrl + V | クリップボードの値を選択セルにペースト |
| Ctrl + Z | 直前の操作を元に戻す（1段階のみ） |
| F2 | 選択セルの編集モードに入る |
| Delete | 選択セルの値をクリア |

#### グローバルショートカット

| キー | 動作 |
|------|------|
| Ctrl + S | 未保存の変更を保存 |
| Ctrl + N | 新規案件登録ダイアログを開く |
| Ctrl + / | キーボードショートカットのヘルプを表示 |
| Ctrl + K | グローバル検索にフォーカス |

### 6.4 レスポンシブ対応方針

#### PC（1280px以上）
- フル機能を提供
- サイドバー展開表示（幅: 240px）
- スプレッドシートUI表示（インラインセル編集対応）
- 列固定表示（左5列固定）
- すべてのキーボードショートカットが有効

#### タブレット（768px - 1279px）
- サイドバーを折りたたみ（アイコンのみ、幅: 64px）、ハンバーガーメニューで展開
- テーブルは横スクロール対応
- インラインセル編集はタップで対応
- ダッシュボードのKPIカードは2列グリッド

#### スマートフォン（767px以下）
- 閲覧のみ対応（編集機能は非対応、「PCで操作してください」メッセージ表示）
- サイドバーはハンバーガーメニューに完全置換
- テーブルはカード型レイアウトに切替
- 各カードに企業名、ヨミステータス、担当者、次のアクションを表示
- カードタップで案件詳細を表示
- ダッシュボードのKPIカードは1列スタック

### 6.5 エラー表示仕様

#### トースト通知
- 位置: 画面右上（top: 16px, right: 16px）
- スタック表示: 最大3件まで同時表示、古いものから消去
- 種別と表示時間:
  - 成功（緑）: 3秒で自動消去、アイコン: チェックマーク
  - エラー（赤）: 手動消去のみ（×ボタン）、アイコン: エクスクラメーション
  - 警告（黄）: 5秒で自動消去、アイコン: 三角エクスクラメーション
  - 情報（青）: 3秒で自動消去、アイコン: インフォメーション
- アニメーション: 右からスライドイン、フェードアウト
- メッセージ例:
  - 成功: 「案件を保存しました」「ステータスを更新しました」
  - エラー: 「保存に失敗しました。ネットワーク接続を確認してください」
  - 警告: 「この案件は30日以上ステータスが変更されていません」

#### フォームバリデーションエラー
- 表示タイミング: フィールドからフォーカスが外れた時（onBlur）+ 送信時
- 表示位置: エラーのあるフィールドの直下
- スタイル: 赤字テキスト（font-size: 12px）+ フィールド枠線を赤色に変更
- メッセージ例:
  - 必須: 「企業名は必須です」
  - 日付: 「商談日はアポ取得日以降の日付を入力してください」
  - 数値: 「正の整数を入力してください」
  - 形式: 「有効な電話番号を入力してください」
- 送信時に複数エラーがある場合は最初のエラーフィールドにスクロール

#### APIエラー
- 401 (Unauthorized): 自動的にログイン画面へリダイレクト
- 403 (Forbidden): 「この操作を行う権限がありません」トースト表示
- 404 (Not Found): 404エラーページに遷移
- 500 (Server Error): 500エラーページに遷移 + 「サーバーエラーが発生しました」トースト
- ネットワークエラー: 「ネットワーク接続を確認してください」トースト（エラー種別）

### 6.6 ローディング仕様（スケルトンスクリーン）

#### テーブルローディング
- テーブルヘッダーは即座に表示（静的コンテンツ）
- ボディ部分に10行のスケルトン行を表示
- スケルトン行の各セルはグレーのパルスアニメーション（pulse animation）
- 列幅はヘッダーの幅に合わせる

#### ダッシュボードローディング
- KPIカード: カード枠は表示、内部の数値部分をスケルトン表示
- グラフ: グラフ枠 + タイトルは表示、グラフ描画エリアをスケルトン表示
- アクションリスト: リスト枠 + タイトルは表示、リストアイテムをスケルトン表示

#### 詳細画面ローディング
- セクションヘッダーは表示
- 各フィールド値をスケルトン表示
- タイムライン（フォロー履歴）は3件分のスケルトン表示

#### 遷移時のローディング
- ページ遷移時はヘッダーバーにプログレスバー（薄い青色、高さ2px）を表示
- Next.js の `loading.tsx` を利用したストリーミングSSR

### 6.7 空状態（Empty State）仕様

各画面でデータが存在しない場合に表示する案内。

| 画面 | 空状態メッセージ | アクションボタン |
|------|----------------|---------------|
| 案件一覧 | 「まだ案件がありません」 | 「最初の案件を登録する」ボタン |
| 案件一覧（フィルタ結果0件） | 「条件に一致する案件がありません」 | 「フィルタをクリア」ボタン |
| AIツール受注管理 | 「まだAIツールの受注がありません」 | 「受注を登録する」ボタン |
| 営業代行受注管理 | 「まだ営業代行の受注がありません」 | 「受注を登録する」ボタン |
| 統合受注管理 | 「まだ受注がありません」 | 「受注を登録する」ボタン |
| フォロー履歴 | 「まだフォロー履歴がありません」 | 「フォローを追加する」ボタン |
| 活動ログ | 「まだ活動履歴がありません」 | -- |
| 分析レポート | 「分析に必要なデータがまだありません」 | 「案件を登録する」ボタン |
| 営業代行抽出 | 「営業代行の案件がまだありません」 | 「案件を確認する」ボタン |

空状態のデザイン:
- 中央寄せレイアウト
- lucide-react のアイコン（各画面に適したもの）を大きく表示（64x64px、グレー）
- メインメッセージ: font-size 18px, font-weight 600, color: gray-700
- サブメッセージ: font-size 14px, color: gray-500
- アクションボタン: プライマリボタン（shadcn/ui の Button variant="default"）

---

## 7. 非機能要件

### 7.1 パフォーマンス要件

| 項目 | 要件 |
|------|------|
| 案件一覧の初期表示 | 2秒以内 |
| インラインセル更新 | 500ms以内 |
| ダッシュボードKPI表示 | 1秒以内 |
| グローバル検索結果表示 | 500ms以内（デバウンス300ms後） |
| ページ遷移 | 1秒以内 |
| Excelエクスポート（500件） | 5秒以内 |

### 7.2 容量・スケーラビリティ

| 項目 | 要件 |
|------|------|
| 同時接続数 | 初期10ユーザー、将来50ユーザーまで対応 |
| データ量 | 初期: 500案件/年、将来: 5,000案件/年まで対応 |
| テーブル表示 | 仮想スクロールにより500行以上でも快適動作 |
| DB容量 | Supabase Free: 500MB（数年分のデータに十分） |

### 7.3 セキュリティ

| 項目 | 要件 |
|------|------|
| 認証 | Supabase Auth によるメール/パスワード認証 |
| アクセス制御 | RLS（Row Level Security）によるロールベースアクセス |
| 通信 | HTTPS通信（Vercel SSL自動付与） |
| トークン管理 | JWT、HttpOnly Cookie によるセッション管理 |
| 入力サニタイズ | XSS防止のための入力値エスケープ |
| CSRF | Supabase Auth のCSRF対策を利用 |

### 7.4 可用性・バックアップ

| 項目 | 要件 |
|------|------|
| 可用性 | Vercel + Supabase のマネージドサービスによる高可用性運用 |
| バックアップ | Supabase自動バックアップ（日次）+ Excelエクスポートによる手動バックアップ |
| 障害時対応 | Excelエクスポートによるオフライン運用のフォールバック |

### 7.5 ブラウザ対応

| ブラウザ | 対応レベル |
|---------|----------|
| Chrome 最新版 | 推奨・フルサポート |
| Edge 最新版 | サポート |
| Safari 最新版 | サポート |
| Firefox 最新版 | ベストエフォート |

### 7.6 レスポンシブ対応

| デバイス | 対応レベル |
|---------|----------|
| PC（1280px以上） | メイン対応（フル機能） |
| タブレット（768px-1279px） | 対応（横スクロール、サイドバー折りたたみ） |
| スマートフォン（767px以下） | 閲覧のみ対応（編集不可） |

### 7.7 環境変数一覧

| 変数名 | 説明 | 必須 | 例 |
|--------|------|------|---|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase プロジェクトURL | YES | `https://xxxxx.supabase.co` |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase Anon Key（公開キー） | YES | `eyJhbGciOiJIUzI1NiIs...` |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase Service Role Key（サーバーサイドのみ） | YES | `eyJhbGciOiJIUzI1NiIs...` |
| `NEXT_PUBLIC_APP_URL` | アプリケーションのベースURL | YES | `https://soloptilink.vercel.app` |
| `NEXT_PUBLIC_APP_ENV` | 実行環境 | YES | `development` / `production` |

`.env.local` ファイル（ローカル開発用、Gitにコミットしない）:
```
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIs...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIs...
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_APP_ENV=development
```

### 7.8 ビルド・デプロイ設定

#### ビルドコマンド

```bash
# 開発サーバー起動
npm run dev

# 本番ビルド
npm run build

# 本番サーバー起動
npm run start

# 型チェック
npx tsc --noEmit

# Lint
npm run lint
```

#### Vercel デプロイ設定

```json
{
  "framework": "nextjs",
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "installCommand": "npm install",
  "devCommand": "npm run dev",
  "regions": ["hnd1"],
  "env": {
    "NEXT_PUBLIC_SUPABASE_URL": "@supabase-url",
    "NEXT_PUBLIC_SUPABASE_ANON_KEY": "@supabase-anon-key",
    "SUPABASE_SERVICE_ROLE_KEY": "@supabase-service-role-key"
  }
}
```

#### ディレクトリ構成

```
src/
├── app/
│   ├── (auth)/
│   │   ├── login/
│   │   │   └── page.tsx
│   │   └── layout.tsx
│   ├── (dashboard)/
│   │   ├── dashboard/
│   │   │   └── page.tsx
│   │   ├── deals/
│   │   │   ├── page.tsx
│   │   │   └── [id]/
│   │   │       └── page.tsx
│   │   ├── orders/
│   │   │   ├── ai-tools/
│   │   │   │   └── page.tsx
│   │   │   ├── outsourcing/
│   │   │   │   └── page.tsx
│   │   │   └── all/
│   │   │       └── page.tsx
│   │   ├── revenue/
│   │   │   └── page.tsx
│   │   ├── analytics/
│   │   │   └── page.tsx
│   │   ├── leads/
│   │   │   └── outsourcing/
│   │   │       └── page.tsx
│   │   ├── settings/
│   │   │   └── page.tsx
│   │   └── layout.tsx
│   ├── not-found.tsx
│   ├── error.tsx
│   ├── loading.tsx
│   ├── layout.tsx
│   └── page.tsx          # → /dashboard にリダイレクト
├── components/
│   ├── ui/               # shadcn/ui コンポーネント
│   ├── deals/            # 案件関連コンポーネント
│   ├── orders/           # 受注関連コンポーネント
│   ├── analytics/        # 分析関連コンポーネント
│   ├── dashboard/        # ダッシュボード関連コンポーネント
│   └── layout/           # レイアウトコンポーネント（ヘッダー、サイドバー）
├── lib/
│   ├── supabase/
│   │   ├── client.ts     # ブラウザ用 Supabase Client
│   │   ├── server.ts     # サーバー用 Supabase Client
│   │   └── middleware.ts  # 認証ミドルウェア
│   ├── utils/
│   │   ├── format.ts     # 日付/金額フォーマット
│   │   ├── validation.ts # バリデーション関数
│   │   └── margin.ts     # マージン計算ロジック
│   └── constants/
│       ├── yomi.ts       # ヨミステータス定義・色定義
│       ├── margins.ts    # マージン率定義
│       └── routes.ts     # ルート定義
├── hooks/
│   ├── use-deals.ts      # 案件CRUD hooks
│   ├── use-orders.ts     # 受注CRUD hooks
│   ├── use-analytics.ts  # 分析データ hooks
│   ├── use-auth.ts       # 認証 hooks
│   └── use-toast.ts      # トースト通知 hooks
├── stores/
│   ├── filter-store.ts   # フィルタ状態管理
│   ├── table-store.ts    # テーブル状態管理（列幅、表示/非表示）
│   └── ui-store.ts       # UI状態管理（サイドバー開閉等）
└── types/
    ├── database.ts       # Supabase DB型定義（自動生成）
    ├── deals.ts          # 案件関連の型
    ├── orders.ts         # 受注関連の型
    └── analytics.ts      # 分析関連の型
```

---

## 8. ヨミ定義・ビジネスロジック

### 8.1 ヨミステータス定義

SoloptiLinkの営業パイプラインにおける8段階のステータス定義。

| ステータス | 定義 | 想定受注率 | 表示色 | 色コード |
|-----------|------|----------|--------|---------|
| 受注 | クライアント側で申し込み確認取れたもの | 100% | 青 | `#3B82F6` |
| Aヨミ | 口頭合意と申し込みURL送付、案内の日程まで決まっているもの | 80% | 赤 | `#EF4444` |
| Bヨミ | 口頭合意と申し込みURL送付、案内の日程が決まっていないもの | 50% | オレンジ | `#F97316` |
| Cヨミ | 月内スタート検討 | 20% | 黄 | `#EAB308` |
| ネタ | 3か月以内の利用可能性あり | 10% | 緑 | `#22C55E` |
| 没ネタ | 3か月以上かかりそうだが、検討余地あり | 5% | グレー | `#9CA3AF` |
| 失注 | 当面やらなそう | 0% | 灰色 | `#6B7280` |
| 消滅 | 既存顧客等 | 0% | 灰色 | `#D1D5DB` |

### 8.2 想定受注金額の計算ロジック

パイプラインにおける想定受注金額は以下の計算式で算出する。

```
想定受注金額 = Σ(受注案件の金額 × 1.0)
             + Σ(A案件の金額 × 0.8)
             + Σ(B案件の金額 × 0.5)
             + Σ(C案件の金額 × 0.2)
             + Σ(ネタ案件の金額 × 0.1)
             + Σ(没ネタ案件の金額 × 0.05)
```

失注・消滅は計算対象外（0%）。

### 8.3 マージン率計算ロジック

AIツール各商材のマージン率（現行Excelの計算式に準拠）:

| # | 商材名 | マージン率 | 計算例 |
|---|-------|----------|--------|
| 1 | AIテレアポ | 20% | 月額200,000円 → マージン40,000円 |
| 2 | フォーム営業AI | 30% | 月額50,000円 → マージン15,000円 |
| 3 | Lシンク | 30% | 月額10,000円 → マージン3,000円 |
| 4 | 営業リスト生成AI | 50% | 月額30,000円 → マージン15,000円 |
| 5 | 社長コピーAI | 50% | 月額料金 x 50% |
| 6 | 名刺フォローAI | 50% | 月額30,000円 → マージン15,000円 |
| 7 | AI経営参謀 | 50% | 月額料金 x 50% |
| 8 | MEO | 50% | 月額料金 x 50% |
| 9 | 採用募集自動化AI | 50% | 月額30,000円 → マージン15,000円 |
| 10 | ハチドリAI | 50% | 月額料金 x 50% |
| 11 | AIステップアップ研修 | 50% | 月額料金 x 50% |

初期費用（ショット）のマージン率: **50%**（初期費用合計 x 50%）

マージン率定数定義（TypeScript）:
```typescript
export const MARGIN_RATES: Record<string, number> = {
  ai_teleapo: 0.20,
  form_sales_ai: 0.30,
  l_sync: 0.30,
  sales_list_ai: 0.50,
  ceo_copy_ai: 0.50,
  business_card_ai: 0.50,
  ai_cfo: 0.50,
  meo: 0.50,
  recruitment_ai: 0.50,
  hachidori_ai: 0.50,
  ai_training: 0.50,
  initial_fee: 0.50,
} as const;
```

### 8.4 月次売上集計ロジック

#### ショット売上（初期費用）
- 口頭合意月にのみ計上
- 計算: 初期費用合計 x マージン率（50%）
- 例: 初期費用 ライトアップ100,000円 + AIテレアポ50,000円 = 150,000円 → マージン75,000円

#### ストック売上（月額費用）
- 月額入金開始日（H列）から毎月計上
- 計算: 各商材の月額費用 x 各商材のマージン率
- 11商材分のマージンを合算

#### 解約処理ロジック
- F列（解約月）に日付が入っている場合:
  - その月の1日を解約月として判定
  - 解約月の前月までストック収益を計上
  - 解約月以降のストック収益は0
- 解約月が未設定の場合: ストック収益を継続計上

#### 年間合計
- 12ヶ月分（1月〜12月）のショット + ストックを自動合算
- 計算式: `年間合計 = Σ(月次ショット売上) + Σ(月次ストック売上)`

#### 月次集計のタイミング
- 受注データの登録/更新時にトリガーで `monthly_revenue` テーブルを自動更新
- 手動での再計算ボタンも提供（管理者のみ）

### 8.5 受注率計算ロジック

各種分析レポートで使用する受注率の計算方法。

#### クローザー別受注率
```
受注率 = 受注件数 / 商談件数 x 100
想定受注金額 = A案件数 x 平均単価 x 0.8 + B案件数 x 平均単価 x 0.5 + ...
```

#### アポインター別受注率
```
受注率 = 受注件数 / アポイント件数 x 100
アポ品質 = 商談可率 = 商談可件数 / アポイント件数 x 100
```

#### 決裁者別受注率
```
受注率 = 受注件数 / 商談件数 x 100 （アポ先 x クローザー のクロス集計）
```

#### リスト別受注率
```
受注率 = 受注件数 / アポイント件数 x 100
費用対効果 = 受注金額合計 / リストのコスト （コストが管理されている場合）
```

---

## 付録

### A. 開発ルール

1. **TypeScript**: `any` 型は禁止。全コンポーネントにProps型定義を付与
2. **金額計算**: 必ず整数（円単位）で行い、小数点は使用しない
3. **日付表示**: 全てJST（Asia/Tokyo）で統一
4. **エラーハンドリング**: try-catchで必ず行い、ユーザー向けトースト通知で表示
5. **プルダウン値**: 全てマスタテーブルに格納し、ハードコードしない
6. **Supabaseクエリ**: TanStack Queryでラップし、キャッシュ/自動再取得を管理
7. **コンポーネント設計**: 単一責任原則に従い、1コンポーネント1ファイル

### B. 初期化コマンド

```bash
npx create-next-app@latest soloptilink-sfa --typescript --tailwind --eslint --app --src-dir --import-alias '@/*'
cd soloptilink-sfa
npm install @supabase/supabase-js @supabase/ssr @tanstack/react-table @tanstack/react-query zustand recharts xlsx date-fns lucide-react
npx shadcn@latest init
```

### C. インフラコスト

| サービス | プラン | 月額費用 | 利用可能な範囲 |
|---------|-------|---------|-------------|
| Vercel | Hobby (Free) | 0円 | Next.jsホスティング、自動CI/CD、Edge Functions、SSL自動付与 |
| Supabase | Free | 0円 | PostgreSQL 500MB、Auth 50,000MAU、Storage 1GB、Realtime対応 |
| ドメイン | 不要 | 0円 | *.vercel.app サブドメインで運用可能 |
| SSL証明書 | 自動付与 | 0円 | Vercelが自動でプロビジョニング |
| **合計** | -- | **0円/月** | 外部有料API契約不要・全機能無料枠内で完結 |
