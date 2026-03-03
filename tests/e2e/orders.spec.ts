import { test, expect } from '@playwright/test';

test.describe('受注管理ページ', () => {
  const errors: string[] = [];

  test.beforeEach(async ({ page, context }) => {
    errors.length = 0;
    page.on('console', msg => {
      if (msg.type() === 'error') errors.push(msg.text());
    });
    page.on('pageerror', err => errors.push(err.message));

    // デモモード認証クッキーをセット
    await context.addCookies([{
      name: 'demo-auth',
      value: 'true',
      domain: 'localhost',
      path: '/',
    }]);
  });

  test('AIツール受注管理ページが表示される', async ({ page }) => {
    const res = await page.goto('/orders/ai-tools');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();

    // ページタイトルまたは見出しが表示される
    const heading = page.locator('h1, h2').filter({ hasText: /AIツール|AI|受注/i }).first();
    await expect(heading).toBeVisible({ timeout: 3000 });
  });

  test('AIツール受注管理ページでコンソールエラーが発生しない', async ({ page }) => {
    await page.goto('/orders/ai-tools');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(1500);

    expect(errors).toEqual([]);
  });

  test('営業代行受注管理ページが表示される', async ({ page }) => {
    const res = await page.goto('/orders/outsourcing');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();

    // ページタイトルまたは見出しが表示される
    const heading = page.locator('h1, h2').filter({ hasText: /営業代行|代行|アウトソーシング|受注/i }).first();
    await expect(heading).toBeVisible({ timeout: 3000 });
  });

  test('営業代行受注管理ページでコンソールエラーが発生しない', async ({ page }) => {
    await page.goto('/orders/outsourcing');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(1500);

    expect(errors).toEqual([]);
  });

  test('統合受注管理ページが表示される', async ({ page }) => {
    const res = await page.goto('/orders/all');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();

    // ページタイトルまたは見出しが表示される
    const heading = page.locator('h1, h2').filter({ hasText: /全受注|統合|受注一覧|受注管理/i }).first();
    await expect(heading).toBeVisible({ timeout: 3000 });
  });

  test('統合受注管理ページでコンソールエラーが発生しない', async ({ page }) => {
    await page.goto('/orders/all');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(1500);

    expect(errors).toEqual([]);
  });

  test('各受注管理ページにテーブルまたはリストが表示される', async ({ page }) => {
    const pages = [
      '/orders/ai-tools',
      '/orders/outsourcing',
      '/orders/all'
    ];

    for (const pagePath of pages) {
      await page.goto(pagePath);
      await page.waitForTimeout(1500);

      // テーブルまたはデータリストが表示されることを確認
      const hasTable = await page.locator('table').count() > 0;
      const hasList = await page.locator('ul, ol').count() > 0;
      const hasCards = await page.locator('.card, [class*="card"]').count() > 0;

      // いずれかのデータ表示形式が存在することを確認
      expect(hasTable || hasList || hasCards).toBeTruthy();
    }
  });
});
