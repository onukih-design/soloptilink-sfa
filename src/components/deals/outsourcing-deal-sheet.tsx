'use client'

import { useState } from 'react'
import { Sheet, SheetContent, SheetHeader, SheetTitle } from '@/components/ui/sheet'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { CompanyLink } from '@/components/ui/company-link'
import { useDeal, useUpdateDeal, useInlineUpdateDeal } from '@/hooks/use-deals'
import { YomiSelectCell } from '@/components/deals/yomi-select-cell'
import { OutsourcingFollowupSection } from './outsourcing-followup-section'
import { formatCurrency, formatDate } from '@/lib/utils/format'
import { Loader2, Building2, Users, FileText, Clock } from 'lucide-react'
import { toast } from 'sonner'
import type { YomiStatus } from '@/types/deals'

const yomiColors: Record<string, string> = {
  '受注': 'bg-green-100 text-green-800 border-green-200',
  'Aヨミ': 'bg-blue-100 text-blue-800 border-blue-200',
  'Bヨミ': 'bg-cyan-100 text-cyan-800 border-cyan-200',
  'Cヨミ': 'bg-yellow-100 text-yellow-800 border-yellow-200',
  'ネタ': 'bg-purple-100 text-purple-800 border-purple-200',
  '没ネタ': 'bg-gray-100 text-gray-800 border-gray-200',
  '失注': 'bg-red-100 text-red-800 border-red-200',
  '消滅': 'bg-gray-100 text-gray-600 border-gray-200',
}

type Props = {
  dealId: string | null
  open: boolean
  onOpenChange: (open: boolean) => void
}

function InfoRow({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div className="flex justify-between items-start py-1.5 border-b last:border-0">
      <span className="text-xs text-muted-foreground shrink-0 w-24">{label}</span>
      <span className="text-sm text-right">{value || '-'}</span>
    </div>
  )
}

