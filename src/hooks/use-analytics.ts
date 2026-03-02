'use client'

import { useQuery } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_DEALS, MOCK_USERS, MOCK_AI_TOOL_ORDERS, MOCK_LISTS } from '@/lib/mock-data'

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

export type ListAnalysis = {
  listId: string
  listName: string
  totalDeals: number
  activeDeals: number
  wonDeals: number
  lostDeals: number
  closeRate: number
  byYomi: Record<string, number>
  topClosers: Array<{ name: string; count: number }>
  topAppointers: Array<{ name: string; count: number }>
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

type ListDealRow = {
  id: string
  yomi_status: string | null
  list_id: string | null
  closer_id: string | null
  appointer_id: string | null
  closer: { display_name: string } | { display_name: string }[] | null
  appointer: { display_name: string } | { display_name: string }[] | null
  list: { id: string; list_name: string } | { id: string; list_name: string }[] | null
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

// List analysis
export function useListAnalysis() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['analytics', 'list'],
    queryFn: async () => {
      let deals: ListDealRow[] = []

      // デモモード: モックデータを使用
      if (IS_DEMO_MODE) {
        // MOCK_LISTSからリストIDとリスト名のマップを作成
        const listNameMap = new Map<string, string>()
        MOCK_LISTS.forEach((l) => {
          listNameMap.set(l.id, l.list_name)
        })

        deals = MOCK_DEALS.map((d) => {
          const closer = MOCK_USERS.find((u) => u.id === d.closer_id)
          const appointer = MOCK_USERS.find((u) => u.id === d.appointer_id)

          return {
            id: d.id,
            yomi_status: d.yomi_status,
            list_id: d.list_id,
            closer_id: d.closer_id,
            appointer_id: d.appointer_id,
            closer: closer || null,
            appointer: appointer || null,
            list: d.list_id ? { id: d.list_id, list_name: listNameMap.get(d.list_id) || '未分類' } : null,
          }
        })
      } else {
        // 通常モード
        const { data, error } = await supabase!
          .from('deals')
          .select(`
            id,
            yomi_status,
            list_id,
            closer_id,
            appointer_id,
            closer:users!deals_closer_id_fkey(id, display_name),
            appointer:users!deals_appointer_id_fkey(id, display_name),
            list:lists!deals_list_id_fkey(id, list_name)
          `)

        if (error) throw error
        deals = (data || []) as ListDealRow[]
      }

      const listMap = new Map<string, ListAnalysis>()

      for (const deal of deals || []) {
        const listId = deal.list_id
        if (!listId) continue

        const listData = deal.list as { id: string; list_name: string } | null
        const listName = listData?.list_name || 'リスト名不明'

        if (!listMap.has(listId)) {
          listMap.set(listId, {
            listId,
            listName,
            totalDeals: 0,
            activeDeals: 0,
            wonDeals: 0,
            lostDeals: 0,
            closeRate: 0,
            byYomi: {},
            topClosers: [],
            topAppointers: [],
          })
        }

        const list = listMap.get(listId)!
        list.totalDeals += 1

        const yomi = deal.yomi_status || 'ネタ'
        list.byYomi[yomi] = (list.byYomi[yomi] || 0) + 1

        if (yomi === '受注') {
          list.wonDeals += 1
        } else if (yomi === '失注' || yomi === '消滅') {
          list.lostDeals += 1
        } else if (!['没ネタ'].includes(yomi)) {
          list.activeDeals += 1
        }
      }

      // クローザー・アポインターのトップを計算
      return Array.from(listMap.values()).map((list) => {
        const listDeals = deals.filter((d) => d.list_id === list.listId)

        // クローザー集計
        const closerCounts = new Map<string, { name: string; count: number }>()
        listDeals.forEach((d) => {
          if (d.closer_id && d.yomi_status === '受注') {
            const closerData = d.closer as { display_name: string } | null
            const name = closerData?.display_name || '不明'
            if (!closerCounts.has(d.closer_id)) {
              closerCounts.set(d.closer_id, { name, count: 0 })
            }
            closerCounts.get(d.closer_id)!.count += 1
          }
        })

        // アポインター集計
        const appointerCounts = new Map<string, { name: string; count: number }>()
        listDeals.forEach((d) => {
          if (d.appointer_id) {
            const appointerData = d.appointer as { display_name: string } | null
            const name = appointerData?.display_name || '不明'
            if (!appointerCounts.has(d.appointer_id)) {
              appointerCounts.set(d.appointer_id, { name, count: 0 })
            }
            appointerCounts.get(d.appointer_id)!.count += 1
          }
        })

        return {
          ...list,
          closeRate: list.totalDeals > 0 ? list.wonDeals / list.totalDeals : 0,
          topClosers: Array.from(closerCounts.values())
            .sort((a, b) => b.count - a.count)
            .slice(0, 3),
          topAppointers: Array.from(appointerCounts.values())
            .sort((a, b) => b.count - a.count)
            .slice(0, 3),
        }
      }).sort((a, b) => b.totalDeals - a.totalDeals)
    },
    staleTime: 60 * 1000,
  })
}
