# SoloptiLink 開発ベストプラクティス（自動蓄積）

このファイルはチェーン開発で確認された良い実装パターンを蓄積します。

---

## アーキテクチャ

### BP001: 3層AI ルーティング
```
ユーザー入力
  ↓ Gemini Flash（$0.10/M）で分類
  ├─ 簡単 → Gemini Flash で処理
  ├─ 中程度 → DeepSeek V3.2 で処理（$0.28/M）
  └─ 複雑 → DeepSeek Reasoner で処理
```
全AI機能でこのパターンを適用すること。

### BP002: 3層キャッシュ
```
リクエスト
  ↓ アプリメモリキャッシュ（Map/Redis）→ ヒット → 返却（$0）
  ↓ APIプレフィックスキャッシュ（DeepSeek自動）→ 90%割引
  ↓ レスポンスDBキャッシュ（SQLite）→ ヒット → 返却（$0）
  ↓ API呼び出し（最後の手段）
```

### BP003: エラー境界パターン（React）
```tsx
// 全ページで ErrorBoundary + Suspense
<ErrorBoundary fallback={<ErrorPage />}>
  <Suspense fallback={<Loading />}>
    <PageContent />
  </Suspense>
</ErrorBoundary>
```

### BP004: API レスポンス統一形式
```json
{
  "success": true,
  "data": { ... },
  "error": null,
  "meta": { "page": 1, "total": 100 }
}
```
全APIエンドポイントでこの形式を使用。

## フロントエンド

### BP005: 3状態UI
全データ表示コンポーネントは「ローディング」「空状態」「エラー」の3状態を実装。

### BP006: 楽観的更新
ユーザー操作（いいね、削除等）はAPIレスポンスを待たずにUI更新。失敗時にロールバック。

## バックエンド

### BP007: 入力バリデーション（二重防御）
フロントエンド（UX用）とバックエンド（セキュリティ用）の両方でzodバリデーション。

### BP008: SQLiteの適切な設定
```js
// WALモードで同時読取可能にする
db.pragma('journal_mode = WAL');
db.pragma('busy_timeout = 5000');
```
