'use client'

import { useMemo, useState } from 'react'
import {
  useReactTable,
  getCoreRowModel,
  getSortedRowModel,
  getFilteredRowModel,
  flexRender,
  type ColumnDef,
  type SortingState,
} from '@tanstack/react-table'
import { OutsourcingDealSheet } from '@/components/deals/outsourcing-deal-sheet'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Badge } from '@/components/ui/badge'
import { Input } from '@/components/ui/input'
import { useDeals } from '@/hooks/use-deals'
import { formatCurrency, formatDate } from '@/lib/utils/format'
import {
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  Search,
  Filter,
  Users,
  Building2,
  TrendingUp,
  Activity,
  BarChart3,
} from 'lucide-react'
import type { DealWithRelations } from '@/types/deals'
import { MOCK_LISTS, MOCK_COMPANIES } from '@/lib/mock-data'
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

const yomiColors: Record<string, string> = {
  '受注': 'bg-green-100 text-green-800 border-green-200',
  'Aヨミ': 'bg-blue-100 text-blue-800 border-blue-200',
  'Bヨミ': 'bg-cyan-100 text-cyan-800 border-cyan-200',
  'Cヨミ': 'bg-yellow-100 text-yellow-800 border-yellow-200',
  'ネタ': 'bg-purple-100 text-purple-800 border-purple-200',
  '没ネタ': 'bg-gray-100 text-gray-800 border-gray-200',
  '失注': 'bg-red-100 text-red-800 border-red-200',
  '消滅': 'bg-gray-100 text-gray-600 border-gray-200',
}

const CHART_COLORS = [
  '#22C55E', // 受注 - green
  '#3B82F6', // Aヨミ - blue
  '#06B6D4', // Bヨミ - cyan
  '#EAB308', // Cヨミ - yellow
  '#8B5CF6', // ネタ - purple
  '#6B7280', // 没ネタ - gray
  '#EF4444', // 失注 - red
  '#9CA3AF', // 消滅 - gray
]

