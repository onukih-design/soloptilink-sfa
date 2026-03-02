'use client'

import { useMemo } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import {
  useRevenueSummary,
  useAiToolOrders,
  useSalesOutsourcingOrders,
} from '@/hooks/use-orders'
import { formatCurrency, formatPercent, formatYearMonth } from '@/lib/utils/format'
import { PRODUCT_NAMES, type ProductKey } from '@/lib/constants/margins'
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
  PieChart,
  Pie,
  Cell,
  type PieLabelRenderProps,
} from 'recharts'
import { TrendingUp, DollarSign, PieChart as PieChartIcon, BarChart3 } from 'lucide-react'

const CHART_COLORS = [
  '#3B82F6',
  '#EF4444',
  '#F97316',
  '#EAB308',
  '#22C55E',
  '#8B5CF6',
  '#EC4899',
  '#06B6D4',
  '#84CC16',
  '#F59E0B',
  '#6366F1',
]

function getProductDisplayName(productKey: string): string {
  if (productKey in PRODUCT_NAMES) {
    return PRODUCT_NAMES[productKey as ProductKey]
  }
  return productKey || '不明'
}

interface TooltipPayloadEntry {
  dataKey: string
  value: number
  color: string
}

function CustomTooltip({
  active,
  payload,
  label,
}: {
  active?: boolean
  payload?: TooltipPayloadEntry[]
  label?: string
}) {
  if (active && payload && payload.length && label) {
    return (
      <div className="rounded-lg border bg-background p-3 shadow-sm">
        <p className="font-medium text-sm mb-1">{formatYearMonth(label)}</p>
        {payload.map((p, i) => (
          <p key={i} className="text-sm" style={{ color: p.color }}>
            {p.dataKey}:{' '}
            {p.dataKey === '件数'
              ? `${p.value}件`
              : formatCurrency(p.value)}
          </p>
        ))}
      </div>
    )
  }
  return null
}

