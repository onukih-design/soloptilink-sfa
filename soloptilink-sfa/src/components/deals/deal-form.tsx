'use client'

import { useState, useEffect } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { useCompanies, useContacts, useUsers, useLists } from '@/hooks/use-deals'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import { PRODUCT_OPTIONS } from '@/lib/constants/margins'
import { dealFormSchema, type DealFormValues } from '@/lib/validators/deal'
import { toast } from 'sonner'
import { Loader2, Save, ArrowLeft, Plus } from 'lucide-react'
import Link from 'next/link'
import type { DealWithRelations } from '@/types/deals'
import { QuickAddCompanyDialog } from '@/components/companies/quick-add-company-dialog'
import { QuickAddContactDialog } from '@/components/contacts/quick-add-contact-dialog'

type Props = {
  deal?: DealWithRelations
  onSubmit: (data: DealFormValues) => Promise<void>
  isSubmitting: boolean
}

export function DealForm({ deal, onSubmit, isSubmitting }: Props) {
  const { data: companies } = useCompanies()
  const { data: users } = useUsers()
  const { data: lists } = useLists()

  const [formData, setFormData] = useState<Partial<DealFormValues>>({
    deal_name: deal?.deal_name || '',
    company_id: deal?.company_id || '',
    contact_id: deal?.contact_id || null,
    product: deal?.product || '',
    yomi_status: (deal?.yomi_status as DealFormValues['yomi_status']) || 'ネタ',
    amount: deal?.amount || 0,
    monthly_amount: deal?.monthly_amount || 0,
    initial_amount: deal?.initial_amount || 0,
    closer_id: deal?.closer_id || null,
    appointer_id: deal?.appointer_id || null,
    list_id: deal?.list_id || null,
    expected_close_date: deal?.expected_close_date || null,
    closed_date: deal?.closed_date || null,
    contract_start_date: deal?.contract_start_date || null,
    contract_months: deal?.contract_months || null,
    memo: deal?.notes || null,
  })

  // deal propが後から到着した場合にフォームstateを同期
  useEffect(() => {
    if (deal) {
      setFormData({
        deal_name: deal.deal_name || '',
        company_id: deal.company_id || '',
        contact_id: deal.contact_id || null,
        product: deal.product || '',
        yomi_status: (deal.yomi_status as DealFormValues['yomi_status']) || 'ネタ',
        amount: deal.amount || 0,
        monthly_amount: deal.monthly_amount || 0,
        initial_amount: deal.initial_amount || 0,
        closer_id: deal.closer_id || null,
        appointer_id: deal.appointer_id || null,
        list_id: deal.list_id || null,
        expected_close_date: deal.expected_close_date || null,
        closed_date: deal.closed_date || null,
        contract_start_date: deal.contract_start_date || null,
        contract_months: deal.contract_months || null,
        memo: deal.notes || null,
      })
    }
  }, [deal?.id])

  const [errors, setErrors] = useState<Record<string, string>>({})
  const [showQuickAddCompany, setShowQuickAddCompany] = useState(false)
  const [showQuickAddContact, setShowQuickAddContact] = useState(false)

  const { data: contacts } = useContacts(formData.company_id || null)

  const updateField = <K extends keyof DealFormValues>(
    field: K,
    value: DealFormValues[K]
  ) => {
    setFormData((prev) => ({ ...prev, [field]: value }))
    // Clear error on change
    if (errors[field]) {
      setErrors((prev) => {
        const next = { ...prev }
        delete next[field]
        return next
      })
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    const result = dealFormSchema.safeParse(formData)
    if (!result.success) {
      const fieldErrors: Record<string, string> = {}
      for (const issue of result.error.issues) {
        const field = issue.path[0]
        if (field && typeof field === 'string') {
          fieldErrors[field] = issue.message
        }
      }
      setErrors(fieldErrors)
      toast.error('入力内容にエラーがあります')
      return
    }

    try {
      await onSubmit(result.data)
    } catch (err) {
      console.error(err)
    }
  }

  const selectClassName = (hasError?: boolean) =>
    `flex h-9 w-full rounded-md border bg-transparent px-3 py-1 text-sm shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring ${
      hasError ? 'border-destructive' : 'border-input'
    }`

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {/* 基本情報 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">基本情報</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-4 md:grid-cols-2">
          <div className="md:col-span-2">
            <Label htmlFor="deal_name">
              案件名 <span className="text-destructive">*</span>
            </Label>
            <Input
              id="deal_name"
              value={formData.deal_name || ''}
              onChange={(e) => updateField('deal_name', e.target.value)}
              placeholder="案件名を入力"
              className={errors.deal_name ? 'border-destructive' : ''}
            />
            {errors.deal_name && (
              <p className="text-xs text-destructive mt-1">{errors.deal_name}</p>
            )}
          </div>

          <div>
            <Label htmlFor="company_id">
              企業 <span className="text-destructive">*</span>
            </Label>
            <div className="flex gap-2">
              <select
                id="company_id"
                value={formData.company_id || ''}
                onChange={(e) => {
                  updateField('company_id', e.target.value)
                  updateField('contact_id', null)
                }}
                className={`flex-1 ${selectClassName(!!errors.company_id)}`}
              >
                <option value="">企業を選択</option>
                {(companies || []).map((c) => (
                  <option key={c.id} value={c.id}>
                    {c.company_name}
                  </option>
                ))}
              </select>
              <Button
                type="button"
                variant="outline"
                size="icon"
                onClick={() => setShowQuickAddCompany(true)}
                title="新規会社を追加"
              >
                <Plus className="h-4 w-4" />
              </Button>
            </div>
            {errors.company_id && (
              <p className="text-xs text-destructive mt-1">{errors.company_id}</p>
            )}
          </div>

          <div>
            <Label htmlFor="contact_id">担当者</Label>
            <div className="flex gap-2">
              <select
                id="contact_id"
                value={formData.contact_id || ''}
                onChange={(e) =>
                  updateField('contact_id', e.target.value || null)
                }
                className={`flex-1 ${selectClassName()}`}
                disabled={!formData.company_id}
              >
                <option value="">担当者を選択</option>
                {(contacts || []).map((c) => (
                  <option key={c.id} value={c.id}>
                    {c.last_name} {c.first_name}
                    {c.position ? ` (${c.position})` : ''}
                  </option>
                ))}
              </select>
              {formData.company_id && (
                <Button
                  type="button"
                  variant="outline"
                  size="icon"
                  onClick={() => setShowQuickAddContact(true)}
                  title="新規担当者を追加"
                >
                  <Plus className="h-4 w-4" />
                </Button>
              )}
            </div>
          </div>

          <div>
            <Label htmlFor="product">
              商品 <span className="text-destructive">*</span>
            </Label>
            <select
              id="product"
              value={formData.product || ''}
              onChange={(e) => updateField('product', e.target.value)}
              className={selectClassName(!!errors.product)}
            >
              <option value="">商品を選択</option>
              {PRODUCT_OPTIONS.map((p) => (
                <option key={p.key} value={p.key}>
                  {p.name}
                </option>
              ))}
            </select>
            {errors.product && (
              <p className="text-xs text-destructive mt-1">{errors.product}</p>
            )}
          </div>

          <div>
            <Label htmlFor="yomi_status">
              ヨミステータス <span className="text-destructive">*</span>
            </Label>
            <select
              id="yomi_status"
              value={formData.yomi_status || 'ネタ'}
              onChange={(e) =>
                updateField(
                  'yomi_status',
                  e.target.value as DealFormValues['yomi_status']
                )
              }
              className={selectClassName()}
            >
              {YOMI_STATUSES.map((s) => (
                <option key={s.name} value={s.name}>
                  {s.label}
                </option>
              ))}
            </select>
          </div>
        </CardContent>
      </Card>

      {/* 金額情報 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">金額情報</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-4 md:grid-cols-3">
          <div>
            <Label htmlFor="amount">総額（円）</Label>
            <Input
              id="amount"
              type="number"
              value={formData.amount || 0}
              onChange={(e) =>
                updateField('amount', Math.floor(Number(e.target.value) || 0))
              }
              min={0}
              className="text-right font-mono"
            />
          </div>
          <div>
            <Label htmlFor="monthly_amount">月額（円）</Label>
            <Input
              id="monthly_amount"
              type="number"
              value={formData.monthly_amount || 0}
              onChange={(e) =>
                updateField(
                  'monthly_amount',
                  Math.floor(Number(e.target.value) || 0)
                )
              }
              min={0}
              className="text-right font-mono"
            />
          </div>
          <div>
            <Label htmlFor="initial_amount">初期費用（円）</Label>
            <Input
              id="initial_amount"
              type="number"
              value={formData.initial_amount || 0}
              onChange={(e) =>
                updateField(
                  'initial_amount',
                  Math.floor(Number(e.target.value) || 0)
                )
              }
              min={0}
              className="text-right font-mono"
            />
          </div>
        </CardContent>
      </Card>

      {/* 担当・リスト */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">担当・リスト</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-4 md:grid-cols-3">
          <div>
            <Label htmlFor="closer_id">クローザー</Label>
            <select
              id="closer_id"
              value={formData.closer_id || ''}
              onChange={(e) =>
                updateField('closer_id', e.target.value || null)
              }
              className={selectClassName()}
            >
              <option value="">選択なし</option>
              {(users || []).map((u) => (
                <option key={u.id} value={u.id}>
                  {u.display_name}
                </option>
              ))}
            </select>
          </div>
          <div>
            <Label htmlFor="appointer_id">アポインター</Label>
            <select
              id="appointer_id"
              value={formData.appointer_id || ''}
              onChange={(e) =>
                updateField('appointer_id', e.target.value || null)
              }
              className={selectClassName()}
            >
              <option value="">選択なし</option>
              {(users || []).map((u) => (
                <option key={u.id} value={u.id}>
                  {u.display_name}
                </option>
              ))}
            </select>
          </div>
          <div>
            <Label htmlFor="list_id">リスト</Label>
            <select
              id="list_id"
              value={formData.list_id || ''}
              onChange={(e) =>
                updateField('list_id', e.target.value || null)
              }
              className={selectClassName()}
            >
              <option value="">選択なし</option>
              {(lists || []).map((l) => (
                <option key={l.id} value={l.id}>
                  {l.list_name}
                </option>
              ))}
            </select>
          </div>
        </CardContent>
      </Card>

      {/* 日程 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">日程</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
          <div>
            <Label htmlFor="expected_close_date">受注予定日</Label>
            <Input
              id="expected_close_date"
              type="date"
              value={formData.expected_close_date || ''}
              onChange={(e) =>
                updateField('expected_close_date', e.target.value || null)
              }
            />
          </div>
          <div>
            <Label htmlFor="closed_date">受注日</Label>
            <Input
              id="closed_date"
              type="date"
              value={formData.closed_date || ''}
              onChange={(e) =>
                updateField('closed_date', e.target.value || null)
              }
            />
          </div>
          <div>
            <Label htmlFor="contract_start_date">契約開始日</Label>
            <Input
              id="contract_start_date"
              type="date"
              value={formData.contract_start_date || ''}
              onChange={(e) =>
                updateField('contract_start_date', e.target.value || null)
              }
            />
          </div>
          <div>
            <Label htmlFor="contract_months">契約月数</Label>
            <Input
              id="contract_months"
              type="number"
              value={formData.contract_months ?? ''}
              onChange={(e) =>
                updateField(
                  'contract_months',
                  e.target.value ? Number(e.target.value) : null
                )
              }
              min={0}
              placeholder="例: 12"
            />
          </div>
        </CardContent>
      </Card>

      {/* 備考 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">備考</CardTitle>
        </CardHeader>
        <CardContent>
          <textarea
            value={formData.memo || ''}
            onChange={(e) =>
              updateField('memo', e.target.value || null)
            }
            className="flex min-h-[100px] w-full rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
            placeholder="備考を入力..."
            maxLength={2000}
          />
        </CardContent>
      </Card>

      {/* アクションボタン */}
      <div className="flex items-center justify-between">
        <Link href="/deals">
          <Button type="button" variant="outline">
            <ArrowLeft className="h-4 w-4 mr-2" />
            一覧に戻る
          </Button>
        </Link>
        <Button type="submit" disabled={isSubmitting}>
          {isSubmitting ? (
            <Loader2 className="h-4 w-4 mr-2 animate-spin" />
          ) : (
            <Save className="h-4 w-4 mr-2" />
          )}
          {deal ? '更新する' : '登録する'}
        </Button>
      </div>

      {/* Quick Add Dialogs */}
      <QuickAddCompanyDialog
        open={showQuickAddCompany}
        onOpenChange={setShowQuickAddCompany}
        onCreated={(id) => {
          setFormData({ ...formData, company_id: id })
        }}
      />

      {formData.company_id && (
        <QuickAddContactDialog
          companyId={formData.company_id}
          open={showQuickAddContact}
          onOpenChange={setShowQuickAddContact}
          onCreated={(id) => {
            setFormData({ ...formData, contact_id: id })
          }}
        />
      )}
    </form>
  )
}
