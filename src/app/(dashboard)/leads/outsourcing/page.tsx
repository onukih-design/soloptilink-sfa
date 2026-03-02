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
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
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
  Phone,
} from 'lucide-react'
import type { DealWithRelations } from '@/types/deals'

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

export default function LeadsOutsourcingPage() {
  const { data: deals, isLoading, error } = useDeals(
    { yomiStatus: null, closerId: null, appointerId: null, listId: null, month: null, keyword: '' },
    { key: 'updated_at', order: 'desc' }
  )
  const [sorting, setSorting] = useState<SortingState>([])
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedStatus, setSelectedStatus] = useState<string>('all')

  // 営業代行向けリード: 受注・失注・消滅以外のアクティブな案件
  const leads = useMemo(() => {
    if (!deals) return []
    let filtered = deals.filter(
      (d) => !['受注', '失注', '消滅'].includes(d.yomi_status || '')
    )

    if (selectedStatus !== 'all') {
      filtered = filtered.filter((d) => d.yomi_status === selectedStatus)
    }

    if (searchQuery) {
      const q = searchQuery.toLowerCase()
      filtered = filtered.filter(
        (d) =>
          d.company?.company_name?.toLowerCase().includes(q) ||
          d.deal_name?.toLowerCase().includes(q) ||
          String(d.deal_number).includes(q)
      )
    }

    return filtered
  }, [deals, selectedStatus, searchQuery])

  const statusFilters = ['all', 'Aヨミ', 'Bヨミ', 'Cヨミ', 'ネタ', '没ネタ']

  // サマリ統計
  const stats = useMemo(() => {
    const activeLeads = deals?.filter(
      (d) => !['受注', '失注', '消滅'].includes(d.yomi_status || '')
    ) || []
    const totalAmount = activeLeads.reduce((sum, d) => sum + (d.amount || 0), 0)
    const withPhone = activeLeads.filter(
      (d) => d.company && 'phone' in d.company && d.company.phone
    ).length

    return {
      totalLeads: activeLeads.length,
      totalAmount,
      withPhone,
      avgAmount: activeLeads.length > 0 ? Math.floor(totalAmount / activeLeads.length) : 0,
    }
  }, [deals])

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
        id: 'list_name',
        accessorFn: (row) => row.list?.list_name || '',
        header: 'リスト',
        size: 140,
        cell: ({ row }) => (
          <span className="text-sm text-muted-foreground">
            {row.original.list?.list_name || '-'}
          </span>
        ),
      },
      {
        accessorKey: 'expected_close_date',
        header: '受注予定日',
        size: 110,
        cell: ({ row }) => (
          <span className="text-sm text-muted-foreground">
            {formatDate(row.original.expected_close_date)}
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
    data: leads,
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
        <h1 className="text-2xl font-bold tracking-tight">営業代行リード抽出</h1>
        <p className="text-muted-foreground text-sm">
          営業代行向けのリード候補を案件データから抽出・フィルタリングします
        </p>
      </div>

      {/* サマリカード */}
      <div className="grid gap-4 md:grid-cols-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
              <Users className="h-4 w-4" />
              アクティブリード
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalLeads}件</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
              <Building2 className="h-4 w-4" />
              パイプライン総額
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(stats.totalAmount)}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
              <Phone className="h-4 w-4" />
              平均案件額
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(stats.avgAmount)}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground flex items-center gap-1.5">
              <Filter className="h-4 w-4" />
              表示中
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{leads.length}件</div>
          </CardContent>
        </Card>
      </div>

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
                          <p>該当するリードがありません</p>
                          <p className="text-xs">フィルター条件を変更してください</p>
                        </div>
                      </TableCell>
                    </TableRow>
                  ) : (
                    table.getRowModel().rows.map((row) => (
                      <TableRow key={row.id} className="hover:bg-muted/50">
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
            {leads.length > 0 && (
              <div className="border-t px-4 py-2 text-xs text-muted-foreground">
                全 {leads.length} 件のリード
              </div>
            )}
          </>
        )}
      </div>
    </div>
  )
}