export default function RevenuePage() {
  const { data: revenueSummary, isLoading } = useRevenueSummary(12)
  const { data: aiOrders } = useAiToolOrders()
  const { data: outsourcingOrders } = useSalesOutsourcingOrders()

  // 現在の契約中オーダーの集計
  const activeAiOrders = useMemo(
    () => (aiOrders || []).filter((o) => o.status === '契約中' || !o.status),
    [aiOrders]
  )
  const activeOutOrders = useMemo(
    () =>
      (outsourcingOrders || []).filter(
        (o) => o.status === '契約中' || !o.status
      ),
    [outsourcingOrders]
  )

  const totalMRR = useMemo(
    () =>
      activeAiOrders.reduce((s, o) => s + (o.monthly_fee || 0), 0) +
      activeOutOrders.reduce((s, o) => s + (o.monthly_fee || 0), 0),
    [activeAiOrders, activeOutOrders]
  )
  const totalMargin = useMemo(
    () =>
      activeAiOrders.reduce((s, o) => s + (o.monthly_margin || 0), 0) +
      activeOutOrders.reduce((s, o) => s + (o.monthly_commission || 0), 0),
    [activeAiOrders, activeOutOrders]
  )
  const marginRate = totalMRR > 0 ? totalMargin / totalMRR : 0

  // MRR推移データ
  const trendData = useMemo(
    () =>
      (revenueSummary || []).map((s) => ({
        month: s.yearMonth,
        displayMonth: s.yearMonth.substring(5) + '月',
        売上: s.totalMonthlyFee,
        粗利: s.totalMarginAmount,
        件数: s.activeCount,
      })),
    [revenueSummary]
  )

  // 商品別円グラフデータ
  const pieData = useMemo(() => {
    const productBreakdown = new Map<string, number>()
    for (const order of activeAiOrders) {
      const product = order.product || 'unknown'
      const name = getProductDisplayName(product)
      productBreakdown.set(
        name,
        (productBreakdown.get(name) || 0) + (order.monthly_fee || 0)
      )
    }
    return Array.from(productBreakdown.entries())
      .map(([name, value]) => ({ name, value }))
      .sort((a, b) => b.value - a.value)
  }, [activeAiOrders])

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="h-8 w-48 bg-muted animate-pulse rounded" />
        <div className="grid gap-4 md:grid-cols-4">
          {Array.from({ length: 4 }).map((_, i) => (
            <div key={i} className="h-24 bg-muted animate-pulse rounded-lg" />
          ))}
        </div>
        <div className="h-[400px] bg-muted animate-pulse rounded-lg" />
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">売上ダッシュボード</h1>
        <p className="text-muted-foreground text-sm">
          月次売上・粗利の推移と商品別内訳を確認します
        </p>
      </div>

      {/* KPIカード */}
      <div className="grid gap-4 md:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              MRR（月額売上）
            </CardTitle>
            <DollarSign className="h-4 w-4 text-blue-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(totalMRR)}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              月額粗利
            </CardTitle>
            <TrendingUp className="h-4 w-4 text-green-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {formatCurrency(totalMargin)}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              粗利率
            </CardTitle>
            <PieChartIcon className="h-4 w-4 text-purple-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {formatPercent(marginRate, true)}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              契約中件数
            </CardTitle>
            <BarChart3 className="h-4 w-4 text-orange-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {activeAiOrders.length + activeOutOrders.length}件
            </div>
          </CardContent>
        </Card>
      </div>

      {/* チャート */}
      <Tabs defaultValue="trend">
        <TabsList>
          <TabsTrigger value="trend">売上推移</TabsTrigger>
          <TabsTrigger value="breakdown">商品別内訳</TabsTrigger>
        </TabsList>

        <TabsContent value="trend">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">
                月次売上・粗利推移（過去12ヶ月）
              </CardTitle>
            </CardHeader>
            <CardContent>
              {trendData.length === 0 ? (
                <div className="h-[350px] flex items-center justify-center text-muted-foreground">
                  売上データがありません
                </div>
              ) : (
                <ResponsiveContainer width="100%" height={350}>
                  <LineChart
                    data={trendData}
                    margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                  >
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="displayMonth" tick={{ fontSize: 12 }} />
                    <YAxis
                      tickFormatter={(v: number) =>
                        `¥${Math.floor(v / 10000)}万`
                      }
                      tick={{ fontSize: 12 }}
                    />
                    <Tooltip content={<CustomTooltip />} />
                    <Legend />
                    <Line
                      type="monotone"
                      dataKey="売上"
                      stroke="#3B82F6"
                      strokeWidth={2}
                      dot={{ r: 4 }}
                    />
                    <Line
                      type="monotone"
                      dataKey="粗利"
                      stroke="#22C55E"
                      strokeWidth={2}
                      dot={{ r: 4 }}
                    />
                  </LineChart>
                </ResponsiveContainer>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="breakdown">
          <div className="grid gap-6 lg:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle className="text-base">商品別月額売上</CardTitle>
              </CardHeader>
              <CardContent>
                {pieData.length === 0 ? (
                  <div className="h-[300px] flex items-center justify-center text-muted-foreground">
                    データがありません
                  </div>
                ) : (
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={pieData}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={(props: PieLabelRenderProps) => {
                          const name = String(props.name || '')
                          const percent = Number(props.percent || 0)
                          return `${name} ${Math.floor(percent * 100)}%`
                        }}
                        outerRadius={100}
                        fill="#8884d8"
                        dataKey="value"
                      >
                        {pieData.map((_, index) => (
                          <Cell
                            key={`cell-${index}`}
                            fill={CHART_COLORS[index % CHART_COLORS.length]}
                          />
                        ))}
                      </Pie>
                      <Tooltip
                        formatter={(value: unknown) => formatCurrency(value as number)}
                      />
                    </PieChart>
                  </ResponsiveContainer>
                )}
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">商品別詳細</CardTitle>
              </CardHeader>
              <CardContent>
                {pieData.length === 0 ? (
                  <p className="text-sm text-muted-foreground text-center py-6">
                    データがありません
                  </p>
                ) : (
                  <div className="space-y-3">
                    {pieData.map((item, i) => (
                      <div
                        key={item.name}
                        className="flex items-center justify-between"
                      >
                        <div className="flex items-center gap-2">
                          <div
                            className="w-3 h-3 rounded-full"
                            style={{
                              backgroundColor:
                                CHART_COLORS[i % CHART_COLORS.length],
                            }}
                          />
                          <span className="text-sm">{item.name}</span>
                        </div>
                        <span className="text-sm font-mono font-medium">
                          {formatCurrency(item.value)}
                        </span>
                      </div>
                    ))}
                    <div className="border-t pt-2 flex items-center justify-between">
                      <span className="text-sm font-medium">合計</span>
                      <span className="text-sm font-mono font-bold">
                        {formatCurrency(
                          pieData.reduce((s, p) => s + p.value, 0)
                        )}
                      </span>
                    </div>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </TabsContent>
      </Tabs>
    </div>
  )
}
