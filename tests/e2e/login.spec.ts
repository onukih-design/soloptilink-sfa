import { test, expect } from '@playwright/test';

test.describe('ログインページ', () => {
  const errors: string[] = [];

  test.beforeEach(async ({ page }) => {
    errors.length = 0;
    page.on('console', msg => {
      if (msg.type() === 'error') errors.push(msg.text());
    });
    page.on('pageerror', err => errors.push(err.message));
  });

  test('ログインページが正常に表示される', async ({ page }) => {
    const res = await page.goto('/login');
    expect(res?.status()).toBeLessThan(400);
    await expect(page.locator('body')).toBeVisible();
  });

  test('デモモードバナーが表示される', async ({ page }) => {
    await page.goto('/login');

    // デモモードのバナー（青い背景）が表示されることを確認
    const demoBanner = page.locator('div.bg-blue-50');
    await expect(demoBanner).toBeVisible();
    await expect(demoBanner).toContainText('デモモード');
    await expect(demoBanner).toContainText('onuki.h@soloptilink.com');
  });

  test('ログインフォームが表示される', async ({ page }) => {
    await page.goto('/login');

    // タイトル
    await expect(page.locator('h1, h2').filter({ hasText: 'SoloptiLink SFA' })).toBeVisible();

    // メールアドレス入力フォーム
    const emailInput = page.locator('input[type="email"]');
    await expect(emailInput).toBeVisible();

    // パスワード入力フォーム
    const passwordInput = page.locator('input[type="password"]');
    await expect(passwordInput).toBeVisible();

    // ログインボタン
    const loginButton = page.locator('button[type="submit"]');
    await expect(loginButton).toBeVisible();
    await expect(loginButton).toContainText('ログイン');
  });

  test('デモ認証情報でログインすると、ダッシュボードへリダイレクトされる', async ({ page }) => {
    await page.goto('/login');

    // フォームに入力
    await page.locator('input[type="email"]').fill('onuki.h@soloptilink.com');
    await page.locator('input[type="password"]').fill('Hiro9101');

    // ログインボタンをクリック
    await page.locator('button[type="submit"]').click();

    // ダッシュボードへリダイレクトされることを確認
    await page.waitForURL('/dashboard', { timeout: 5000 });
    expect(page.url()).toContain('/dashboard');
  });

  test('誤った認証情報ではエラーメッセージが表示される', async ({ page }) => {
    await page.goto('/login');

    // 誤った認証情報を入力
    await page.locator('input[type="email"]').fill('wrong@example.com');
    await page.locator('input[type="password"]').fill('wrongpassword');

    // ログインボタンをクリック
    await page.locator('button[type="submit"]').click();

    // エラーメッセージが表示されることを確認
    await expect(page.locator('div.text-destructive, div.bg-destructive\\/10')).toBeVisible();
  });

  test('コンソールエラーが発生しない', async ({ page }) => {
    await page.goto('/login');

    // フォームに入力
    await page.locator('input[type="email"]').fill('onuki.h@soloptilink.com');
    await page.locator('input[type="password"]').fill('Hiro9101');

    // 少し待機してエラーが発生しないことを確認
    await page.waitForTimeout(1000);

    expect(errors).toEqual([]);
  });
});
