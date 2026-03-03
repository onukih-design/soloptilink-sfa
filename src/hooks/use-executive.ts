'use client'

import { useQuery } from '@tanstack/react-query'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_DEALS, MOCK_AI_TOOL_ORDERS, MOCK_MONTHLY_REVENUE, MOCK_COMPANIES } from '@/lib/mock-data'
import { YOMI_COLORS } from '@/lib/constants/yomi'
import type { YomiStatus } from '@/types/deals'

const EXECUTIVE_KEY = 'executive'

export type ExecutiveData = {
  annualTarget: number
  annualActual: number
  currentMRR: number
  currentMargin: number
  activeContractCount: number
  pipelineWeighted: number
  monthlyTrend: Array<{
    month: string
    shotRevenue: number
    stockRevenue: number
    totalRevenue: number
    dealCount: number
  }>
  statusBreakdown: Array<{
    status: string
    count: number
    amount: number
    color: string
  }>
  allDealsRevenue: Array<{
    id: string
    dealName: string
    companyId: string
    companyName: string
    yomiStatus: string
    product: string
    monthlyFee: number
    initialFee: number
    monthlyMargin: number
    contractMonths: number
    statusLabel: string
  }>
}

/**
 * 経営ダッシュボード用データ取得フック
 */
export function useExecutive() {
  return useQuery({
    queryKey: [EXECUTIVE_KEY, 'dashboard'],
    queryFn: async (): Promise<ExecutiveData> => {
      if (IS_DEMO_MODE) {
        return buildDemoExecutiveData()
      }

      // TODO: Supabaseモードの実装
      return buildDemoExecutiveData()
    },
    staleTime: 60 * 1000,
  })
}

/**
 * デモモード用のExecutiveDataを構築
 */
function buildDemoExecutiveData(): ExecutiveData {
  const annualTarget = 30_000_000

  // 2026年の売上実績を集計
  const revenue2026 = MOCK_MONTHLY_REVENUE.filter(r => r.year_month.startsWith('2026'))
  const annualActual = revenue2026.reduce((sum, r) => sum + r.margin_amount, 0)

  // 当月（2026-03）のMRRと粗利
  const currentMonth = '2026-03'
  const currentMonthRevenue = MOCK_MONTHLY_REVENUE.filter(r => r.year_month === currentMonth)
  const currentMRR = currentMonthRevenue.reduce((sum, r) => sum + r.monthly_fee, 0)
  const currentMargin = currentMonthRevenue.reduce((sum, r) => sum + r.margin_amount, 0)

  // 契約中件数（AIツール受注で status='契約中' のもの）
  const activeContractCount = MOCK_AI_TOOL_ORDERS.filter(o => o.status === '契約中').length

  // パイプライン総額（加重後）— 受注以外のヨミステータスの案件
  const pipelineDeals = MOCK_DEALS.filter(d => d.yomi_status !== '受注' && d.yomi_status !== '失注' && d.yomi_status !== '没ネタ')
  const yomiRates: Record<YomiStatus, number> = {
    '受注': 1.0,
    'Aヨミ': 0.8,
    'Bヨミ': 0.5,
    'Cヨミ': 0.2,
    'ネタ': 0.1,
    '没ネタ': 0.05,
    '失注': 0.0,
    '消滅': 0.0,
  }
  const pipelineWeighted = pipelineDeals.reduce((sum, d) => {
    const amount = (d.amount || 0) + ((d.monthly_amount || 0) * 12)
    const rate = yomiRates[d.yomi_status as YomiStatus] || 0
    return sum + (amount * rate)
  }, 0)

  // 月次推移（12ヶ月分）
  const monthlyTrend = buildMonthlyTrend()

  // ステータス別集計
  const statusBreakdown = buildStatusBreakdown()

  // 全案件売上一覧
  const allDealsRevenue = buildAllDealsRevenue()

  return {
    annualTarget,
    annualActual,
    currentMRR,
    currentMargin,
    activeContractCount,
    pipelineWeighted,
    monthlyTrend,
    statusBreakdown,
    allDealsRevenue,
  }
}

