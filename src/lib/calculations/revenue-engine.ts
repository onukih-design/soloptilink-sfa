/**
 * 売上計算エンジン
 *
 * ビジネスロジック（FULL_REQUIREMENTS.md Section 8）:
 * - ショット売上: 初期費用 × マージン率(50%) → 受注月に計上
 * - ストック売上: 月額 × マージン率 → 契約開始月から毎月計上
 * - ヨミ加重: 受注(100%), Aヨミ(80%), Bヨミ(50%), Cヨミ(20%), ネタ(10%), 没ネタ(5%), 失注/消滅(0%)
 */

import type { Deal } from '@/types/deals';
import type { AiToolOrder } from '@/types/orders';
import { YOMI_RATES } from '@/lib/constants/yomi';
import { INITIAL_FEE_MARGIN_RATE, PRODUCT_NAMES } from '@/lib/constants/margins';

/**
 * 月次売上結果
 */
export type MonthlyRevenueResult = {
  yearMonth: string;
  shotRevenue: number;     // ショット売上
  shotMargin: number;      // ショット粗利
  stockRevenue: number;    // ストック売上（月額合計）
  stockMargin: number;     // ストック粗利（月額粗利合計）
  totalRevenue: number;    // 合計売上
  totalMargin: number;     // 合計粗利
  marginRate: number;      // 粗利率
  newContracts: number;    // 新規契約数
  activeContracts: number; // 契約中件数
};

/**
 * ヨミ加重パイプライン結果
 */
export type WeightedPipelineResult = {
  totalPipeline: number;       // パイプライン総額
  weightedPipeline: number;    // 加重パイプライン
  byYomi: Record<string, {
    count: number;
    totalAmount: number;
    weightedAmount: number;
    rate: number;
  }>;
};

/**
 * 商材別収益結果
 */
export type ProductRevenueResult = {
  product: string;
  productName: string;
  activeCount: number;
  monthlyFee: number;
  monthlyMargin: number;
  marginRate: number;
};

/**
 * ショット/ストック分離結果
 */
export type ShotStockResult = {
  yearMonth: string;
  shot: { revenue: number; margin: number; count: number };
  stock: { revenue: number; margin: number; count: number };
  total: { revenue: number; margin: number };
};

/**
 * 'YYYY-MM' 形式の文字列をDateオブジェクトに変換
 */
function parseYearMonth(yearMonth: string): Date {
  const [year, month] = yearMonth.split('-').map(Number);
  return new Date(year, month - 1, 1);
}

/**
 * DateオブジェクトをYYYY-MM形式に変換
 */
function formatYearMonth(date: Date): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  return `${year}-${month}`;
}

/**
 * 指定月に該当するか判定
 */
function isInMonth(dateStr: string | null, targetMonth: string): boolean {
  if (!dateStr) return false;
  const date = new Date(dateStr);
  const yearMonth = formatYearMonth(date);
  return yearMonth === targetMonth;
}

/**
 * 指定月以前かどうか判定
 */
function isBeforeOrInMonth(dateStr: string | null, targetMonth: string): boolean {
  if (!dateStr) return false;
  const date = new Date(dateStr);
  const target = parseYearMonth(targetMonth);
  return date <= new Date(target.getFullYear(), target.getMonth() + 1, 0); // 月末まで含む
}

/**
 * 指定月以降かどうか判定
 */
function isAfterOrInMonth(dateStr: string | null, targetMonth: string): boolean {
  if (!dateStr) return false;
  const date = new Date(dateStr);
  const target = parseYearMonth(targetMonth);
  return date >= target;
}

/**
 * 1. 月次売上計算
 *
 * @param deals 案件リスト
 * @param orders 受注リスト
 * @param targetMonth 'YYYY-MM' 形式
 * @returns 月次売上結果
 */
export function calculateMonthlyRevenue(
  deals: Deal[],
  orders: AiToolOrder[],
  targetMonth: string
): MonthlyRevenueResult {
  let shotRevenue = 0;
  let shotMargin = 0;
  let stockRevenue = 0;
  let stockMargin = 0;
  let newContracts = 0;
  let activeContracts = 0;

  // ショット売上: 受注月（closed_date）に初期費用を計上
  deals.forEach((deal) => {
    if (deal.yomi_status === '受注' && isInMonth(deal.closed_date, targetMonth)) {
      const initialAmount = deal.initial_amount ?? 0;
      shotRevenue += initialAmount;
      shotMargin += initialAmount * INITIAL_FEE_MARGIN_RATE;
      newContracts += 1;
    }
  });

  // ストック売上: 契約中のAIツール受注から月額を計上
  orders.forEach((order) => {
    const {
      status,
      contract_start_date,
      contract_end_date,
      monthly_fee,
      margin_rate
    } = order;

    // 契約開始日が指定月以前、解約日が指定月以降（or null）なら稼働中
    const isActive =
      status === '契約中' &&
      isBeforeOrInMonth(contract_start_date, targetMonth) &&
      (!contract_end_date || isAfterOrInMonth(contract_end_date, targetMonth));

    if (isActive) {
      stockRevenue += monthly_fee;
      stockMargin += monthly_fee * margin_rate;
      activeContracts += 1;
    }
  });

  const totalRevenue = shotRevenue + stockRevenue;
  const totalMargin = shotMargin + stockMargin;
  const marginRate = totalRevenue > 0 ? totalMargin / totalRevenue : 0;

  return {
    yearMonth: targetMonth,
    shotRevenue,
    shotMargin,
    stockRevenue,
    stockMargin,
    totalRevenue,
    totalMargin,
    marginRate,
    newContracts,
    activeContracts,
  };
}

