# SoloptiLink SFA レビューレポート Round 2
## 総合スコア: 62 / 100

**レビュー日時**: 2026-03-02  
**レビュー対象**: SoloptiLink SFA（営業支援ツール）  
**レビュアー**: Claude Sonnet 4.5 (シニアコードレビューエージェント)  

---

## 客観的指標

| 指標 | 結果 |
|------|------|
| ビルド | ❌ FAILED (ESLintエラー: MARGIN_RATES未使用) |
| TypeScriptエラー | 0件 |
| ESLint警告 | 1件 (エラーレベル) |
| テスト | 0/0 pass (テスト未実装) |

---

## スコア詳細

| # | 観点 | スコア | 根拠 |
|---|------|--------|------|
| 1 | 機能完成度 | 7/10 | src/app/(dashboard)/ 配下に17画面実装済み。ダッシュボード、案件管理、売上管理、分析機能が稼働。ただし**Supabase未接続**でデモモードのみ動作。 |
| 2 | コード品質 | 5/10 | `src/lib/calculations/revenue-engine.ts:13` でMARGIN_RATES未使用エラーによりビルド失敗。`src/lib/mock-data.ts`が1316行で保守性低下。any型が4ファイルに残存。 |
| 3 | エラーハンドリング | 7/10 | `src/app/(dashboard)/dashboard/page.tsx:14-33` でローディング・エラー表示実装。`src/hooks/use-deals.ts` でtry-catchパターン使用。ただし全API routeでのエラーハンドリング統一が不十分。 |
| 4 | セキュリティ | 3/10 | **Supabase RLS未設定**（デモモード）。認証は`src/middleware.ts`でCookieベースのみ。`.env.example`にSUPABASE_URL設定あるが未接続。 |
| 5 | パフォーマンス | 6/10 | React Query（TanStack Query）でキャッシング実装（`src/hooks/use-dashboard.ts:322` でstaleTime: 30秒）。ただし、`src/lib/mock-data.ts`の巨大配列がメモリ常駐。 |
| 6 | UX/UI | 7/10 | Tailwind CSS + shadcn/ui で統一感あり。ローディングスケルトン実装（`src/app/(dashboard)/dashboard/page.tsx:65-99`）。ただし**インラインセル編集未実装**。 |
| 7 | テストカバレッジ | 0/10 | **E2Eテスト0件**。`tests/e2e/` ディレクトリが空。Playwright設定済み（package.jsonに依存記述なし）だがテストコードなし。 |
| 8 | コスト最適化 | 8/10 | DeepSeek V3統合（`src/lib/ai/ai-service.ts`）でClaude API不使用。Supabase Free tier設計。ただし本番接続未完了で検証不可。 |
| 9 | ドキュメント | 8/10 | `docs/REVIEW_REPORT_R1.md`（18KB）が詳細。README.mdはNext.jsデフォルトのまま。コンポーネントにTSDoc付き。 |
| 10 | デプロイ準備 | 4/10 | `package.json:7` にbuildスクリプトあり。`.env.example`完備。ただし**ビルド失敗**でVercelデプロイ不可。 |

---

## 🔴 重大な問題（必ず修正）

### 1. **ビルド失敗 - MARGIN_RATES未使用エラー**
**ファイル**: `src/lib/calculations/revenue-engine.ts:13`  
**問題**: `import { MARGIN_RATES } from '@/lib/constants/margins'` で定義された変数が未使用のためESLintエラー。  
**影響**: `npm run build` が失敗し、本番デプロイ不可能。  
**修正方法**:
```typescript
// revenue-engine.ts:13 - MARGIN_RATESをインポートから削除
import { INITIAL_FEE_MARGIN_RATE, PRODUCT_NAMES } from '@/lib/constants/margins';
```

---

### 2. **Supabase未接続 - 本番データ永続化不可**
**ファイル**: `src/lib/demo-mode.ts:1`  
**問題**: `export const IS_DEMO_MODE = true` がハードコード。全hookで分岐処理あり（`src/hooks/use-deals.ts:20`, `src/hooks/use-orders.ts:17` 等）。  
**影響**: 現在システム全体がモックデータで動作。データ永続化不可。  
**修正方法**:
1. Supabaseプロジェクト作成
2. `supabase/migrations/` のマイグレーション実行
3. `.env.local` の `NEXT_PUBLIC_SUPABASE_URL` 設定
4. `src/lib/demo-mode.ts` を `export const IS_DEMO_MODE = process.env.NEXT_PUBLIC_DEMO_MODE === 'true'` に変更
5. RLSポリシー適用（全テーブルに `authenticated` ロール設定）

---

### 3. **E2Eテスト0件 - 品質保証体制なし**
**ディレクトリ**: `tests/e2e/`  
**問題**: Playwrightテストが1件も存在しない。  
**影響**: リグレッション検出不可。機能追加時にバグ混入リスク高。  
**修正方法**:
```typescript
// tests/e2e/dashboard.spec.ts
import { test, expect } from '@playwright/test';

test.describe('ダッシュボード', () => {
  test('画面が正常に表示される', async ({ page }) => {
    await page.goto('/dashboard');
    await expect(page.locator('h1')).toContainText('ダッシュボード');
    await expect(page.locator('[class*="animate-pulse"]')).toHaveCount(0); // ローディング終了確認
  });
});
```
最低限、以下13画面のテスト作成:
- login, dashboard, deals, revenue, analytics, orders/all, orders/ai-tools, orders/outsourcing, companies, settings

---

