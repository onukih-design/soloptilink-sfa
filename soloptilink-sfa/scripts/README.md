# データ移行スクリプト

このディレクトリには、ExcelファイルからSupabase PostgreSQLへのデータ移行スクリプトが含まれています。

## スクリプト一覧

### 1. generate-seed.js
ExcelファイルからSupabase用のシードSQLを生成するメインスクリプト。

**入力**: `/Users/onukifutoshishuu/Downloads/AI商社 案件管理表.xlsx`

**出力**: `../supabase/migrations/002_seed_data.sql`

**実行方法**:
```bash
node scripts/generate-seed.js
```

**処理内容**:
- 「当月案件管理表」シートから案件データを抽出
- 「AIツール　受注管理表」シートから受注データを抽出
- ユーザー、企業、連絡先、リスト、案件、フォローアップ、AI受注のINSERT文を生成

**生成データ統計**:
- Users: 6人
- Companies: 236社
- Contacts: 214件
- Lists: 20件
- Deals: 582件
- Deal Followups: 551件
- AI Tool Orders: 26件

### 2. inspect-excel.js
Excelファイルの構造をデバッグするためのユーティリティスクリプト。

**実行方法**:
```bash
node scripts/inspect-excel.js
```

**用途**:
- Excelファイルのカラム構造確認
- ヘッダー行の検証
- データサンプルの確認

### 3. create-auth-users.js
Supabase Authにユーザーを作成し、usersテーブルと紐付けるスクリプト。

**前提条件**:
- `.env.local` に以下の環境変数が設定されていること:
  - `NEXT_PUBLIC_SUPABASE_URL`
  - `SUPABASE_SERVICE_ROLE_KEY` (service_role key必須)

**実行方法**:
```bash
node scripts/create-auth-users.js
```

**処理内容**:
- 6人のユーザーをSupabase Auth経由で作成
- 生成されたauth.users IDでusersテーブルを更新
- 初期パスワードは `ChangeMe123!` (admin: `SolOptiLink2025!`)

## データ移行フロー

### 完全移行手順

1. **シードSQLを生成**
   ```bash
   node scripts/generate-seed.js
   ```

2. **データベースをリセット（既存データがある場合）**
   ```bash
   supabase db reset
   ```

3. **マイグレーションを適用**
   ```bash
   supabase db push
   ```
   これで `002_seed_data.sql` が実行され、FK制約が一時的に無効化された状態でデータが投入されます。

4. **Supabase Authにユーザーを作成**
   ```bash
   node scripts/create-auth-users.js
   ```

5. **FK制約を再有効化**
   Supabase SQL Editorで以下を実行:
   ```sql
   ALTER TABLE users ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);
   ALTER TABLE deals ADD CONSTRAINT deals_appointer_id_fkey FOREIGN KEY (appointer_id) REFERENCES users(id);
   ALTER TABLE deals ADD CONSTRAINT deals_closer_id_fkey FOREIGN KEY (closer_id) REFERENCES users(id);
   ALTER TABLE deal_followups ADD CONSTRAINT deal_followups_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES users(id);
   ALTER TABLE activity_logs ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
   ```

6. **データ検証**
   ```sql
   SELECT 'users' AS table_name, COUNT(*) FROM users
   UNION ALL SELECT 'companies', COUNT(*) FROM companies
   UNION ALL SELECT 'contacts', COUNT(*) FROM contacts
   UNION ALL SELECT 'lists', COUNT(*) FROM lists
   UNION ALL SELECT 'deals', COUNT(*) FROM deals
   UNION ALL SELECT 'deal_followups', COUNT(*) FROM deal_followups
   UNION ALL SELECT 'ai_tool_orders', COUNT(*) FROM ai_tool_orders;
   ```

## トラブルシューティング

### Excelのパスが異なる場合

`generate-seed.js` の以下の行を編集:
```javascript
const EXCEL_PATH = '/Users/onukifutoshishuu/Downloads/AI商社 案件管理表.xlsx';
```

### カラム構造が変更された場合

1. `inspect-excel.js` を実行してカラムインデックスを確認
2. `generate-seed.js` の対応するカラムインデックスを修正
3. スクリプトを再実行

### UUIDの不一致エラー

Supabase Authでは、カスタムUUIDを指定できない場合があります。その場合:
1. `create-auth-users.js` がauth.usersで生成されたIDでusersテーブルを自動更新します
2. ただし、deals/deal_followupsの外部キーも更新が必要な場合があります
3. その場合は、以下のSQLを実行してマッピングを更新:
   ```sql
   -- 例: 小貫のIDが変更された場合
   UPDATE deals SET appointer_id = '<new-uuid>' WHERE appointer_id = '00000000-0000-0000-0000-000000000001';
   UPDATE deals SET closer_id = '<new-uuid>' WHERE closer_id = '00000000-0000-0000-0000-000000000001';
   UPDATE deal_followups SET assignee_id = '<new-uuid>' WHERE assignee_id = '00000000-0000-0000-0000-000000000001';
   ```

## 注意事項

- **Excel日付のシリアル値**: Excelの日付はシリアル値（例: 45988 = 2025-11-27）として格納されています。スクリプトは自動的にYYYY-MM-DD形式に変換します。
- **Excel時刻の小数値**: Excelの時刻は0-1の小数値（例: 0.4375 = 10:30）として格納されています。スクリプトは自動的にHH:MM:SS形式に変換します。
- **NULL処理**: 空文字列や空セルは自動的にNULLとして扱われます。
- **文字列エスケープ**: シングルクォートは自動的にダブルクォート (`''`) にエスケープされます。
- **JSONB形式**: AI Tool OrdersのmonthlyFeesとmarginAmountsはJSONB形式で保存されます。

## ファイル構造

```
scripts/
├── README.md                    # このファイル
├── generate-seed.js             # メインスクリプト
├── inspect-excel.js             # デバッグ用
└── create-auth-users.js         # ユーザー作成

supabase/
├── migrations/
│   ├── 001_initial_schema.sql   # 初期スキーマ
│   └── 002_seed_data.sql        # 生成されるシードデータ
└── MIGRATION_GUIDE.md           # 移行ガイド
```
