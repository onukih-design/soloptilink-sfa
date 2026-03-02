import { test, expect } from '@playwright/test';

test.describe('経営ダッシュボード', () => {
  const errors: string[] = [];

  test.beforeEach(async ({ page }) => {
    errors.length = 0;
    page.on('console', msg => {
      if (msg.type() === 'error') errors.push(msg.text());
    });
  });

  test('ページが正常に表示される', async ({ page }) => {
    const res = await page.goto('/executive');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();

    // タイトルの確認
    await expect(page.locator('h1:has-text("経営ダッシュボード")')).toBeVisible();

    // コンソールエラーがないことを確認
    expect(errors).toEqual([]);
  });

  test('KPIカードが6枚表示される', async ({ page }) => {
    await page.goto('/executive');

    // KPIカードのタイトルを確認
    await expect(page.locator('text=年間目標達成率')).toBeVisible();
    await expect(page.locator('text=年間累計売上')).toBeVisible();
    await expect(page.locator('text=当月MRR')).toBeVisible();
    await expect(page.locator('text=当月粗利')).toBeVisible();
    await expect(page.locator('text=契約中案件数')).toBeVisible();
    await expect(page.locator('text=パイプライン総額')).toBeVisible();
  });

  test('月次売上推移グラフが表示される', async ({ page }) => {
    await page.goto('/executive');

    // グラフタイトルの確認
    await expect(page.locator('text=月次売上推移（12ヶ月）')).toBeVisible();

    // Recharts SVGの存在確認
    const chart = page.locator('.recharts-responsive-container').first();
    await expect(chart).toBeVisible();
  });

  test('案件ステータス別円グラフが表示される', async ({ page }) => {
    await page.goto('/executive');

    // グラフタイトルの確認
    await expect(page.locator('text=案件ステータス別件数')).toBeVisible();

    // Recharts SVGの存在確認
    const pieChart = page.locator('.recharts-responsive-container').nth(1);
    await expect(pieChart).toBeVisible();
  });

  test('全案件売上一覧テーブルが表示される', async ({ page }) => {
    await page.goto('/executive');

    // テーブルタイトルの確認
    await expect(page.locator('text=全案件売上一覧')).toBeVisible();

    // タブの存在確認
    await expect(page.locator('role=tab[name*="全て"]')).toBeVisible();
    await expect(page.locator('role=tab[name*="受注のみ"]')).toBeVisible();

    // テーブルヘッダーの確認
    await expect(page.locator('th:has-text("案件名")')).toBeVisible();
    await expect(page.locator('th:has-text("企業名")')).toBeVisible();
    await expect(page.locator('th:has-text("ヨミステータス")')).toBeVisible();
    await expect(page.locator('th:has-text("商材")')).toBeVisible();
    await expect(page.locator('th:has-text("月額売上")')).toBeVisible();
    await expect(page.locator('th:has-text("初期費用")')).toBeVisible();
    await expect(page.locator('th:has-text("月額粗利")')).toBeVisible();
    await expect(page.locator('th:has-text("契約期間")')).toBeVisible();
  });

  test('受注のみタブに切り替えられる', async ({ page }) => {
    await page.goto('/executive');

    // 受注のみタブをクリック
    await page.click('role=tab[name*="受注のみ"]');

    // 受注案件のみが表示されていることを確認（ヨミステータス列がないことを確認）
    const headers = page.locator('th');
    await expect(headers.filter({ hasText: 'ヨミステータス' })).toHaveCount(0);

    // コンソールエラーがないことを確認
    expect(errors).toEqual([]);
  });

  test('金額が正しくフォーマットされて表示される', async ({ page }) => {
    await page.goto('/executive');

    // 金額フォーマット（¥記号とカンマ）の確認
    const currencyPattern = /¥[\d,]+/;
    const kpiCards = page.locator('.text-xl.font-bold');

    // 少なくとも1つのKPIカードに金額が表示されていることを確認
    const firstKpi = await kpiCards.first().textContent();
    expect(firstKpi).toMatch(currencyPattern);
  });

  test('プログレスバーが目標達成率を表示する', async ({ page }) => {
    await page.goto('/executive');

    // プログレスバーの存在確認
    const progressBar = page.locator('.bg-blue-600.h-2.rounded-full');
    await expect(progressBar).toBeVisible();

    // width スタイルが設定されていることを確認
    const width = await progressBar.getAttribute('style');
    expect(width).toContain('width');
  });

  test('サイドバーから経営ダッシュボードに遷移できる', async ({ page }) => {
    // ダッシュボードページから開始
    await page.goto('/dashboard');

    // サイドバーの経営ダッシュボードリンクをクリック
    await page.click('a[href="/executive"]');

    // URLが変わったことを確認
    await expect(page).toHaveURL('/executive');

    // ページタイトルの確認
    await expect(page.locator('h1:has-text("経営ダッシュボード")')).toBeVisible();

    // コンソールエラーがないことを確認
    expect(errors).toEqual([]);
  });
});
