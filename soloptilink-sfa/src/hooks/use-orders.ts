'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import type { AiToolOrderWithRelations, SalesOutsourcingOrderWithRelations, MonthlyRevenueSummary } from '@/types/orders'
import type { Tables } from '@/types/database'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_AI_TOOL_ORDERS, MOCK_COMPANIES, MOCK_MONTHLY_REVENUE, MOCK_SALES_OUTSOURCING_ORDERS } from '@/lib/mock-data'

const ORDERS_KEY = 'orders'
const REVENUE_KEY = 'revenue'

/**
 * AIツール受注一覧を取得
 */
export function useAiToolOrders() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [ORDERS_KEY, 'ai-tools'],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        return MOCK_AI_TOOL_ORDERS.map((order) => ({
          ...order,
          company: MOCK_COMPANIES.find((c) => c.id === order.company_id) || {
            id: '',
            company_name: '不明',
          },
          closer: null,
          appointer: null,
        })) as unknown as AiToolOrderWithRelations[]
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('ai_tool_orders')
        .select(`
          *,
          company:companies(id, company_name),
          closer:users!ai_tool_orders_closer_id_fkey(id, display_name),
          appointer:users!ai_tool_orders_appointer_id_fkey(id, display_name)
        `)
        .order('created_at', { ascending: false })

      if (error) throw error
      return (data || []) as unknown as AiToolOrderWithRelations[]
    },
    staleTime: 30 * 1000,
  })
}

/**
 * 営業代行受注一覧を取得
 */
export function useSalesOutsourcingOrders() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [ORDERS_KEY, 'outsourcing'],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        return MOCK_SALES_OUTSOURCING_ORDERS.map((order) => ({
          ...order,
          company: MOCK_COMPANIES.find((c) => c.id === order.company_id) || {
            id: '',
            company_name: '不明',
          },
          closer: null,
          appointer: null,
        })) as unknown as SalesOutsourcingOrderWithRelations[]
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('sales_outsourcing_orders')
        .select(`
          *,
          company:companies(id, company_name),
          closer:users!sales_outsourcing_orders_closer_id_fkey(id, display_name),
          appointer:users!sales_outsourcing_orders_appointer_id_fkey(id, display_name)
        `)
        .order('created_at', { ascending: false })

      if (error) throw error
      return (data || []) as unknown as SalesOutsourcingOrderWithRelations[]
    },
    staleTime: 30 * 1000,
  })
}

/**
 * 月次収益データを取得
 */
export function useMonthlyRevenue(months?: number) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [REVENUE_KEY, 'monthly', months],
    queryFn: async () => {
      const now = new Date()
      const startDate = new Date(now.getFullYear(), now.getMonth() - (months || 12), 1)
      const startYearMonth = `${startDate.getFullYear()}-${String(startDate.getMonth() + 1).padStart(2, '0')}`

      // デモモード: モックデータをフィルタして返す
      if (IS_DEMO_MODE) {
        return (
          MOCK_MONTHLY_REVENUE.filter((r) => r.year_month >= startYearMonth)
            .sort((a, b) => a.year_month.localeCompare(b.year_month))
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
        ) as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('monthly_revenue')
        .select('*')
        .gte('year_month', startYearMonth)
        .order('year_month', { ascending: true })

      if (error) throw error
      return (data || []) as Tables<'monthly_revenue'>[]
    },
    staleTime: 60 * 1000,
  })
}

/**
 * 月次収益サマリ（月ごとに集計）を取得
 */
export function useRevenueSummary(months?: number) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [REVENUE_KEY, 'summary', months],
    queryFn: async () => {
      const now = new Date()
      const startDate = new Date(now.getFullYear(), now.getMonth() - (months || 12), 1)
      const startYearMonth = `${startDate.getFullYear()}-${String(startDate.getMonth() + 1).padStart(2, '0')}`

      let rows: {
        year_month: string
        product: string
        monthly_fee: number
        margin_amount: number
      }[] = []

      // デモモード: モックデータを使用
      if (IS_DEMO_MODE) {
        rows = MOCK_MONTHLY_REVENUE.filter((r) => r.year_month >= startYearMonth).map(
          (r) => ({
            year_month: r.year_month,
            product: r.product,
            monthly_fee: r.monthly_fee,
            margin_amount: r.margin_amount,
          })
        )
      } else {
        // 通常モード
        const { data, error } = await supabase!
          .from('monthly_revenue')
          .select('year_month, product, monthly_fee, margin_amount')
          .gte('year_month', startYearMonth)
          .order('year_month', { ascending: true })

        if (error) throw error
        rows = (data || []) as unknown as {
          year_month: string
          product: string
          monthly_fee: number
          margin_amount: number
        }[]
      }

      // 月ごとにグルーピング
      const grouped = new Map<string, {
        yearMonth: string
        totalMonthlyFee: number
        totalMarginAmount: number
        activeCount: number
        byProduct: Map<string, { product: string; monthlyFee: number; marginAmount: number; count: number }>
      }>()

      for (const row of rows) {
        const ym = row.year_month || ''
        if (!grouped.has(ym)) {
          grouped.set(ym, {
            yearMonth: ym,
            totalMonthlyFee: 0,
            totalMarginAmount: 0,
            activeCount: 0,
            byProduct: new Map(),
          })
        }
        const group = grouped.get(ym)!
        group.totalMonthlyFee += row.monthly_fee || 0
        group.totalMarginAmount += row.margin_amount || 0
        group.activeCount += 1

        const product = row.product || 'unknown'
        if (!group.byProduct.has(product)) {
          group.byProduct.set(product, { product, monthlyFee: 0, marginAmount: 0, count: 0 })
        }
        const p = group.byProduct.get(product)!
        p.monthlyFee += row.monthly_fee || 0
        p.marginAmount += row.margin_amount || 0
        p.count += 1
      }

      const result: MonthlyRevenueSummary[] = Array.from(grouped.values()).map((g) => ({
        yearMonth: g.yearMonth,
        totalMonthlyFee: g.totalMonthlyFee,
        totalMarginAmount: g.totalMarginAmount,
        activeCount: g.activeCount,
        byProduct: Array.from(g.byProduct.values()),
      }))

      return result
    },
    staleTime: 60 * 1000,
  })
}

/**
 * AIツール受注ステータスを更新
 */
export function useUpdateAiToolOrderStatus() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({ id, status }: { id: string; status: string }) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id, status } as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('ai_tool_orders')
        .update({ status })
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [ORDERS_KEY] })
    },
  })
}

/**
 * 営業代行受注ステータスを更新
 */
export function useUpdateSalesOutsourcingOrderStatus() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({ id, status }: { id: string; status: string }) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id, status } as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('sales_outsourcing_orders')
        .update({ status })
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [ORDERS_KEY] })
    },
  })
}
