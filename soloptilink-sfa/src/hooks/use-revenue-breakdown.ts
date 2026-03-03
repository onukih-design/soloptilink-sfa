'use client'

import { useQuery } from '@tanstack/react-query'
import * as engine from '@/lib/calculations/revenue-engine-v2'

/**
 * 売上内訳フック
 *
 * AIツール vs 営業代行の売上分析に特化したフック
 * 売上ダッシュボード画面で使用
 */
export function useRevenueBreakdown() {
  return useQuery({
    queryKey: ['revenue-breakdown'],
    queryFn: async () => {
      const aiTools = engine.calculateAIToolRevenue()
      const outsourcing = engine.calculateOutsourcingRevenue()
      const total = engine.calculateTotalRevenue()

      return {
        aiTools,
        outsourcing,
        total,
        summary: {
          totalMRR: aiTools.totalMRR + outsourcing.totalMonthlyCommission,
          totalMargin: aiTools.totalMonthlyMargin + outsourcing.totalMonthlyCommission,
          aiToolShare: total.byCategory.find(c => c.category === 'AIツール')?.percentage || 0,
          outsourcingShare: total.byCategory.find(c => c.category === '営業代行')?.percentage || 0,
        },
      }
    },
    staleTime: 30 * 1000, // 30 seconds
  })
}
