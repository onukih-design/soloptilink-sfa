---
globs: "src/**/*.{ts,tsx,js,jsx}"
---

# テスト駆動開発ルール

このルールは src/ 配下のコードファイルに適用される。

## ルール
1. 新しいページ・コンポーネントを作成したら、対応する tests/e2e/ のテストファイルも同時に作成する
2. テストは最低限以下をカバーする:
   - ページが正常に表示される（HTTPステータス < 400）
   - コンソールエラーが出ていない
   - 主要なUIエレメントが表示されている
3. APIエンドポイントを追加したら、対応するレスポンスの検証テストを追加する

## テストファイルの命名規則
- `src/pages/Login.tsx` → `tests/e2e/login.spec.ts`
- `src/pages/Dashboard.tsx` → `tests/e2e/dashboard.spec.ts`
- `src/api/tasks.ts` → `tests/e2e/api-tasks.spec.ts`

## テストテンプレート
```typescript
import { test, expect } from '@playwright/test';

test.describe('[画面名]', () => {
  const errors: string[] = [];

  test.beforeEach(async ({ page }) => {
    errors.length = 0;
    page.on('console', msg => {
      if (msg.type() === 'error') errors.push(msg.text());
    });
  });

  test('画面が正常に表示される', async ({ page }) => {
    const res = await page.goto('/[パス]');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();
    expect(errors).toEqual([]);
  });
});
```
