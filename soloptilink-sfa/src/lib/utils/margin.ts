/**
 * マージン計算関数群
 * 商材別マージン率に基づく計算ロジック
 */

import {
  MARGIN_RATES,
  INITIAL_FEE_MARGIN_RATE,
  type ProductKey,
} from '@/lib/constants/margins';

/**
 * 指定商材の月額マージンを計算
 * @param productKey - 商材キー
 * @param monthlyFee - 月額費用
 * @returns マージン額
 */
export function calculateMargin(
  productKey: ProductKey,
  monthlyFee: number
): number {
  const rate = MARGIN_RATES[productKey];
  return Math.floor(monthlyFee * rate);
}

/**
 * 全商材の月次マージン合計を計算
 * @param monthlyFees - 商材キーと月額費用のマップ
 * @returns 月次マージン合計額
 */
export function calculateTotalMonthlyMargin(
  monthlyFees: Partial<Record<ProductKey, number>>
): number {
  let total = 0;

  for (const [key, fee] of Object.entries(monthlyFees)) {
    if (fee === undefined || fee === null) continue;

    const productKey = key as ProductKey;

    if (productKey in MARGIN_RATES) {
      total += calculateMargin(productKey, fee);
    }
  }

  return total;
}

/**
 * ショット（初期費用）マージンを計算
 * 初期費用のマージン率は全商材共通で 50%
 * @param initialFees - 商材キーと初期費用のマップ、または単一の初期費用額
 * @returns ショットマージン合計額
 */
export function calculateShotMargin(
  initialFees: Partial<Record<ProductKey, number>> | number
): number {
  if (typeof initialFees === 'number') {
    return Math.floor(initialFees * INITIAL_FEE_MARGIN_RATE);
  }

  let total = 0;

  for (const fee of Object.values(initialFees)) {
    if (fee === undefined || fee === null) continue;
    total += Math.floor(fee * INITIAL_FEE_MARGIN_RATE);
  }

  return total;
}

/**
 * 商材ごとのマージン内訳を計算
 * @param monthlyFees - 商材キーと月額費用のマップ
 * @returns 商材キーとマージン額のマップ
 */
export function calculateMarginBreakdown(
  monthlyFees: Partial<Record<ProductKey, number>>
): Partial<Record<ProductKey, number>> {
  const breakdown: Partial<Record<ProductKey, number>> = {};

  for (const [key, fee] of Object.entries(monthlyFees)) {
    if (fee === undefined || fee === null) continue;

    const productKey = key as ProductKey;

    if (productKey in MARGIN_RATES) {
      breakdown[productKey] = calculateMargin(productKey, fee);
    }
  }

  return breakdown;
}

/**
 * マージン率を取得（安全なアクセス）
 * @param productKey - 商材キー
 * @returns マージン率。不明な商材の場合は 0
 */
export function getMarginRateSafe(productKey: string): number {
  if (productKey in MARGIN_RATES) {
    return MARGIN_RATES[productKey as ProductKey];
  }
  return 0;
}
