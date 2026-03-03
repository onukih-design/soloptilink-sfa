'use client'

import { Sheet, SheetContent, SheetHeader, SheetTitle } from '@/components/ui/sheet'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { Badge } from '@/components/ui/badge'
import { useListDeals } from '@/hooks/use-list-analysis'
import { useInlineUpdateDeal } from '@/hooks/use-deals'
import { YomiSelectCell } from '@/components/deals/yomi-select-cell'
import { formatCurrency } from '@/lib/utils/format'
import { Loader2 } from 'lucide-react'
import type { YomiStatus } from '@/types/deals'

type Props = {
  listId: string | null
  listName: string
  open: boolean
  onOpenChange: (open: boolean) => void
}

export function ListDealsSheet({ listId, listName, open, onOpenChange }: Props) {
  const { data: deals, isLoading } = useListDeals(listId || '')
  const { mutate: updateDeal } = useInlineUpdateDeal()

  const handleYomiChange = (dealId: string, newStatus: YomiStatus) => {
    updateDeal({
      id: dealId,
      field: 'yomi_status',
      value: newStatus,
    })
  }

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent side="right" className="sm:max-w-[750px] overflow-y-auto">
        <SheetHeader>
          <SheetTitle className="flex items-center gap-2">
            {listName}
            {deals && (
              <Badge variant="outline" className="text-xs font-normal">
                {deals.length}件
              </Badge>
            )}
          </SheetTitle>
        </SheetHeader>

        <div className="mt-4">
          {isLoading ? (
            <div className="flex items-center justify-center h-40">
              <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
            </div>
          ) : !deals || deals.length === 0 ? (
            <div className="flex items-center justify-center h-40 text-muted-foreground">
              案件がありません
            </div>
          ) : (
            <div className="rounded-md border">
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead className="w-[50px]">No.</TableHead>
                    <TableHead className="min-w-[140px]">企業名</TableHead>
                    <TableHead className="w-[100px]">ヨミ</TableHead>
                    <TableHead className="w-[100px] text-right">金額</TableHead>
                    <TableHead className="w-[80px]">クローザー</TableHead>
                    <TableHead className="w-[80px]">アポインター</TableHead>
                    <TableHead className="min-w-[150px]">メモ</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {deals.map((deal) => (
                    <TableRow key={deal.id}>
                      <TableCell className="text-xs text-muted-foreground">
                        {deal.deal_number}
                      </TableCell>
                      <TableCell className="font-medium text-sm">
                        {deal.company?.company_name || '-'}
                      </TableCell>
                      <TableCell>
                        <YomiSelectCell
                          value={deal.yomi_status as YomiStatus}
                          onSave={(newStatus) => handleYomiChange(deal.id, newStatus)}
                        />
                      </TableCell>
                      <TableCell className="text-right text-sm font-mono">
                        {deal.amount ? formatCurrency(deal.amount) : '-'}
                      </TableCell>
                      <TableCell className="text-sm">
                        {deal.closer?.display_name || '-'}
                      </TableCell>
                      <TableCell className="text-sm">
                        {deal.appointer?.display_name || '-'}
                      </TableCell>
                      <TableCell>
                        <div
                          className="text-xs text-muted-foreground truncate max-w-[200px]"
                          title={deal.notes || ''}
                        >
                          {deal.notes || '-'}
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
          )}
        </div>
      </SheetContent>
    </Sheet>
  )
}