/**
 * 2. N月分の売上推移計算
 *
 * @param deals 案件リスト
 * @param orders 受注リスト
 * @param months 過去N月分
 * @returns 月次売上結果の配列（古い順）
 */
export function calculateRevenueTrend(
  deals: Deal[],
  orders: AiToolOrder[],
  months: number
): MonthlyRevenueResult[] {
  const results: MonthlyRevenueResult[] = [];
  const now = new Date();

  for (let i = months - 1; i >= 0; i--) {
    const targetDate = new Date(now.getFullYear(), now.getMonth() - i, 1);
    const yearMonth = formatYearMonth(targetDate);
    const result = calculateMonthlyRevenue(deals, orders, yearMonth);
    results.push(result);
  }

  return results;
}

/**
 * 3. ヨミ加重金額計算
 *
 * @param deals 案件リスト
 * @returns ヨミ加重パイプライン結果
 */
export function calculateWeightedPipeline(
  deals: Deal[]
): WeightedPipelineResult {
  let totalPipeline = 0;
  let weightedPipeline = 0;
  const byYomi: Record<string, {
    count: number;
    totalAmount: number;
    weightedAmount: number;
    rate: number;
  }> = {};

  deals.forEach((deal) => {
    const yomiStatus = deal.yomi_status as keyof typeof YOMI_RATES;
    const amount = deal.amount ?? 0;
    const rate = YOMI_RATES[yomiStatus] ?? 0;
    const weightedAmount = amount * rate;

    totalPipeline += amount;
    weightedPipeline += weightedAmount;

    if (!byYomi[yomiStatus]) {
      byYomi[yomiStatus] = {
        count: 0,
        totalAmount: 0,
        weightedAmount: 0,
        rate,
      };
    }

    byYomi[yomiStatus].count += 1;
    byYomi[yomiStatus].totalAmount += amount;
    byYomi[yomiStatus].weightedAmount += weightedAmount;
  });

  return {
    totalPipeline,
    weightedPipeline,
    byYomi,
  };
}

/**
 * 4. 商材別収益分析
 *
 * @param orders 受注リスト
 * @returns 商材別収益結果の配列
 */
export function calculateProductRevenue(
  orders: AiToolOrder[]
): ProductRevenueResult[] {
  const productMap = new Map<string, {
    activeCount: number;
    monthlyFee: number;
    monthlyMargin: number;
    marginRate: number;
  }>();

  // 契約中の受注のみ集計
  orders
    .filter((order) => order.status === '契約中')
    .forEach((order) => {
      const { product, monthly_fee, margin_rate } = order;
      const monthlyMargin = monthly_fee * margin_rate;

      if (!productMap.has(product)) {
        productMap.set(product, {
          activeCount: 0,
          monthlyFee: 0,
          monthlyMargin: 0,
          marginRate: margin_rate,
        });
      }

      const data = productMap.get(product)!;
      data.activeCount += 1;
      data.monthlyFee += monthly_fee;
      data.monthlyMargin += monthlyMargin;
    });

  // 配列に変換
  const results: ProductRevenueResult[] = [];
  productMap.forEach((data, product) => {
    results.push({
      product,
      productName: PRODUCT_NAMES[product as keyof typeof PRODUCT_NAMES] ?? product,
      activeCount: data.activeCount,
      monthlyFee: data.monthlyFee,
      monthlyMargin: data.monthlyMargin,
      marginRate: data.marginRate,
    });
  });

  // 月額粗利が大きい順にソート
  results.sort((a, b) => b.monthlyMargin - a.monthlyMargin);

  return results;
}

/**
 * 5. ショット/ストック分離計算
 *
 * @param deals 案件リスト
 * @param orders 受注リスト
 * @param targetMonth 'YYYY-MM' 形式
 * @returns ショット/ストック分離結果
 */
export function calculateShotStockRevenue(
  deals: Deal[],
  orders: AiToolOrder[],
  targetMonth: string
): ShotStockResult {
  const monthlyResult = calculateMonthlyRevenue(deals, orders, targetMonth);

  return {
    yearMonth: targetMonth,
    shot: {
      revenue: monthlyResult.shotRevenue,
      margin: monthlyResult.shotMargin,
      count: monthlyResult.newContracts,
    },
    stock: {
      revenue: monthlyResult.stockRevenue,
      margin: monthlyResult.stockMargin,
      count: monthlyResult.activeContracts,
    },
    total: {
      revenue: monthlyResult.totalRevenue,
      margin: monthlyResult.totalMargin,
    },
  };
}
