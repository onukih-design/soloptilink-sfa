import { test, expect } from '@playwright/test';

test.describe('ヘルスチェック', () => {
  test('トップページが正常に表示される', async ({ page }) => {
    // コンソールエラーを収集
    const errors: string[] = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });

    // ページにアクセス
    const response = await page.goto('/');
    
    // HTTPステータスが正常
    expect(response?.status()).toBeLessThan(400);
    
    // ページが表示される
    await expect(page.locator('body')).toBeVisible();
    
    // コンソールエラーがない
    expect(errors).toEqual([]);
  });
});
