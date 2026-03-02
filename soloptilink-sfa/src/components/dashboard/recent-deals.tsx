'use client'

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import { formatCurrency, formatDate } from '@/lib/utils/format'
import Link from 'next/link'
import type { DashboardSummary } from '@/hooks/use-dashboard'

type Props = {
  deals: DashboardSummary['recentDeals']
}

/**
 * 最近更新された案件テーブル（上位10件）
 */
export function RecentDeals({ deals }: Props) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">最近更新された案件</CardTitle>
      </CardHeader>
      <CardContent>
        {deals.length === 0 ? (
          <p className="text-sm text-muted-foreground text-center py-6">
            案件データがありません
          </p>
        ) : (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-[80px]">案件番号</TableHead>
                <TableHead>企業名</TableHead>
                <TableHead>案件名</TableHead>
                <TableHead className="w-[90px]">ヨミ</TableHead>
                <TableHead className="text-right w-[120px]">金額</TableHead>
                <TableHead className="w-[100px]">更新日</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {deals.map((deal) => {
                const yomiConfig = YOMI_STATUSES.find(
                  (y) => y.name === deal.yomiStatus
                )
                return (
                  <TableRow key={deal.id}>
                    <TableCell>
                      <Link
                        href={`/deals/${deal.id}`}
                        className="text-blue-600 hover:underline text-xs font-mono"
                      >
                        {deal.dealNumber}
                      </Link>
                    </TableCell>
                    <TableCell className="font-medium text-sm truncate max-w-[200px]">
                      {deal.companyName}
                    </TableCell>
                    <TableCell className="text-sm truncate max-w-[200px]">
                      {deal.dealName}
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="outline"
                        style={{
                          borderColor: yomiConfig?.color || '#9CA3AF',
                          color: yomiConfig?.color || '#9CA3AF',
                          backgroundColor: `${yomiConfig?.color || '#9CA3AF'}15`,
                        }}
                        className="text-xs"
                      >
                        {deal.yomiStatus}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right text-sm font-mono">
                      {formatCurrency(deal.amount)}
                    </TableCell>
                    <TableCell className="text-xs text-muted-foreground">
                      {formatDate(deal.updatedAt)}
                    </TableCell>
                  </TableRow>
                )
              })}
            </TableBody>
          </Table>
        )}
      </CardContent>
    </Card>
  )
}
