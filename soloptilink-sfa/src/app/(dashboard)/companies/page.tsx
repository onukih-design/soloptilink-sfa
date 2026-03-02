'use client'

import { useState } from 'react'
import { useCompanyList } from '@/hooks/use-companies'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Plus, Search } from 'lucide-react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import {
  useReactTable,
  getCoreRowModel,
  flexRender,
  type ColumnDef,
} from '@tanstack/react-table'
import type { Tables } from '@/types/database'

export default function CompaniesPage() {
  const router = useRouter()
  const [keyword, setKeyword] = useState('')
  const [sort] = useState({ key: 'company_name', order: 'asc' as const })

  const { data: companies, isLoading, error } = useCompanyList({ keyword }, sort)

  const columns: ColumnDef<Tables<'companies'>>[] = [
    {
      accessorKey: 'company_name',
      header: '会社名',
      cell: ({ row }) => (
        <button
          onClick={() => router.push(`/companies/${row.original.id}`)}
          className="text-left font-medium text-primary hover:underline"
        >
          {row.original.company_name}
        </button>
      ),
    },
    {
      accessorKey: 'industry',
      header: '業種',
      cell: ({ row }) => row.original.industry || '-',
    },
    {
      accessorKey: 'phone',
      header: '電話番号',
      cell: ({ row }) => row.original.phone || '-',
    },
    {
      accessorKey: 'email',
      header: 'メール',
      cell: ({ row }) => row.original.email || '-',
    },
    {
      accessorKey: 'address',
      header: '住所',
      cell: ({ row }) => {
        const address = row.original.address
        if (!address) return '-'
        return (
          <span className="max-w-xs truncate block" title={address}>
            {address}
          </span>
        )
      },
    },
  ]

  const table = useReactTable({
    data: companies || [],
    columns,
    getCoreRowModel: getCoreRowModel(),
  })

  if (error) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <p className="text-destructive font-medium">
            データの取得に失敗しました
          </p>
          <p className="text-sm text-muted-foreground mt-1">
            ページを再読み込みしてください
          </p>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">会社管理</h1>
          <p className="text-muted-foreground text-sm">
            取引先企業の情報を管理します
          </p>
        </div>
        <Link href="/companies/new">
          <Button>
            <Plus className="h-4 w-4 mr-2" />
            新規会社追加
          </Button>
        </Link>
      </div>

      {/* 検索バー */}
      <div className="flex items-center gap-2">
        <div className="relative flex-1 max-w-sm">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="会社名で検索..."
            value={keyword}
            onChange={(e) => setKeyword(e.target.value)}
            className="pl-9"
          />
        </div>
      </div>

      {/* テーブル */}
      {isLoading ? (
        <div className="space-y-2">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="h-10 bg-muted animate-pulse rounded" />
          ))}
        </div>
      ) : companies && companies.length === 0 ? (
        <div className="flex items-center justify-center h-64 border rounded-lg">
          <div className="text-center">
            <p className="text-muted-foreground">会社が登録されていません</p>
            <Link href="/companies/new">
              <Button variant="outline" className="mt-4">
                <Plus className="h-4 w-4 mr-2" />
                最初の会社を追加
              </Button>
            </Link>
          </div>
        </div>
      ) : (
        <div className="border rounded-lg overflow-hidden">
          <table className="w-full">
            <thead className="bg-muted/50">
              {table.getHeaderGroups().map((headerGroup) => (
                <tr key={headerGroup.id}>
                  {headerGroup.headers.map((header) => (
                    <th
                      key={header.id}
                      className="px-4 py-3 text-left text-sm font-medium text-muted-foreground"
                    >
                      {flexRender(
                        header.column.columnDef.header,
                        header.getContext()
                      )}
                    </th>
                  ))}
                </tr>
              ))}
            </thead>
            <tbody>
              {table.getRowModel().rows.map((row) => (
                <tr
                  key={row.id}
                  className="border-t hover:bg-muted/50 transition-colors cursor-pointer"
                  onClick={() => router.push(`/companies/${row.original.id}`)}
                >
                  {row.getVisibleCells().map((cell) => (
                    <td key={cell.id} className="px-4 py-3 text-sm">
                      {flexRender(
                        cell.column.columnDef.cell,
                        cell.getContext()
                      )}
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {!isLoading && companies && companies.length > 0 && (
        <div className="text-sm text-muted-foreground">
          全 {companies.length} 件
        </div>
      )}
    </div>
  )
}
