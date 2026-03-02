'use client'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { formatCurrency, formatPercent } from '@/lib/utils/format'
import { Briefcase, TrendingUp, DollarSign, CalendarCheck } from 'lucide-react'
import type { DashboardSummary } from '@/hooks/use-dashboard'

type Props = {
  data: DashboardSummary
}

/**
 * KPIカード4枚
 * パイプライン総額・今月受注・MRR・本日のアクション
 */
export function KpiCards({ data }: Props) {
  const cards = [
    {
      title: 'パイプライン総額',
      value: formatCurrency(data.totalPipelineAmount),
      subValue: `加重: ${formatCurrency(data.totalWeightedAmount)}`,
      description: `${data.activeDealCount}件の案件`,
      icon: Briefcase,
      color: 'text-blue-600',
      bgColor: 'bg-blue-50',
    },
    {
      title: '今月受注',
      value: formatCurrency(data.wonAmountThisMonth),
      subValue: null,
      description: `${data.wonDealsThisMonth}件受注`,
      icon: DollarSign,
      color: 'text-green-600',
      bgColor: 'bg-green-50',
    },
    {
      title: 'MRR（月額売上）',
      value: formatCurrency(data.monthlyRevenue.currentMonth),
      subValue: `粗利: ${formatCurrency(data.monthlyRevenue.currentMargin)}`,
      description:
        data.monthlyRevenue.growthRate !== 0
          ? `前月比 ${data.monthlyRevenue.growthRate > 0 ? '+' : ''}${formatPercent(data.monthlyRevenue.growthRate, true)}`
          : '前月データなし',
      icon: TrendingUp,
      color:
        data.monthlyRevenue.growthRate >= 0
          ? 'text-emerald-600'
          : 'text-red-600',
      bgColor:
        data.monthlyRevenue.growthRate >= 0 ? 'bg-emerald-50' : 'bg-red-50',
    },
    {
      title: '本日のアクション',
      value: `${data.todayFollowups.length}件`,
      subValue: null,
      description:
        data.todayFollowups.length > 0 ? '対応が必要です' : '予定なし',
      icon: CalendarCheck,
      color:
        data.todayFollowups.length > 0 ? 'text-orange-600' : 'text-gray-600',
      bgColor:
        data.todayFollowups.length > 0 ? 'bg-orange-50' : 'bg-gray-50',
    },
  ]

  return (
    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
      {cards.map((card) => (
        <Card key={card.title}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              {card.title}
            </CardTitle>
            <div className={`rounded-lg p-2 ${card.bgColor}`}>
              <card.icon className={`h-4 w-4 ${card.color}`} />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{card.value}</div>
            {card.subValue && (
              <p className="text-xs text-muted-foreground mt-1">
                {card.subValue}
              </p>
            )}
            <p className={`text-xs mt-1 ${card.color}`}>{card.description}</p>
          </CardContent>
        </Card>
      ))}
    </div>
  )
}
