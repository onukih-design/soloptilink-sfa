'use client'

import { useQuery } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_DEALS, MOCK_USERS, MOCK_AI_TOOL_ORDERS } from '@/lib/mock-data'

export type CloserAnalysis = {
  userId: string
  displayName: string
  totalDeals: number
  wonDeals: number
  closeRate: number
  totalAmount: number
  wonAmount: number
  avgDealSize: number
  byYomi: Record<string, number>
}

export type AppointerAnalysis = {
  userId: string
  displayName: string
  totalAppointments: number
  convertedDeals: number
  conversionRate: number
  totalAmount: number
}

export type ProductAnalysis = {
  product: string
  productName: string
  activeCount: number
  totalMRR: number
  totalMargin: number
  avgMonthlyFee: number
  marginRate: number
}

// 分析用の中間型定義（any型排除）
type CloserDealRow = {
  id: string
  yomi_status: string | null
  amount: number | null
  closer_id: string | null
  closer: { display_name: string } | { display_name: string }[] | null
}

type AppointerDealRow = {
  id: string
  yomi_status: string | null
  amount: number | null
  appointer_id: string | null
  appointer: { display_name: string } | { display_name: string }[] | null
}

type ProductOrderRow = {
  product: string | null
  monthly_fee: number | null
  monthly_margin: number | null
  margin_rate: number | null
  status: string | null
}

// Closer performance analysis
export function useCloserAnalysis() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['analytics', 'closer'],
    queryFn: async () => {
      let deals: CloserDealRow[] = []

      // デモモード: モックデータを使用
      if (IS_DEMO_MODE) {
        deals = MOCK_DEALS.map((d) => ({
          id: d.id,
          yomi_status: d.yomi_status,
          amount: d.amount,
          closer_id: d.closer_id,
          closer: MOCK_USERS.find((u) => u.id === d.closer_id) || null,
        }))
      } else {
        // 通常モード
        const { data, error } = await supabase!
          .from('deals')
          .select('id, yomi_status, amount, closer_id, closer:users!deals_closer_id_fkey(id, display_name)')

        if (error) throw error
        deals = (data || []) as CloserDealRow[]
      }

      const closerMap = new Map<string, CloserAnalysis>()

      for (const deal of deals || []) {
        const closerId = deal.closer_id
        if (!closerId) continue

        if (!closerMap.has(closerId)) {
          closerMap.set(closerId, {
            userId: closerId,
            displayName: (deal.closer as { display_name: string } | null)?.display_name || '不明',
            totalDeals: 0,
            wonDeals: 0,
            closeRate: 0,
            totalAmount: 0,
            wonAmount: 0,
            avgDealSize: 0,
            byYomi: {},
          })
        }

        const closer = closerMap.get(closerId)!
        closer.totalDeals += 1
        closer.totalAmount += deal.amount || 0

        const yomi = deal.yomi_status || 'ネタ'
        closer.byYomi[yomi] = (closer.byYomi[yomi] || 0) + 1

        if (yomi === '受注') {
          closer.wonDeals += 1
          closer.wonAmount += deal.amount || 0
        }
      }

      return Array.from(closerMap.values()).map((c) => ({
        ...c,
        closeRate: c.totalDeals > 0 ? c.wonDeals / c.totalDeals : 0,
        avgDealSize: c.wonDeals > 0 ? Math.floor(c.wonAmount / c.wonDeals) : 0,
      })).sort((a, b) => b.wonAmount - a.wonAmount)
    },
    staleTime: 60 * 1000,
  })
}

// Appointer performance analysis
export function useAppointerAnalysis() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['analytics', 'appointer'],
    queryFn: async () => {
      let deals: AppointerDealRow[] = []

      // デモモード: モックデータを使用
      if (IS_DEMO_MODE) {
        deals = MOCK_DEALS.map((d) => ({
          id: d.id,
          yomi_status: d.yomi_status,
          amount: d.amount,
          appointer_id: d.appointer_id,
          appointer: MOCK_USERS.find((u) => u.id === d.appointer_id) || null,
        }))
      } else {
        // 通常モード
        const { data, error } = await supabase!
          .from('deals')
          .select('id, yomi_status, amount, appointer_id, appointer:users!deals_appointer_id_fkey(id, display_name)')

        if (error) throw error
        deals = (data || []) as AppointerDealRow[]
      }

      const appointerMap = new Map<string, AppointerAnalysis>()

      for (const deal of deals || []) {
        const appointerId = deal.appointer_id
        if (!appointerId) continue

        if (!appointerMap.has(appointerId)) {
          appointerMap.set(appointerId, {
            userId: appointerId,
            displayName: (deal.appointer as { display_name: string } | null)?.display_name || '不明',
            totalAppointments: 0,
            convertedDeals: 0,
            conversionRate: 0,
            totalAmount: 0,
          })
        }

        const appointer = appointerMap.get(appointerId)!
        appointer.totalAppointments += 1
        appointer.totalAmount += deal.amount || 0

        if (deal.yomi_status === '受注') {
          appointer.convertedDeals += 1
        }
      }

      return Array.from(appointerMap.values()).map((a) => ({
        ...a,
        conversionRate: a.totalAppointments > 0 ? a.convertedDeals / a.totalAppointments : 0,
      })).sort((a, b) => b.totalAppointments - a.totalAppointments)
    },
    staleTime: 60 * 1000,
  })
}

// Product analysis
export function useProductAnalysis() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['analytics', 'product'],
    queryFn: async () => {
      let orders: ProductOrderRow[] = []

      // デモモード: モックデータを使用
      if (IS_DEMO_MODE) {
        orders = MOCK_AI_TOOL_ORDERS.map((o) => ({
          product: o.product,
          monthly_fee: o.monthly_fee,
          monthly_margin: o.monthly_margin,
          margin_rate: o.margin_rate,
          status: o.status,
        }))
      } else {
        // 通常モード
        const { data, error } = await supabase!
          .from('ai_tool_orders')
          .select('product, monthly_fee, monthly_margin, margin_rate, status')

        if (error) throw error
        orders = (data || []) as ProductOrderRow[]
      }

      const productMap = new Map<string, ProductAnalysis>()

      for (const order of orders || []) {
        const product = order.product || 'unknown'
        const isActive = order.status === '契約中' || !order.status

        if (!productMap.has(product)) {
          productMap.set(product, {
            product,
            productName: product,
            activeCount: 0,
            totalMRR: 0,
            totalMargin: 0,
            avgMonthlyFee: 0,
            marginRate: order.margin_rate || 0,
          })
        }

        const p = productMap.get(product)!
        if (isActive) {
          p.activeCount += 1
          p.totalMRR += order.monthly_fee || 0
          p.totalMargin += order.monthly_margin || 0
        }
      }

      return Array.from(productMap.values()).map((p) => ({
        ...p,
        avgMonthlyFee: p.activeCount > 0 ? Math.floor(p.totalMRR / p.activeCount) : 0,
      })).sort((a, b) => b.totalMRR - a.totalMRR)
    },
    staleTime: 60 * 1000,
  })
}
