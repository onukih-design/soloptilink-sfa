'use client'

import { useQuery } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import { YOMI_RATES } from '@/lib/constants/yomi'
import type { YomiStatus } from '@/types/deals'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_DEALS, MOCK_COMPANIES, MOCK_MONTHLY_REVENUE, MOCK_FOLLOWUPS } from '@/lib/mock-data'

/** Supabase から取得する案件行の型 */
type DealRow = {
  id: string
  deal_number: number
  deal_name: string
  yomi_status: string
  amount: number | null
  monthly_amount: number | null
  closed_date: string | null
  updated_at: string
  notes: string | null
  company: { company_name: string } | null
}

/** Supabase から取得するフォローアップ行の型 */
type FollowupRow = {
  id: string
  deal_id: string
  next_action: string | null
  next_action_date: string | null
  deal: {
    deal_name: string
    company: { company_name: string } | null
  } | null
}

/** Supabase から取得する月次売上行の型 */
type RevenueRow = {
  monthly_fee: number
  margin_amount: number
}

// ダッシュボード集計データ型
export type DashboardSummary = {
  pipelineByYomi: Array<{
    yomiStatus: string
    count: number
    totalAmount: number
    weightedAmount: number
  }>
  totalPipelineAmount: number
  totalWeightedAmount: number
  wonDealsThisMonth: number
  wonAmountThisMonth: number
  activeDealCount: number
  todayFollowups: Array<{
    id: string
    dealId: string
    dealName: string
    companyName: string
    nextAction: string
    nextActionDate: string
  }>
  recentDeals: Array<{
    id: string
    dealNumber: string
    dealName: string
    companyName: string
    yomiStatus: string
    amount: number
    updatedAt: string
    notes: string
  }>
  monthlyRevenue: {
    currentMonth: number
    currentMargin: number
    previousMonth: number
    previousMargin: number
    growthRate: number
  }
  monthlyProgress: Array<{
    month: string
    displayMonth: string
    shotRevenue: number
    stockRevenue: number
    target: number
  }>
  annualSummary: {
    target: number
    actual: number
    achievementRate: number
  }
}

/**
 * ダッシュボード集計データを取得するカスタムフック
 * パイプライン・受注・MRR・本日のアクション・最近の案件を一括取得
 */
