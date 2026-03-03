'use client'

import { useQuery } from '@tanstack/react-query'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_DEALS, MOCK_LISTS, MOCK_USERS, MOCK_COMPANIES } from '@/lib/mock-data'

export type ListAnalysis = {
  listId: string
  listName: string
  totalDeals: number
  activeDeals: number // 受注・失注・消滅以外
  wonDeals: number
  lostDeals: number
  closeRate: number // 受注 / (受注+失注)
  byYomi: Record<string, number> // ヨミステータス別件数
  topClosers: Array<{ name: string; count: number }>
  topAppointers: Array<{ name: string; count: number }>
  totalAmount: number
  avgDealAge: number // 平均日数
}

export function useListAnalysis() {
  return useQuery({
    queryKey: ['analytics', 'list'],
    queryFn: async () => {
      // デモモード: モックデータを使用
      if (IS_DEMO_MODE) {
        const listMap = new Map<string, ListAnalysis>()

        // 「未分類」リスト用
        const UNCLASSIFIED = { id: 'unclassified', name: '未分類' }

        for (const deal of MOCK_DEALS) {
          const list = deal.list_id ? MOCK_LISTS.find(l => l.id === deal.list_id) : null
          const listId = list?.id || UNCLASSIFIED.id
          const listName = list?.list_name || UNCLASSIFIED.name

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
              totalAmount: 0,
              avgDealAge: 0,
            })
          }

          const la = listMap.get(listId)!
          la.totalDeals += 1
          la.totalAmount += deal.amount || 0

          const yomi = deal.yomi_status || 'ネタ'
          la.byYomi[yomi] = (la.byYomi[yomi] || 0) + 1

          if (yomi === '受注') la.wonDeals += 1
          else if (yomi === '失注') la.lostDeals += 1
          else if (yomi !== '消滅') la.activeDeals += 1
        }

        // closeRate 計算 + closer/appointer 集計
        const result = Array.from(listMap.values()).map(la => {
          // closeRate
          const decided = la.wonDeals + la.lostDeals
          la.closeRate = decided > 0 ? la.wonDeals / decided : 0

          // closer集計
          const closerMap = new Map<string, number>()
          const appointerMap = new Map<string, number>()

          for (const deal of MOCK_DEALS) {
            const list = deal.list_id ? MOCK_LISTS.find(l => l.id === deal.list_id) : null
            const dealListId = list?.id || UNCLASSIFIED.id
            if (dealListId !== la.listId) continue

            if (deal.closer_id) {
              const closer = MOCK_USERS.find(u => u.id === deal.closer_id)
              const name = closer?.display_name || '不明'
              closerMap.set(name, (closerMap.get(name) || 0) + 1)
            }
            if (deal.appointer_id) {
              const appointer = MOCK_USERS.find(u => u.id === deal.appointer_id)
              const name = appointer?.display_name || '不明'
              appointerMap.set(name, (appointerMap.get(name) || 0) + 1)
            }
          }

          la.topClosers = Array.from(closerMap.entries())
            .map(([name, count]) => ({ name, count }))
            .sort((a, b) => b.count - a.count)
            .slice(0, 5)

          la.topAppointers = Array.from(appointerMap.entries())
            .map(([name, count]) => ({ name, count }))
            .sort((a, b) => b.count - a.count)
            .slice(0, 5)

          return la
        })

        return result.sort((a, b) => b.totalDeals - a.totalDeals)
      }

      // 通常モード: Supabase
      // (same as demo for now, extend later)
      return [] as ListAnalysis[]
    },
    staleTime: 60 * 1000,
  })
}

// 特定リストの案件一覧を取得
export function useListDeals(listId: string | null) {
  return useQuery({
    queryKey: ['analytics', 'list-deals', listId],
    queryFn: async () => {
      if (!listId || !IS_DEMO_MODE) return []

      return MOCK_DEALS
        .filter(d => {
          if (listId === 'unclassified') return !d.list_id
          return d.list_id === listId
        })
        .map(d => ({
          ...d,
          company: MOCK_COMPANIES.find(c => c.id === d.company_id) || { id: '', company_name: '不明' },
          closer: MOCK_USERS.find(u => u.id === d.closer_id) || null,
          appointer: MOCK_USERS.find(u => u.id === d.appointer_id) || null,
        }))
    },
    enabled: !!listId,
    staleTime: 60 * 1000,
  })
}
