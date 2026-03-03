/**
 * KPI関連の型定義
 * ダッシュボードおよび分析画面で使用される全てのメトリクス型を定義
 */

/**
 * ヨミステータス別集計
 */
export type YomiSummary = {
  byStatus: Array<{
    status: string
    count: number
    totalAmount: number
    monthlyAmount: number
    weightedAmount: number
    rate: number
    color: string
  }>
  hotPipeline: { count: number; amount: number; weighted: number }
  coldPipeline: { count: number; amount: number; weighted: number }
  total: { count: number; amount: number; weighted: number }
}

/**
 * AIツール売上メトリクス
 */
export type AIToolMetrics = {
  mrr: number
  arr: number
  totalMonthlyMargin: number
  activeContracts: number
  churnRate: number
  ltv: number
  newContractsThisMonth: number
  byProduct: Array<{
    product: string
    productName: string
    activeContracts: number
    mrr: number
    margin: number
    avgContractMonths: number
  }>
}

/**
 * 営業代行売上メトリクス
 */
export type OutsourcingMetrics = {
  totalMonthlyCommission: number
  totalMonthlyFee: number
  activeContracts: number
  avgContractValue: number
  byServiceType: Array<{
    serviceType: string
    serviceTypeName: string
    activeContracts: number
    monthlyFee: number
    commission: number
  }>
}

/**
 * 統合売上メトリクス（AIツール + 営業代行）
 */
export type CombinedRevenueMetrics = {
  totalMonthlyRevenue: number
  totalMonthlyMargin: number
  aiToolShare: number // percentage
  outsourcingShare: number // percentage
  aiTools: AIToolMetrics
  outsourcing: OutsourcingMetrics
  monthlyTrend: Array<{
    month: string
    displayMonth: string
    aiToolRevenue: number
    outsourcingRevenue: number
    totalRevenue: number
    totalMargin: number
    target: number
  }>
  growthRateMoM: number // 前月比成長率
  growthRateYoY: number // 前年比成長率
}

/**
 * ファネル分析メトリクス
 */
export type FunnelMetrics = {
  stages: Array<{
    name: string
    count: number
    conversionRate: number
    dropOffRate: number
    avgValue: number
  }>
  overallConversionRate: number
  avgDealCycleTime: number // days
}

/**
 * 目標 vs 実績
 */
export type TargetVsActual = {
  monthly: Array<{
    month: string
    displayMonth: string
    targetRevenue: number
    actualRevenue: number
    targetMargin: number
    actualMargin: number
    achievementRate: number
    targetNewDeals: number
    actualNewDeals: number
  }>
  cumulative: {
    targetRevenue: number
    actualRevenue: number
    targetMargin: number
    actualMargin: number
    achievementRate: number
  }
  forecast: {
    yearEndRevenue: number
    yearEndMargin: number
    yearEndNewDeals: number
    onTrack: boolean
  }
}

/**
 * 期限超過アクション
 */
export type OverdueAction = {
  id: string
  dealId: string
  dealName: string
  companyId: string
  companyName: string
  nextAction: string
  nextActionDate: string
  daysOverdue: number
  urgency: 'low' | 'medium' | 'high' | 'critical'
}

/**
 * 営業担当者別パフォーマンス
 */
export type SalesPerformance = {
  userId: string
  displayName: string
  role: string
  metrics: {
    totalDeals: number
    wonDeals: number
    closingRate: number
    totalRevenue: number
    avgDealSize: number
    appointmentCount: number
    appointmentToWonRate: number
  }
  ranking: {
    revenueRank: number
    closingRateRank: number
    dealCountRank: number
  }
}

/**
 * 商品別売上分析
 */
export type ProductAnalysis = {
  product: string
  productName: string
  totalRevenue: number
  totalMargin: number
  activeContracts: number
  avgContractValue: number
  avgContractMonths: number
  churnRate: number
  growthRate: number
}

/**
 * リスト別効果分析
 */
export type ListAnalysis = {
  listId: string
  listName: string
  totalCompanies: number
  appointmentCount: number
  dealCount: number
  wonCount: number
  totalRevenue: number
  conversionRate: number
  avgRevenuePerCompany: number
  roi: number
}

/**
 * 期間フィルタ
 */
export type DateRange = {
  start: string
  end: string
}

/**
 * 時系列データポイント
 */
export type TimeSeriesDataPoint = {
  date: string
  value: number
  label?: string
}

/**
 * トレンド方向
 */
export type TrendDirection = 'up' | 'down' | 'flat'

/**
 * メトリクスカード
 */
export type MetricCard = {
  title: string
  value: number
  unit?: string
  change?: number
  changeLabel?: string
  trend?: TrendDirection
  status?: 'good' | 'warning' | 'danger' | 'neutral'
}
