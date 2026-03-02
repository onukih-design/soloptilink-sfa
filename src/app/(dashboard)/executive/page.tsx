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
import { useExecutive } from '@/hooks/use-executive'
import { formatCurrency, formatPercent } from '@/lib/utils/format'
import {
  BarChart,
  Bar,
  PieChart,
  Pie,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts'
import {
  Target,
  TrendingUp,
  DollarSign,
  Briefcase,
  FileText,
} from 'lucide-react'

export default function ExecutivePage() {
  const { data: executive, isLoading } = useExecutive()

  if (isLoading || !executive) {
    return (
      <div className="space-y-6">
        <div className="h-8 w-64 bg-muted animate-pulse rounded" />
        <div className="grid gap-4 md:grid-cols-6">
          {Array.from({ length: 6 }).map((_, i) => (
            <div key={i} className="h-24 bg-muted animate-pulse rounded-lg" />
          ))}
        </div>
        <div className="grid gap-6 lg:grid-cols-2">
          <div className="h-[400px] bg-muted animate-pulse rounded-lg" />
          <div className="h-[400px] bg-muted animate-pulse rounded-lg" />
        </div>
        <div className="h-[500px] bg-muted animate-pulse rounded-lg" />
      </div>
    )
  }

  const achievementRate = executive.annualTarget > 0
    ? executive.annualActual / executive.annualTarget
    : 0

  return (
    <div className="space-y-6">
      {/* ヘッダー */}
      <div>
        <h1 className="text-2xl font-bold tracking-tight">経営ダッシュボード</h1>
        <p className="text-muted-foreground text-sm">
          全案件の売上状況と年間目標達成率を一目で確認します
        </p>
      </div>

      {/* KPIカード（6枚横並び） */}
      <div className="grid gap-4 md:grid-cols-3 lg:grid-cols-6">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-xs font-medium text-muted-foreground">
              年間目標達成率
            </CardTitle>
            <Target className="h-4 w-4 text-blue-600" />
          </CardHeader>
          <CardContent>
            <div className="text-xl font-bold">
              {formatPercent(achievementRate, true, 1)}
            </div>
            <div className="w-full bg-muted rounded-full h-2 mt-2">
              <div
                className="bg-blue-600 h-2 rounded-full transition-all"
                style={{ width: `${Math.min(achievementRate * 100, 100)}%` }}
              />
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              目標: {formatCurrency(executive.annualTarget)}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-xs font-medium text-muted-foreground">
              年間累計売上
            </CardTitle>
            <TrendingUp className="h-4 w-4 text-green-600" />
          </CardHeader>
          <CardContent>
            <div className="text-xl font-bold">
              {formatCurrency(executive.annualActual)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              ショット + ストック合計
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-xs font-medium text-muted-foreground">
              当月MRR
            </CardTitle>
            <DollarSign className="h-4 w-4 text-purple-600" />
          </CardHeader>
          <CardContent>
            <div className="text-xl font-bold">
              {formatCurrency(executive.currentMRR)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              月額経常収益
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-xs font-medium text-muted-foreground">
              当月粗利
            </CardTitle>
            <TrendingUp className="h-4 w-4 text-orange-600" />
          </CardHeader>
          <CardContent>
            <div className="text-xl font-bold">
              {formatCurrency(executive.currentMargin)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              月額マージン合計
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-xs font-medium text-muted-foreground">
              契約中案件数
            </CardTitle>
            <Briefcase className="h-4 w-4 text-pink-600" />
          </CardHeader>
          <CardContent>
            <div className="text-xl font-bold">
              {executive.activeContractCount}件
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              稼働中の契約
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-xs font-medium text-muted-foreground">
              パイプライン総額
            </CardTitle>
            <FileText className="h-4 w-4 text-cyan-600" />
          </CardHeader>
          <CardContent>
            <div className="text-xl font-bold">
              {formatCurrency(executive.pipelineWeighted)}
            </div>
            <p className="text-xs text-muted-foreground mt-1">
              ヨミ率加重後
            </p>
          </CardContent>
        </Card>
      </div>

      {/* チャートエリア（2列） */}
      <div className="grid gap-6 lg:grid-cols-2">
        {/* 月次売上推移 */}
        <Card>
          <CardHeader>
            <CardTitle className="text-base">月次売上推移（12ヶ月）</CardTitle>
          </CardHeader>
          <CardContent>
            {executive.monthlyTrend.length === 0 ? (
              <div className="h-[350px] flex items-center justify-center text-muted-foreground">
                データがありません
              </div>
            ) : (
              <ResponsiveContainer width="100%" height={350}>
                <BarChart
                  data={executive.monthlyTrend.map(t => ({
                    month: t.month.substring(5) + '月',
                    ショット: t.shotRevenue,
                    ストック: t.stockRevenue,
                  }))}
                  margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                >
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="month" tick={{ fontSize: 12 }} />
                  <YAxis
                    tickFormatter={(v: number) => `¥${Math.floor(v / 10000)}万`}
                    tick={{ fontSize: 12 }}
                  />
                  <Tooltip
                    formatter={(value: unknown) => formatCurrency(value as number)}
                  />
                  <Legend />
                  <Bar dataKey="ショット" stackId="a" fill="#3B82F6" />
                  <Bar dataKey="ストック" stackId="a" fill="#22C55E" />
                </BarChart>
              </ResponsiveContainer>
            )}
          </CardContent>
        </Card>

        {/* ステータス別円グラフ */}
        <Card>
          <CardHeader>
            <CardTitle className="text-base">案件ステータス別件数</CardTitle>
          </CardHeader>
          <CardContent>
            {executive.statusBreakdown.length === 0 ? (
              <div className="h-[350px] flex items-center justify-center text-muted-foreground">
                データがありません
              </div>
            ) : (
              <ResponsiveContainer width="100%" height={350}>
                <PieChart>
                  <Pie
                    data={executive.statusBreakdown}
                    cx="50%"
                    cy="50%"
                    labelLine={false}
                    label={(props) => {
                      const entry = props as unknown as { status: string; count: number }
                      return `${entry.status} (${entry.count})`
                    }}
                    outerRadius={120}
                    fill="#8884d8"
                    dataKey="count"
                  >
                    {executive.statusBreakdown.map((entry, index) => (
                      <Cell key={`cell-${index}`} fill={entry.color} />
                    ))}
                  </Pie>
                  <Tooltip
                    formatter={(value: unknown) => `${value}件`}
                  />
                </PieChart>
              </ResponsiveContainer>
            )}
          </CardContent>
        </Card>
      </div>

      {/* 全案件売上一覧テーブル */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">全案件売上一覧</CardTitle>
        </CardHeader>
        <CardContent>
          <Tabs defaultValue="all">
            <TabsList>
              <TabsTrigger value="all">全て ({executive.allDealsRevenue.length})</TabsTrigger>
              <TabsTrigger value="contracted">
                受注のみ ({executive.allDealsRevenue.filter(d => d.yomiStatus === '受注').length})
              </TabsTrigger>
            </TabsList>

            <TabsContent value="all" className="mt-4">
              <div className="rounded-md border overflow-auto max-h-[600px]">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>案件名</TableHead>
                      <TableHead>企業名</TableHead>
                      <TableHead>ヨミステータス</TableHead>
                      <TableHead>商材</TableHead>
                      <TableHead className="text-right">月額売上</TableHead>
                      <TableHead className="text-right">初期費用</TableHead>
                      <TableHead className="text-right">月額粗利</TableHead>
                      <TableHead className="text-right">契約期間</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {executive.allDealsRevenue.length === 0 ? (
                      <TableRow>
                        <TableCell colSpan={8} className="text-center text-muted-foreground">
                          データがありません
                        </TableCell>
                      </TableRow>
                    ) : (
                      <>
                        {executive.allDealsRevenue.map((deal) => (
                          <TableRow key={deal.id}>
                            <TableCell className="font-medium">{deal.dealName}</TableCell>
                            <TableCell>{deal.companyName}</TableCell>
                            <TableCell>
                              <Badge
                                style={{
                                  backgroundColor: getYomiColor(deal.yomiStatus),
                                  color: '#FFFFFF',
                                }}
                              >
                                {deal.statusLabel}
                              </Badge>
                            </TableCell>
                            <TableCell>{deal.product}</TableCell>
                            <TableCell className="text-right font-mono">
                              {formatCurrency(deal.monthlyFee)}
                            </TableCell>
                            <TableCell className="text-right font-mono">
                              {formatCurrency(deal.initialFee)}
                            </TableCell>
                            <TableCell className="text-right font-mono">
                              {formatCurrency(deal.monthlyMargin)}
                            </TableCell>
                            <TableCell className="text-right">
                              {deal.contractMonths}ヶ月
                            </TableCell>
                          </TableRow>
                        ))}
                        <TableRow className="font-bold bg-muted/50">
                          <TableCell colSpan={4}>合計</TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(
                              executive.allDealsRevenue.reduce((s, d) => s + d.monthlyFee, 0)
                            )}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(
                              executive.allDealsRevenue.reduce((s, d) => s + d.initialFee, 0)
                            )}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(
                              executive.allDealsRevenue.reduce((s, d) => s + d.monthlyMargin, 0)
                            )}
                          </TableCell>
                          <TableCell></TableCell>
                        </TableRow>
                      </>
                    )}
                  </TableBody>
                </Table>
              </div>
            </TabsContent>

            <TabsContent value="contracted" className="mt-4">
              <div className="rounded-md border overflow-auto max-h-[600px]">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>案件名</TableHead>
                      <TableHead>企業名</TableHead>
                      <TableHead>商材</TableHead>
                      <TableHead className="text-right">月額売上</TableHead>
                      <TableHead className="text-right">初期費用</TableHead>
                      <TableHead className="text-right">月額粗利</TableHead>
                      <TableHead className="text-right">契約期間</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {executive.allDealsRevenue.filter(d => d.yomiStatus === '受注').length === 0 ? (
                      <TableRow>
                        <TableCell colSpan={7} className="text-center text-muted-foreground">
                          受注案件がありません
                        </TableCell>
                      </TableRow>
                    ) : (
                      <>
                        {executive.allDealsRevenue
                          .filter(d => d.yomiStatus === '受注')
                          .map((deal) => (
                            <TableRow key={deal.id}>
                              <TableCell className="font-medium">{deal.dealName}</TableCell>
                              <TableCell>{deal.companyName}</TableCell>
                              <TableCell>{deal.product}</TableCell>
                              <TableCell className="text-right font-mono">
                                {formatCurrency(deal.monthlyFee)}
                              </TableCell>
                              <TableCell className="text-right font-mono">
                                {formatCurrency(deal.initialFee)}
                              </TableCell>
                              <TableCell className="text-right font-mono">
                                {formatCurrency(deal.monthlyMargin)}
                              </TableCell>
                              <TableCell className="text-right">
                                {deal.contractMonths}ヶ月
                              </TableCell>
                            </TableRow>
                          ))}
                        <TableRow className="font-bold bg-muted/50">
                          <TableCell colSpan={3}>合計</TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(
                              executive.allDealsRevenue
                                .filter(d => d.yomiStatus === '受注')
                                .reduce((s, d) => s + d.monthlyFee, 0)
                            )}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(
                              executive.allDealsRevenue
                                .filter(d => d.yomiStatus === '受注')
                                .reduce((s, d) => s + d.initialFee, 0)
                            )}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(
                              executive.allDealsRevenue
                                .filter(d => d.yomiStatus === '受注')
                                .reduce((s, d) => s + d.monthlyMargin, 0)
                            )}
                          </TableCell>
                          <TableCell></TableCell>
                        </TableRow>
                      </>
                    )}
                  </TableBody>
                </Table>
              </div>
            </TabsContent>
          </Tabs>
        </CardContent>
      </Card>
    </div>
  )
}

/**
 * ヨミステータスから色を取得
 */
function getYomiColor(status: string): string {
  const colorMap: Record<string, string> = {
    '受注': '#3B82F6',
    'Aヨミ': '#EF4444',
    'Bヨミ': '#F97316',
    'Cヨミ': '#EAB308',
    'ネタ': '#22C55E',
    '没ネタ': '#9CA3AF',
    '失注': '#6B7280',
    '消滅': '#D1D5DB',
  }
  return colorMap[status] || '#9CA3AF'
}
