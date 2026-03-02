'use client'

import Link from 'next/link'
import { useDashboardSummary } from '@/hooks/use-dashboard'
import { KpiCards } from '@/components/dashboard/kpi-cards'
import { PipelineChart } from '@/components/dashboard/pipeline-chart'
import { TodayActions } from '@/components/dashboard/today-actions'
import { RecentDeals } from '@/components/dashboard/recent-deals'
import { MonthlyProgressChart } from '@/components/dashboard/monthly-progress-chart'
import { AnnualProgressBar } from '@/components/dashboard/annual-progress-bar'
import { ArrowRight } from 'lucide-react'

/**
 * ダッシュボードページ
 * パイプライン・受注・MRR・アクション・最近の案件を一覧表示
 */
export default function DashboardPage() {
  const { data, isLoading, error } = useDashboardSummary()

  if (isLoading) {
    return <DashboardSkeleton />
  }

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

  if (!data) return null

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">ダッシュボード</h1>
          <p className="text-muted-foreground">
            案件パイプラインと売上の概要
          </p>
        </div>
        <Link
          href="/executive"
          className="flex items-center gap-1 text-sm text-primary hover:underline"
        >
          経営ダッシュボード
          <ArrowRight className="h-4 w-4" />
        </Link>
      </div>

      <AnnualProgressBar data={data.annualSummary} />

      <KpiCards data={data} />

      <div className="grid gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <PipelineChart data={data.pipelineByYomi} />
        </div>
        <div>
          <TodayActions followups={data.todayFollowups} />
        </div>
      </div>

      {data.monthlyProgress.length > 0 && (
        <MonthlyProgressChart data={data.monthlyProgress} />
      )}

      <RecentDeals deals={data.recentDeals} />
    </div>
  )
}

/**
 * ダッシュボードのローディングスケルトン
 */
function DashboardSkeleton() {
  return (
    <div className="space-y-6">
      <div>
        <div className="h-8 w-48 bg-muted animate-pulse rounded" />
        <div className="h-4 w-64 bg-muted animate-pulse rounded mt-2" />
      </div>
      <div className="h-16 bg-muted animate-pulse rounded-lg" />
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {Array.from({ length: 4 }).map((_, i) => (
          <div key={i} className="rounded-xl border bg-card p-6">
            <div className="h-4 w-24 bg-muted animate-pulse rounded" />
            <div className="h-8 w-32 bg-muted animate-pulse rounded mt-3" />
            <div className="h-3 w-20 bg-muted animate-pulse rounded mt-2" />
          </div>
        ))}
      </div>
      <div className="grid gap-6 lg:grid-cols-3">
        <div className="lg:col-span-2 rounded-xl border bg-card p-6">
          <div className="h-[300px] bg-muted animate-pulse rounded" />
        </div>
        <div className="rounded-xl border bg-card p-6">
          <div className="h-[300px] bg-muted animate-pulse rounded" />
        </div>
      </div>
      <div className="rounded-xl border bg-card p-6">
        <div className="h-4 w-40 bg-muted animate-pulse rounded" />
        <div className="space-y-3 mt-4">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="h-10 bg-muted animate-pulse rounded" />
          ))}
        </div>
      </div>
    </div>
  )
}
