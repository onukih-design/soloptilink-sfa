'use client'

import { useState, useCallback } from 'react'
import { useDeals, useInlineUpdateDeal } from '@/hooks/use-deals'
import { useFilterStore } from '@/stores/filter-store'
import { DealsFilterBar } from '@/components/deals/deals-filter-bar'
import { DealsTable } from '@/components/deals/deals-table'
import { Button } from '@/components/ui/button'
import { Plus } from 'lucide-react'
import Link from 'next/link'
import { toast } from 'sonner'
import type { DealSort } from '@/types/deals'

export default function DealsPage() {
  const filters = useFilterStore()
  const [sort] = useState<DealSort>({ key: 'updated_at', order: 'desc' })

  const { data: deals, isLoading, error } = useDeals(
    {
      yomiStatus: filters.yomiStatus,
      closerId: filters.closerId,
      appointerId: filters.appointerId,
      listId: filters.listId,
      month: filters.month,
      keyword: filters.keyword,
    },
    sort
  )

  const inlineUpdate = useInlineUpdateDeal()

  const handleInlineUpdate = useCallback(
    (id: string, field: string, value: unknown) => {
      inlineUpdate.mutate(
        { id, field, value },
        {
          onSuccess: () => {
            toast.success('更新しました')
          },
          onError: (err) => {
            toast.error('更新に失敗しました')
            console.error(err)
          },
        }
      )
    },
    [inlineUpdate]
  )

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
          <h1 className="text-2xl font-bold tracking-tight">案件一覧</h1>
          <p className="text-muted-foreground text-sm">
            案件の管理・進捗確認を行います
          </p>
        </div>
        <Link href="/deals/new">
          <Button>
            <Plus className="h-4 w-4 mr-2" />
            新規案件
          </Button>
        </Link>
      </div>

      <DealsFilterBar />

      {isLoading ? (
        <div className="space-y-2">
          {Array.from({ length: 8 }).map((_, i) => (
            <div key={i} className="h-10 bg-muted animate-pulse rounded" />
          ))}
        </div>
      ) : (
        <DealsTable
          deals={deals || []}
          onInlineUpdate={handleInlineUpdate}
          isUpdating={inlineUpdate.isPending}
        />
      )}
    </div>
  )
}
