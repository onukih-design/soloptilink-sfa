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
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { InlineEditCell } from './inline-edit-cell'
import { YomiSelectCell } from './yomi-select-cell'
import { formatDate } from '@/lib/utils/format'
import { PRODUCT_NAMES, type ProductKey } from '@/lib/constants/margins'
import { ArrowUpDown, ArrowUp, ArrowDown, ExternalLink, Clock, AlertCircle } from 'lucide-react'
import Link from 'next/link'
import type { DealWithRelations, DealFollowup, YomiStatus } from '@/types/deals'

type Props = {
  deals: DealWithRelations[]
  onInlineUpdate: (id: string, field: string, value: unknown) => void
  isUpdating: boolean
}

export function DealsTable({ deals, onInlineUpdate }: Props) {
  const [sorting, setSorting] = useState<SortingState>([
    { id: 'updated_at', desc: true },
  ])

  const columns = useMemo<ColumnDef<DealWithRelations>[]>(
    () => [
      {
        accessorKey: 'deal_number',
        header: '案件番号',
        size: 100,
        cell: ({ row }) => (
          <Link
            href={`/deals/${row.original.id}`}
            className="text-blue-600 hover:underline font-mono text-xs"
          >
            {row.original.deal_number}
          </Link>
        ),
      },
      {
        id: 'company_name',
        accessorFn: (row) => row.company?.company_name || '',
        header: '企業名',
        size: 180,
        cell: ({ row }) => (
          <div className="font-medium text-sm truncate max-w-[180px]">
            {row.original.company?.company_name || '-'}
          </div>
        ),
      },
      {
        accessorKey: 'deal_name',
        header: '案件名',
        size: 200,
        cell: ({ row }) => (
          <InlineEditCell
            value={row.original.deal_name}
            onSave={(v) => onInlineUpdate(row.original.id, 'deal_name', v)}
          />
        ),
      },
      {
        accessorKey: 'product',
        header: '商品',
        size: 140,
        cell: ({ row }) => {
          const product = row.original.product
          const name =
            product && product in PRODUCT_NAMES
              ? PRODUCT_NAMES[product as ProductKey]
              : product || '-'
          return <span className="text-sm">{name}</span>
        },
      },
      {
        accessorKey: 'yomi_status',
        header: 'ヨミ',
        size: 100,
        cell: ({ row }) => (
          <YomiSelectCell
            value={row.original.yomi_status as YomiStatus}
            onSave={(v) => onInlineUpdate(row.original.id, 'yomi_status', v)}
          />
        ),
      },
      {
        accessorKey: 'amount',
        header: () => <div className="text-right">総額</div>,
        size: 120,
        cell: ({ row }) => (
          <InlineEditCell
            value={row.original.amount}
            type="currency"
            onSave={(v) =>
              onInlineUpdate(
                row.original.id,
                'amount',
                Math.floor(Number(v) || 0)
              )
            }
          />
        ),
      },
      {
        accessorKey: 'monthly_amount',
        header: () => <div className="text-right">月額</div>,
        size: 110,
        cell: ({ row }) => (
          <InlineEditCell
            value={row.original.monthly_amount}
            type="currency"
            onSave={(v) =>
              onInlineUpdate(
                row.original.id,
                'monthly_amount',
                Math.floor(Number(v) || 0)
              )
            }
          />
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
        accessorKey: 'updated_at',
        header: '更新日',
        size: 100,
        cell: ({ row }) => (
          <span className="text-xs text-muted-foreground">
            {formatDate(row.original.updated_at)}
          </span>
        ),
      },
      {
        accessorKey: 'notes',
        header: 'メモ',
        size: 200,
        cell: ({ row }) => (
          <div
            className="text-sm truncate max-w-[190px] text-muted-foreground"
            title={row.original.notes || ''}
          >
            {row.original.notes || '-'}
          </div>
        ),
      },
      {
        id: 'latest_followup',
        header: '最終対応',
        size: 120,
        cell: ({ row }) => {
          const followups = row.original.followups || []
          const latest = followups.find((f: DealFollowup) => f.round === 'latest')
          if (!latest || !latest.status) return <span className="text-xs text-muted-foreground">-</span>

          const statusColors: Record<string, string> = {
            'A': 'bg-red-100 text-red-800',
            'B': 'bg-orange-100 text-orange-800',
            'C': 'bg-blue-100 text-blue-800',
            'ネタ': 'bg-purple-100 text-purple-800',
            '代理店A': 'bg-emerald-100 text-emerald-800',
            '失注': 'bg-gray-100 text-gray-800',
            '受注': 'bg-green-100 text-green-800',
            '没ネタ': 'bg-gray-100 text-gray-500',
            '消滅': 'bg-gray-100 text-gray-400',
          }

          return (
            <div className="flex flex-col gap-0.5">
              <Badge variant="outline" className={`text-[10px] px-1.5 py-0 ${statusColors[latest.status] || ''}`}>
                {latest.status}
              </Badge>
              <span className="text-[10px] text-muted-foreground">
                {latest.created_at ? new Date(latest.created_at).toLocaleDateString('ja-JP', { month: 'short', day: 'numeric' }) : ''}
              </span>
            </div>
          )
        },
      },
      {
        id: 'next_action',
        header: '次アクション',
        size: 160,
        cell: ({ row }) => {
          const followups = row.original.followups || []
          const latest = followups.find((f: DealFollowup) => f.round === 'latest')
          if (!latest?.next_action) return <span className="text-xs text-muted-foreground">-</span>
          return (
            <div className="text-xs truncate max-w-[150px]" title={latest.next_action}>
              {latest.next_action}
            </div>
          )
        },
      },
      {
        id: 'action_deadline',
        header: '期限',
        size: 100,
        cell: ({ row }) => {
          const followups = row.original.followups || []
          const latest = followups.find((f: DealFollowup) => f.round === 'latest')
          if (!latest?.next_action_date) return <span className="text-xs text-muted-foreground">-</span>

          const deadline = new Date(latest.next_action_date)
          const today = new Date()
          today.setHours(0, 0, 0, 0)
          const diffDays = Math.floor((deadline.getTime() - today.getTime()) / (1000 * 60 * 60 * 24))

          let colorClass = 'text-muted-foreground'
          if (diffDays < 0) colorClass = 'text-red-600 font-semibold'
          else if (diffDays <= 1) colorClass = 'text-amber-600 font-medium'
          else if (diffDays <= 3) colorClass = 'text-yellow-600'

          return (
            <div className="flex items-center gap-1">
              {diffDays < 0 && <AlertCircle className="h-3 w-3 text-red-500" />}
              {diffDays >= 0 && diffDays <= 1 && <Clock className="h-3 w-3 text-amber-500" />}
              <span className={`text-xs ${colorClass}`}>
                {deadline.toLocaleDateString('ja-JP', { month: 'short', day: 'numeric' })}
              </span>
            </div>
          )
        },
      },
      {
        id: 'actions',
        size: 40,
        enableSorting: false,
        cell: ({ row }) => (
          <Link href={`/deals/${row.original.id}`}>
            <Button variant="ghost" size="sm" className="h-7 w-7 p-0">
              <ExternalLink className="h-3.5 w-3.5" />
            </Button>
          </Link>
        ),
      },
    ],
    [onInlineUpdate]
  )

  const table = useReactTable({
    data: deals,
    columns,
    state: { sorting },
    onSortingChange: setSorting,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
  })

  return (
    <div className="rounded-md border bg-background">
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
                        {header.column.getCanSort() && (
                          <>
                            {header.column.getIsSorted() === 'asc' ? (
                              <ArrowUp className="h-3.5 w-3.5" />
                            ) : header.column.getIsSorted() === 'desc' ? (
                              <ArrowDown className="h-3.5 w-3.5" />
                            ) : (
                              <ArrowUpDown className="h-3.5 w-3.5 opacity-30" />
                            )}
                          </>
                        )}
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
                  className="h-32 text-center"
                >
                  <div className="text-muted-foreground">
                    <p className="font-medium">案件が見つかりません</p>
                    <p className="text-sm mt-1">
                      フィルターを変更するか、新しい案件を登録してください
                    </p>
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
                      className="py-1.5"
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
      {deals.length > 0 && (
        <div className="border-t px-4 py-2 text-xs text-muted-foreground">
          全 {deals.length} 件
        </div>
      )}
    </div>
  )
}
