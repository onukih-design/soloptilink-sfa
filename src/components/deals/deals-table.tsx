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
import { InlineEditCell } from './inline-edit-cell'
import { YomiSelectCell } from './yomi-select-cell'
import { formatDate } from '@/lib/utils/format'
import { PRODUCT_NAMES, type ProductKey } from '@/lib/constants/margins'
import { ArrowUpDown, ArrowUp, ArrowDown, ExternalLink } from 'lucide-react'
import Link from 'next/link'
import type { DealWithRelations, YomiStatus } from '@/types/deals'

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
