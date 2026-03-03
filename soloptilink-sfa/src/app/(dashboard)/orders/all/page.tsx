'use client'

import { useMemo } from 'react'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { useAiToolOrders, useSalesOutsourcingOrders } from '@/hooks/use-orders'
import { formatCurrency } from '@/lib/utils/format'
import { PRODUCT_NAMES, type ProductKey } from '@/lib/constants/margins'
import { Package, Bot, Users } from 'lucide-react'

function getProductDisplayName(productKey: string): string {
  if (productKey in PRODUCT_NAMES) {
    return PRODUCT_NAMES[productKey as ProductKey]
  }
  return productKey || '-'
}

export default function AllOrdersPage() {
  const { data: aiOrders, isLoading: aiLoading } = useAiToolOrders()
  const { data: outOrders, isLoading: outLoading } =
    useSalesOutsourcingOrders()

  const activeAi = useMemo(
    () => (aiOrders || []).filter((o) => o.status === '契約中' || !o.status),
    [aiOrders]
  )
  const activeOut = useMemo(
    () => (outOrders || []).filter((o) => o.status === '契約中' || !o.status),
    [outOrders]
  )

  const aiMRR = useMemo(
    () => activeAi.reduce((s, o) => s + (o.monthly_fee || 0), 0),
    [activeAi]
  )
  const outMRR = useMemo(
    () => activeOut.reduce((s, o) => s + (o.monthly_fee || 0), 0),
    [activeOut]
  )
  const totalMRR = aiMRR + outMRR

  const aiMargin = useMemo(
    () => activeAi.reduce((s, o) => s + (o.monthly_margin || 0), 0),
    [activeAi]
  )
  const outMargin = useMemo(
    () => activeOut.reduce((s, o) => s + (o.monthly_commission || 0), 0),
    [activeOut]
  )
  const totalMargin = aiMargin + outMargin

  const isLoading = aiLoading || outLoading

  const aiOrdersList = useMemo(() => aiOrders || [], [aiOrders])
  const outOrdersList = useMemo(() => outOrders || [], [outOrders])

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">統合受注管理</h1>
        <p className="text-muted-foreground text-sm">
          AIツールと営業代行の全受注を統合的に管理します
        </p>
      </div>

      {/* サマリ */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              総MRR
            </CardTitle>
            <Package className="h-4 w-4 text-blue-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(totalMRR)}</div>
            <p className="text-xs text-muted-foreground mt-1">
              全 {activeAi.length + activeOut.length} 件の契約
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              総月額粗利
            </CardTitle>
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
              AIツール
            </CardTitle>
            <Bot className="h-4 w-4 text-purple-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(aiMRR)}</div>
            <p className="text-xs text-muted-foreground mt-1">
              {activeAi.length}件
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              営業代行
            </CardTitle>
            <Users className="h-4 w-4 text-green-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(outMRR)}</div>
            <p className="text-xs text-muted-foreground mt-1">
              {activeOut.length}件
            </p>
          </CardContent>
        </Card>
      </div>

      {/* 種別タブ */}
      <Tabs defaultValue="ai">
        <TabsList>
          <TabsTrigger value="ai">
            AIツール
            <Badge variant="secondary" className="ml-1.5 text-[10px] h-4 px-1">
              {aiOrdersList.length}
            </Badge>
          </TabsTrigger>
          <TabsTrigger value="outsourcing">
            営業代行
            <Badge variant="secondary" className="ml-1.5 text-[10px] h-4 px-1">
              {outOrdersList.length}
            </Badge>
          </TabsTrigger>
        </TabsList>

        <TabsContent value="ai">
          <Card>
            <CardContent className="pt-6">
              {isLoading ? (
                <div className="space-y-2">
                  {Array.from({ length: 5 }).map((_, i) => (
                    <div
                      key={i}
                      className="h-12 bg-muted animate-pulse rounded"
                    />
                  ))}
                </div>
              ) : aiOrdersList.length === 0 ? (
                <p className="text-sm text-muted-foreground text-center py-6">
                  AIツール受注がありません
                </p>
              ) : (
                <div className="space-y-2">
                  {aiOrdersList.map((order) => (
                    <div
                      key={order.id}
                      className="flex items-center justify-between rounded-lg border p-3 hover:bg-accent transition-colors"
                    >
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium truncate">
                          {order.company?.company_name || '-'}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          {getProductDisplayName(order.product)}
                          {order.plan ? ` / ${order.plan}` : ''}
                        </p>
                      </div>
                      <div className="text-right ml-4">
                        <p className="text-sm font-mono font-medium">
                          {formatCurrency(order.monthly_fee)}/月
                        </p>
                        <p className="text-xs text-muted-foreground">
                          粗利 {formatCurrency(order.monthly_margin)}
                        </p>
                      </div>
                      <Badge
                        variant="outline"
                        className={`ml-3 text-xs ${
                          order.status === '契約中' || !order.status
                            ? 'bg-green-50 text-green-700 border-green-200'
                            : 'bg-gray-50 text-gray-700'
                        }`}
                      >
                        {order.status || '契約中'}
                      </Badge>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="outsourcing">
          <Card>
            <CardContent className="pt-6">
              {isLoading ? (
                <div className="space-y-2">
                  {Array.from({ length: 5 }).map((_, i) => (
                    <div
                      key={i}
                      className="h-12 bg-muted animate-pulse rounded"
                    />
                  ))}
                </div>
              ) : outOrdersList.length === 0 ? (
                <p className="text-sm text-muted-foreground text-center py-6">
                  営業代行受注がありません
                </p>
              ) : (
                <div className="space-y-2">
                  {outOrdersList.map((order) => (
                    <div
                      key={order.id}
                      className="flex items-center justify-between rounded-lg border p-3 hover:bg-accent transition-colors"
                    >
                      <div className="flex-1 min-w-0">
                        <p className="text-sm font-medium truncate">
                          {order.company?.company_name || '-'}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          {order.service_type || '営業代行'}
                        </p>
                      </div>
                      <div className="text-right ml-4">
                        <p className="text-sm font-mono font-medium">
                          {formatCurrency(order.monthly_fee)}/月
                        </p>
                        <p className="text-xs text-muted-foreground">
                          手数料 {formatCurrency(order.monthly_commission)}
                        </p>
                      </div>
                      <Badge
                        variant="outline"
                        className={`ml-3 text-xs ${
                          order.status === '契約中' || !order.status
                            ? 'bg-green-50 text-green-700 border-green-200'
                            : 'bg-gray-50 text-gray-700'
                        }`}
                      >
                        {order.status || '契約中'}
                      </Badge>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  )
}