/**
 * 月次推移データを構築（12ヶ月分）
 */
function buildMonthlyTrend() {
  const grouped = new Map<string, { shotRevenue: number; stockRevenue: number; dealCount: number }>()

  for (const r of MOCK_MONTHLY_REVENUE) {
    if (!grouped.has(r.year_month)) {
      grouped.set(r.year_month, { shotRevenue: 0, stockRevenue: 0, dealCount: 0 })
    }
    const g = grouped.get(r.year_month)!
    // 粗利を月額マージンとして積み上げ（ストック）
    g.stockRevenue += r.margin_amount
    g.dealCount += 1
  }

  // 初期費用マージンを追加（ショット）
  for (const order of MOCK_AI_TOOL_ORDERS) {
    if (!order.contract_start_date) continue
    const month = order.contract_start_date.substring(0, 7)
    if (!grouped.has(month)) {
      grouped.set(month, { shotRevenue: 0, stockRevenue: 0, dealCount: 0 })
    }
    const g = grouped.get(month)!
    const initialMargin = order.initial_margin || 0
    g.shotRevenue += initialMargin
  }

  return Array.from(grouped.entries())
    .map(([month, data]) => ({
      month,
      shotRevenue: data.shotRevenue,
      stockRevenue: data.stockRevenue,
      totalRevenue: data.shotRevenue + data.stockRevenue,
      dealCount: data.dealCount,
    }))
    .sort((a, b) => a.month.localeCompare(b.month))
    .slice(-12) // 最新12ヶ月
}

/**
 * ステータス別集計
 */
function buildStatusBreakdown() {
  const grouped = new Map<string, { count: number; amount: number }>()

  for (const deal of MOCK_DEALS) {
    const status = deal.yomi_status || 'ネタ'
    if (!grouped.has(status)) {
      grouped.set(status, { count: 0, amount: 0 })
    }
    const g = grouped.get(status)!
    g.count += 1
    g.amount += (deal.amount || 0) + ((deal.monthly_amount || 0) * 12)
  }

  return Array.from(grouped.entries()).map(([status, data]) => ({
    status,
    count: data.count,
    amount: data.amount,
    color: YOMI_COLORS[status as YomiStatus] || '#9CA3AF',
  }))
}

/**
 * 全案件売上一覧を構築
 */
function buildAllDealsRevenue() {
  const result: ExecutiveData['allDealsRevenue'] = []

  // 受注案件 — AIツール受注データから
  for (const order of MOCK_AI_TOOL_ORDERS) {
    const company = MOCK_COMPANIES.find(c => c.id === order.company_id)

    result.push({
      id: order.id,
      dealName: company?.company_name || '不明',
      companyId: order.company_id || '',
      companyName: company?.company_name || '不明',
      yomiStatus: '受注',
      product: order.product || '-',
      monthlyFee: order.monthly_fee || 0,
      initialFee: order.initial_fee || 0,
      monthlyMargin: order.monthly_margin || 0,
      contractMonths: order.contract_months || 12,
      statusLabel: '受注',
    })
  }

  // パイプライン案件 — MOCK_DEALSから受注以外
  for (const deal of MOCK_DEALS) {
    if (deal.yomi_status === '受注') continue // 受注は上で追加済み

    const company = MOCK_COMPANIES.find(c => c.id === deal.company_id)

    result.push({
      id: deal.id,
      dealName: deal.deal_name || company?.company_name || '不明',
      companyId: deal.company_id || '',
      companyName: company?.company_name || '不明',
      yomiStatus: deal.yomi_status || 'ネタ',
      product: '-',
      monthlyFee: deal.monthly_amount || 0,
      initialFee: deal.amount || 0,
      monthlyMargin: (deal.monthly_amount || 0) * 0.5, // 仮で50%マージン
      contractMonths: 12,
      statusLabel: deal.yomi_status || 'ネタ',
    })
  }

  // 受注を上に
  result.sort((a, b) => {
    if (a.yomiStatus === '受注' && b.yomiStatus !== '受注') return -1
    if (a.yomiStatus !== '受注' && b.yomiStatus === '受注') return 1
    return 0
  })

  return result
}
