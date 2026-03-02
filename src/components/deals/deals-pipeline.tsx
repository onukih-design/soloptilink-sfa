'use client'

import type { DealWithRelations } from '@/types/deals'
import type { YomiStatus } from '@/types/deals'
import Link from 'next/link'
import { Badge } from '@/components/ui/badge'
import { AlertCircle } from 'lucide-react'
import { formatCurrency } from '@/lib/utils/format'

type Props = {
  deals: DealWithRelations[]
}

type ColumnConfig = {
  status: YomiStatus
  label: string
  color: string
}

const COLUMNS: ColumnConfig[] = [
  { status: 'ネタ', label: 'ネタ', color: 'bg-purple-100 border-purple-300 text-purple-900' },
  { status: 'Cヨミ', label: 'Cヨミ', color: 'bg-blue-100 border-blue-300 text-blue-900' },
  { status: 'Bヨミ', label: 'Bヨミ', color: 'bg-orange-100 border-orange-300 text-orange-900' },
  { status: 'Aヨミ', label: 'Aヨミ', color: 'bg-red-100 border-red-300 text-red-900' },
  { status: '受注', label: '受注', color: 'bg-green-100 border-green-300 text-green-900' },
]

const EXCLUDED_STATUSES: YomiStatus[] = ['失注', '没ネタ', '消滅']

export function DealsPipeline({ deals }: Props) {
  // 除外ステータスをフィルタ
  const activeDeals = deals.filter(
    (deal) => !EXCLUDED_STATUSES.includes(deal.yomi_status as YomiStatus)
  )

  // ステータスごとにグループ化
  const groupedDeals = COLUMNS.reduce((acc, column) => {
    acc[column.status] = activeDeals.filter(
      (deal) => deal.yomi_status === column.status
    )
    return acc
  }, {} as Record<YomiStatus, DealWithRelations[]>)

  return (
    <div className="overflow-x-auto pb-4">
      <div className="flex gap-4 min-w-max">
        {COLUMNS.map((column) => (
          <div key={column.status} className="flex-shrink-0 w-[280px]">
            <div
              className={`rounded-lg border-2 ${column.color} px-3 py-2 mb-3 flex items-center justify-between`}
            >
              <h3 className="font-semibold text-sm">{column.label}</h3>
              <Badge variant="secondary" className="ml-2">
                {groupedDeals[column.status]?.length || 0}
              </Badge>
            </div>

            <div className="space-y-3">
              {groupedDeals[column.status]?.map((deal) => (
                <DealCard key={deal.id} deal={deal} />
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

function DealCard({ deal }: { deal: DealWithRelations }) {
  const latestFollowup = deal.followups?.[0]
  const nextActionDate = latestFollowup?.next_action_date
  const isOverdue =
    nextActionDate &&
    new Date(nextActionDate) < new Date(new Date().setHours(0, 0, 0, 0))

  return (
    <Link href={`/deals/${deal.id}`}>
      <div className="bg-white border rounded-lg p-3 hover:shadow-md transition-shadow cursor-pointer">
        {/* 会社名 */}
        <h4 className="font-semibold text-sm mb-1 truncate">
          {deal.company.company_name}
        </h4>

        {/* 案件名 */}
        <p className="text-xs text-muted-foreground mb-2 truncate">
          {deal.deal_name}
        </p>

        {/* クローザー */}
        {deal.closer && (
          <p className="text-xs text-muted-foreground mb-2">
            担当: {deal.closer.display_name}
          </p>
        )}

        {/* 金額 */}
        {deal.amount && deal.amount > 0 && (
          <p className="text-sm font-semibold mb-2">
            {formatCurrency(deal.amount)}
          </p>
        )}

        {/* 最新フォローアップ */}
        {latestFollowup && (
          <div className="mb-2">
            <Badge
              variant="outline"
              className={`text-xs ${getFollowupTypeColor(latestFollowup.followup_type)}`}
            >
              {latestFollowup.followup_type}
            </Badge>
          </div>
        )}

        {/* 次回アクション */}
        {nextActionDate && (
          <div
            className={`flex items-center gap-1 text-xs ${
              isOverdue ? 'text-red-600 font-medium' : 'text-muted-foreground'
            }`}
          >
            {isOverdue && <AlertCircle className="h-3 w-3" />}
            <span>
              {new Date(nextActionDate).toLocaleDateString('ja-JP', {
                month: 'short',
                day: 'numeric',
              })}
            </span>
          </div>
        )}
      </div>
    </Link>
  )
}

function getFollowupTypeColor(followupType: string): string {
  switch (followupType) {
    case '電話':
      return 'bg-blue-50 text-blue-700 border-blue-200'
    case 'メール':
      return 'bg-purple-50 text-purple-700 border-purple-200'
    case '訪問':
      return 'bg-orange-50 text-orange-700 border-orange-200'
    case 'Web会議':
      return 'bg-green-50 text-green-700 border-green-200'
    case 'その他':
      return 'bg-gray-50 text-gray-700 border-gray-200'
    default:
      return 'bg-gray-50 text-gray-700 border-gray-200'
  }
}
