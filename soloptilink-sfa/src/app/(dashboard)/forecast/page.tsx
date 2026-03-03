'use client'

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
import { useForecast } from '@/hooks/use-forecast'
import { formatCurrency, formatPercent, formatYearMonth } from '@/lib/utils/format'
import { MONTHLY_TARGETS_2026, getQuarterMonths } from '@/lib/constants/kpi-targets'
import {
  ComposedChart,
  Bar,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  AreaChart,
  Area,
} from 'recharts'
import {
  TrendingUp,
  TrendingDown,
  Target,
  AlertCircle,
  CheckCircle,
  Calendar,
  DollarSign,
  Activity,
  Minus,
} from 'lucide-react'

const ACHIEVEMENT_COLORS = {
  excellent: 'bg-green-100 text-green-800 border-green-300',
  good: 'bg-blue-100 text-blue-800 border-blue-300',
  warning: 'bg-yellow-100 text-yellow-800 border-yellow-300',
  danger: 'bg-red-100 text-red-800 border-red-300',
}

function getAchievementStatus(rate: number): {
  color: string
  label: string
  icon: React.ReactNode
} {
  if (rate >= 100) {
    return {
      color: ACHIEVEMENT_COLORS.excellent,
      label: '達成',
      icon: <CheckCircle className="h-4 w-4" />,
    }
  } else if (rate >= 80) {
    return {
      color: ACHIEVEMENT_COLORS.good,
      label: '良好',
      icon: <TrendingUp className="h-4 w-4" />,
    }
  } else if (rate >= 60) {
    return {
      color: ACHIEVEMENT_COLORS.warning,
      label: '注意',
      icon: <AlertCircle className="h-4 w-4" />,
    }
  } else {
    return {
      color: ACHIEVEMENT_COLORS.danger,
      label: '要改善',
      icon: <TrendingDown className="h-4 w-4" />,
    }
  }
}

