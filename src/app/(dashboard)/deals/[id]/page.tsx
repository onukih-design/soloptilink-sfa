'use client'

import { useState } from 'react'
import { useParams, useRouter } from 'next/navigation'
import {
  useDeal,
  useUpdateDeal,
  useDeleteDeal,
  useAddFollowup,
} from '@/hooks/use-deals'
import { DealForm } from '@/components/deals/deal-form'
import { YomiBadge } from '@/components/deals/yomi-badge'
import { CompanyLink } from '@/components/ui/company-link'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from '@/components/ui/tabs'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogFooter,
  DialogClose,
} from '@/components/ui/dialog'
import { formatCurrency, formatDate } from '@/lib/utils/format'
import { PRODUCT_NAMES } from '@/lib/constants/margins'
import type { ProductKey } from '@/lib/constants/margins'
import { getMarginRateSafe } from '@/lib/utils/margin'
import {
  ArrowLeft,
  Trash2,
  Plus,
  Phone,
  Mail,
  Video,
  Users,
  MessageSquare,
  Loader2,
} from 'lucide-react'
import Link from 'next/link'
import { toast } from 'sonner'
import type { DealFormValues } from '@/lib/validators/deal'
import type { FollowupType, DealFollowup } from '@/types/deals'
import type { LucideIcon } from 'lucide-react'

const followupTypeIcons: Record<string, LucideIcon> = {
  '電話': Phone,
  'メール': Mail,
  'Web会議': Video,
  '訪問': Users,
  'その他': MessageSquare,
}

function InfoRow({
  label,
  value,
  mono,
}: {
  label: string
  value: React.ReactNode
  mono?: boolean
}) {
  return (
    <div className="flex items-center justify-between">
      <span className="text-sm text-muted-foreground">{label}</span>
      <span className={`text-sm font-medium ${mono ? 'font-mono' : ''}`}>
        {value}
      </span>
    </div>
  )
}

