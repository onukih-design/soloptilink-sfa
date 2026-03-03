'use client'

import { useMemo } from 'react'
import Link from 'next/link'
import { AlertTriangle, ChevronRight } from 'lucide-react'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { MOCK_FOLLOWUPS, MOCK_DEALS, MOCK_COMPANIES } from '@/lib/mock-data'

export function OverdueActions() {
  const overdueItems = useMemo(() => {
    const today = new Date()
    today.setHours(0, 0, 0, 0)

    // Get latest followup for each deal
    const latestFollowups = MOCK_FOLLOWUPS.filter(f => f.round === 'latest' && f.next_action_date)

    return latestFollowups
      .map(f => {
        const deadline = new Date(f.next_action_date!)
        const diffDays = Math.floor((today.getTime() - deadline.getTime()) / (1000 * 60 * 60 * 24))
        if (diffDays <= 0) return null

        const deal = MOCK_DEALS.find(d => d.id === f.deal_id)
        if (!deal) return null
        const company = MOCK_COMPANIES.find(c => c.id === deal.company_id)

        return {
          dealId: deal.id,
          companyName: company?.company_name || '不明',
          nextAction: f.next_action || '未設定',
          daysOverdue: diffDays,
          status: f.status,
        }
      })
      .filter(Boolean)
      .sort((a, b) => b!.daysOverdue - a!.daysOverdue)
      .slice(0, 10)
  }, [])

  if (overdueItems.length === 0) return null

  return (
    <Card className="border-red-200 bg-red-50/50">
      <CardHeader className="pb-3">
        <CardTitle className="text-sm font-medium flex items-center gap-2 text-red-700">
          <AlertTriangle className="h-4 w-4" />
          期限切れアクション ({overdueItems.length}件)
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-2">
        {overdueItems.map((item) => item && (
          <Link
            key={item.dealId}
            href={`/deals/${item.dealId}`}
            className="flex items-center justify-between p-2 rounded-md hover:bg-red-100/50 transition-colors"
          >
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate">{item.companyName}</p>
              <p className="text-xs text-muted-foreground truncate">{item.nextAction}</p>
            </div>
            <div className="flex items-center gap-2 ml-2">
              <span className="text-xs font-bold text-red-600">{item.daysOverdue}日超過</span>
              <ChevronRight className="h-3 w-3 text-muted-foreground" />
            </div>
          </Link>
        ))}
      </CardContent>
    </Card>
  )
}
