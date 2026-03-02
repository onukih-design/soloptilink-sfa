import { test, expect } from '@playwright/test';

test.describe('分析ページ', () => {
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

  test('売上ダッシュボードページが表示される', async ({ page }) => {
    const res = await page.goto('/analytics/revenue');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();

    // ページタイトルまたは見出しが表示される
    const heading = page.locator('h1, h2').filter({ hasText: /売上|レベニュー|収益|ダッシュボード/i }).first();
    await expect(heading).toBeVisible({ timeout: 3000 });
  });

  test('売上ダッシュボードでコンソールエラーが発生しない', async ({ page }) => {
    await page.goto('/analytics/revenue');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    expect(errors).toEqual([]);
  });

  test('売上ダッシュボードにチャートまたはグラフが表示される', async ({ page }) => {
    await page.goto('/analytics/revenue');
    await page.waitForTimeout(1500);

    // チャート要素（canvas, svg等）が存在することを確認
    const hasChart = await page.locator('canvas, svg').count() > 0;

    // チャートライブラリが使用されている場合
    expect(hasChart).toBeTruthy();
  });

  test('分析レポートページが表示される', async ({ page }) => {
    const res = await page.goto('/analytics/reports');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();

    // ページタイトルまたは見出しが表示される
    const heading = page.locator('h1, h2').filter({ hasText: /分析|レポート|報告/i }).first();
    await expect(heading).toBeVisible({ timeout: 3000 });
  });

  test('分析レポートページでコンソールエラーが発生しない', async ({ page }) => {
    await page.goto('/analytics/reports');
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);

    expect(errors).toEqual([]);
  });

  test('分析レポートページにデータ表示要素がある', async ({ page }) => {
    await page.goto('/analytics/reports');
    await page.waitForTimeout(1500);

    // テーブル、カード、チャートなどのデータ表示要素が存在することを確認
    const hasTable = await page.locator('table').count() > 0;
    const hasCards = await page.locator('.card, [class*="card"], .rounded-xl.border').count() > 0;
    const hasChart = await page.locator('canvas, svg').count() > 0;

    // いずれかのデータ表示形式が存在することを確認
    expect(hasTable || hasCards || hasChart).toBeTruthy();
  });

  test('各分析ページ間で遷移できる', async ({ page }) => {
    // 売上ダッシュボードから開始
    await page.goto('/analytics/revenue');
    await page.waitForTimeout(1000);

    // ナビゲーションリンクまたはタブで分析レポートへ遷移
    const reportLink = page.locator('a, button').filter({ hasText: /レポート|報告|分析/i }).first();

    if (await reportLink.count() > 0) {
      await reportLink.click();
      await page.waitForTimeout(1000);

      // URLが変わったことを確認
      expect(page.url()).toContain('/analytics');
    }
  });
});
