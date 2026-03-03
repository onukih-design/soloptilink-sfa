'use client'

import { useQuery } from '@tanstack/react-query'
import * as engine from '@/lib/calculations/revenue-engine-v2'
import { MONTHLY_TARGETS_2026 } from '@/lib/constants/kpi-targets'

/**
 * KPI統合サマリーフック
 *
 * 全ての主要メトリクスを1つのフックで取得する
 * ダッシュボード画面のメインフック
 */
export function useKPISummary() {
  return useQuery({
    queryKey: ['kpi-summary'],
    queryFn: async () => {
      // Calculate all metrics from engine
      const yomi = engine.calculateYomiSummary()
      const aiTools = engine.calculateAIToolRevenue()
      const outsourcing = engine.calculateOutsourcingRevenue()
      const totalRevenue = engine.calculateTotalRevenue()
      const funnel = engine.calculateFunnelMetrics()

      // Convert MONTHLY_TARGETS_2026 to array format
      const targetArray = Object.entries(MONTHLY_TARGETS_2026).map(([month, target]) => ({
        month,
        target: target.margin, // Use margin as target
      }))

      const targetVsActual = engine.calculateMonthlyTargetVsActual(targetArray)
      const overdue = engine.calculateOverdueActions()
      const closerPerf = engine.calculateCloserPerformance()
      const appointerPerf = engine.calculateAppointerPerformance()
      const listPerf = engine.calculateListPerformance()

      return {
        yomi,
        aiTools,
        outsourcing,
        totalRevenue,
        funnel,
        targetVsActual,
        overdue,
        closerPerf,
        appointerPerf,
        listPerf,
        lastUpdated: new Date().toISOString(),
      }
    },
    staleTime: 30 * 1000, // 30 seconds
    refetchInterval: 60 * 1000, // 1 minute
  })
}
