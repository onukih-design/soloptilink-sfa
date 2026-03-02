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
  Legend,
  ReferenceLine,
} from 'recharts'
import { formatCurrency } from '@/lib/utils/format'

type MonthlyData = {
  month: string
  displayMonth: string
  shotRevenue: number
  stockRevenue: number
  target: number
}

type Props = {
  data: MonthlyData[]
}

function CustomTooltip({
  active,
  payload,
  label,
}: {
  active?: boolean
  payload?: Array<{ dataKey: string; value: number; color: string }>
  label?: string
}) {
  if (active && payload && payload.length && label) {
    const total = payload.reduce((s, p) => s + (p.value || 0), 0)
    return (
      <div className="rounded-lg border bg-background p-3 shadow-sm">
        <p className="font-medium text-sm mb-1">{label}</p>
        {payload.map((p, i) => (
          <p key={i} className="text-sm" style={{ color: p.color }}>
            {p.dataKey}: {formatCurrency(p.value)}
          </p>
        ))}
        <p className="text-sm font-medium border-t pt-1 mt-1">
          合計: {formatCurrency(total)}
        </p>
      </div>
    )
  }
  return null
}

/**
 * 月次売上進捗チャート
 * ショット/ストック積み上げ棒グラフ + 目標ライン
 */
export function MonthlyProgressChart({ data }: Props) {
  const targetLine = data.length > 0 ? data[0].target : 0

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">月次売上進捗</CardTitle>
      </CardHeader>
      <CardContent>
        {data.length === 0 ? (
          <div className="h-[300px] flex items-center justify-center text-muted-foreground">
            データがありません
          </div>
        ) : (
          <ResponsiveContainer width="100%" height={300}>
            <BarChart
              data={data}
              margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
            >
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="displayMonth" tick={{ fontSize: 11 }} />
              <YAxis
                tickFormatter={(v: number) =>
                  `${Math.floor(v / 10000)}万`
                }
                tick={{ fontSize: 11 }}
              />
              <Tooltip content={<CustomTooltip />} />
              <Legend />
              {targetLine > 0 && (
                <ReferenceLine
                  y={targetLine}
                  label={{ value: '月次目標', fontSize: 10 }}
                  stroke="#EF4444"
                  strokeDasharray="5 5"
                />
              )}
              <Bar
                dataKey="stockRevenue"
                name="ストック粗利"
                stackId="revenue"
                fill="#3B82F6"
                radius={[0, 0, 0, 0]}
              />
              <Bar
                dataKey="shotRevenue"
                name="ショット粗利"
                stackId="revenue"
                fill="#F97316"
                radius={[4, 4, 0, 0]}
              />
            </BarChart>
          </ResponsiveContainer>
        )}
      </CardContent>
    </Card>
  )
}