export function useDashboardSummary() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['dashboard-summary'],
    queryFn: async (): Promise<DashboardSummary> => {
      const now = new Date()
      const currentYearMonth = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}`
      const prevMonth = new Date(now.getFullYear(), now.getMonth() - 1, 1)
      const prevYearMonth = `${prevMonth.getFullYear()}-${String(prevMonth.getMonth() + 1).padStart(2, '0')}`
      const todayStr = now.toISOString().split('T')[0]

      // デモモード: モックデータから集計
      if (IS_DEMO_MODE) {
        // アクティブな案件（失注・消滅を除く）
        const deals = MOCK_DEALS.filter(
          (d) => d.yomi_status !== '失注' && d.yomi_status !== '消滅'
        ).map((d) => ({
          ...d,
          company: MOCK_COMPANIES.find((c) => c.id === d.company_id) || { company_name: '不明' },
        }))

        // ヨミ別集計
        const yomiMap = new Map<string, { count: number; totalAmount: number; weightedAmount: number }>()
        for (const deal of deals) {
          const status = deal.yomi_status || 'ネタ'
          const current = yomiMap.get(status) || { count: 0, totalAmount: 0, weightedAmount: 0 }
          const amount = deal.amount || 0
          const rate = YOMI_RATES[status as YomiStatus] ?? 0
          current.count += 1
          current.totalAmount += amount
          current.weightedAmount += Math.floor(amount * rate)
          yomiMap.set(status, current)
        }

        const pipelineByYomi = Array.from(yomiMap.entries()).map(([yomiStatus, data]) => ({
          yomiStatus,
          ...data,
        }))

        // 今月の受注案件
        const wonDeals = deals.filter((d) => {
          if (d.yomi_status !== '受注') return false
          if (!d.closed_date) return false
          const closedDate = String(d.closed_date)
          return closedDate.startsWith(currentYearMonth)
        })

        // 最近更新された案件
        const recentDeals = deals.slice(0, 10).map((d) => ({
          id: d.id,
          dealNumber: String(d.deal_number || ''),
          dealName: d.deal_name || '',
          companyName: d.company?.company_name || '',
          yomiStatus: d.yomi_status || '',
          amount: d.amount || 0,
          updatedAt: d.updated_at || '',
          notes: d.notes || '',
        }))

        // 月次売上集計
        const currentMonthRevenue = MOCK_MONTHLY_REVENUE.filter(
          (r) => r.year_month === currentYearMonth
        ).reduce((sum, r) => sum + (r.monthly_fee || 0), 0)

        const currentMonthMargin = MOCK_MONTHLY_REVENUE.filter(
          (r) => r.year_month === currentYearMonth
        ).reduce((sum, r) => sum + (r.margin_amount || 0), 0)

        const prevMonthRevenue = MOCK_MONTHLY_REVENUE.filter(
          (r) => r.year_month === prevYearMonth
        ).reduce((sum, r) => sum + (r.monthly_fee || 0), 0)

        const prevMonthMargin = MOCK_MONTHLY_REVENUE.filter(
          (r) => r.year_month === prevYearMonth
        ).reduce((sum, r) => sum + (r.margin_amount || 0), 0)

        const growthRate =
          prevMonthRevenue > 0
            ? (currentMonthRevenue - prevMonthRevenue) / prevMonthRevenue
            : 0

        // 本日のフォローアップ（デモモード）
        const todayFollowups = MOCK_FOLLOWUPS
          .filter((f) => f.next_action_date === todayStr)
          .map((f) => {
            const deal = MOCK_DEALS.find((d) => d.id === f.deal_id)
            const company = deal ? MOCK_COMPANIES.find((c) => c.id === deal.company_id) : null
            return {
              id: f.id,
              dealId: f.deal_id,
              dealName: deal?.deal_name || '',
              companyName: company?.company_name || '',
              nextAction: f.next_action || '',
              nextActionDate: f.next_action_date || '',
            }
          })

        // 月次売上進捗（ショット/ストック分離、6ヶ月分）
        const monthlyTarget = 2500000 // 月次目標 250万円
        const annualTarget = 30000000 // 年間目標 3000万円
        const monthlyProgressMap = new Map<string, { shot: number; stock: number }>()
        for (const r of MOCK_MONTHLY_REVENUE) {
          const cur = monthlyProgressMap.get(r.year_month) || { shot: 0, stock: 0 }
          // 粗利ベースで集計
          cur.stock += r.margin_amount || 0
          monthlyProgressMap.set(r.year_month, cur)
        }
        const monthlyProgress = Array.from(monthlyProgressMap.entries())
          .sort((a, b) => a[0].localeCompare(b[0]))
          .map(([month, data]) => ({
            month,
            displayMonth: month.substring(5) + '月',
            shotRevenue: Math.floor(data.shot),
            stockRevenue: Math.floor(data.stock),
            target: monthlyTarget,
          }))

        // 年間サマリー（2026年度）
        const annualActual = Array.from(monthlyProgressMap.entries())
          .filter(([m]) => m.startsWith('2026'))
          .reduce((sum, [, d]) => sum + d.shot + d.stock, 0)

        return {
          pipelineByYomi,
          totalPipelineAmount: deals.reduce((sum, d) => sum + (d.amount || 0), 0),
          totalWeightedAmount: pipelineByYomi.reduce((sum, p) => sum + p.weightedAmount, 0),
          wonDealsThisMonth: wonDeals.length,
          wonAmountThisMonth: wonDeals.reduce((sum, d) => sum + (d.amount || 0), 0),
          activeDealCount: deals.length,
          todayFollowups,
          recentDeals,
          monthlyRevenue: {
            currentMonth: currentMonthRevenue,
            currentMargin: currentMonthMargin,
            previousMonth: prevMonthRevenue,
            previousMargin: prevMonthMargin,
            growthRate,
          },
          monthlyProgress,
          annualSummary: {
            target: annualTarget,
            actual: annualActual,
            achievementRate: annualTarget > 0 ? annualActual / annualTarget : 0,
          },
        }
      }

      // 通常モード: Supabaseから取得
      const [dealsResult, followupsResult, revenueCurrentResult, revenuePrevResult] = await Promise.all([
        // アクティブな案件（失注・消滅を除く）
        supabase!
          .from('deals')
          .select('id, deal_number, deal_name, yomi_status, amount, monthly_amount, closed_date, updated_at, notes, company:companies(company_name)')
          .not('yomi_status', 'in', '("失注","消滅")')
          .order('updated_at', { ascending: false })
          .returns<DealRow[]>(),

        // 本日のフォローアップ
        supabase!
          .from('deal_followups')
          .select('id, deal_id, next_action, next_action_date, deal:deals(deal_name, company:companies(company_name))')
          .eq('next_action_date', todayStr)
          .not('next_action', 'is', null)
          .returns<FollowupRow[]>(),

        // 当月の月次売上
        supabase!
          .from('monthly_revenue')
          .select('monthly_fee, margin_amount')
          .eq('year_month', currentYearMonth)
          .returns<RevenueRow[]>(),

        // 前月の月次売上
        supabase!
          .from('monthly_revenue')
          .select('monthly_fee, margin_amount')
          .eq('year_month', prevYearMonth)
          .returns<RevenueRow[]>(),
      ])

      // 案件データの集計処理
      const deals = dealsResult.data || []
      const yomiMap = new Map<string, { count: number; totalAmount: number; weightedAmount: number }>()

      for (const deal of deals) {
        const status = deal.yomi_status || 'ネタ'
        const current = yomiMap.get(status) || { count: 0, totalAmount: 0, weightedAmount: 0 }
        const amount = deal.amount || 0
        const rate = YOMI_RATES[status as YomiStatus] ?? 0
        current.count += 1
        current.totalAmount += amount
        current.weightedAmount += Math.floor(amount * rate)
        yomiMap.set(status, current)
      }

      const pipelineByYomi = Array.from(yomiMap.entries()).map(([yomiStatus, data]) => ({
        yomiStatus,
        ...data,
      }))

      // 今月の受注案件
      const wonDeals = deals.filter(
        (d) =>
          d.yomi_status === '受注' &&
          d.closed_date &&
          d.closed_date.startsWith(currentYearMonth)
      )

      // 本日のフォローアップ整形
      const todayFollowups = (followupsResult.data || []).map((f) => ({
        id: f.id,
        dealId: f.deal_id,
        dealName: f.deal?.deal_name || '',
        companyName: f.deal?.company?.company_name || '',
        nextAction: f.next_action || '',
        nextActionDate: f.next_action_date || '',
      }))

      // 最近更新された案件（上位10件）
      const recentDeals = deals.slice(0, 10).map((d) => ({
        id: d.id,
        dealNumber: String(d.deal_number || ''),
        dealName: d.deal_name || '',
        companyName: d.company?.company_name || '',
        yomiStatus: d.yomi_status || '',
        amount: d.amount || 0,
        updatedAt: d.updated_at || '',
        notes: d.notes || '',
      }))

      // 月次売上集計
      const currentMonthRevenue = (revenueCurrentResult.data || []).reduce(
        (sum, r) => sum + (r.monthly_fee || 0),
        0
      )
      const currentMonthMargin = (revenueCurrentResult.data || []).reduce(
        (sum, r) => sum + (r.margin_amount || 0),
        0
      )
      const prevMonthRevenue = (revenuePrevResult.data || []).reduce(
        (sum, r) => sum + (r.monthly_fee || 0),
        0
      )
      const prevMonthMargin = (revenuePrevResult.data || []).reduce(
        (sum, r) => sum + (r.margin_amount || 0),
        0
      )
      const growthRate =
        prevMonthRevenue > 0
          ? (currentMonthRevenue - prevMonthRevenue) / prevMonthRevenue
          : 0

      return {
        pipelineByYomi,
        totalPipelineAmount: deals.reduce((sum, d) => sum + (d.amount || 0), 0),
        totalWeightedAmount: pipelineByYomi.reduce((sum, p) => sum + p.weightedAmount, 0),
        wonDealsThisMonth: wonDeals.length,
        wonAmountThisMonth: wonDeals.reduce((sum, d) => sum + (d.amount || 0), 0),
        activeDealCount: deals.length,
        todayFollowups,
        recentDeals,
        monthlyRevenue: {
          currentMonth: currentMonthRevenue,
          currentMargin: currentMonthMargin,
          previousMonth: prevMonthRevenue,
          previousMargin: prevMonthMargin,
          growthRate,
        },
        monthlyProgress: [],
        annualSummary: {
          target: 30000000,
          actual: currentMonthRevenue * 12,
          achievementRate: 0,
        },
      }
    },
    staleTime: 30 * 1000,
    refetchInterval: 60 * 1000,
  })
}