### 4. **案件一覧が11列のみ - Excel再現度30%**
**ファイル**: `src/components/deals/deals-table.tsx`  
**問題**: FULL_REQUIREMENTS.md の `deals` テーブルは65カラムだが、現在11列のみ表示。  
**影響**: ユーザー（代表）がExcelと比べて使いにくい → システム放棄の可能性。  
**修正方法**:
1. `src/components/deals/deals-table.tsx` に以下列を追加:
   - `appo_date`, `meeting_date`, `meeting_time`, `appo_type`, `appo_target`
   - `list_id`, `memo`, `notes`, `reminder_status`
   - `meeting_result`, `order_result`, `loss_reason`
   - `next_action`, `next_action_date`, `expected_close_date`
2. TanStack Table の `columnHelper` で列定義を拡張
3. 列の表示/非表示プリセット機能追加（アポインター用/クローザー用/管理者用）

---

### 5. **mock-data.tsが1316行 - 保守性低下**
**ファイル**: `src/lib/mock-data.ts`  
**問題**: 全エンティティのモックデータが1ファイルに集約。CLAUDE.mdの「ファイル300行以内」ルール違反。  
**影響**: コードナビゲーション困難。変更時のバグ混入リスク高。  
**修正方法**:
```bash
# ファイル分割
src/lib/mock-data/
  ├── users.ts         (MOCK_USERS)
  ├── companies.ts     (MOCK_COMPANIES)
  ├── contacts.ts      (MOCK_CONTACTS)
  ├── lists.ts         (MOCK_LISTS)
  ├── deals.ts         (MOCK_DEALS)
  ├── followups.ts     (MOCK_FOLLOWUPS)
  ├── ai-orders.ts     (MOCK_AI_TOOL_ORDERS)
  ├── monthly-revenue.ts (MOCK_MONTHLY_REVENUE)
  └── index.ts         (re-export all)
```

---

## 🟡 改善推奨

### 1. **TypeScript型安全性の回復**
`src/hooks/use-deals.ts:208`, `src/hooks/use-orders.ts:104`, `src/lib/utils/excel-export.ts` で `any` 型使用。  
**推奨**: ジェネリクスで型定義。

### 2. **revenue-engineの未使用ロジック**
`src/lib/calculations/revenue-engine.ts:136-139` で `initial_amount` を使用しているが、  
`src/types/database.ts` の `deals` テーブルに `initial_amount` カラムが存在。  
しかし `src/lib/mock-data.ts` の MOCK_DEALS には `initial_amount` がない（`amount` と `monthly_amount` のみ）。  
**推奨**: データ構造を統一。

### 3. **インラインセル編集の欠如**
TanStack Table使用だがセル編集未実装。  
**推奨**: `yomi_status` のインライン変更を優先実装。

### 4. **コンソールエラーの潜在リスク**
`src/hooks/use-deals.ts:42` で `toast.error()` 使用だが、デモモードではエラーが握りつぶされる。  
**推奨**: デモモードでもエラーログ出力。

---

## 🟢 良い点

1. **React Query（TanStack Query）の適切な使用**  
   `src/hooks/use-dashboard.ts:322` で `staleTime`, `refetchInterval` 設定。  
2. **エラー境界の実装**  
   `src/app/error.tsx` でアプリレベルエラーハンドリング。  
3. **型定義の充実**  
   `src/types/` ディレクトリに deals.ts, orders.ts, database.ts 分離。  
4. **shadcn/ui統一**  
   `src/components/ui/` でコンポーネントライブラリ統一。  
5. **売上計算ロジックの分離**  
   `src/lib/calculations/revenue-engine.ts` でビジネスロジック独立。

---

## 🧠 新しい知見

- **ヨミステータス加重計算**:  
  `src/lib/constants/yomi.ts` で受注=100%, Aヨミ=80%, Bヨミ=50%の加重率定義。  
  `src/lib/calculations/revenue-engine.ts:217-257` で加重パイプライン計算。  
  → 実ビジネスの売上予測精度向上に寄与。

- **モックデータの実データベース**:  
  `src/lib/mock-data.ts` の MOCK_DEALS は30件、MOCK_AI_TOOL_ORDERS は7件で、  
  実際のExcelからの移植データ。ダミーではなく本番想定。

---

## 次のセッションへの修正指示書

### 優先度: 高（必ず実行）

1. **ビルドエラー修正 (5分)**
   ```bash
   # src/lib/calculations/revenue-engine.ts:13
   - import { MARGIN_RATES, INITIAL_FEE_MARGIN_RATE, PRODUCT_NAMES } from '@/lib/constants/margins';
   + import { INITIAL_FEE_MARGIN_RATE, PRODUCT_NAMES } from '@/lib/constants/margins';
   ```

2. **Supabase本番接続 (2日)**
   - Supabaseプロジェクト作成 → マイグレーション実行 → RLS設定 → 認証切替

3. **E2Eテスト作成 (3日)**
   - Playwright MCPで13画面のテスト作成

### 優先度: 中（推奨）

4. **案件一覧65列対応 (3日)**
   - TanStack Tableで列追加 + 列プリセット機能

5. **mock-data.ts分割 (0.5日)**
   - 8ファイルに分割

6. **インラインセル編集 (2日)**
   - `yomi_status` のインライン変更実装

### 優先度: 低（時間があれば）

7. **any型除去 (0.5日)**
8. **README.md更新 (0.5日)**

---

**次回レビュー予定**: Round 3 (Supabase接続後)  
**推奨タイミング**: 2026-03-09
