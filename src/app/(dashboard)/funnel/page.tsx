'use client'

import { useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
} from '@/components/ui/sheet'
import { DealLink } from '@/components/ui/deal-link'
import { useKPISummary } from '@/hooks/use-kpi-summary'
import { formatCurrency, formatPercent } from '@/lib/utils/format'
import { YOMI_COLORS } from '@/lib/constants/yomi'
import { getDealsByFunnelStage } from '@/lib/calculations/revenue-engine-v2'
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts'
import {
  TrendingUp,
  Filter,
  Users,
  Clock,
  DollarSign,
  Target,
  AlertCircle,
  ArrowRight,
} from 'lucide-react'

type FunnelStage = 'leads' | 'appointments' | 'negotiations' | 'won'

export default function FunnelPage() {
  const { data, isLoading, error } = useKPISummary()
  const [selectedStage, setSelectedStage] = useState<FunnelStage | null>(null)
  const [sheetOpen, setSheetOpen] = useState(false)

  const handleStageClick = (stage: FunnelStage) => {
    setSelectedStage(stage)
    setSheetOpen(true)
  }

  if (isLoading || !data) {
    return <FunnelPageSkeleton />
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-center">
          <AlertCircle className="h-12 w-12 text-destructive mx-auto mb-4" />
          <p className="text-destructive font-medium">データの取得に失敗しました</p>
          <p className="text-sm text-muted-foreground mt-1">
            ページを再読み込みしてください
          </p>
        </div>
      </div>
    )
  }

  const { funnel, yomi, closerPerf, appointerPerf } = data

  // Calculate key metrics
  const totalLeads = funnel.totalLeads
  const appointments = funnel.appointments
  const negotiations = funnel.negotiations
  const wonDeals = funnel.wonDeals
  const overallConversion = funnel.conversionRates.leadToWon
  const avgCycleDays = funnel.avgDealCycleDays
  const hotPipelineCount = yomi.hot.count
  const hotPipelineValue = yomi.hot.weightedAmount
  const coldPipelineCount = yomi.cold.count
  const coldPipelineValue = yomi.cold.weightedAmount

  // Prepare funnel stages data
  // conversionRate = percentage of total leads that reach this stage (全体比率)
  // stageRate = conversion from previous stage to this stage (前段階比)
  const funnelStages = [
    {
      name: 'リード',
      stage: 'leads' as FunnelStage,
      count: totalLeads,
      conversionRate: 100,
      stageRate: 100,
      dropOffRate: 0,
      avgValue: 0,
      width: 100,
      color: 'from-blue-500 to-blue-600',
    },
    {
      name: 'アポイント',
      stage: 'appointments' as FunnelStage,
      count: appointments,
      conversionRate: funnel.conversionRates.leadToAppointment,
      stageRate: funnel.conversionRates.leadToAppointment,
      dropOffRate: ((totalLeads - appointments) / Math.max(totalLeads, 1)) * 100,
      avgValue: 0,
      width: 75,
      color: 'from-teal-500 to-teal-600',
    },
    {
      name: '商談中',
      stage: 'negotiations' as FunnelStage,
      count: negotiations,
      conversionRate: totalLeads > 0 ? (negotiations / totalLeads) * 100 : 0,
      stageRate: funnel.conversionRates.appointmentToNegotiation,
      dropOffRate: ((appointments - negotiations) / Math.max(appointments, 1)) * 100,
      avgValue: 0,
      width: 50,
      color: 'from-green-500 to-green-600',
    },
    {
      name: '受注',
      stage: 'won' as FunnelStage,
      count: wonDeals,
      conversionRate: funnel.conversionRates.leadToWon,
      stageRate: funnel.conversionRates.negotiationToWon,
      dropOffRate: ((negotiations - wonDeals) / Math.max(negotiations, 1)) * 100,
      avgValue: wonDeals > 0 ? closerPerf.reduce((sum, c) => sum + c.totalRevenue, 0) / wonDeals : 0,
      width: 25,
      color: 'from-emerald-500 to-emerald-600',
    },
  ]

  // Prepare yomi distribution data
  const yomiDistData = yomi.byStatus
    .filter(s => s.count > 0)
    .map(s => ({
      status: s.status,
      count: s.count,
      amount: s.totalAmount,
      weighted: s.weightedAmount,
      percentage: (s.count / yomi.totals.count) * 100,
      color: YOMI_COLORS[s.status] || '#888',
    }))

  // Prepare closer funnel data
  const closerFunnelData = closerPerf
    .map(c => ({
      name: c.closerName,
      entered: c.dealCount,
      won: c.winCount,
      rate: c.winRate,
    }))
    .sort((a, b) => b.rate - a.rate)
    .slice(0, 10)

  // Prepare appointer funnel data
  const appointerFunnelData = appointerPerf
    .map(a => ({
      name: a.appointerName,
      appointments: a.appointmentsSet,
      rate: a.conversionRate,
    }))
    .sort((a, b) => b.rate - a.rate)
    .slice(0, 10)

  return (
    <div className="space-y-6 pb-8">
      {/* Header */}
      <div className="bg-gradient-to-r from-purple-600 to-pink-600 -mx-6 -mt-6 px-6 py-8 text-white">
        <h1 className="text-3xl font-bold tracking-tight">ファネル分析</h1>
        <p className="text-purple-100 mt-2">リード → アポ → 商談 → 受注の変換プロセス分析</p>
        <p className="text-xs text-purple-200 mt-1">最終更新: {new Date(data.lastUpdated).toLocaleString('ja-JP')}</p>
      </div>

      {/* Top Row: Key Funnel Metrics */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card className="border-l-4 border-l-emerald-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              総合転換率
            </CardTitle>
            <Target className="h-5 w-5 text-emerald-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatPercent(overallConversion, false, 1)}</div>
            <div className="flex items-center gap-2 mt-2">
              <Badge variant={overallConversion >= 15 ? 'default' : 'outline'} className="text-xs">
                リード → 受注
              </Badge>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              {totalLeads}件 → {wonDeals}件
            </p>
          </CardContent>
        </Card>

        <Card className="border-l-4 border-l-blue-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              平均案件期間
            </CardTitle>
            <Clock className="h-5 w-5 text-blue-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{avgCycleDays.toFixed(0)}日</div>
            <div className="flex items-center gap-2 mt-2">
              <Badge variant="outline" className="text-xs">
                商談サイクル
              </Badge>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              初回接触から受注まで
            </p>
          </CardContent>
        </Card>

        <Card className="border-l-4 border-l-red-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Hotパイプライン
            </CardTitle>
            <TrendingUp className="h-5 w-5 text-red-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{hotPipelineCount}件</div>
            <div className="flex items-center gap-2 mt-2">
              <span className="text-xs font-medium text-red-600">
                {formatCurrency(hotPipelineValue)}
              </span>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              受注・A・Bヨミ合計
            </p>
          </CardContent>
        </Card>

        <Card className="border-l-4 border-l-indigo-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Coldパイプライン
            </CardTitle>
            <Filter className="h-5 w-5 text-indigo-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{coldPipelineCount}件</div>
            <div className="flex items-center gap-2 mt-2">
              <span className="text-xs font-medium text-indigo-600">
                {formatCurrency(coldPipelineValue)}
              </span>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              C・ネタ・没ネタ合計
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Second Row: Visual Funnel */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">セールスファネル（ビジュアル）</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="py-8">
            {funnelStages.map((stage, index) => (
              <div key={stage.name} className="mb-8 last:mb-0">
                {/* Stage Bar */}
                <div className="flex items-center gap-4">
                  <div className="w-24 text-right">
                    <div className="text-sm font-medium">{stage.name}</div>
                  </div>
                  <div className="flex-1">
                    <div
                      className={`relative h-16 bg-gradient-to-r ${stage.color} rounded-lg shadow-md flex items-center justify-between px-6 text-white transition-all duration-300 hover:shadow-lg cursor-pointer`}
                      style={{ width: `${stage.width}%`, minWidth: '200px' }}
                      onClick={() => handleStageClick(stage.stage)}
                      role="button"
                      tabIndex={0}
                      onKeyDown={(e) => {
                        if (e.key === 'Enter' || e.key === ' ') {
                          handleStageClick(stage.stage)
                        }
                      }}
                    >
                      <div className="flex flex-col">
                        <span className="text-2xl font-bold">{stage.count}</span>
                        <span className="text-xs opacity-90">件数</span>
                      </div>
                      <div className="flex flex-col items-end">
                        <span className="text-lg font-bold">{stage.stageRate.toFixed(1)}%</span>
                        <span className="text-xs opacity-90">転換率</span>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Conversion Arrow and Stats */}
                {index < funnelStages.length - 1 && (
                  <div className="flex items-center gap-4 mt-2 mb-2">
                    <div className="w-24"></div>
                    <div className="flex items-center gap-3 text-xs text-muted-foreground ml-6">
                      <ArrowRight className="h-4 w-4" />
                      <span>
                        離脱率: <span className="font-medium text-orange-600">{stage.dropOffRate.toFixed(1)}%</span>
                      </span>
                      {stage.avgValue > 0 && (
                        <>
                          <span>|</span>
                          <span>
                            平均単価: <span className="font-medium">{formatCurrency(stage.avgValue)}</span>
                          </span>
                        </>
                      )}
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Third Row: Stage Detail Cards */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {funnelStages.map((stage, index) => {
          const nextStage = index < funnelStages.length - 1 ? funnelStages[index + 1] : null
          const conversionToNext = nextStage
            ? (nextStage.count / Math.max(stage.count, 1)) * 100
            : 0

          return (
            <Card
              key={stage.name}
              className="cursor-pointer hover:shadow-md transition-shadow"
              onClick={() => handleStageClick(stage.stage)}
            >
              <CardHeader className="pb-3">
                <CardTitle className="text-sm font-medium">{stage.name}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2">
                <div className="flex justify-between items-center">
                  <span className="text-xs text-muted-foreground">件数</span>
                  <span className="text-lg font-bold">{stage.count}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-xs text-muted-foreground">全体比率</span>
                  <span className="text-sm font-medium">{stage.conversionRate.toFixed(1)}%</span>
                </div>
                {index > 0 && (
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-muted-foreground">前段階比</span>
                    <span className="text-sm font-medium">
                      {stage.stageRate.toFixed(1)}%
                    </span>
                  </div>
                )}
                {nextStage && (
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-muted-foreground">次段階率</span>
                    <Badge variant={conversionToNext >= 50 ? 'default' : 'outline'} className="text-xs">
                      {conversionToNext.toFixed(1)}%
                    </Badge>
                  </div>
                )}
                {stage.avgValue > 0 && (
                  <div className="flex justify-between items-center pt-2 border-t">
                    <span className="text-xs text-muted-foreground">平均単価</span>
                    <span className="text-sm font-bold">{formatCurrency(stage.avgValue)}</span>
                  </div>
                )}
              </CardContent>
            </Card>
          )
        })}
      </div>

      {/* Fourth Row: Yomi Distribution */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">ヨミステータス分布（全案件）</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {/* Stacked Bar */}
            <div className="h-16 flex rounded-lg overflow-hidden shadow-sm">
              {yomiDistData.map((s) => (
                <div
                  key={s.status}
                  style={{
                    width: `${s.percentage}%`,
                    backgroundColor: s.color,
                  }}
                  className="flex items-center justify-center text-white text-xs font-medium px-2 hover:opacity-90 transition-opacity cursor-pointer"
                  title={`${s.status}: ${s.count}件 (${s.percentage.toFixed(1)}%)`}
                >
                  {s.percentage > 5 && (
                    <span className="truncate">
                      {s.status} {s.percentage.toFixed(0)}%
                    </span>
                  )}
                </div>
              ))}
            </div>

            {/* Legend */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
              {yomiDistData.map(s => (
                <div key={s.status} className="flex items-center gap-2 p-2 border rounded-lg">
                  <div
                    className="w-4 h-4 rounded"
                    style={{ backgroundColor: s.color }}
                  />
                  <div className="flex-1 min-w-0">
                    <div className="text-xs font-medium truncate">{s.status}</div>
                    <div className="text-xs text-muted-foreground">
                      {s.count}件 ({s.percentage.toFixed(1)}%)
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Fifth Row: Team Funnel Performance */}
      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">クローザー転換率ランキング</CardTitle>
            <Users className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={320}>
              <BarChart data={closerFunnelData} layout="vertical" margin={{ top: 5, right: 30, left: 100, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" domain={[0, 100]} tickFormatter={(v) => `${v}%`} tick={{ fontSize: 11 }} />
                <YAxis type="category" dataKey="name" tick={{ fontSize: 11 }} width={90} />
                <Tooltip
                  content={({ active, payload }) => {
                    if (active && payload && payload.length > 0) {
                      const data = payload[0].payload
                      return (
                        <div className="bg-white p-3 border rounded-lg shadow-lg">
                          <p className="font-medium">{data.name}</p>
                          <p className="text-sm">案件数: {data.entered}件</p>
                          <p className="text-sm">受注数: {data.won}件</p>
                          <p className="text-sm font-medium text-primary">成約率: {data.rate.toFixed(1)}%</p>
                        </div>
                      )
                    }
                    return null
                  }}
                />
                <Legend />
                <Bar dataKey="rate" name="成約率" fill="#3B82F6" radius={[0, 4, 4, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">アポインター転換率ランキング</CardTitle>
            <DollarSign className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={320}>
              <BarChart data={appointerFunnelData} layout="vertical" margin={{ top: 5, right: 30, left: 100, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" domain={[0, 100]} tickFormatter={(v) => `${v}%`} tick={{ fontSize: 11 }} />
                <YAxis type="category" dataKey="name" tick={{ fontSize: 11 }} width={90} />
                <Tooltip
                  content={({ active, payload }) => {
                    if (active && payload && payload.length > 0) {
                      const data = payload[0].payload
                      return (
                        <div className="bg-white p-3 border rounded-lg shadow-lg">
                          <p className="font-medium">{data.name}</p>
                          <p className="text-sm">アポ数: {data.appointments}件</p>
                          <p className="text-sm font-medium text-primary">案件化率: {data.rate.toFixed(1)}%</p>
                        </div>
                      )
                    }
                    return null
                  }}
                />
                <Legend />
                <Bar dataKey="rate" name="案件化率" fill="#22C55E" radius={[0, 4, 4, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      {/* Sixth Row: Pipeline Health Table */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">パイプライン健全性分析</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-auto">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>ステータス</TableHead>
                  <TableHead className="text-right">案件数</TableHead>
                  <TableHead className="text-right">総額</TableHead>
                  <TableHead className="text-right">加重額</TableHead>
                  <TableHead className="text-right">平均単価</TableHead>
                  <TableHead className="text-right">受注率</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {yomiDistData.map(s => {
                  const avgDealSize = s.count > 0 ? s.amount / s.count : 0
                  const rate = s.weighted / Math.max(s.amount, 1)
                  return (
                    <TableRow key={s.status}>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div
                            className="w-3 h-3 rounded"
                            style={{ backgroundColor: s.color }}
                          />
                          <span className="font-medium">{s.status}</span>
                        </div>
                      </TableCell>
                      <TableCell className="text-right">{s.count}</TableCell>
                      <TableCell className="text-right font-mono text-sm">
                        {formatCurrency(s.amount)}
                      </TableCell>
                      <TableCell className="text-right font-mono text-sm font-medium">
                        {formatCurrency(s.weighted)}
                      </TableCell>
                      <TableCell className="text-right font-mono text-sm">
                        {formatCurrency(avgDealSize)}
                      </TableCell>
                      <TableCell className="text-right">
                        <Badge
                          variant={rate >= 0.8 ? 'default' : rate >= 0.5 ? 'outline' : 'secondary'}
                          className="text-xs"
                        >
                          {formatPercent(rate, true, 0)}
                        </Badge>
                      </TableCell>
                    </TableRow>
                  )
                })}
                <TableRow className="font-bold bg-muted/50">
                  <TableCell>合計</TableCell>
                  <TableCell className="text-right">{yomi.totals.count}</TableCell>
                  <TableCell className="text-right font-mono">
                    {formatCurrency(yomi.totals.totalAmount)}
                  </TableCell>
                  <TableCell className="text-right font-mono">
                    {formatCurrency(yomi.totals.weightedAmount)}
                  </TableCell>
                  <TableCell className="text-right font-mono">
                    {formatCurrency(yomi.totals.count > 0 ? yomi.totals.totalAmount / yomi.totals.count : 0)}
                  </TableCell>
                  <TableCell className="text-right">
                    <Badge variant="default" className="text-xs">
                      {formatPercent(yomi.totals.count > 0 ? yomi.totals.weightedAmount / yomi.totals.totalAmount : 0, true, 0)}
                    </Badge>
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </div>
        </CardContent>
      </Card>

      {/* Drill-down Sheet */}
      <Sheet open={sheetOpen} onOpenChange={setSheetOpen}>
        <SheetContent className="sm:max-w-2xl overflow-y-auto">
          <SheetHeader>
            <SheetTitle>
              {selectedStage === 'leads' && 'リード一覧'}
              {selectedStage === 'appointments' && 'アポイント一覧'}
              {selectedStage === 'negotiations' && '商談中一覧'}
              {selectedStage === 'won' && '受注一覧'}
            </SheetTitle>
            <SheetDescription>
              {selectedStage && `${getDealsByFunnelStage(selectedStage).length}件の案件`}
            </SheetDescription>
          </SheetHeader>
          <div className="mt-6">
            {selectedStage && (
              <div className="space-y-3">
                {getDealsByFunnelStage(selectedStage).map((deal) => (
                  <Card key={deal.id} className="p-4">
                    <div className="flex items-start justify-between gap-4">
                      <div className="flex-1 min-w-0">
                        <DealLink
                          dealId={deal.id}
                          dealName={deal.deal_name}
                          className="font-medium text-base"
                        />
                        <div className="mt-2 space-y-1">
                          <div className="flex items-center gap-2 text-sm">
                            <Badge
                              variant="outline"
                              style={{
                                backgroundColor: YOMI_COLORS[deal.yomi_status as keyof typeof YOMI_COLORS] || '#888',
                                color: 'white',
                                borderColor: YOMI_COLORS[deal.yomi_status as keyof typeof YOMI_COLORS] || '#888',
                              }}
                            >
                              {deal.yomi_status}
                            </Badge>
                            <span className="text-muted-foreground">
                              {formatCurrency(deal.amount)}
                            </span>
                          </div>
                          <p className="text-xs text-muted-foreground">
                            作成日: {new Date(deal.created_at).toLocaleDateString('ja-JP')}
                          </p>
                        </div>
                      </div>
                    </div>
                  </Card>
                ))}
              </div>
            )}
          </div>
        </SheetContent>
      </Sheet>
    </div>
  )
}

function FunnelPageSkeleton() {
  return (
    <div className="space-y-6 pb-8">
      <div className="bg-gradient-to-r from-purple-600 to-pink-600 -mx-6 -mt-6 px-6 py-8">
        <div className="h-8 w-64 bg-purple-500/50 animate-pulse rounded" />
        <div className="h-4 w-96 bg-purple-500/30 animate-pulse rounded mt-2" />
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-4 w-24 bg-muted animate-pulse rounded" />
            <div className="h-8 w-32 bg-muted animate-pulse rounded mt-3" />
            <div className="h-3 w-20 bg-muted animate-pulse rounded mt-2" />
          </div>
        ))}
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[400px] bg-muted animate-pulse rounded" />
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-4 w-20 bg-muted animate-pulse rounded" />
            <div className="h-6 w-16 bg-muted animate-pulse rounded mt-2" />
          </div>
        ))}
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[200px] bg-muted animate-pulse rounded" />
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        {Array.from({ length: 2 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-[320px] bg-muted animate-pulse rounded" />
          </div>
        ))}
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[300px] bg-muted animate-pulse rounded" />
      </div>
    </div>
  )
}