export default function ForecastPage() {
  const { data, isLoading, error } = useForecast()

  if (isLoading || !data) {
    return <ForecastPageSkeleton />
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

  const { targetVsActual, monthlyTrend, growthRateMoM, growthRateYoY } = data

  // Calculate cumulative values
  const cumulativeTarget = targetVsActual.monthly.reduce((sum, m) => sum + m.target, 0)
  const cumulativeActual = targetVsActual.monthly.reduce((sum, m) => sum + m.actual, 0)
  const cumulativeAchievement = cumulativeTarget > 0 ? (cumulativeActual / cumulativeTarget) * 100 : 0

  // Calculate year-end forecast
  const completedMonths = targetVsActual.monthly.filter(m => m.actual > 0).length
  const avgMonthlyActual = completedMonths > 0 ? cumulativeActual / completedMonths : 0
  const yearEndForecast = avgMonthlyActual * 12
  const yearEndTarget = Object.values(MONTHLY_TARGETS_2026).reduce((sum, t) => sum + t.margin, 0)
  const yearEndAchievementRate = yearEndTarget > 0 ? (yearEndForecast / yearEndTarget) * 100 : 0
  const onTrack = yearEndAchievementRate >= 80

  // Prepare chart data for monthly target vs actual
  const monthlyChartData = targetVsActual.monthly.map(m => ({
    month: m.month.slice(5), // MM only
    displayMonth: formatYearMonth(m.month),
    目標: m.target,
    実績: m.actual,
    達成率: m.achievementRate,
  }))

  // Calculate quarterly summary
  const quarters = [
    { quarter: 'Q1', months: getQuarterMonths('q1') },
    { quarter: 'Q2', months: getQuarterMonths('q2') },
    { quarter: 'Q3', months: getQuarterMonths('q3') },
    { quarter: 'Q4', months: getQuarterMonths('q4') },
  ]

  const quarterlySummary = quarters.map(({ quarter, months }) => {
    const quarterData = targetVsActual.monthly.filter(m => months.includes(m.month))
    const target = quarterData.reduce((sum, m) => sum + m.target, 0)
    const actual = quarterData.reduce((sum, m) => sum + m.actual, 0)
    const rate = target > 0 ? (actual / target) * 100 : 0
    return { quarter, target, actual, rate }
  })

  // Prepare revenue breakdown chart data
  const revenueBreakdownData = monthlyTrend.map(m => ({
    month: m.month.slice(5), // MM only
    displayMonth: formatYearMonth(m.month),
    AIツール: m.aiTools || 0,
    営業代行: m.outsourcing || 0,
    目標: MONTHLY_TARGETS_2026[m.month]?.margin || 0,
  }))

  // Overall achievement status
  const overallStatus = getAchievementStatus(cumulativeAchievement * 100)

  return (
    <div className="space-y-6 pb-8">
      {/* Header with gradient background */}
      <div className="bg-gradient-to-r from-indigo-600 to-purple-700 -mx-6 -mt-6 px-6 py-8 text-white">
        <h1 className="text-3xl font-bold tracking-tight">予実管理</h1>
        <p className="text-indigo-100 mt-2">2026年度 月次・四半期・年間の目標達成状況</p>
        <p className="text-xs text-indigo-200 mt-1">
          データ基準月: {new Date().toLocaleDateString('ja-JP', { year: 'numeric', month: 'long' })}
        </p>
      </div>

      {/* Top Row: 3 Big KPI Cards */}
      <div className="grid gap-4 md:grid-cols-3">
        {/* Card 1: Annual Achievement Rate */}
        <Card className="border-l-4 border-l-indigo-600">
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              年間達成率
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center justify-between mb-4">
              <div className="text-4xl font-bold">
                {formatPercent(cumulativeAchievement, false, 1)}
              </div>
              <div className={`flex items-center gap-1 px-3 py-1 rounded-full border ${overallStatus.color}`}>
                {overallStatus.icon}
                <span className="text-xs font-medium">{overallStatus.label}</span>
              </div>
            </div>
            {/* Simple gauge visual */}
            <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
              <div
                className={`h-3 rounded-full transition-all ${
                  cumulativeAchievement >= 100 ? 'bg-green-600' :
                  cumulativeAchievement >= 80 ? 'bg-blue-600' :
                  cumulativeAchievement >= 60 ? 'bg-yellow-600' : 'bg-red-600'
                }`}
                style={{ width: `${Math.min(cumulativeAchievement, 100)}%` }}
              />
            </div>
            <p className="text-xs text-muted-foreground">
              実績 {formatCurrency(cumulativeActual)} / 目標 {formatCurrency(cumulativeTarget)}
            </p>
          </CardContent>
        </Card>

        {/* Card 2: Cumulative Actual vs Target */}
        <Card className="border-l-4 border-l-green-600">
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              年間累計売上
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-2 mb-4">
              <DollarSign className="h-5 w-5 text-green-600" />
              <div className="text-4xl font-bold">{formatCurrency(cumulativeActual)}</div>
            </div>
            {/* Progress bar */}
            <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
              <div
                className="h-3 rounded-full bg-green-600 transition-all"
                style={{ width: `${Math.min(cumulativeAchievement, 100)}%` }}
              />
            </div>
            <div className="flex items-center justify-between text-xs text-muted-foreground">
              <span>目標: {formatCurrency(cumulativeTarget)}</span>
              <span className={cumulativeAchievement >= 80 ? 'text-green-600 font-medium' : 'text-yellow-600 font-medium'}>
                {cumulativeAchievement >= 100 ? '+' : ''}{formatCurrency(cumulativeActual - cumulativeTarget)}
              </span>
            </div>
          </CardContent>
        </Card>

        {/* Card 3: Year-End Forecast */}
        <Card className="border-l-4 border-l-purple-600">
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              年末予測
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-2 mb-4">
              <Activity className="h-5 w-5 text-purple-600" />
              <div className="text-4xl font-bold">{formatCurrency(yearEndForecast)}</div>
            </div>
            <div className="flex items-center gap-2 mb-2">
              <Badge variant={onTrack ? 'default' : 'destructive'} className="text-xs">
                {onTrack ? (
                  <><CheckCircle className="h-3 w-3 mr-1" /> On Track</>
                ) : (
                  <><AlertCircle className="h-3 w-3 mr-1" /> Off Track</>
                )}
              </Badge>
              <span className="text-xs text-muted-foreground">
                予測達成率: {formatPercent(yearEndAchievementRate, false, 1)}
              </span>
            </div>
            <p className="text-xs text-muted-foreground">
              年間目標: {formatCurrency(yearEndTarget)}
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Second Row: Monthly Target vs Actual Chart */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">月次目標 vs 実績推移</CardTitle>
        </CardHeader>
        <CardContent>
          <ResponsiveContainer width="100%" height={350}>
            <ComposedChart data={monthlyChartData} margin={{ top: 20, right: 30, left: 20, bottom: 5 }}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="month" tick={{ fontSize: 11 }} />
              <YAxis tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 11 }} />
              <Tooltip
                formatter={(v) => formatCurrency(v as number)}
                labelFormatter={(label) => {
                  const data = monthlyChartData.find(d => d.month === label)
                  return data?.displayMonth || label
                }}
              />
              <Legend />
              <Bar dataKey="実績" fill="#3B82F6" radius={[4, 4, 0, 0]} />
              <Line
                type="monotone"
                dataKey="目標"
                stroke="#94A3B8"
                strokeWidth={2}
                strokeDasharray="5 5"
                dot={{ r: 4 }}
              />
            </ComposedChart>
          </ResponsiveContainer>
        </CardContent>
      </Card>

      {/* Third Row: Quarterly Summary + Growth Metrics */}
      <div className="grid gap-6 lg:grid-cols-2">
        {/* Quarterly Summary */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">四半期別サマリー</CardTitle>
            <Calendar className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 gap-3">
              {quarterlySummary.map(q => {
                const status = getAchievementStatus(q.rate * 100)
                return (
                  <div key={q.quarter} className="p-4 border rounded-lg hover:shadow-md transition-shadow">
                    <div className="flex items-center justify-between mb-2">
                      <h3 className="font-bold text-lg">{q.quarter}</h3>
                      <Badge variant="outline" className={`text-xs ${status.color}`}>
                        {formatPercent(q.rate, false, 1)}
                      </Badge>
                    </div>
                    <div className="space-y-1 text-sm">
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">目標</span>
                        <span className="font-mono">{formatCurrency(q.target)}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-muted-foreground">実績</span>
                        <span className="font-mono font-medium">{formatCurrency(q.actual)}</span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-2 mt-2">
                        <div
                          className={`h-2 rounded-full transition-all ${
                            q.rate >= 100 ? 'bg-green-600' :
                            q.rate >= 80 ? 'bg-blue-600' :
                            q.rate >= 60 ? 'bg-yellow-600' : 'bg-red-600'
                          }`}
                          style={{ width: `${Math.min(q.rate, 100)}%` }}
                        />
                      </div>
                    </div>
                  </div>
                )
              })}
            </div>
          </CardContent>
        </Card>

        {/* Growth Metrics */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">成長指標</CardTitle>
            <Activity className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 gap-4">
              {/* MoM Growth */}
              <div className="p-4 border rounded-lg bg-muted/30">
                <div className="flex items-center gap-2 mb-2">
                  {growthRateMoM >= 0 ? (
                    <TrendingUp className="h-5 w-5 text-green-600" />
                  ) : (
                    <TrendingDown className="h-5 w-5 text-red-600" />
                  )}
                  <span className="text-xs text-muted-foreground">前月比成長率</span>
                </div>
                <div className={`text-2xl font-bold ${growthRateMoM >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                  {growthRateMoM >= 0 ? '+' : ''}{Math.abs(growthRateMoM) > 999 ? (growthRateMoM >= 0 ? '>999%' : '<-999%') : formatPercent(growthRateMoM, false, 1)}
                </div>
                <p className="text-xs text-muted-foreground mt-1">MoM Growth</p>
              </div>

              {/* YoY Growth */}
              <div className="p-4 border rounded-lg bg-muted/30">
                <div className="flex items-center gap-2 mb-2">
                  {growthRateYoY >= 0 ? (
                    <TrendingUp className="h-5 w-5 text-blue-600" />
                  ) : (
                    <TrendingDown className="h-5 w-5 text-red-600" />
                  )}
                  <span className="text-xs text-muted-foreground">前年比成長率</span>
                </div>
                <div className={`text-2xl font-bold ${growthRateYoY >= 0 ? 'text-blue-600' : 'text-red-600'}`}>
                  {growthRateYoY >= 0 ? '+' : ''}{Math.abs(growthRateYoY) > 999 ? (growthRateYoY >= 0 ? '>999%' : '<-999%') : formatPercent(growthRateYoY, false, 1)}
                </div>
                <p className="text-xs text-muted-foreground mt-1">YoY Growth</p>
              </div>

              {/* Trend Direction */}
              <div className="p-4 border rounded-lg bg-muted/30">
                <div className="flex items-center gap-2 mb-2">
                  {growthRateMoM > 5 ? (
                    <TrendingUp className="h-5 w-5 text-green-600" />
                  ) : growthRateMoM < -5 ? (
                    <TrendingDown className="h-5 w-5 text-red-600" />
                  ) : (
                    <Minus className="h-5 w-5 text-gray-600" />
                  )}
                  <span className="text-xs text-muted-foreground">トレンド方向</span>
                </div>
                <div className="text-lg font-bold">
                  {growthRateMoM > 5 ? '上昇' : growthRateMoM < -5 ? '下降' : '横ばい'}
                </div>
                <p className="text-xs text-muted-foreground mt-1">
                  {growthRateMoM > 5 ? '順調に成長中' : growthRateMoM < -5 ? '要改善' : '安定推移'}
                </p>
              </div>

              {/* Avg Monthly Achievement */}
              <div className="p-4 border rounded-lg bg-muted/30">
                <div className="flex items-center gap-2 mb-2">
                  <Target className="h-5 w-5 text-purple-600" />
                  <span className="text-xs text-muted-foreground">平均達成率</span>
                </div>
                <div className={`text-2xl font-bold ${cumulativeAchievement >= 80 ? 'text-green-600' : 'text-yellow-600'}`}>
                  {formatPercent(cumulativeAchievement, false, 1)}
                </div>
                <p className="text-xs text-muted-foreground mt-1">累計期間平均</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Fourth Row: Monthly Detail Table */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">月次詳細実績</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-auto">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-28">月</TableHead>
                  <TableHead className="text-right">目標売上</TableHead>
                  <TableHead className="text-right">実績売上</TableHead>
                  <TableHead className="text-right">達成率</TableHead>
                  <TableHead className="text-right">差異</TableHead>
                  <TableHead className="text-center">評価</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {targetVsActual.monthly.map(m => {
                  const status = getAchievementStatus(m.achievementRate)
                  const diff = m.actual - m.target
                  return (
                    <TableRow key={m.month}>
                      <TableCell className="font-medium">{formatYearMonth(m.month)}</TableCell>
                      <TableCell className="text-right font-mono">{formatCurrency(m.target)}</TableCell>
                      <TableCell className="text-right font-mono font-medium">{formatCurrency(m.actual)}</TableCell>
                      <TableCell className="text-right">
                        <Badge variant={m.achievementRate >= 100 ? 'default' : m.achievementRate >= 80 ? 'outline' : 'destructive'} className="text-xs">
                          {formatPercent(m.achievementRate, false, 1)}
                        </Badge>
                      </TableCell>
                      <TableCell className={`text-right font-mono text-sm ${diff >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                        {diff >= 0 ? '+' : ''}{formatCurrency(diff)}
                      </TableCell>
                      <TableCell className="text-center">
                        <div className={`inline-flex items-center gap-1 px-2 py-1 rounded-full border text-xs ${status.color}`}>
                          {status.icon}
                          <span>{status.label}</span>
                        </div>
                      </TableCell>
                    </TableRow>
                  )
                })}
                {/* Totals Row */}
                <TableRow className="font-bold bg-muted/50">
                  <TableCell>合計</TableCell>
                  <TableCell className="text-right font-mono">{formatCurrency(cumulativeTarget)}</TableCell>
                  <TableCell className="text-right font-mono">{formatCurrency(cumulativeActual)}</TableCell>
                  <TableCell className="text-right">
                    <Badge variant={cumulativeAchievement >= 80 ? 'default' : 'destructive'} className="text-xs">
                      {formatPercent(cumulativeAchievement, false, 1)}
                    </Badge>
                  </TableCell>
                  <TableCell className={`text-right font-mono ${cumulativeActual >= cumulativeTarget ? 'text-green-600' : 'text-red-600'}`}>
                    {cumulativeActual >= cumulativeTarget ? '+' : ''}{formatCurrency(cumulativeActual - cumulativeTarget)}
                  </TableCell>
                  <TableCell className="text-center">
                    <div className={`inline-flex items-center gap-1 px-2 py-1 rounded-full border text-xs ${overallStatus.color}`}>
                      {overallStatus.icon}
                      <span>{overallStatus.label}</span>
                    </div>
                  </TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </div>
        </CardContent>
      </Card>

      {/* Fifth Row: Revenue Category Breakdown */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">売上カテゴリ別推移（AIツール vs 営業代行）</CardTitle>
        </CardHeader>
        <CardContent>
          <ResponsiveContainer width="100%" height={350}>
            <AreaChart data={revenueBreakdownData} margin={{ top: 10, right: 30, left: 20, bottom: 5 }}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="month" tick={{ fontSize: 11 }} />
              <YAxis tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 11 }} />
              <Tooltip
                formatter={(v) => formatCurrency(v as number)}
                labelFormatter={(label) => {
                  const data = revenueBreakdownData.find(d => d.month === label)
                  return data?.displayMonth || label
                }}
              />
              <Legend />
              <Area
                type="monotone"
                dataKey="AIツール"
                stackId="1"
                stroke="#3B82F6"
                fill="#3B82F6"
                fillOpacity={0.6}
              />
              <Area
                type="monotone"
                dataKey="営業代行"
                stackId="1"
                stroke="#22C55E"
                fill="#22C55E"
                fillOpacity={0.6}
              />
              <Line
                type="monotone"
                dataKey="目標"
                stroke="#EF4444"
                strokeWidth={2}
                strokeDasharray="5 5"
                dot={{ r: 3 }}
              />
            </AreaChart>
          </ResponsiveContainer>
          <div className="grid grid-cols-2 gap-4 mt-4 text-center">
            <div>
              <div className="text-xs text-muted-foreground">AIツール累計</div>
              <div className="text-lg font-bold text-blue-600">
                {formatCurrency(revenueBreakdownData.reduce((sum, m) => sum + m.AIツール, 0))}
              </div>
            </div>
            <div>
              <div className="text-xs text-muted-foreground">営業代行累計</div>
              <div className="text-lg font-bold text-green-600">
                {formatCurrency(revenueBreakdownData.reduce((sum, m) => sum + m.営業代行, 0))}
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}

function ForecastPageSkeleton() {
  return (
    <div className="space-y-6 pb-8">
      <div className="bg-gradient-to-r from-indigo-600 to-purple-700 -mx-6 -mt-6 px-6 py-8">
        <div className="h-8 w-64 bg-indigo-500/50 animate-pulse rounded" />
        <div className="h-4 w-96 bg-indigo-500/30 animate-pulse rounded mt-2" />
      </div>

      <div className="grid gap-4 md:grid-cols-3">
        {Array.from({ length: 3 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-4 w-24 bg-muted animate-pulse rounded" />
            <div className="h-10 w-32 bg-muted animate-pulse rounded mt-3" />
            <div className="h-3 w-full bg-muted animate-pulse rounded mt-2" />
            <div className="h-3 w-20 bg-muted animate-pulse rounded mt-2" />
          </div>
        ))}
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[350px] bg-muted animate-pulse rounded" />
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        {Array.from({ length: 2 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-[300px] bg-muted animate-pulse rounded" />
          </div>
        ))}
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[400px] bg-muted animate-pulse rounded" />
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[350px] bg-muted animate-pulse rounded" />
      </div>
    </div>
  )
}
