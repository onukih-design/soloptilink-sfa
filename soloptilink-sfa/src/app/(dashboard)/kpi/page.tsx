'use client'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Badge } from '@/components/ui/badge'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { useKPISummary } from '@/hooks/use-kpi-summary'
import { formatCurrency, formatPercent } from '@/lib/utils/format'
import { YOMI_COLORS } from '@/lib/constants/yomi'
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
  Line,
  ComposedChart,
} from 'recharts'
import {
  TrendingUp,
  TrendingDown,
  DollarSign,
  Target,
  Briefcase,
  FileText,
  AlertCircle,
  Users,
  UserCheck,
  Package,
  Calendar,
  Zap,
} from 'lucide-react'

const REVENUE_COLORS = {
  aiTools: '#3B82F6',
  outsourcing: '#22C55E',
  target: '#EF4444',
}

const URGENCY_COLORS = {
  critical: 'bg-red-100 text-red-800 border-red-300',
  high: 'bg-orange-100 text-orange-800 border-orange-300',
  medium: 'bg-yellow-100 text-yellow-800 border-yellow-300',
  low: 'bg-blue-100 text-blue-800 border-blue-300',
}

export default function KPIPage() {
  const { data, isLoading, error } = useKPISummary()

  if (isLoading || !data) {
    return <KPIPageSkeleton />
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

  const { yomi, aiTools, outsourcing, totalRevenue, funnel, targetVsActual, overdue, closerPerf, appointerPerf, listPerf } = data

  // Calculate key metrics
  const totalMRR = aiTools.totalMRR + outsourcing.totalMonthlyCommission
  const totalARR = totalMRR * 12
  const totalActiveContracts = (aiTools.byProduct?.reduce((sum, p) => sum + p.activeContracts, 0) || 0) + outsourcing.totalActiveContracts
  const totalNewContracts = aiTools.newContractsThisMonth
  const pipelineValue = yomi.totals.weightedAmount
  const hotPipelineValue = yomi.hot.weightedAmount
  const coldPipelineValue = yomi.cold.weightedAmount

  // MoM growth rate from totalRevenue
  const momGrowth = totalRevenue.growthRateMoM

  // Calculate current month achievement
  const currentMonth = new Date().toISOString().slice(0, 7) // YYYY-MM
  const currentMonthTarget = targetVsActual.monthly.find(m => m.month === currentMonth)
  const achievementRate = currentMonthTarget?.achievementRate || 0

  // Calculate churn rate
  const avgChurnRate = aiTools.churnRate

  // Calculate avg deal size from closer performance
  const totalWonAmount = closerPerf.reduce((sum, c) => sum + c.totalRevenue, 0)
  const totalWonDeals = closerPerf.reduce((sum, c) => sum + c.winCount, 0)
  const avgDealSize = totalWonDeals > 0 ? totalWonAmount / totalWonDeals : 0

  // Calculate avg cycle time from funnel
  const avgCycleTime = funnel.avgDealCycleDays

  // Calculate LTV (simplified: avg MRR * avg contract months / churn)
  const avgContractMonths = aiTools.byProduct.reduce((sum, p) => sum + p.avgContractMonths, 0) / Math.max(aiTools.byProduct.length, 1)
  const simpleLTV = avgChurnRate > 0 ? (totalMRR / Math.max(totalActiveContracts, 1)) * avgContractMonths : 0

  // Calculate conversion rate from funnel
  const conversionRate = funnel.conversionRates.leadToWon

  // Revenue split for donut chart
  const revenueData = [
    { name: 'AIツール', value: aiTools.totalMRR, color: REVENUE_COLORS.aiTools },
    { name: '営業代行', value: outsourcing.totalMonthlyCommission, color: REVENUE_COLORS.outsourcing },
  ]

  // Monthly revenue trend (last 6 months)
  const monthlyTrendData = totalRevenue.monthlyTrend.slice(-6).map(m => ({
    month: m.month,
    AIツール: m.aiTools,
    営業代行: m.outsourcing,
    目標: 0, // No target in data
  }))

  // Yomi pipeline for horizontal bar chart
  const yomiPipelineData = yomi.byStatus
    .filter(s => s.count > 0)
    .map(s => ({
      status: s.status,
      count: s.count,
      amount: s.totalAmount,
      weighted: s.weightedAmount,
      color: YOMI_COLORS[s.status],
    }))

  // Target vs Actual (last 6 months)
  const targetVsActualData = targetVsActual.monthly.slice(-6).map(m => ({
    month: m.month,
    目標: m.target,
    実績: m.actual,
    達成率: m.achievementRate,
  }))

  // Funnel data (rates already in percentage 0-100 from engine)
  const funnelData = [
    { name: 'リード', count: funnel.totalLeads, conversionRate: 100 },
    { name: 'アポ', count: funnel.appointments, conversionRate: funnel.conversionRates.leadToAppointment },
    { name: '商談', count: funnel.negotiations, conversionRate: funnel.conversionRates.appointmentToNegotiation },
    { name: '受注', count: funnel.wonDeals, conversionRate: funnel.conversionRates.negotiationToWon },
  ]

  // Group overdue by urgency
  const overdueByUrgency = {
    critical: 0, // Not in data structure
    high: overdue.byUrgency.high.length,
    medium: overdue.byUrgency.medium.length,
    low: overdue.byUrgency.low.length,
  }

  return (
    <div className="space-y-6 pb-8">
      {/* Header with gradient background */}
      <div className="bg-gradient-to-r from-blue-600 to-indigo-700 -mx-6 -mt-6 px-6 py-8 text-white">
        <h1 className="text-3xl font-bold tracking-tight">統合KPIダッシュボード</h1>
        <p className="text-blue-100 mt-2">全ての重要指標を一目で確認</p>
        <p className="text-xs text-blue-200 mt-1">最終更新: {new Date(data.lastUpdated).toLocaleString('ja-JP')}</p>
      </div>

      {/* Top Row: Key Metrics Cards */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card className="border-l-4 border-l-blue-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total MRR
            </CardTitle>
            <DollarSign className="h-5 w-5 text-blue-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(totalMRR)}</div>
            <div className="flex items-center gap-2 mt-2">
              {momGrowth >= 0 ? (
                <TrendingUp className="h-4 w-4 text-green-600" />
              ) : (
                <TrendingDown className="h-4 w-4 text-red-600" />
              )}
              <span className={`text-xs font-medium ${momGrowth >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                {momGrowth >= 0 ? '+' : ''}{Math.abs(momGrowth) > 999 ? (momGrowth >= 0 ? '>999%' : '<-999%') : formatPercent(momGrowth, false, 1)} MoM
              </span>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              AIツール: {formatCurrency(aiTools.totalMRR)} / 営業代行: {formatCurrency(outsourcing.totalMonthlyCommission)}
            </p>
          </CardContent>
        </Card>

        <Card className="border-l-4 border-l-green-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total ARR
            </CardTitle>
            <Target className="h-5 w-5 text-green-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(totalARR)}</div>
            <div className="flex items-center gap-2 mt-2">
              <Badge variant={achievementRate >= 80 ? 'default' : 'destructive'} className="text-xs">
                目標達成率: {formatPercent(achievementRate, false, 0)}
              </Badge>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              年間予測: {formatCurrency(targetVsActual.forecastedYearEnd)}
            </p>
          </CardContent>
        </Card>

        <Card className="border-l-4 border-l-purple-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              稼働中契約
            </CardTitle>
            <Briefcase className="h-5 w-5 text-purple-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{totalActiveContracts}件</div>
            <div className="flex items-center gap-2 mt-2">
              {totalNewContracts > 0 && (
                <Badge variant="outline" className="text-xs bg-green-50 text-green-700 border-green-200">
                  今月 +{totalNewContracts}件
                </Badge>
              )}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              AIツール: {aiTools.byProduct?.reduce((sum, p) => sum + p.activeContracts, 0) || 0}件 / 営業代行: {outsourcing.totalActiveContracts}件
            </p>
          </CardContent>
        </Card>

        <Card className="border-l-4 border-l-orange-600">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              パイプライン総額
            </CardTitle>
            <FileText className="h-5 w-5 text-orange-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(pipelineValue)}</div>
            <div className="flex items-center gap-2 mt-2 text-xs">
              <span className="text-red-600 font-medium">Hot: {formatCurrency(hotPipelineValue)}</span>
              <span className="text-muted-foreground">|</span>
              <span className="text-blue-600 font-medium">Cold: {formatCurrency(coldPipelineValue)}</span>
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              案件数: {yomi.totals.count}件（加重後）
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Second Row: Revenue Split */}
      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">売上構成比（AIツール vs 営業代行）</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center justify-center">
              <ResponsiveContainer width="100%" height={280}>
                <PieChart>
                  <Pie
                    data={revenueData}
                    cx="50%"
                    cy="50%"
                    labelLine={false}
                    label={(entry) => `${entry.name}: ${formatPercent((entry.value / totalMRR), true, 1)}`}
                    outerRadius={100}
                    fill="#8884d8"
                    dataKey="value"
                  >
                    {revenueData.map((entry, index) => (
                      <Cell key={`cell-${index}`} fill={entry.color} />
                    ))}
                  </Pie>
                  <Tooltip formatter={(value) => formatCurrency(value as number)} />
                </PieChart>
              </ResponsiveContainer>
            </div>
            <div className="grid grid-cols-2 gap-4 mt-4">
              <div className="text-center">
                <div className="text-xs text-muted-foreground">AIツール</div>
                <div className="text-lg font-bold text-blue-600">{formatCurrency(aiTools.totalMRR)}</div>
                <div className="text-xs text-muted-foreground">{formatPercent(totalRevenue.byCategory.find(c => c.category === 'AIツール')?.percentage || 0, false, 1)}</div>
              </div>
              <div className="text-center">
                <div className="text-xs text-muted-foreground">営業代行</div>
                <div className="text-lg font-bold text-green-600">{formatCurrency(outsourcing.totalMonthlyCommission)}</div>
                <div className="text-xs text-muted-foreground">{formatPercent(totalRevenue.byCategory.find(c => c.category === '営業代行')?.percentage || 0, false, 1)}</div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">月次売上推移（直近6ヶ月）</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={280}>
              <ComposedChart data={monthlyTrendData} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" tick={{ fontSize: 11 }} />
                <YAxis tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 11 }} />
                <Tooltip formatter={(v) => formatCurrency(v as number)} />
                <Legend />
                <Bar dataKey="AIツール" stackId="a" fill={REVENUE_COLORS.aiTools} />
                <Bar dataKey="営業代行" stackId="a" fill={REVENUE_COLORS.outsourcing} />
                <Line type="monotone" dataKey="目標" stroke={REVENUE_COLORS.target} strokeWidth={2} dot={{ r: 4 }} />
              </ComposedChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      {/* Third Row: Yomi Pipeline */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">ヨミステータス別パイプライン</CardTitle>
        </CardHeader>
        <CardContent>
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={yomiPipelineData} layout="vertical" margin={{ top: 5, right: 30, left: 100, bottom: 5 }}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis type="number" tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 11 }} />
              <YAxis type="category" dataKey="status" tick={{ fontSize: 12 }} width={90} />
              <Tooltip
                formatter={(value, name) => {
                  if (name === '加重額') return formatCurrency(value as number)
                  return value
                }}
                content={({ active, payload }) => {
                  if (active && payload && payload.length > 0) {
                    const data = payload[0].payload
                    return (
                      <div className="bg-white p-3 border rounded-lg shadow-lg">
                        <p className="font-medium">{data.status}</p>
                        <p className="text-sm">案件数: {data.count}件</p>
                        <p className="text-sm">総額: {formatCurrency(data.amount)}</p>
                        <p className="text-sm font-medium text-primary">加重額: {formatCurrency(data.weighted)}</p>
                      </div>
                    )
                  }
                  return null
                }}
              />
              <Bar dataKey="weighted" name="加重額" radius={[0, 4, 4, 0]}>
                {yomiPipelineData.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.color} />
                ))}
              </Bar>
            </BarChart>
          </ResponsiveContainer>
        </CardContent>
      </Card>

      {/* Fourth Row: Performance Comparison */}
      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">目標 vs 実績（直近6ヶ月）</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={280}>
              <BarChart data={targetVsActualData} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" tick={{ fontSize: 11 }} />
                <YAxis tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 11 }} />
                <Tooltip formatter={(v) => formatCurrency(v as number)} />
                <Legend />
                <Bar dataKey="目標" fill="#94A3B8" />
                <Bar dataKey="実績" fill="#3B82F6" />
              </BarChart>
            </ResponsiveContainer>
            <div className="mt-4 grid grid-cols-3 gap-2 text-center">
              <div>
                <div className="text-xs text-muted-foreground">累計目標</div>
                <div className="text-sm font-bold">{formatCurrency(targetVsActual.monthly.reduce((sum, m) => sum + m.target, 0))}</div>
              </div>
              <div>
                <div className="text-xs text-muted-foreground">累計実績</div>
                <div className="text-sm font-bold text-blue-600">{formatCurrency(targetVsActual.monthly.reduce((sum, m) => sum + m.actual, 0))}</div>
              </div>
              <div>
                <div className="text-xs text-muted-foreground">達成率</div>
                <div className={`text-sm font-bold ${targetVsActual.cumulativeAchievement >= 80 ? 'text-green-600' : 'text-red-600'}`}>
                  {formatPercent(targetVsActual.cumulativeAchievement, false, 1)}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">セールスファネル</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={280}>
              <BarChart data={funnelData} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="name" tick={{ fontSize: 10 }} />
                <YAxis tick={{ fontSize: 11 }} />
                <Tooltip />
                <Legend />
                <Bar dataKey="count" name="件数" fill="#3B82F6" />
              </BarChart>
            </ResponsiveContainer>
            <div className="mt-4 grid grid-cols-3 gap-2 text-center">
              <div>
                <div className="text-xs text-muted-foreground">総合転換率</div>
                <div className="text-sm font-bold text-green-600">{formatPercent(funnel.conversionRates.leadToWon, false, 1)}</div>
              </div>
              <div>
                <div className="text-xs text-muted-foreground">平均サイクル</div>
                <div className="text-sm font-bold">{funnel.avgDealCycleDays.toFixed(0)}日</div>
              </div>
              <div>
                <div className="text-xs text-muted-foreground">全ステージ</div>
                <div className="text-sm font-bold">4段階</div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Fifth Row: AI Tool Details + Outsourcing Details */}
      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">AIツール商品別実績</CardTitle>
            <Package className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="overflow-auto max-h-[400px]">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>商品名</TableHead>
                    <TableHead className="text-right">契約数</TableHead>
                    <TableHead className="text-right">MRR</TableHead>
                    <TableHead className="text-right">粗利</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {aiTools.byProduct.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={4} className="text-center text-muted-foreground h-20">
                        データがありません
                      </TableCell>
                    </TableRow>
                  ) : (
                    aiTools.byProduct.map((p) => (
                      <TableRow key={p.product}>
                        <TableCell className="font-medium text-sm">
                          {p.productName}
                        </TableCell>
                        <TableCell className="text-right">{p.activeContracts}</TableCell>
                        <TableCell className="text-right font-mono text-sm">{formatCurrency(p.mrr)}</TableCell>
                        <TableCell className="text-right font-mono text-sm">{formatCurrency(p.margin)}</TableCell>
                      </TableRow>
                    ))
                  )}
                  {aiTools.byProduct.length > 0 && (
                    <TableRow className="font-bold bg-muted/50">
                      <TableCell>合計</TableCell>
                      <TableCell className="text-right">{aiTools.byProduct.reduce((sum, p) => sum + p.activeContracts, 0)}</TableCell>
                      <TableCell className="text-right font-mono">{formatCurrency(aiTools.totalMRR)}</TableCell>
                      <TableCell className="text-right font-mono">{formatCurrency(aiTools.totalMonthlyMargin)}</TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">営業代行サービス別実績</CardTitle>
            <Users className="h-5 w-5 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="overflow-auto max-h-[400px]">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>サービス</TableHead>
                    <TableHead className="text-right">契約数</TableHead>
                    <TableHead className="text-right">月額料金</TableHead>
                    <TableHead className="text-right">粗利</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {outsourcing.byService.length === 0 ? (
                    <TableRow>
                      <TableCell colSpan={4} className="text-center text-muted-foreground h-20">
                        データがありません
                      </TableCell>
                    </TableRow>
                  ) : (
                    outsourcing.byService.map((s) => (
                      <TableRow key={s.serviceType}>
                        <TableCell className="font-medium text-sm">
                          {s.serviceType}
                        </TableCell>
                        <TableCell className="text-right">{s.activeContracts}</TableCell>
                        <TableCell className="text-right font-mono text-sm">{formatCurrency(s.avgContractValue)}</TableCell>
                        <TableCell className="text-right font-mono text-sm">{formatCurrency(s.monthlyCommission)}</TableCell>
                      </TableRow>
                    ))
                  )}
                  {outsourcing.byService.length > 0 && (
                    <TableRow className="font-bold bg-muted/50">
                      <TableCell>合計</TableCell>
                      <TableCell className="text-right">{outsourcing.totalActiveContracts}</TableCell>
                      <TableCell className="text-right font-mono">-</TableCell>
                      <TableCell className="text-right font-mono">{formatCurrency(outsourcing.totalMonthlyCommission)}</TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Sixth Row: Team Performance */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">チームパフォーマンス</CardTitle>
        </CardHeader>
        <CardContent>
          <Tabs defaultValue="closer">
            <TabsList className="mb-4">
              <TabsTrigger value="closer" className="flex items-center gap-2">
                <UserCheck className="h-4 w-4" />
                クローザー
              </TabsTrigger>
              <TabsTrigger value="appointer" className="flex items-center gap-2">
                <Calendar className="h-4 w-4" />
                アポインター
              </TabsTrigger>
            </TabsList>

            <TabsContent value="closer">
              <div className="overflow-auto max-h-[400px]">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>担当者</TableHead>
                      <TableHead className="text-right">案件数</TableHead>
                      <TableHead className="text-right">受注数</TableHead>
                      <TableHead className="text-right">成約率</TableHead>
                      <TableHead className="text-right">総売上</TableHead>
                      <TableHead className="text-right">PL総額</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {closerPerf.length === 0 ? (
                      <TableRow>
                        <TableCell colSpan={6} className="text-center text-muted-foreground h-20">
                          データがありません
                        </TableCell>
                      </TableRow>
                    ) : (
                      closerPerf.map((closer) => (
                        <TableRow key={closer.closerId}>
                          <TableCell className="font-medium">{closer.closerName}</TableCell>
                          <TableCell className="text-right">{closer.dealCount}</TableCell>
                          <TableCell className="text-right">{closer.winCount}</TableCell>
                          <TableCell className="text-right">
                            <Badge variant={closer.winRate >= 30 ? 'default' : 'outline'} className="text-xs">
                              {formatPercent(closer.winRate, false, 1)}
                            </Badge>
                          </TableCell>
                          <TableCell className="text-right font-mono text-sm">{formatCurrency(closer.totalRevenue)}</TableCell>
                          <TableCell className="text-right font-mono text-sm">{formatCurrency(closer.pipelineValue)}</TableCell>
                        </TableRow>
                      ))
                    )}
                  </TableBody>
                </Table>
              </div>
            </TabsContent>

            <TabsContent value="appointer">
              <div className="overflow-auto max-h-[400px]">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>担当者</TableHead>
                      <TableHead className="text-right">アポ数</TableHead>
                      <TableHead className="text-right">案件化数</TableHead>
                      <TableHead className="text-right">案件化率</TableHead>
                      <TableHead className="text-right">受注数</TableHead>
                      <TableHead className="text-right">総売上</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {appointerPerf.length === 0 ? (
                      <TableRow>
                        <TableCell colSpan={6} className="text-center text-muted-foreground h-20">
                          データがありません
                        </TableCell>
                      </TableRow>
                    ) : (
                      appointerPerf.map((appointer) => (
                        <TableRow key={appointer.appointerId}>
                          <TableCell className="font-medium">{appointer.appointerName}</TableCell>
                          <TableCell className="text-right">{appointer.appointmentsSet}</TableCell>
                          <TableCell className="text-right">-</TableCell>
                          <TableCell className="text-right">
                            <Badge variant={appointer.conversionRate >= 50 ? 'default' : 'outline'} className="text-xs">
                              {formatPercent(appointer.conversionRate, false, 1)}
                            </Badge>
                          </TableCell>
                          <TableCell className="text-right">-</TableCell>
                          <TableCell className="text-right font-mono text-sm">{formatCurrency(appointer.revenueAttributed)}</TableCell>
                        </TableRow>
                      ))
                    )}
                  </TableBody>
                </Table>
              </div>
            </TabsContent>
          </Tabs>
        </CardContent>
      </Card>

      {/* Seventh Row: Overdue Actions + Quick Stats */}
      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">期限超過フォローアップ</CardTitle>
            <AlertCircle className="h-5 w-5 text-orange-600" />
          </CardHeader>
          <CardContent>
            <div className="flex gap-2 mb-4">
              <Badge variant="outline" className={URGENCY_COLORS.critical}>
                緊急: {overdueByUrgency.critical}件
              </Badge>
              <Badge variant="outline" className={URGENCY_COLORS.high}>
                高: {overdueByUrgency.high}件
              </Badge>
              <Badge variant="outline" className={URGENCY_COLORS.medium}>
                中: {overdueByUrgency.medium}件
              </Badge>
              <Badge variant="outline" className={URGENCY_COLORS.low}>
                低: {overdueByUrgency.low}件
              </Badge>
            </div>
            <div className="overflow-auto max-h-[300px] space-y-2">
              {overdue.count === 0 ? (
                <div className="text-center text-muted-foreground py-8">
                  期限超過はありません
                </div>
              ) : (
                overdue.items.slice(0, 10).map((item) => {
                  const urgency: 'low' | 'medium' | 'high' = item.daysOverdue >= 8 ? 'high' : item.daysOverdue >= 4 ? 'medium' : 'low'
                  return (
                    <div key={item.dealId} className="p-3 border rounded-lg hover:bg-muted/50 transition-colors">
                      <div className="flex items-start justify-between gap-2">
                        <div className="flex-1 min-w-0">
                          <div className="font-medium text-sm truncate">{item.dealName}</div>
                          <div className="text-xs text-muted-foreground">{item.companyName}</div>
                          <div className="text-xs mt-1">{item.nextAction}</div>
                        </div>
                        <Badge variant="outline" className={`${URGENCY_COLORS[urgency]} whitespace-nowrap text-xs`}>
                          {item.daysOverdue}日超過
                        </Badge>
                      </div>
                    </div>
                  )
                })
              )}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-base">主要指標サマリー</CardTitle>
            <Zap className="h-5 w-5 text-yellow-600" />
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-2 gap-4">
              <div className="p-3 border rounded-lg bg-muted/30">
                <div className="text-xs text-muted-foreground mb-1">Churn Rate</div>
                <div className="text-xl font-bold">{formatPercent(avgChurnRate, false, 1)}</div>
                <div className="text-xs text-muted-foreground mt-1">月次解約率</div>
              </div>
              <div className="p-3 border rounded-lg bg-muted/30">
                <div className="text-xs text-muted-foreground mb-1">Avg Deal Size</div>
                <div className="text-xl font-bold">{formatCurrency(avgDealSize)}</div>
                <div className="text-xs text-muted-foreground mt-1">平均受注単価</div>
              </div>
              <div className="p-3 border rounded-lg bg-muted/30">
                <div className="text-xs text-muted-foreground mb-1">Avg Cycle Time</div>
                <div className="text-xl font-bold">{avgCycleTime.toFixed(0)}日</div>
                <div className="text-xs text-muted-foreground mt-1">平均商談期間</div>
              </div>
              <div className="p-3 border rounded-lg bg-muted/30">
                <div className="text-xs text-muted-foreground mb-1">LTV (推定)</div>
                <div className="text-xl font-bold">{formatCurrency(simpleLTV)}</div>
                <div className="text-xs text-muted-foreground mt-1">顧客生涯価値</div>
              </div>
              <div className="p-3 border rounded-lg bg-muted/30">
                <div className="text-xs text-muted-foreground mb-1">Conversion Rate</div>
                <div className="text-xl font-bold">{formatPercent(conversionRate, false, 1)}</div>
                <div className="text-xs text-muted-foreground mt-1">総合転換率</div>
              </div>
              <div className="p-3 border rounded-lg bg-muted/30">
                <div className="text-xs text-muted-foreground mb-1">Active Lists</div>
                <div className="text-xl font-bold">{listPerf.length}</div>
                <div className="text-xs text-muted-foreground mt-1">稼働リスト数</div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

function KPIPageSkeleton() {
  return (
    <div className="space-y-6 pb-8">
      <div className="bg-gradient-to-r from-blue-600 to-indigo-700 -mx-6 -mt-6 px-6 py-8">
        <div className="h-8 w-64 bg-blue-500/50 animate-pulse rounded" />
        <div className="h-4 w-96 bg-blue-500/30 animate-pulse rounded mt-2" />
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

      <div className="grid gap-6 lg:grid-cols-2">
        {Array.from({ length: 2 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-[300px] bg-muted animate-pulse rounded" />
          </div>
        ))}
      </div>

      <div className="rounded-xl border bg-card p-6">
        <div className="h-[300px] bg-muted animate-pulse rounded" />
      </div>

      <div className="grid gap-6 lg:grid-cols-2">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-[300px] bg-muted animate-pulse rounded" />
          </div>
        ))}
      </div>
    </div>
  )
}
