# データ移行ガイド

このガイドでは、ExcelデータからSupabase PostgreSQLへのデータ移行手順を説明します。

## 生成されたデータ概要

- **Users**: 6人
- **Companies**: 236社
- **Contacts**: 214件
- **Lists**: 20件
- **Deals**: 582件
- **Deal Followups**: 551件
- **AI Tool Orders**: 26件

## 移行手順

### 1. Excelからシードデータを生成

既に生成済みです。再生成する場合:

```bash
node scripts/generate-seed.js
```

生成されるファイル:
- `supabase/migrations/002_seed_data.sql`

### 2. Supabaseにマイグレーションを適用

```bash
supabase db push
```

このコマンドで以下が実行されます:
- FK制約の一時無効化
- Users、Lists、Companies、Contacts、Deals、Deal Followups、AI Tool Ordersの投入

### 3. Supabase Authにユーザーを作成

**重要**: `002_seed_data.sql`で挿入されたusersレコードは、auth.usersテーブルとの外部キー制約が無効化された状態です。以下のユーザーをSupabase Auth経由で作成する必要があります。

#### 作成が必要なユーザー

| ID | 名前 | メールアドレス | ロール | パスワード(初期) |
|----|------|---------------|--------|-----------------|
| `00000000-0000-0000-0000-000000000001` | 小貫 | onuki.h@soloptilink.com | admin | (管理者が設定) |
| `00000000-0000-0000-0000-000000000002` | 樋上 | 樋上@soloptilink.com | appointer | (管理者が設定) |
| `00000000-0000-0000-0000-000000000003` | 高橋 | 高橋@soloptilink.com | appointer | (管理者が設定) |
| `00000000-0000-0000-0000-000000000004` | 野村 | 野村@soloptilink.com | appointer | (管理者が設定) |
| `b313633e-4001-4c13-9a93-de2b0b1971a0` | 正橋 | 正橋@soloptilink.com | appointer | (管理者が設定) |
| `63a55be1-0fca-459f-8335-8c800019c678` | 稲吉 | 稲吉@soloptilink.com | appointer | (管理者が設定) |

#### Supabase Auth経由でのユーザー作成方法

**Option A: Supabase Dashboard経由**

1. Supabase Dashboardにログイン
2. Authentication → Users → Add User
3. 上記テーブルの各ユーザーについて:
   - Email: 指定のメールアドレス
   - Password: 仮パスワード(ユーザーが初回ログイン時に変更)
   - User UID: 上記テーブルのID (手動で指定可能な場合)

**Option B: Supabase Admin API経由 (推奨)**

以下のNode.jsスクリプトを作成して実行:

```javascript
// scripts/create-auth-users.js
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY; // service_role key必須

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

const users = [
  { id: '00000000-0000-0000-0000-000000000001', email: 'onuki.h@soloptilink.com', password: 'ChangeMe123!' },
  { id: '00000000-0000-0000-0000-000000000002', email: '樋上@soloptilink.com', password: 'ChangeMe123!' },
  { id: '00000000-0000-0000-0000-000000000003', email: '高橋@soloptilink.com', password: 'ChangeMe123!' },
  { id: '00000000-0000-0000-0000-000000000004', email: '野村@soloptilink.com', password: 'ChangeMe123!' },
  { id: 'b313633e-4001-4c13-9a93-de2b0b1971a0', email: '正橋@soloptilink.com', password: 'ChangeMe123!' },
  { id: '63a55be1-0fca-459f-8335-8c800019c678', email: '稲吉@soloptilink.com', password: 'ChangeMe123!' },
];

async function createUsers() {
  for (const user of users) {
    const { data, error } = await supabase.auth.admin.createUser({
      email: user.email,
      password: user.password,
      email_confirm: true,
      user_metadata: {
        name: user.email.split('@')[0]
      }
    });

    if (error) {
      console.error(`Failed to create user ${user.email}:`, error);
    } else {
      console.log(`Created user: ${user.email} with ID: ${data.user.id}`);

      // Update users table with auth.users id
      if (data.user.id !== user.id) {
        console.warn(`Warning: Generated ID ${data.user.id} doesn't match expected ${user.id}`);
      }
    }
  }
}

createUsers().catch(console.error);
```

**注意**: Supabase Authでは、UUIDを手動で指定できない場合があります。その場合は、生成されたIDをusersテーブルに反映する必要があります。

### 4. FK制約を再有効化

ユーザー作成後、以下のSQLを実行:

```sql
ALTER TABLE users ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);
ALTER TABLE deals ADD CONSTRAINT deals_appointer_id_fkey FOREIGN KEY (appointer_id) REFERENCES users(id);
ALTER TABLE deals ADD CONSTRAINT deals_closer_id_fkey FOREIGN KEY (closer_id) REFERENCES users(id);
ALTER TABLE deal_followups ADD CONSTRAINT deal_followups_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES users(id);
ALTER TABLE activity_logs ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
```

これはSupabase SQL Editorまたは `supabase db execute` で実行できます。

## トラブルシューティング

### エラー: "duplicate key value violates unique constraint"

- 既にデータが投入されている場合、`supabase db reset` でデータベースをリセットしてから再度マイグレーションを実行してください。

### エラー: "violates foreign key constraint"

- auth.usersにユーザーが作成されていない状態でFK制約を再有効化しようとしている場合です。手順3を完了してから手順4を実行してください。

### Excel再生成が必要な場合

Excelファイルが更新された場合:

```bash
# スクリプトを再実行
node scripts/generate-seed.js

# マイグレーションファイルが更新されるので、データベースをリセット
supabase db reset

# マイグレーションを適用
supabase db push

# 手順3、4を再度実行
```

## データ検証

マイグレーション後、以下のSQLで件数を確認:

```sql
SELECT 'users' AS table_name, COUNT(*) FROM users
UNION ALL
SELECT 'companies', COUNT(*) FROM companies
UNION ALL
SELECT 'contacts', COUNT(*) FROM contacts
UNION ALL
SELECT 'lists', COUNT(*) FROM lists
UNION ALL
SELECT 'deals', COUNT(*) FROM deals
UNION ALL
SELECT 'deal_followups', COUNT(*) FROM deal_followups
UNION ALL
SELECT 'ai_tool_orders', COUNT(*) FROM ai_tool_orders;
```

期待される結果:
- users: 6
- companies: 236
- contacts: 214
- lists: 20
- deals: 582
- deal_followups: 551
- ai_tool_orders: 26
