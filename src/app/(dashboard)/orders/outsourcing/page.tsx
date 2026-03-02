'use client'

import { useMemo, useState } from 'react'
import {
  useReactTable,
  getCoreRowModel,
  getSortedRowModel,
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
import { useSalesOutsourcingOrders } from '@/hooks/use-orders'
import { formatCurrency, formatDate, formatPercent } from '@/lib/utils/format'
import { ArrowUpDown, ArrowUp, ArrowDown } from 'lucide-react'
import type { SalesOutsourcingOrderWithRelations } from '@/types/orders'

const statusColors: Record<string, string> = {
  '契約中': 'bg-green-100 text-green-800 border-green-200',
  '解約予定': 'bg-yellow-100 text-yellow-800 border-yellow-200',
  '解約済み': 'bg-gray-100 text-gray-800 border-gray-200',
  '休止中': 'bg-orange-100 text-orange-800 border-orange-200',
}

export default function OutsourcingOrdersPage() {
  const { data: orders, isLoading, error } = useSalesOutsourcingOrders()
  const [sorting, setSorting] = useState<SortingState>([])

  const columns = useMemo<ColumnDef<SalesOutsourcingOrderWithRelations>[]>(
    () => [
      {
        id: 'company_name',
        accessorFn: (row) => row.company?.company_name || '',
        header: '企業名',
        size: 180,
        cell: ({ row }) => (
          <span className="font-medium text-sm">
            {row.original.company?.company_name || '-'}
          </span>
        ),
      },
      {
        accessorKey: 'service_type',
        header: 'サービス種別',
        size: 140,
        cell: ({ row }) => (
          <span className="text-sm">{row.original.service_type || '-'}</span>
        ),
      },
      {
        accessorKey: 'monthly_fee',
        header: () => <div className="text-right">月額</div>,
        size: 120,
        cell: ({ row }) => (
          <div className="text-right font-mono text-sm">
            {formatCurrency(row.original.monthly_fee)}
          </div>
        ),
      },
      {
        accessorKey: 'monthly_commission',
        header: () => <div className="text-right">月額手数料</div>,
        size: 120,
        cell: ({ row }) => (
          <div className="text-right font-mono text-sm">
            {formatCurrency(row.original.monthly_commission)}
          </div>
        ),
      },
      {
        accessorKey: 'commission_rate',
        header: '手数料率',
        size: 90,
        cell: ({ row }) => (
          <span className="text-sm">
            {formatPercent(row.original.commission_rate, true)}
          </span>
        ),
      },
      {
        accessorKey: 'initial_fee',
        header: () => <div className="text-right">初期費用</div>,
        size: 110,
        cell: ({ row }) => (
          <div className="text-right font-mono text-sm">
            {formatCurrency(row.original.initial_fee)}
          </div>
        ),
      },
      {
        accessorKey: 'contract_start_date',
        header: '契約開始',
        size: 110,
        cell: ({ row }) => (
          <span className="text-sm text-muted-foreground">
            {formatDate(row.original.contract_start_date)}
          </span>
        ),
      },
      {
        accessorKey: 'status',
        header: 'ステータス',
        size: 100,
        cell: ({ row }) => {
          const status = row.original.status || '契約中'
          return (
            <Badge
              variant="outline"
              className={`text-xs ${statusColors[status] || ''}`}
            >
              {status}
            </Badge>
          )
        },
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
    ],
    []
  )

  const tableData = useMemo(() => orders || [], [orders])

  const table = useReactTable({
    data: tableData,
    columns,
    state: { sorting },
    onSortingChange: setSorting,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
  })

  // サマリ統計
  const activeOrders = useMemo(
    () => tableData.filter((o) => o.status === '契約中' || !o.status),
    [tableData]
  )
  const totalMRR = useMemo(
    () => activeOrders.reduce((sum, o) => sum + (o.monthly_fee || 0), 0),
    [activeOrders]
  )
  const totalCommission = useMemo(
    () =>
      activeOrders.reduce((sum, o) => sum + (o.monthly_commission || 0), 0),
    [activeOrders]
  )

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
        <h1 className="text-2xl font-bold tracking-tight">営業代行受注一覧</h1>
        <p className="text-muted-foreground text-sm">
          営業代行サービスの受注・契約状況を管理します
        </p>
      </div>

      {/* サマリカード */}
      <div className="grid gap-4 md:grid-cols-3">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              契約中件数
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{activeOrders.length}件</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              月額売上合計
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{formatCurrency(totalMRR)}</div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              月額手数料合計
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {formatCurrency(totalCommission)}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* テーブル */}
      <div className="rounded-md border bg-background">
        {isLoading ? (
          <div className="space-y-2 p-4">
            {Array.from({ length: 6 }).map((_, i) => (
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
                        受注データがありません
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
            {tableData.length > 0 && (
              <div className="border-t px-4 py-2 text-xs text-muted-foreground">
                全 {tableData.length} 件
              </div>
            )}
          </>
        )}
      </div>
    </div>
  )
}
