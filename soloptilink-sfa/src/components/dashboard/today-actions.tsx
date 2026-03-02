'use client'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { CalendarCheck, ArrowRight } from 'lucide-react'
import Link from 'next/link'
import type { DashboardSummary } from '@/hooks/use-dashboard'

type Props = {
  followups: DashboardSummary['todayFollowups']
}

/**
 * 本日のアクション一覧
 * フォローアップ予定がある案件をリスト表示
 */
export function TodayActions({ followups }: Props) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base flex items-center gap-2">
          <CalendarCheck className="h-4 w-4" />
          本日のアクション
          {followups.length > 0 && (
            <Badge variant="destructive" className="ml-auto">
              {followups.length}件
            </Badge>
          )}
        </CardTitle>
      </CardHeader>
      <CardContent>
        {followups.length === 0 ? (
          <p className="text-sm text-muted-foreground text-center py-6">
            本日予定されているアクションはありません
          </p>
        ) : (
          <div className="space-y-3">
            {followups.map((followup) => (
              <Link
                key={followup.id}
                href={`/deals/${followup.dealId}`}
                className="flex items-center justify-between rounded-lg border p-3 hover:bg-accent transition-colors"
              >
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium truncate">
                    {followup.companyName}
                  </p>
                  <p className="text-xs text-muted-foreground truncate">
                    {followup.dealName}
                  </p>
                  <p className="text-xs text-orange-600 mt-1">
                    {followup.nextAction}
                  </p>
                </div>
                <ArrowRight className="h-4 w-4 text-muted-foreground shrink-0 ml-2" />
              </Link>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  )
}
