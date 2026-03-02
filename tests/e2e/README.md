# E2Eテストスイート - SoloptiLink SFA

## 概要
SoloptiLink SFA（営業支援ツール）のPlaywright E2Eテストスイートです。
デモモード環境（Supabase未接続）で動作し、主要な画面とユーザーフローを検証します。

## テストファイル一覧

### 1. login.spec.ts - ログイン機能
- ログインページの表示確認
- デモモードバナーの表示確認
- ログインフォームの表示確認
- デモ認証情報でのログイン成功
- 誤った認証情報でのエラー表示
- コンソールエラーの検出

**テスト数**: 6件

### 2. dashboard.spec.ts - ダッシュボード
- ダッシュボードページの表示確認
- KPIカード4つの表示確認（パイプライン総額、今月受注、MRR、本日のアクション）
- パイプラインチャートの表示確認
- 本日のアクションセクションの表示確認
- 最近の案件テーブルの表示確認
- コンソールエラーの検出

**テスト数**: 6件

### 3. deals.spec.ts - 案件管理
- 案件一覧ページの表示確認
- テーブルヘッダー（案件番号、企業名、ヨミ等）の表示確認
- 案件データの表示確認
- ヨミステータスフィルタの表示確認
- ヨミステータスフィルタの動作確認
- 案件詳細ページへの遷移確認
- コンソールエラーの検出

**テスト数**: 7件

### 4. orders.spec.ts - 受注管理
- AIツール受注管理ページの表示確認
- 営業代行受注管理ページの表示確認
- 統合受注管理ページの表示確認
- 各ページでのテーブル/リスト表示確認
- 各ページでのコンソールエラー検出

**テスト数**: 6件

### 5. analytics.spec.ts - 分析レポート
- 売上ダッシュボードの表示確認
- 売上ダッシュボードのチャート表示確認
- 分析レポートページの表示確認
- 分析レポートのデータ表示要素確認
- 各分析ページ間の遷移確認
- 各ページでのコンソールエラー検出

**テスト数**: 6件

### 6. navigation.spec.ts - ナビゲーション
- サイドバーの表示確認
- サイドバーの主要メニューリンク存在確認
- ダッシュボードへの遷移確認
- 案件一覧への遷移確認
- 受注管理への遷移確認
- 分析ページへの遷移確認
- 設定ページへの遷移確認
- リード管理ページへの遷移確認
- 404ページの表示確認
- 全主要ページでのコンソールエラー検出
- ブラウザバック・フォワードの動作確認

**テスト数**: 11件

## 合計テスト数: 42件

## 実行方法

### 前提条件
```bash
# 開発サーバーを起動（別ターミナル）
cd soloptilink-sfa
npm run dev
```

### 全テスト実行
```bash
npx playwright test
```

### 特定のテストファイルのみ実行
```bash
npx playwright test tests/e2e/login.spec.ts
npx playwright test tests/e2e/dashboard.spec.ts
npx playwright test tests/e2e/deals.spec.ts
npx playwright test tests/e2e/orders.spec.ts
npx playwright test tests/e2e/analytics.spec.ts
npx playwright test tests/e2e/navigation.spec.ts
```

### UIモードで実行（デバッグ用）
```bash
npx playwright test --ui
```

### ヘッドモードで実行（ブラウザ表示）
```bash
npx playwright test --headed
```

### HTMLレポート生成
```bash
npx playwright test --reporter=html
npx playwright show-report
```

### JSON形式でレポート出力
```bash
npx playwright test --reporter=json 2>&1 | tee docs/test-e2e-result.json
```

## テスト設計の原則

### 1. コンソールエラー検出
全テストで以下のパターンを実装:
```typescript
const errors: string[] = [];
page.on('console', msg => {
  if (msg.type() === 'error') errors.push(msg.text());
});
page.on('pageerror', err => errors.push(err.message));
expect(errors).toEqual([]);
```

### 2. デモモード認証
各テストの`beforeEach`でデモ認証クッキーをセット:
```typescript
await context.addCookies([{
  name: 'demo-auth',
  value: 'true',
  domain: 'localhost',
  path: '/',
}]);
```

### 3. 適切な待機処理
- `page.waitForTimeout()`: データロード待機
- `page.waitForLoadState('networkidle')`: ネットワーク安定待機
- `page.waitForURL()`: ページ遷移待機

### 4. 柔軟なセレクタ
- テキストベースのセレクタを優先（実装詳細に依存しない）
- 正規表現を使用した柔軟なマッチング
- フォールバック検証を実装

## デモモード認証情報
- Email: `onuki.h@soloptilink.com`
- Password: `Hiro9101`

## カバレッジ対象
- ✅ 認証フロー（ログイン/ログアウト）
- ✅ ダッシュボード表示
- ✅ 案件管理（一覧・詳細・フィルタ）
- ✅ 受注管理（AIツール/営業代行/統合）
- ✅ 分析レポート（売上/レポート）
- ✅ ナビゲーション（サイドバー/遷移）
- ✅ エラー処理（404ページ）
- ✅ コンソールエラー検出

## 未カバレッジ領域（今後の拡張）
- ⬜ 案件の新規作成フロー
- ⬜ 案件の編集・更新フロー
- ⬜ 案件の削除フロー
- ⬜ フォームバリデーション
- ⬜ ソート機能
- ⬜ ページネーション
- ⬜ 検索機能
- ⬜ エクスポート機能
- ⬜ 設定ページの詳細機能
- ⬜ 外部連携（Google Calendar等）

## トラブルシューティング

### テストがタイムアウトする
```bash
# タイムアウト時間を延長
npx playwright test --timeout=60000
```

### 開発サーバーが起動していない
```bash
# playwright.config.tsのwebServer設定で自動起動されます
# または手動で起動:
cd soloptilink-sfa && npm run dev
```

### 認証エラーが発生する
- デモモードが有効か確認（`IS_DEMO_MODE=true`）
- クッキーが正しくセットされているか確認
- middleware.tsの認証ロジックを確認

## CI/CD統合

### GitHub Actions例
```yaml
- name: Install Playwright
  run: npx playwright install --with-deps chromium

- name: Run E2E tests
  run: npx playwright test

- name: Upload test report
  if: always()
  uses: actions/upload-artifact@v3
  with:
    name: playwright-report
    path: playwright-report/
```

## メンテナンス

### テスト追加時のチェックリスト
- [ ] コンソールエラー検出を実装
- [ ] デモモード認証をセットアップ
- [ ] 適切な待機処理を実装
- [ ] HTTPステータスコードを検証
- [ ] 主要UI要素の表示を検証
- [ ] テストファイル名は `*.spec.ts`
- [ ] このREADMEを更新

## 関連ドキュメント
- [Playwright公式ドキュメント](https://playwright.dev/)
- [プロジェクトCLAUDE.md](/CLAUDE.md)
- [テスト駆動開発ルール](/.claude/rules/test-first.md)
