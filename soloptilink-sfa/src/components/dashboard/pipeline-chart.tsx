'use client'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Cell,
} from 'recharts'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import { formatCurrency } from '@/lib/utils/format'
import type { DashboardSummary } from '@/hooks/use-dashboard'

type Props = {
  data: DashboardSummary['pipelineByYomi']
}

/** パイプライン表示で使うヨミステータスの順序（失注・消滅は除外） */
const yomiOrder = ['受注', 'Aヨミ', 'Bヨミ', 'Cヨミ', 'ネタ', '没ネタ']

/**
 * パイプラインチャート（横棒グラフ）
 * ヨミステータス別の件数を表示し、ツールチップで金額も確認可能
 */
export function PipelineChart({ data }: Props) {
  const chartData = yomiOrder.map((status) => {
    const found = data.find((d) => d.yomiStatus === status)
    const config = YOMI_STATUSES.find((y) => y.name === status)
    return {
      name: status,
      件数: found?.count || 0,
      金額: found?.totalAmount || 0,
      加重金額: found?.weightedAmount || 0,
      color: config?.color || '#9CA3AF',
    }
  })

  const CustomTooltip = ({ active, payload, label }: {
    active?: boolean
    payload?: Array<{ value?: number }>
    label?: string
  }) => {
    if (active && payload && payload.length) {
      const item = chartData.find((d) => d.name === label)
      return (
        <div className="rounded-lg border bg-background p-3 shadow-sm">
          <p className="font-medium">{label}</p>
          <p className="text-sm text-muted-foreground">
            件数: {payload[0]?.value}件
          </p>
          <p className="text-sm text-muted-foreground">
            金額: {formatCurrency(item?.金額 || 0)}
          </p>
          <p className="text-sm text-muted-foreground">
            加重金額: {formatCurrency(item?.加重金額 || 0)}
          </p>
        </div>
      )
    }
    return null
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">パイプライン（ヨミ別）</CardTitle>
      </CardHeader>
      <CardContent>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart
            data={chartData}
            layout="vertical"
            margin={{ top: 0, right: 30, left: 40, bottom: 0 }}
          >
            <CartesianGrid strokeDasharray="3 3" horizontal={false} />
            <XAxis type="number" />
            <YAxis
              dataKey="name"
              type="category"
              width={60}
              tick={{ fontSize: 12 }}
            />
            <Tooltip content={<CustomTooltip />} />
            <Bar dataKey="件数" radius={[0, 4, 4, 0]} maxBarSize={32}>
              {chartData.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={entry.color} />
              ))}
            </Bar>
          </BarChart>
        </ResponsiveContainer>
      </CardContent>
    </Card>
  )
}