export default function DealDetailPage() {
  const params = useParams()
  const router = useRouter()
  const id = params.id as string

  const { data: deal, isLoading, error } = useDeal(id)
  const updateDeal = useUpdateDeal()
  const deleteDeal = useDeleteDeal()
  const addFollowup = useAddFollowup()

  const [activeTab, setActiveTab] = useState('detail')
  const [showDeleteDialog, setShowDeleteDialog] = useState(false)

  // 対応履歴フォームの状態
  const [followupForm, setFollowupForm] = useState({
    followup_date: new Date().toISOString().split('T')[0],
    followup_type: '電話' as FollowupType,
    content: '',
    next_action: '',
    next_action_date: '',
  })
  const [isAddingFollowup, setIsAddingFollowup] = useState(false)

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="h-8 w-48 bg-muted animate-pulse rounded" />
        <div className="h-[400px] bg-muted animate-pulse rounded" />
      </div>
    )
  }

  if (error || !deal) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <p className="text-destructive font-medium">案件が見つかりません</p>
          <Link href="/deals">
            <Button variant="outline" className="mt-4">
              <ArrowLeft className="h-4 w-4 mr-2" />
              一覧に戻る
            </Button>
          </Link>
        </div>
      </div>
    )
  }

  const handleUpdate = async (data: DealFormValues) => {
    try {
      const { memo, ...rest } = data
      await updateDeal.mutateAsync({ id, data: { ...rest, notes: memo ?? null } })
      toast.success('案件を更新しました')
      setActiveTab('detail')
    } catch {
      toast.error('更新に失敗しました')
    }
  }

  const handleDelete = async () => {
    try {
      await deleteDeal.mutateAsync(id)
      toast.success('案件を削除しました')
      router.push('/deals')
    } catch {
      toast.error('削除に失敗しました')
    }
  }

  const handleAddFollowup = async () => {
    if (!followupForm.content.trim()) {
      toast.error('対応内容を入力してください')
      return
    }
    setIsAddingFollowup(true)
    try {
      await addFollowup.mutateAsync({
        deal_id: id,
        followup_date: followupForm.followup_date,
        followup_type: followupForm.followup_type,
        content: followupForm.content,
        next_action: followupForm.next_action || null,
        next_action_date: followupForm.next_action_date || null,
      })
      toast.success('対応履歴を追加しました')
      setFollowupForm({
        followup_date: new Date().toISOString().split('T')[0],
        followup_type: '電話',
        content: '',
        next_action: '',
        next_action_date: '',
      })
    } catch {
      toast.error('追加に失敗しました')
    } finally {
      setIsAddingFollowup(false)
    }
  }

  const productName =
    deal.product && deal.product in PRODUCT_NAMES
      ? PRODUCT_NAMES[deal.product as ProductKey]
      : deal.product || '-'
  const marginRate = deal.product ? getMarginRateSafe(deal.product) : 0
  const monthlyMargin = deal.monthly_amount
    ? Math.floor(deal.monthly_amount * marginRate)
    : 0

  const companyName =
    deal.company && typeof deal.company === 'object' && 'company_name' in deal.company
      ? (deal.company as { company_name: string }).company_name
      : ''
  const contactName =
    deal.contact && typeof deal.contact === 'object' && 'last_name' in deal.contact
      ? `${(deal.contact as { last_name: string; first_name: string }).last_name} ${(deal.contact as { last_name: string; first_name: string }).first_name}`
      : '-'
  const closerName =
    deal.closer && typeof deal.closer === 'object' && 'display_name' in deal.closer
      ? (deal.closer as { display_name: string }).display_name
      : '-'
  const appointerName =
    deal.appointer && typeof deal.appointer === 'object' && 'display_name' in deal.appointer
      ? (deal.appointer as { display_name: string }).display_name
      : '-'
  const listName =
    deal.list && typeof deal.list === 'object' && 'list_name' in deal.list
      ? (deal.list as { list_name: string }).list_name
      : '-'

  const followups: DealFollowup[] = deal.followups || []

  return (
    <div className="space-y-6">
      {/* ヘッダー */}
      <div className="flex items-start justify-between">
        <div>
          <div className="flex items-center gap-3 mb-1">
            <Link href="/deals">
              <Button variant="ghost" size="sm">
                <ArrowLeft className="h-4 w-4" />
              </Button>
            </Link>
            <h1 className="text-2xl font-bold tracking-tight">
              {deal.deal_name}
            </h1>
            <YomiBadge status={deal.yomi_status || 'ネタ'} />
          </div>
          <p className="text-muted-foreground text-sm ml-11">
            {deal.deal_number} | {companyName}
          </p>
        </div>
        <Dialog open={showDeleteDialog} onOpenChange={setShowDeleteDialog}>
          <DialogTrigger asChild>
            <Button
              variant="outline"
              size="sm"
              className="text-destructive hover:text-destructive"
            >
              <Trash2 className="h-4 w-4 mr-2" />
              削除
            </Button>
          </DialogTrigger>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>案件を削除しますか？</DialogTitle>
            </DialogHeader>
            <p className="text-sm text-muted-foreground">
              「{deal.deal_name}」を削除します。この操作は取り消せません。
            </p>
            <DialogFooter>
              <DialogClose asChild>
                <Button variant="outline">キャンセル</Button>
              </DialogClose>
              <Button
                variant="destructive"
                onClick={handleDelete}
                disabled={deleteDeal.isPending}
              >
                {deleteDeal.isPending && (
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                )}
                削除する
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList>
          <TabsTrigger value="detail">詳細</TabsTrigger>
          <TabsTrigger value="followups">
            対応履歴
            {followups.length > 0 && (
              <Badge
                variant="secondary"
                className="ml-1.5 text-[10px] h-4 px-1"
              >
                {followups.length}
              </Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="edit">編集</TabsTrigger>
        </TabsList>

        {/* 詳細タブ */}
        <TabsContent value="detail" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle className="text-base">基本情報</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <InfoRow label="案件番号" value={deal.deal_number ? String(deal.deal_number) : '-'} />
                <InfoRow
                  label="企業名"
                  value={
                    deal.company_id && companyName ? (
                      <CompanyLink companyId={deal.company_id} companyName={companyName} className="text-sm" />
                    ) : (
                      companyName || '-'
                    )
                  }
                />
                <InfoRow label="担当者" value={contactName} />
                <InfoRow label="商品" value={productName} />
                <InfoRow label="ヨミステータス" value={deal.yomi_status || '-'} />
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">金額・粗利</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <InfoRow
                  label="総額"
                  value={formatCurrency(deal.amount)}
                  mono
                />
                <InfoRow
                  label="月額"
                  value={formatCurrency(deal.monthly_amount)}
                  mono
                />
                <InfoRow
                  label="初期費用"
                  value={formatCurrency(deal.initial_amount)}
                  mono
                />
                <InfoRow
                  label="粗利率"
                  value={`${Math.floor(marginRate * 100)}%`}
                />
                <InfoRow
                  label="月額粗利"
                  value={formatCurrency(monthlyMargin)}
                  mono
                />
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">担当・リスト</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <InfoRow label="クローザー" value={closerName} />
                <InfoRow label="アポインター" value={appointerName} />
                <InfoRow label="リスト" value={listName} />
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">日程</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <InfoRow
                  label="受注予定日"
                  value={formatDate(deal.expected_close_date)}
                />
                <InfoRow
                  label="受注日"
                  value={formatDate(deal.closed_date)}
                />
                <InfoRow
                  label="契約開始日"
                  value={formatDate(deal.contract_start_date)}
                />
                <InfoRow
                  label="契約月数"
                  value={
                    deal.contract_months
                      ? `${deal.contract_months}ヶ月`
                      : '-'
                  }
                />
              </CardContent>
            </Card>
          </div>

          {deal.notes && (
            <Card>
              <CardHeader>
                <CardTitle className="text-base">備考</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm whitespace-pre-wrap">{deal.notes}</p>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        {/* 対応履歴タブ */}
        <TabsContent value="followups" className="space-y-4">
          {/* 対応追加フォーム */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">対応を記録</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid gap-4 md:grid-cols-3">
                <div>
                  <Label>日付</Label>
                  <Input
                    type="date"
                    value={followupForm.followup_date}
                    onChange={(e) =>
                      setFollowupForm((prev) => ({
                        ...prev,
                        followup_date: e.target.value,
                      }))
                    }
                  />
                </div>
                <div>
                  <Label>種別</Label>
                  <select
                    value={followupForm.followup_type}
                    onChange={(e) =>
                      setFollowupForm((prev) => ({
                        ...prev,
                        followup_type: e.target.value as FollowupType,
                      }))
                    }
                    className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm"
                  >
                    <option value="電話">電話</option>
                    <option value="メール">メール</option>
                    <option value="訪問">訪問</option>
                    <option value="Web会議">Web会議</option>
                    <option value="その他">その他</option>
                  </select>
                </div>
              </div>
              <div>
                <Label>
                  対応内容 <span className="text-destructive">*</span>
                </Label>
                <textarea
                  value={followupForm.content}
                  onChange={(e) =>
                    setFollowupForm((prev) => ({
                      ...prev,
                      content: e.target.value,
                    }))
                  }
                  className="flex min-h-[80px] w-full rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
                  placeholder="対応内容を入力..."
                />
              </div>
              <div className="grid gap-4 md:grid-cols-2">
                <div>
                  <Label>次回アクション</Label>
                  <Input
                    value={followupForm.next_action}
                    onChange={(e) =>
                      setFollowupForm((prev) => ({
                        ...prev,
                        next_action: e.target.value,
                      }))
                    }
                    placeholder="次回やることを入力..."
                  />
                </div>
                <div>
                  <Label>次回予定日</Label>
                  <Input
                    type="date"
                    value={followupForm.next_action_date}
                    onChange={(e) =>
                      setFollowupForm((prev) => ({
                        ...prev,
                        next_action_date: e.target.value,
                      }))
                    }
                  />
                </div>
              </div>
              <div className="flex justify-end">
                <Button
                  onClick={handleAddFollowup}
                  disabled={isAddingFollowup}
                >
                  {isAddingFollowup ? (
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  ) : (
                    <Plus className="h-4 w-4 mr-2" />
                  )}
                  追加する
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* 対応履歴タイムライン */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">対応履歴</CardTitle>
            </CardHeader>
            <CardContent>
              {followups.length === 0 ? (
                <p className="text-sm text-muted-foreground text-center py-6">
                  対応履歴がありません
                </p>
              ) : (
                <div className="space-y-4">
                  {[...followups]
                    .sort(
                      (a, b) =>
                        new Date(b.followup_date || '').getTime() -
                        new Date(a.followup_date || '').getTime()
                    )
                    .map((followup) => {
                      const IconComponent =
                        followupTypeIcons[followup.followup_type || ''] ||
                        MessageSquare
                      return (
                        <div
                          key={followup.id}
                          className="flex gap-3 border-l-2 border-muted pl-4 pb-4"
                        >
                          <div className="flex-shrink-0 mt-0.5">
                            <div className="rounded-full bg-muted p-1.5">
                              <IconComponent className="h-3.5 w-3.5 text-muted-foreground" />
                            </div>
                          </div>
                          <div className="flex-1 min-w-0">
                            <div className="flex items-center gap-2 mb-1">
                              <Badge
                                variant="outline"
                                className="text-[10px]"
                              >
                                {followup.followup_type}
                              </Badge>
                              <span className="text-xs text-muted-foreground">
                                {formatDate(followup.followup_date)}
                              </span>
                            </div>
                            <p className="text-sm whitespace-pre-wrap">
                              {followup.content}
                            </p>
                            {followup.next_action && (
                              <div className="mt-2 rounded bg-orange-50 p-2">
                                <p className="text-xs font-medium text-orange-700">
                                  次回: {followup.next_action}
                                </p>
                                {followup.next_action_date && (
                                  <p className="text-xs text-orange-600">
                                    予定日:{' '}
                                    {formatDate(followup.next_action_date)}
                                  </p>
                                )}
                              </div>
                            )}
                          </div>
                        </div>
                      )
                    })}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* 編集タブ */}
        <TabsContent value="edit">
          <DealForm
            deal={deal}
            onSubmit={handleUpdate}
            isSubmitting={updateDeal.isPending}
          />
        </TabsContent>
      </Tabs>
    </div>
  )
}
