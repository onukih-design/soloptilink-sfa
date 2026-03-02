import { test, expect } from '@playwright/test';

test.describe('ナビゲーション', () => {
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

  test('サイドバーが表示される', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    // サイドバーまたはナビゲーション要素が表示される
    const sidebar = page.locator('nav, aside, [class*="sidebar"]').first();
    await expect(sidebar).toBeVisible();
  });

  test('サイドバーの主要メニューリンクが存在する', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    // 主要なメニュー項目が存在することを確認
    const expectedMenuItems = [
      /ダッシュボード|Dashboard/i,
      /案件|Deals/i,
      /受注|Orders/i,
      /分析|Analytics/i,
      /設定|Settings/i,
    ];

    for (const pattern of expectedMenuItems) {
      const menuItem = page.locator('nav a, aside a').filter({ hasText: pattern }).first();
      const exists = await menuItem.count() > 0;
      expect(exists).toBeTruthy();
    }
  });

  test('ダッシュボードへ遷移できる', async ({ page }) => {
    await page.goto('/deals');
    await page.waitForTimeout(1000);

    const dashboardLink = page.locator('a').filter({ hasText: /ダッシュボード|Dashboard/i }).first();
    await dashboardLink.click();

    await page.waitForURL('/dashboard', { timeout: 3000 });
    expect(page.url()).toContain('/dashboard');
  });

  test('案件一覧へ遷移できる', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    const dealsLink = page.locator('a').filter({ hasText: /案件|Deals/i }).first();
    await dealsLink.click();

    await page.waitForTimeout(1000);
    expect(page.url()).toContain('/deals');
  });

  test('受注管理へ遷移できる', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    const ordersLink = page.locator('a').filter({ hasText: /受注|Orders/i }).first();

    if (await ordersLink.count() > 0) {
      await ordersLink.click();
      await page.waitForTimeout(1000);
      expect(page.url()).toContain('/orders');
    }
  });

  test('分析ページへ遷移できる', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    const analyticsLink = page.locator('a').filter({ hasText: /分析|Analytics|売上|レポート/i }).first();

    if (await analyticsLink.count() > 0) {
      await analyticsLink.click();
      await page.waitForTimeout(1000);
      expect(page.url()).toContain('/analytics');
    }
  });

  test('設定ページへ遷移できる', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    const settingsLink = page.locator('a').filter({ hasText: /設定|Settings/i }).first();

    if (await settingsLink.count() > 0) {
      await settingsLink.click();
      await page.waitForTimeout(1000);
      expect(page.url()).toContain('/settings');
    }
  });

  test('リード管理ページへ遷移できる', async ({ page }) => {
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    const leadsLink = page.locator('a').filter({ hasText: /リード|Leads|見込み客/i }).first();

    if (await leadsLink.count() > 0) {
      await leadsLink.click();
      await page.waitForTimeout(1000);
      expect(page.url()).toContain('/leads');
    }
  });

  test('404ページが正しく表示される', async ({ page }) => {
    const res = await page.goto('/this-page-does-not-exist-404-test');

    // 404ステータスまたは404ページのコンテンツが表示される
    // Next.jsのデフォルト404ページまたはカスタム404ページ
    const has404Text = await page.locator('text=/404|Not Found|ページが見つかりません/i').count() > 0;

    expect(has404Text).toBeTruthy();
  });

  test('全主要ページでコンソールエラーが発生しない', async ({ page }) => {
    const pages = [
      '/dashboard',
      '/deals',
      '/orders/all',
      '/analytics/revenue',
      '/settings',
    ];

    for (const pagePath of pages) {
      // エラー配列をリセット
      errors.length = 0;

      await page.goto(pagePath);
      await page.waitForLoadState('networkidle');
      await page.waitForTimeout(1500);

      // 各ページでコンソールエラーがないことを確認
      expect(errors).toEqual([]);
    }
  });

  test('ブラウザバック・フォワードが正常に動作する', async ({ page }) => {
    // ダッシュボードから開始
    await page.goto('/dashboard');
    await page.waitForTimeout(1000);

    // 案件一覧へ遷移
    await page.goto('/deals');
    await page.waitForTimeout(1000);

    // ブラウザバック
    await page.goBack();
    await page.waitForTimeout(1000);
    expect(page.url()).toContain('/dashboard');

    // ブラウザフォワード
    await page.goForward();
    await page.waitForTimeout(1000);
    expect(page.url()).toContain('/deals');
  });
});
