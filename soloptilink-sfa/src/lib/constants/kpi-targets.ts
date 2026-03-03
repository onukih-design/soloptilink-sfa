/**
 * KPI目標値定義
 * SoloptiLink SFAの年間・月次・四半期目標を管理
 */

/**
 * 年間目標（2026年度）
 */
export const KPI_TARGETS = {
  // 年間目標
  annualRevenue: 30000000, // 3000万円
  annualNewContracts: 60, // 新規契約60件
  annualMRR: 2500000, // 月次250万MRR目標

  // 月次目標（標準）
  monthly: {
    revenue: 2500000, // 250万/月
    newDeals: 5, // 新規案件5件/月
    appointments: 20, // アポ20件/月
    closingRate: 0.25, // 成約率25%
    aiToolMRR: 1500000, // AIツールMRR 150万/月
    outsourcingRevenue: 1000000, // 営業代行売上100万/月
  },

  // 四半期目標
  quarterly: {
    q1: { revenue: 6000000, newContracts: 12 }, // Q1: 600万, 12件
    q2: { revenue: 7500000, newContracts: 15 }, // Q2: 750万, 15件
    q3: { revenue: 8000000, newContracts: 17 }, // Q3: 800万, 17件
    q4: { revenue: 8500000, newContracts: 16 }, // Q4: 850万, 16件
  },
}

/**
 * 月次目標詳細（2026年1月〜12月）
 * 段階的な成長を想定した目標設定
 */
export const MONTHLY_TARGETS_2026: Record<
  string,
  { revenue: number; margin: number; newDeals: number }
> = {
  '2026-01': { revenue: 2000000, margin: 800000, newDeals: 4 },
  '2026-02': { revenue: 2200000, margin: 880000, newDeals: 4 },
  '2026-03': { revenue: 2500000, margin: 1000000, newDeals: 5 },
  '2026-04': { revenue: 2600000, margin: 1040000, newDeals: 5 },
  '2026-05': { revenue: 2700000, margin: 1080000, newDeals: 5 },
  '2026-06': { revenue: 2800000, margin: 1120000, newDeals: 6 },
  '2026-07': { revenue: 2900000, margin: 1160000, newDeals: 6 },
  '2026-08': { revenue: 3000000, margin: 1200000, newDeals: 6 },
  '2026-09': { revenue: 3100000, margin: 1240000, newDeals: 6 },
  '2026-10': { revenue: 3200000, margin: 1280000, newDeals: 5 },
  '2026-11': { revenue: 3300000, margin: 1320000, newDeals: 5 },
  '2026-12': { revenue: 3400000, margin: 1360000, newDeals: 6 },
}

/**
 * 指定月の目標値を取得
 * 存在しない月の場合は標準月次目標を返す
 */
export function getMonthlyTarget(yearMonth: string): {
  revenue: number
  margin: number
  newDeals: number
} {
  return (
    MONTHLY_TARGETS_2026[yearMonth] || {
      revenue: KPI_TARGETS.monthly.revenue,
      margin: KPI_TARGETS.monthly.revenue * 0.4, // 粗利率40%想定
      newDeals: KPI_TARGETS.monthly.newDeals,
    }
  )
}

/**
 * 指定期間の累計目標を計算
 */
export function getCumulativeTarget(startYearMonth: string, endYearMonth: string): {
  revenue: number
  margin: number
  newDeals: number
} {
  const months = Object.keys(MONTHLY_TARGETS_2026)
    .filter((m) => m >= startYearMonth && m <= endYearMonth)
    .sort()

  return months.reduce(
    (acc, month) => {
      const target = MONTHLY_TARGETS_2026[month]
      return {
        revenue: acc.revenue + target.revenue,
        margin: acc.margin + target.margin,
        newDeals: acc.newDeals + target.newDeals,
      }
    },
    { revenue: 0, margin: 0, newDeals: 0 }
  )
}

/**
 * 四半期から該当月を取得
 */
export function getQuarterMonths(quarter: 'q1' | 'q2' | 'q3' | 'q4', year = 2026): string[] {
  const quarterMap = {
    q1: ['01', '02', '03'],
    q2: ['04', '05', '06'],
    q3: ['07', '08', '09'],
    q4: ['10', '11', '12'],
  }
  return quarterMap[quarter].map((m) => `${year}-${m}`)
}
