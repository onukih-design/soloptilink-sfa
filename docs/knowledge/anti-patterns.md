# アンチパターン集（やってはいけないこと）

---

### AP001: Claude/OpenAI APIの本番使用
❌ `fetch("https://api.anthropic.com/v1/messages")`
✅ `fetch(process.env.AI_API_URL)` → DeepSeek/Gemini

### AP002: 有料DBのデフォルト採用
❌ `npm install @prisma/client` → PostgreSQL前提
✅ `npm install better-sqlite3` → SQLiteで十分な場合が90%

### AP003: moment.jsの使用
❌ `npm install moment`（300KB+）
✅ `npm install date-fns` or `dayjs`（2KB）

### AP004: console.logのデバッグ残し
❌ `console.log("debug:", data)` が本番コードに残る
✅ 専用logger使用 or 本番ビルドで除去

### AP005: APIキーのハードコード
❌ `const API_KEY = "sk-xxx..."` 
✅ `const API_KEY = process.env.API_KEY`

### AP006: 全件取得のAPI
❌ `GET /api/users` → 全ユーザー返却
✅ `GET /api/users?page=1&limit=20` → ページネーション必須

### AP007: CORSの`*`設定
❌ `cors({ origin: "*" })`
✅ `cors({ origin: process.env.FRONTEND_URL })`

### AP008: 認証なしのAPI公開
❌ 全エンドポイントが認証不要
✅ 公開API以外はJWT/セッション認証必須
