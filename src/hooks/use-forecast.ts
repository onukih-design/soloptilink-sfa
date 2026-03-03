'use client'

import { useQuery } from '@tanstack/react-query'
import * as engine from '@/lib/calculations/revenue-engine-v2'
import { MONTHLY_TARGETS_2026 } from '@/lib/constants/kpi-targets'

/**
 * 予実・予測分析フック
 *
 * 目標 vs 実績、成長率、予測値を提供
 * 予算管理画面で使用
 */
export function useForecast() {
  return useQuery({
    queryKey: ['forecast'],
    queryFn: async () => {
      // Convert MONTHLY_TARGETS_2026 to array format
      const targetArray = Object.entries(MONTHLY_TARGETS_2026).map(([month, target]) => ({
        month,
        target: target.margin, // Use margin as target
      }))

      const targetVsActual = engine.calculateMonthlyTargetVsActual(targetArray)
      const totalRevenue = engine.calculateTotalRevenue()

      return {
        targetVsActual,
        monthlyTrend: totalRevenue.monthlyTrend,
        growthRateMoM: totalRevenue.growthRateMoM,
        growthRateYoY: totalRevenue.growthRateYoY,
      }
    },
    staleTime: 60 * 1000, // 1 minute
  })
}