export function OutsourcingDealSheet({ dealId, open, onOpenChange }: Props) {
  const { data: deal, isLoading } = useDeal(dealId || '')
  const updateDeal = useUpdateDeal()
  const inlineUpdate = useInlineUpdateDeal()
  const [editingNotes, setEditingNotes] = useState(false)
  const [notesValue, setNotesValue] = useState('')

  // Cast deal relations for type safety
  const company = deal?.company as unknown as { id: string; company_name: string } | null
  const contact = deal?.contact as unknown as { id: string; last_name: string; first_name: string } | null
  const closer = deal?.closer as unknown as { id: string; display_name: string } | null
  const appointer = deal?.appointer as unknown as { id: string; display_name: string } | null
  const list = deal?.list as unknown as { id: string; list_name: string } | null
  const followups = (deal?.followups || []) as unknown as Array<{
    id: string
    followup_date: string
    followup_type: string
    content: string
    next_action: string | null
    next_action_date: string | null
    created_at: string
    created_by_user?: { display_name: string } | null
  }>

  const handleSaveNotes = () => {
    if (!deal) return
    updateDeal.mutate(
      { id: deal.id, data: { notes: notesValue } },
      {
        onSuccess: () => {
          toast.success('メモを更新しました')
          setEditingNotes(false)
        },
      }
    )
  }

  const handleYomiChange = (newStatus: YomiStatus) => {
    if (!deal) return
    inlineUpdate.mutate(
      { id: deal.id, field: 'yomi_status', value: newStatus },
      {
        onSuccess: () => {
          toast.success('ヨミステータスを更新しました')
        },
      }
    )
  }

  const startEditNotes = () => {
    setNotesValue(deal?.notes || '')
    setEditingNotes(true)
  }

  if (!dealId) return null

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent side="right" className="sm:max-w-[600px] overflow-y-auto p-0">
        {isLoading ? (
          <div className="flex items-center justify-center h-64">
            <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
          </div>
        ) : !deal ? (
          <div className="flex items-center justify-center h-64 text-muted-foreground">
            案件が見つかりません
          </div>
        ) : (
          <>
            {/* Header */}
            <div className="p-6 pb-0">
              <SheetHeader>
                <div className="flex items-start justify-between">
                  <div>
                    <SheetTitle className="text-lg">
                      {company?.company_name || deal.deal_name}
                    </SheetTitle>
                    <p className="text-xs text-muted-foreground mt-1">
                      案件 #{deal.deal_number}
                    </p>
                  </div>
                  <Badge
                    variant="outline"
                    className={`${yomiColors[deal.yomi_status || 'ネタ'] || ''}`}
                  >
                    {deal.yomi_status || 'ネタ'}
                  </Badge>
                </div>
              </SheetHeader>
            </div>

            {/* Tabs */}
            <Tabs defaultValue="info" className="mt-4">
              <TabsList className="w-full justify-start rounded-none border-b bg-transparent px-6">
                <TabsTrigger value="info" className="text-xs">
                  <Building2 className="h-3.5 w-3.5 mr-1" />
                  基本情報
                </TabsTrigger>
                <TabsTrigger value="progress" className="text-xs">
                  <Clock className="h-3.5 w-3.5 mr-1" />
                  進捗管理
                </TabsTrigger>
                <TabsTrigger value="history" className="text-xs">
                  <FileText className="h-3.5 w-3.5 mr-1" />
                  対応履歴
                </TabsTrigger>
              </TabsList>

              {/* Tab 1: 基本情報 */}
              <TabsContent value="info" className="px-6 pb-6 space-y-4">
                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm flex items-center gap-1.5">
                      <Building2 className="h-4 w-4" />
                      企業情報
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-0">
                    <InfoRow
                      label="企業名"
                      value={
                        company?.id && company?.company_name ? (
                          <CompanyLink companyId={company.id} companyName={company.company_name} className="text-sm" />
                        ) : (
                          company?.company_name || null
                        )
                      }
                    />
                    <InfoRow label="担当者" value={contact ? `${contact.last_name} ${contact.first_name || ''}`.trim() : null} />
                    <InfoRow label="リスト" value={list?.list_name} />
                    <InfoRow label="商品" value={deal.product} />
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm flex items-center gap-1.5">
                      <Users className="h-4 w-4" />
                      担当者
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-0">
                    <InfoRow label="クローザー" value={closer?.display_name} />
                    <InfoRow label="アポインター" value={appointer?.display_name} />
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm">金額</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-0">
                    <InfoRow label="総額" value={deal.amount ? formatCurrency(deal.amount) : null} />
                    <InfoRow label="月額" value={deal.monthly_amount ? formatCurrency(deal.monthly_amount) : null} />
                    <InfoRow label="初期費用" value={deal.initial_amount ? formatCurrency(deal.initial_amount) : null} />
                    <InfoRow label="契約月数" value={deal.contract_months ? `${deal.contract_months}ヶ月` : null} />
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm">日程</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-0">
                    <InfoRow label="受注予定日" value={formatDate(deal.expected_close_date)} />
                    <InfoRow label="受注日" value={formatDate(deal.closed_date)} />
                    <InfoRow label="契約開始日" value={formatDate(deal.contract_start_date)} />
                  </CardContent>
                </Card>

                {/* Notes card */}
                <Card>
                  <CardHeader className="pb-2">
                    <div className="flex items-center justify-between">
                      <CardTitle className="text-sm">メモ・備考</CardTitle>
                      {!editingNotes && (
                        <Button variant="ghost" size="sm" className="h-7 text-xs" onClick={startEditNotes}>
                          編集
                        </Button>
                      )}
                    </div>
                  </CardHeader>
                  <CardContent>
                    {editingNotes ? (
                      <div className="space-y-2">
                        <textarea
                          className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[120px] resize-y"
                          value={notesValue}
                          onChange={(e) => setNotesValue(e.target.value)}
                        />
                        <div className="flex gap-2 justify-end">
                          <Button variant="ghost" size="sm" onClick={() => setEditingNotes(false)}>
                            キャンセル
                          </Button>
                          <Button size="sm" onClick={handleSaveNotes}>保存</Button>
                        </div>
                      </div>
                    ) : (
                      <p className="text-sm whitespace-pre-wrap text-muted-foreground">
                        {deal.notes || 'メモなし'}
                      </p>
                    )}
                  </CardContent>
                </Card>
              </TabsContent>

              {/* Tab 2: 進捗管理 */}
              <TabsContent value="progress" className="px-6 pb-6 space-y-4">
                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm">ヨミステータス</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <YomiSelectCell
                      value={deal.yomi_status as YomiStatus || 'ネタ'}
                      onSave={handleYomiChange}
                    />
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader className="pb-2">
                    <CardTitle className="text-sm">失注理由</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p className="text-sm text-muted-foreground">
                      {deal.lost_reason || '-'}
                    </p>
                  </CardContent>
                </Card>
              </TabsContent>

              {/* Tab 3: 対応履歴 */}
              <TabsContent value="history" className="px-6 pb-6">
                <OutsourcingFollowupSection
                  dealId={deal.id}
                  followups={followups}
                />
              </TabsContent>
            </Tabs>
          </>
        )}
      </SheetContent>
    </Sheet>
  )
}