export default function LeadsOutsourcingPage() {
  const { data: deals, isLoading, error } = useDeals(
    { yomiStatus: null, closerId: null, appointerId: null, listId: null, month: null, keyword: '' },
    { key: 'updated_at', order: 'desc' }
  )
  const [sorting, setSorting] = useState<SortingState>([])
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedStatus, setSelectedStatus] = useState<string>('all')
  const [selectedDealId, setSelectedDealId] = useState<string | null>(null)

  // 営業代行リストIDと企業IDを取得
  const outsourcingListId = useMemo(
    () => MOCK_LISTS.find((l) => l.list_name === '営業代行')?.id,
    []
  )
  const outsourcingCompanyIds = useMemo(
    () => new Set(MOCK_COMPANIES.filter((c) => c.list_name === '営業代行').map((c) => c.id)),
    []
  )

  // 営業代行の案件のみフィルター
  const outsourcingDeals = useMemo(() => {
    if (!deals) return []
    return deals.filter(
      (d) =>
        d.list_id === outsourcingListId || outsourcingCompanyIds.has(d.company_id || '')
    )
  }, [deals, outsourcingListId, outsourcingCompanyIds])

  // フィルター適用
  const filteredDeals = useMemo(() => {
    let result = outsourcingDeals

    if (selectedStatus !== 'all') {
      result = result.filter((d) => d.yomi_status === selectedStatus)
    }

    if (searchQuery) {
      const q = searchQuery.toLowerCase()
      result = result.filter(
        (d) =>
          d.company?.company_name?.toLowerCase().includes(q) ||
          d.deal_name?.toLowerCase().includes(q) ||
          String(d.deal_number).includes(q)
      )
    }

    return result
  }, [outsourcingDeals, selectedStatus, searchQuery])

  const statusFilters = [
    'all',
    '受注',
    'Aヨミ',
    'Bヨミ',
    'Cヨミ',
    'ネタ',
    '没ネタ',
    '失注',
    '消滅',
  ]

  // 分析サマリー統計
  const stats = useMemo(() => {
    const totalDeals = outsourcingDeals.length
    const wonDeals = outsourcingDeals.filter((d) => d.yomi_status === '受注').length
    const lostDeals = outsourcingDeals.filter((d) =>
      ['失注', '消滅'].includes(d.yomi_status || '')
    ).length
    const closeRate =
      wonDeals + lostDeals > 0 ? (wonDeals / (wonDeals + lostDeals)) * 100 : 0
    const activeDeals = outsourcingDeals.filter(
      (d) => !['受注', '失注', '消滅'].includes(d.yomi_status || '')
    ).length

    return {
      totalDeals,
      wonDeals,
      closeRate,
      activeDeals,
    }
  }, [outsourcingDeals])

  // ヨミステータス別件数（グラフ用）
  const yomiStatusData = useMemo(() => {
    const statusCount: Record<string, number> = {}
    outsourcingDeals.forEach((d) => {
      const status = d.yomi_status || 'ネタ'
      statusCount[status] = (statusCount[status] || 0) + 1
    })

    return Object.entries(statusCount)
      .map(([status, count]) => ({ status, count }))
      .sort((a, b) => b.count - a.count)
  }, [outsourcingDeals])

  // クローザー別成績
  const closerPerformance = useMemo(() => {
    const closerMap: Record<
      string,
      { name: string; totalDeals: number; wonDeals: number }
    > = {}

    outsourcingDeals.forEach((d) => {
      const closerId = d.closer_id || 'unassigned'
      const closerName = d.closer?.display_name || '未割当'

      if (!closerMap[closerId]) {
        closerMap[closerId] = { name: closerName, totalDeals: 0, wonDeals: 0 }
      }

      closerMap[closerId].totalDeals += 1
      if (d.yomi_status === '受注') {
        closerMap[closerId].wonDeals += 1
      }
    })

    return Object.values(closerMap)
      .map((c) => ({
        ...c,
        closeRate:
          c.totalDeals > 0
            ? Math.floor((c.wonDeals / (c.totalDeals || 1)) * 100)
            : 0,
      }))
      .sort((a, b) => b.wonDeals - a.wonDeals)
  }, [outsourcingDeals])

  // アポインター別アポ数
  const appointerPerformance = useMemo(() => {
    const appointerMap: Record<string, { name: string; appoCount: number }> = {}

    outsourcingDeals.forEach((d) => {
      const appointerId = d.appointer_id || 'unassigned'
      const appointerName = d.appointer?.display_name || '未割当'

      if (!appointerMap[appointerId]) {
        appointerMap[appointerId] = { name: appointerName, appoCount: 0 }
      }

      appointerMap[appointerId].appoCount += 1
    })

    return Object.values(appointerMap).sort((a, b) => b.appoCount - a.appoCount)
  }, [outsourcingDeals])

  const columns = useMemo<ColumnDef<DealWithRelations>[]>(
    () => [
      {
        accessorKey: 'deal_number',
        header: 'No.',
        size: 60,
        cell: ({ row }) => (
          <span className="text-sm font-mono text-muted-foreground">
            {row.original.deal_number}
          </span>
        ),
      },
      {
        id: 'company_name',
        accessorFn: (row) => row.company?.company_name || '',
        header: '企業名',
        size: 200,
        cell: ({ row }) => (
          <div>
            <div className="font-medium text-sm">
              {row.original.company?.company_name || '-'}
            </div>
            <div className="text-xs text-muted-foreground">
              {row.original.deal_name || ''}
            </div>
          </div>
        ),
      },
      {
        accessorKey: 'yomi_status',
        header: 'ヨミ',
        size: 90,
        cell: ({ row }) => {
          const status = row.original.yomi_status || 'ネタ'
          return (
            <Badge
              variant="outline"
              className={`text-xs ${yomiColors[status] || ''}`}
            >
              {status}
            </Badge>
          )
        },
      },
      {
        accessorKey: 'amount',
        header: () => <div className="text-right">金額</div>,
        size: 120,
        cell: ({ row }) => (
          <div className="text-right font-mono text-sm">
            {formatCurrency(row.original.amount)}
          </div>
        ),
      },
      {
        id: 'appointer_name',
        accessorFn: (row) => row.appointer?.display_name || '',
        header: 'アポインター',
        size: 100,
        cell: ({ row }) => (
          <span className="text-sm">
            {row.original.appointer?.display_name || '-'}
          </span>
        ),
      },
      {
        id: 'closer_name',
        accessorFn: (row) => row.closer?.display_name || '',
        header: 'クローザー',
        size: 100,
        cell: ({ row }) => (
          <span className="text-sm">
            {row.original.closer?.display_name || '-'}
          </span>
        ),
      },
      {
        accessorKey: 'notes',
        header: 'メモ',
        size: 180,
        cell: ({ row }) => (
          <div className="text-sm truncate max-w-[170px] text-muted-foreground">
            {row.original.notes || '-'}
          </div>
        ),
      },
      {
        accessorKey: 'updated_at',
        header: '更新日',
        size: 100,
        cell: ({ row }) => (
          <span className="text-sm text-muted-foreground">
            {formatDate(row.original.updated_at)}
          </span>
        ),
      },
    ],
    []
  )

  const table = useReactTable({
    data: filteredDeals,
    columns,
    state: { sorting },
    onSortingChange: setSorting,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
  })

  if (error) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-destructive">データの取得に失敗しました</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">営業代行管理</h1>
        <p className="text-muted-foreground text-sm">
          営業代行リストの案件データ管理・分析
        </p>
      </div>

      <Tabs defaultValue="deals" className="space-y-4">
        <TabsList>
          <TabsTrigger value="deals" className="flex items-center gap-1.5">
            <Building2 className="h-3.5 w-3.5" />
            案件一覧
          </TabsTrigger>
          <TabsTrigger value="analysis" className="flex items-center gap-1.5">
            <BarChart3 className="h-3.5 w-3.5" />
            分析サマリー
          </TabsTrigger>
        </TabsList>

        {/* タブ1: 案件一覧 */}
        <TabsContent value="deals" className="space-y-4">
          {/* フィルターバー */}
          <div className="flex flex-col sm:flex-row gap-3">
            <div className="relative flex-1 max-w-sm">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder="企業名・案件名で検索..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-9"
              />
            </div>
            <div className="flex gap-1.5 flex-wrap">
              {statusFilters.map((status) => (
                <button
                  key={status}
                  onClick={() => setSelectedStatus(status)}
                  className={`px-3 py-1.5 text-xs font-medium rounded-full transition-colors ${
                    selectedStatus === status
                      ? 'bg-primary text-primary-foreground'
                      : 'bg-muted text-muted-foreground hover:bg-muted/80'
                  }`}
                >
                  {status === 'all' ? 'すべて' : status}
                </button>
              ))}
            </div>
          </div>

          {/* テーブル */}
          <div className="rounded-md border bg-background">
            {isLoading ? (
              <div className="space-y-2 p-4">
                {Array.from({ length: 8 }).map((_, i) => (
                  <div key={i} className="h-10 bg-muted animate-pulse rounded" />
                ))}
              </div>
            ) : (
              <>
                <div className="overflow-x-auto">
                  <Table>
                    <TableHeader>
                      {table.getHeaderGroups().map((headerGroup) => (
                        <TableRow key={headerGroup.id}>
                          {headerGroup.headers.map((header) => (
                            <TableHead
                              key={header.id}
                              style={{ width: header.getSize() }}
                              className="whitespace-nowrap"
                            >
                              {header.isPlaceholder ? null : (
                                <div
                                  className={
                                    header.column.getCanSort()
                                      ? 'flex items-center gap-1 cursor-pointer select-none hover:text-foreground'
                                      : ''
                                  }
                                  onClick={header.column.getToggleSortingHandler()}
                                >
                                  {flexRender(
                                    header.column.columnDef.header,
                                    header.getContext()
                                  )}
                                  {header.column.getCanSort() &&
                                    (header.column.getIsSorted() === 'asc' ? (
                                      <ArrowUp className="h-3.5 w-3.5" />
                                    ) : header.column.getIsSorted() === 'desc' ? (
                                      <ArrowDown className="h-3.5 w-3.5" />
                                    ) : (
                                      <ArrowUpDown className="h-3.5 w-3.5 opacity-30" />
                                    ))}
                                </div>
                              )}
                            </TableHead>
                          ))}
                        </TableRow>
                      ))}
                    </TableHeader>
                    <TableBody>
                      {table.getRowModel().rows.length === 0 ? (
                        <TableRow>
                          <TableCell
                            colSpan={columns.length}
                            className="h-32 text-center text-muted-foreground"
                          >
                            <div className="flex flex-col items-center gap-2">
                              <Filter className="h-8 w-8 opacity-30" />
                              <p>該当する案件がありません</p>
                              <p className="text-xs">フィルター条件を変更してください</p>
                            </div>
                          </TableCell>
                        </TableRow>
                      ) : (
                        table.getRowModel().rows.map((row) => (
                          <TableRow
                            key={row.id}
                            className="hover:bg-muted/50 cursor-pointer"
                            onClick={() => setSelectedDealId(row.original.id)}
                          >
                            {row.getVisibleCells().map((cell) => (
                              <TableCell
                                key={cell.id}
                                style={{ width: cell.column.getSize() }}
                                className="py-2"
                              >
                                {flexRender(
                                  cell.column.columnDef.cell,
                                  cell.getContext()
                                )}
                              </TableCell>
                            ))}
                          </TableRow>
                        ))
                      )}
                    </TableBody>
                  </Table>
                </div>
                {filteredDeals.length > 0 && (
                  <div className="border-t px-4 py-2 text-xs text-muted-foreground">
                    全 {filteredDeals.length} 件の案件
                  </div>
                )}
              </>
            )}
          </div>
        </TabsContent>

        {/* タブ2: 分析サマリー */}
        <TabsContent value="analysis" className="space-y-4">
          {/* サマリーカード */}
          <div className="grid gap-4 md:grid-cols-4">
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
                  <Building2 className="h-4 w-4" />
                  総案件数
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{stats.totalDeals}件</div>
              </CardContent>
            </Card>
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
                  <TrendingUp className="h-4 w-4" />
                  受注件数
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-green-600">
                  {stats.wonDeals}件
                </div>
              </CardContent>
            </Card>
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
                  <BarChart3 className="h-4 w-4" />
                  受注率
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">
                  {Math.floor(stats.closeRate)}%
                </div>
              </CardContent>
            </Card>
            <Card>
              <CardHeader className="pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
                  <Activity className="h-4 w-4" />
                  アクティブ案件
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-blue-600">
                  {stats.activeDeals}件
                </div>
              </CardContent>
            </Card>
          </div>

          {/* ヨミステータス別件数グラフ */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">ヨミステータス別件数</CardTitle>
            </CardHeader>
            <CardContent>
              {isLoading ? (
                <div className="h-80 bg-muted animate-pulse rounded" />
              ) : yomiStatusData.length === 0 ? (
                <div className="h-80 flex items-center justify-center text-muted-foreground">
                  データがありません
                </div>
              ) : (
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={yomiStatusData} layout="vertical">
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis type="number" />
                    <YAxis dataKey="status" type="category" width={80} />
                    <Tooltip />
                    <Bar dataKey="count" radius={[0, 4, 4, 0]}>
                      {yomiStatusData.map((entry, index) => (
                        <Cell
                          key={`cell-${index}`}
                          fill={CHART_COLORS[index % CHART_COLORS.length]}
                        />
                      ))}
                    </Bar>
                  </BarChart>
                </ResponsiveContainer>
              )}
            </CardContent>
          </Card>

          {/* クローザー別成績テーブル */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base flex items-center gap-2">
                <Users className="h-4 w-4" />
                クローザー別成績
              </CardTitle>
            </CardHeader>
            <CardContent>
              {isLoading ? (
                <div className="space-y-2">
                  {Array.from({ length: 5 }).map((_, i) => (
                    <div key={i} className="h-8 bg-muted animate-pulse rounded" />
                  ))}
                </div>
              ) : (
                <div className="rounded-md border">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>担当者</TableHead>
                        <TableHead className="text-right">案件数</TableHead>
                        <TableHead className="text-right">受注数</TableHead>
                        <TableHead className="text-right">受注率</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {closerPerformance.length === 0 ? (
                        <TableRow>
                          <TableCell
                            colSpan={4}
                            className="text-center text-muted-foreground h-20"
                          >
                            データがありません
                          </TableCell>
                        </TableRow>
                      ) : (
                        closerPerformance.map((closer, idx) => (
                          <TableRow key={idx}>
                            <TableCell className="font-medium">
                              {closer.name}
                            </TableCell>
                            <TableCell className="text-right">
                              {closer.totalDeals}
                            </TableCell>
                            <TableCell className="text-right text-green-600 font-semibold">
                              {closer.wonDeals}
                            </TableCell>
                            <TableCell className="text-right">
                              {closer.closeRate}%
                            </TableCell>
                          </TableRow>
                        ))
                      )}
                    </TableBody>
                  </Table>
                </div>
              )}
            </CardContent>
          </Card>

          {/* アポインター別アポ数テーブル */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base flex items-center gap-2">
                <Users className="h-4 w-4" />
                アポインター別アポ数
              </CardTitle>
            </CardHeader>
            <CardContent>
              {isLoading ? (
                <div className="space-y-2">
                  {Array.from({ length: 5 }).map((_, i) => (
                    <div key={i} className="h-8 bg-muted animate-pulse rounded" />
                  ))}
                </div>
              ) : (
                <div className="rounded-md border">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>担当者</TableHead>
                        <TableHead className="text-right">アポ数</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {appointerPerformance.length === 0 ? (
                        <TableRow>
                          <TableCell
                            colSpan={2}
                            className="text-center text-muted-foreground h-20"
                          >
                            データがありません
                          </TableCell>
                        </TableRow>
                      ) : (
                        appointerPerformance.map((appointer, idx) => (
                          <TableRow key={idx}>
                            <TableCell className="font-medium">
                              {appointer.name}
                            </TableCell>
                            <TableCell className="text-right font-semibold text-blue-600">
                              {appointer.appoCount}
                            </TableCell>
                          </TableRow>
                        ))
                      )}
                    </TableBody>
                  </Table>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>

      <OutsourcingDealSheet
        dealId={selectedDealId}
        open={!!selectedDealId}
        onOpenChange={(open) => {
          if (!open) setSelectedDealId(null)
        }}
      />
    </div>
  )
}
