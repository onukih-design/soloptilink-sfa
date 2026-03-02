'use client'

import { Card, CardContent } from '@/components/ui/card'
import { formatCurrency, formatPercent } from '@/lib/utils/format'
import { Target } from 'lucide-react'

type Props = {
  data: {
    target: number
    actual: number
    achievementRate: number
  }
}

/**
 * 年間目標達成率プログレスバー
 * ダッシュボード上部に表示
 */
export function AnnualProgressBar({ data }: Props) {
  const progressPercent = Math.min(data.achievementRate * 100, 100)
  const barColor =
    progressPercent >= 80
      ? 'bg-green-500'
      : progressPercent >= 50
        ? 'bg-blue-500'
        : progressPercent >= 25
          ? 'bg-yellow-500'
          : 'bg-red-500'

  return (
    <Card>
      <CardContent className="pt-4 pb-4">
        <div className="flex items-center gap-4">
          <div className="rounded-lg p-2 bg-primary/10">
            <Target className="h-5 w-5 text-primary" />
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between mb-1">
              <span className="text-sm font-medium">
                年間売上目標 {formatCurrency(data.target)}
              </span>
              <span className="text-sm font-bold">
                {formatPercent(data.achievementRate, true, 1)} 達成
              </span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-3">
              <div
                className={`h-3 rounded-full transition-all duration-500 ${barColor}`}
                style={{ width: `${progressPercent}%` }}
              />
            </div>
            <div className="flex justify-between mt-1">
              <span className="text-xs text-muted-foreground">
                実績: {formatCurrency(data.actual)}
              </span>
              <span className="text-xs text-muted-foreground">
                残り: {formatCurrency(Math.max(0, data.target - data.actual))}
              </span>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  )
}
