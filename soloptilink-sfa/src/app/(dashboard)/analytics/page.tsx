'use client'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Badge } from '@/components/ui/badge'
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from '@/components/ui/table'
import { Button } from '@/components/ui/button'
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell,
} from 'recharts'
import { useCloserAnalysis, useAppointerAnalysis, useProductAnalysis } from '@/hooks/use-analytics'
import { formatCurrency, formatPercent } from '@/lib/utils/format'
import { PRODUCT_NAMES, type ProductKey } from '@/lib/constants/margins'
import { Download, Users, UserCheck, Package } from 'lucide-react'
import { exportToExcel } from '@/lib/utils/excel-export'

const CHART_COLORS = ['#3B82F6', '#22C55E', '#F97316', '#EF4444', '#8B5CF6', '#EC4899', '#06B6D4', '#EAB308']

export default function AnalyticsPage() {
  const { data: closerData, isLoading: closerLoading } = useCloserAnalysis()
  const { data: appointerData, isLoading: appointerLoading } = useAppointerAnalysis()
  const { data: productData, isLoading: productLoading } = useProductAnalysis()

  const isLoading = closerLoading || appointerLoading || productLoading

  const handleExportCloser = () => {
    if (!closerData) return
    exportToExcel(
      closerData.map((c) => ({
        display_name: c.displayName,
        total_deals: c.totalDeals,
        won_deals: c.wonDeals,
        close_rate: `${Math.floor(c.closeRate * 100)}%`,
        total_amount: c.totalAmount,
        won_amount: c.wonAmount,
        avg_deal_size: c.avgDealSize,
      })),
      [
        { header: '担当者', key: 'display_name', width: 15 },
        { header: '総案件数', key: 'total_deals', width: 10 },
        { header: '受注件数', key: 'won_deals', width: 10 },
        { header: '受注率', key: 'close_rate', width: 10 },
        { header: '総額', key: 'total_amount', width: 14 },
        { header: '受注金額', key: 'won_amount', width: 14 },
        { header: '平均受注単価', key: 'avg_deal_size', width: 14 },
      ],
      `クローザー分析_${new Date().toISOString().split('T')[0].replace(/-/g, '')}`,
      'クローザー分析'
    )
  }

  const handleExportProduct = () => {
    if (!productData) return
    exportToExcel(
      productData.map((p) => ({
        product_name: PRODUCT_NAMES[p.product as ProductKey] || p.product,
        active_count: p.activeCount,
        total_mrr: p.totalMRR,
        total_margin: p.totalMargin,
        avg_monthly_fee: p.avgMonthlyFee,
        margin_rate: `${Math.floor(p.marginRate * 100)}%`,
      })),
      [
        { header: '商品', key: 'product_name', width: 20 },
        { header: '契約中件数', key: 'active_count', width: 12 },
        { header: '月額売上合計', key: 'total_mrr', width: 14 },
        { header: '月額粗利合計', key: 'total_margin', width: 14 },
        { header: '平均月額', key: 'avg_monthly_fee', width: 14 },
        { header: '粗利率', key: 'margin_rate', width: 10 },
      ],
      `商品分析_${new Date().toISOString().split('T')[0].replace(/-/g, '')}`,
      '商品分析'
    )
  }

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="h-8 w-48 bg-muted animate-pulse rounded" />
        <div className="h-[400px] bg-muted animate-pulse rounded-lg" />
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">分析レポート</h1>
        <p className="text-muted-foreground text-sm">クローザー・アポインター・商品別の分析データ</p>
      </div>

      <Tabs defaultValue="closer">
        <TabsList>
          <TabsTrigger value="closer" className="flex items-center gap-1">
            <UserCheck className="h-3.5 w-3.5" />
            クローザー分析
          </TabsTrigger>
          <TabsTrigger value="appointer" className="flex items-center gap-1">
            <Users className="h-3.5 w-3.5" />
            アポインター分析
          </TabsTrigger>
          <TabsTrigger value="product" className="flex items-center gap-1">
            <Package className="h-3.5 w-3.5" />
            商品分析
          </TabsTrigger>
        </TabsList>

        {/* クローザー分析 */}
        <TabsContent value="closer" className="space-y-4">
          <div className="flex justify-end">
            <Button variant="outline" size="sm" onClick={handleExportCloser}>
              <Download className="h-4 w-4 mr-2" />
              Excel出力
            </Button>
          </div>

          {/* クローザー別受注金額チャート */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">クローザー別受注金額</CardTitle>
            </CardHeader>
            <CardContent>
              {(!closerData || closerData.length === 0) ? (
                <div className="h-[250px] flex items-center justify-center text-muted-foreground">
                  データがありません
                </div>
              ) : (
                <ResponsiveContainer width="100%" height={250}>
                  <BarChart data={closerData} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="displayName" tick={{ fontSize: 12 }} />
                    <YAxis tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 12 }} />
                    <Tooltip formatter={(v) => formatCurrency(Number(v ?? 0))} />
                    <Bar dataKey="wonAmount" name="受注金額" radius={[4, 4, 0, 0]} maxBarSize={48}>
                      {(closerData || []).map((_, i) => (
                        <Cell key={i} fill={CHART_COLORS[i % CHART_COLORS.length]} />
                      ))}
                    </Bar>
                  </BarChart>
                </ResponsiveContainer>
              )}
            </CardContent>
          </Card>

          {/* クローザーテーブル */}
          <Card>
            <CardContent className="pt-6">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>担当者</TableHead>
                    <TableHead className="text-right">総案件数</TableHead>
                    <TableHead className="text-right">受注件数</TableHead>
                    <TableHead className="text-right">受注率</TableHead>
                    <TableHead className="text-right">受注金額</TableHead>
                    <TableHead className="text-right">平均単価</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {(!closerData || closerData.length === 0) ? (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center text-muted-foreground h-20">
                        データがありません
                      </TableCell>
                    </TableRow>
                  ) : (
                    closerData.map((closer) => (
                      <TableRow key={closer.userId}>
                        <TableCell className="font-medium">{closer.displayName}</TableCell>
                        <TableCell className="text-right">{closer.totalDeals}</TableCell>
                        <TableCell className="text-right">{closer.wonDeals}</TableCell>
                        <TableCell className="text-right">
                          <Badge variant={closer.closeRate >= 0.3 ? 'default' : 'outline'} className="text-xs">
                            {formatPercent(closer.closeRate, true)}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-right font-mono">{formatCurrency(closer.wonAmount)}</TableCell>
                        <TableCell className="text-right font-mono">{formatCurrency(closer.avgDealSize)}</TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        {/* アポインター分析 */}
        <TabsContent value="appointer" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">アポインター別実績</CardTitle>
            </CardHeader>
            <CardContent>
              {(!appointerData || appointerData.length === 0) ? (
                <div className="h-[250px] flex items-center justify-center text-muted-foreground">
                  データがありません
                </div>
              ) : (
                <ResponsiveContainer width="100%" height={250}>
                  <BarChart data={appointerData} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="displayName" tick={{ fontSize: 12 }} />
                    <YAxis tick={{ fontSize: 12 }} />
                    <Tooltip />
                    <Bar dataKey="totalAppointments" name="アポ数" fill="#3B82F6" radius={[4, 4, 0, 0]} maxBarSize={48} />
                    <Bar dataKey="convertedDeals" name="受注数" fill="#22C55E" radius={[4, 4, 0, 0]} maxBarSize={48} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>アポインター</TableHead>
                    <TableHead className="text-right">アポ数</TableHead>
                    <TableHead className="text-right">受注件数</TableHead>
                    <TableHead className="text-right">転換率</TableHead>
                    <TableHead className="text-right">案件総額</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {(!appointerData || appointerData.length === 0) ? (
                    <TableRow>
                      <TableCell colSpan={5} className="text-center text-muted-foreground h-20">
                        データがありません
                      </TableCell>
                    </TableRow>
                  ) : (
                    appointerData.map((appointer) => (
                      <TableRow key={appointer.userId}>
                        <TableCell className="font-medium">{appointer.displayName}</TableCell>
                        <TableCell className="text-right">{appointer.totalAppointments}</TableCell>
                        <TableCell className="text-right">{appointer.convertedDeals}</TableCell>
                        <TableCell className="text-right">
                          <Badge variant={appointer.conversionRate >= 0.2 ? 'default' : 'outline'} className="text-xs">
                            {formatPercent(appointer.conversionRate, true)}
                          </Badge>
                        </TableCell>
                        <TableCell className="text-right font-mono">{formatCurrency(appointer.totalAmount)}</TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        {/* 商品分析 */}
        <TabsContent value="product" className="space-y-4">
          <div className="flex justify-end">
            <Button variant="outline" size="sm" onClick={handleExportProduct}>
              <Download className="h-4 w-4 mr-2" />
              Excel出力
            </Button>
          </div>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">商品別月額売上</CardTitle>
            </CardHeader>
            <CardContent>
              {(!productData || productData.length === 0) ? (
                <div className="h-[250px] flex items-center justify-center text-muted-foreground">
                  データがありません
                </div>
              ) : (
                <ResponsiveContainer width="100%" height={250}>
                  <BarChart data={productData.map(p => ({ ...p, name: PRODUCT_NAMES[p.product as ProductKey] || p.product }))} margin={{ top: 5, right: 30, left: 20, bottom: 5 }}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="name" tick={{ fontSize: 10 }} angle={-30} textAnchor="end" height={60} />
                    <YAxis tickFormatter={(v) => `¥${(v / 10000).toFixed(0)}万`} tick={{ fontSize: 12 }} />
                    <Tooltip formatter={(v) => formatCurrency(Number(v ?? 0))} />
                    <Bar dataKey="totalMRR" name="月額売上" fill="#3B82F6" radius={[4, 4, 0, 0]} maxBarSize={48} />
                    <Bar dataKey="totalMargin" name="月額粗利" fill="#22C55E" radius={[4, 4, 0, 0]} maxBarSize={48} />
                  </BarChart>
                </ResponsiveContainer>
              )}
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>商品</TableHead>
                    <TableHead className="text-right">契約数</TableHead>
                    <TableHead className="text-right">月額売上</TableHead>
                    <TableHead className="text-right">月額粗利</TableHead>
                    <TableHead className="text-right">平均月額</TableHead>
                    <TableHead className="text-right">粗利率</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {(!productData || productData.length === 0) ? (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center text-muted-foreground h-20">
                        データがありません
                      </TableCell>
                    </TableRow>
                  ) : (
                    productData.map((p) => (
                      <TableRow key={p.product}>
                        <TableCell className="font-medium">{PRODUCT_NAMES[p.product as ProductKey] || p.product}</TableCell>
                        <TableCell className="text-right">{p.activeCount}</TableCell>
                        <TableCell className="text-right font-mono">{formatCurrency(p.totalMRR)}</TableCell>
                        <TableCell className="text-right font-mono">{formatCurrency(p.totalMargin)}</TableCell>
                        <TableCell className="text-right font-mono">{formatCurrency(p.avgMonthlyFee)}</TableCell>
                        <TableCell className="text-right">
                          <Badge variant="outline" className="text-xs">
                            {formatPercent(p.marginRate, true)}
                          </Badge>
                        </TableCell>
                      </TableRow>
                    ))
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  )
}
