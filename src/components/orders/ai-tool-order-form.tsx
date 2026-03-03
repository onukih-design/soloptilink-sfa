'use client'

import { useState, useEffect, useMemo } from 'react'
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from '@/components/ui/sheet'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Textarea } from '@/components/ui/textarea'
import { PRODUCT_OPTIONS, INITIAL_FEE_MARGIN_RATE } from '@/lib/constants/margins'
import { useCompanyList } from '@/hooks/use-companies'
import { toast } from 'sonner'
import { Search } from 'lucide-react'

export type AiToolOrderFormData = {
  company_id: string
  product: string
  plan: string | null
  monthly_fee: number
  initial_fee: number
  margin_rate: number
  monthly_margin: number
  initial_margin: number
  contract_start_date: string | null
  contract_months: number | null
  status: string
  closer_id: string | null
  appointer_id: string | null
  notes: string | null
}

interface AiToolOrderFormProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  onSubmit: (data: AiToolOrderFormData) => void
  isSubmitting?: boolean
}

const ORDER_STATUSES = [
  { value: '契約中', label: '契約中' },
  { value: '解約予定', label: '解約予定' },
  { value: '解約済み', label: '解約済み' },
  { value: '休止中', label: '休止中' },
]

export function AiToolOrderForm({
  open,
  onOpenChange,
  onSubmit,
  isSubmitting = false,
}: AiToolOrderFormProps) {
  // Form state
  const [companyId, setCompanyId] = useState('')
  const [product, setProduct] = useState('')
  const [plan, setPlan] = useState('')
  const [monthlyFee, setMonthlyFee] = useState('')
  const [marginRate, setMarginRate] = useState('')
  const [monthlyMargin, setMonthlyMargin] = useState('')
  const [initialFee, setInitialFee] = useState('0')
  const [initialMargin, setInitialMargin] = useState('0')
  const [contractStartDate, setContractStartDate] = useState('')
  const [contractMonths, setContractMonths] = useState('12')
  const [status, setStatus] = useState('契約中')
  const [notes, setNotes] = useState('')

  // Company search
  const [companyKeyword, setCompanyKeyword] = useState('')
  const [showCompanyDropdown, setShowCompanyDropdown] = useState(false)
  const { data: companies = [] } = useCompanyList(
    { keyword: companyKeyword },
    { key: 'company_name', order: 'asc' }
  )

  const selectedCompany = useMemo(
    () => companies.find((c) => c.id === companyId),
    [companies, companyId]
  )

  // Auto-calculate margin_rate when product changes
  useEffect(() => {
    if (product) {
      const selectedProduct = PRODUCT_OPTIONS.find((p) => p.key === product)
      if (selectedProduct) {
        setMarginRate(selectedProduct.marginRate.toString())
      }
    }
  }, [product])

  // Auto-calculate monthly_margin when monthly_fee or margin_rate changes
  useEffect(() => {
    const fee = parseFloat(monthlyFee) || 0
    const rate = parseFloat(marginRate) || 0
    setMonthlyMargin((fee * rate).toFixed(0))
  }, [monthlyFee, marginRate])

  // Auto-calculate initial_margin when initial_fee changes
  useEffect(() => {
    const fee = parseFloat(initialFee) || 0
    setInitialMargin((fee * INITIAL_FEE_MARGIN_RATE).toFixed(0))
  }, [initialFee])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()

    // Validation
    if (!companyId) {
      toast.error('会社を選択してください')
      return
    }
    if (!product) {
      toast.error('商材を選択してください')
      return
    }
    if (!monthlyFee || parseFloat(monthlyFee) <= 0) {
      toast.error('月額費用を入力してください')
      return
    }
    if (!marginRate) {
      toast.error('マージン率を入力してください')
      return
    }

    const formData: AiToolOrderFormData = {
      company_id: companyId,
      product,
      plan: plan || null,
      monthly_fee: parseFloat(monthlyFee),
      initial_fee: parseFloat(initialFee) || 0,
      margin_rate: parseFloat(marginRate),
      monthly_margin: parseFloat(monthlyMargin),
      initial_margin: parseFloat(initialMargin),
      contract_start_date: contractStartDate || null,
      contract_months: contractMonths ? parseInt(contractMonths) : null,
      status,
      closer_id: null,
      appointer_id: null,
      notes: notes || null,
    }

    onSubmit(formData)
  }

  const handleReset = () => {
    setCompanyId('')
    setCompanyKeyword('')
    setProduct('')
    setPlan('')
    setMonthlyFee('')
    setMarginRate('')
    setMonthlyMargin('')
    setInitialFee('0')
    setInitialMargin('0')
    setContractStartDate('')
    setContractMonths('12')
    setStatus('契約中')
    setNotes('')
  }

  return (
    <Sheet open={open} onOpenChange={onOpenChange}>
      <SheetContent className="sm:max-w-[540px] overflow-y-auto">
        <SheetHeader>
          <SheetTitle>AIツール受注登録</SheetTitle>
        </SheetHeader>

        <form onSubmit={handleSubmit} className="space-y-6 mt-6">
          {/* Company Selection */}
          <div className="space-y-2">
            <Label htmlFor="company" className="required">
              会社名
            </Label>
            {selectedCompany ? (
              <div className="flex items-center gap-2">
                <div className="flex-1 px-3 py-2 border rounded-md bg-muted text-sm">
                  {selectedCompany.company_name}
                </div>
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    setCompanyId('')
                    setCompanyKeyword('')
                  }}
                >
                  変更
                </Button>
              </div>
            ) : (
              <div className="relative">
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                  <Input
                    id="company"
                    placeholder="会社名で検索..."
                    value={companyKeyword}
                    onChange={(e) => setCompanyKeyword(e.target.value)}
                    onFocus={() => setShowCompanyDropdown(true)}
                    className="pl-9"
                  />
                </div>
                {showCompanyDropdown && companyKeyword && (
                  <div className="absolute z-50 w-full mt-1 max-h-[200px] overflow-y-auto border rounded-md bg-popover shadow-md">
                    {companies.length > 0 ? (
                      companies.map((company) => (
                        <button
                          key={company.id}
                          type="button"
                          className="w-full px-3 py-2 text-left text-sm hover:bg-accent transition-colors"
                          onClick={() => {
                            setCompanyId(company.id)
                            setShowCompanyDropdown(false)
                          }}
                        >
                          {company.company_name}
                        </button>
                      ))
                    ) : (
                      <div className="px-3 py-2 text-sm text-muted-foreground">
                        該当する会社が見つかりません
                      </div>
                    )}
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Product Selection */}
          <div className="space-y-2">
            <Label htmlFor="product" className="required">
              商材
            </Label>
            <Select value={product} onValueChange={setProduct}>
              <SelectTrigger id="product">
                <SelectValue placeholder="商材を選択" />
              </SelectTrigger>
              <SelectContent>
                {PRODUCT_OPTIONS.map((p) => (
                  <SelectItem key={p.key} value={p.key}>
                    {p.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {/* Plan */}
          <div className="space-y-2">
            <Label htmlFor="plan">プラン</Label>
            <Input
              id="plan"
              placeholder="例: スタンダード、プレミアム"
              value={plan}
              onChange={(e) => setPlan(e.target.value)}
            />
          </div>

          {/* Monthly Fee & Margin */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="monthly_fee" className="required">
                月額費用
              </Label>
              <Input
                id="monthly_fee"
                type="number"
                placeholder="0"
                value={monthlyFee}
                onChange={(e) => setMonthlyFee(e.target.value)}
                min="0"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="margin_rate" className="required">
                マージン率
              </Label>
              <Input
                id="margin_rate"
                type="number"
                step="0.01"
                placeholder="0.00"
                value={marginRate}
                onChange={(e) => setMarginRate(e.target.value)}
                min="0"
                max="1"
              />
            </div>
          </div>

          {/* Monthly Margin (calculated) */}
          <div className="space-y-2">
            <Label htmlFor="monthly_margin">月次マージン（自動計算）</Label>
            <Input
              id="monthly_margin"
              type="number"
              value={monthlyMargin}
              onChange={(e) => setMonthlyMargin(e.target.value)}
              className="bg-muted"
            />
          </div>

          {/* Initial Fee & Margin */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="initial_fee">初期費用</Label>
              <Input
                id="initial_fee"
                type="number"
                placeholder="0"
                value={initialFee}
                onChange={(e) => setInitialFee(e.target.value)}
                min="0"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="initial_margin">初期マージン（50%）</Label>
              <Input
                id="initial_margin"
                type="number"
                value={initialMargin}
                onChange={(e) => setInitialMargin(e.target.value)}
                className="bg-muted"
              />
            </div>
          </div>

          {/* Contract Info */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="contract_start_date">契約開始日</Label>
              <Input
                id="contract_start_date"
                type="date"
                value={contractStartDate}
                onChange={(e) => setContractStartDate(e.target.value)}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="contract_months">契約期間（月）</Label>
              <Input
                id="contract_months"
                type="number"
                placeholder="12"
                value={contractMonths}
                onChange={(e) => setContractMonths(e.target.value)}
                min="1"
              />
            </div>
          </div>

          {/* Status */}
          <div className="space-y-2">
            <Label htmlFor="status">ステータス</Label>
            <Select value={status} onValueChange={setStatus}>
              <SelectTrigger id="status">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {ORDER_STATUSES.map((s) => (
                  <SelectItem key={s.value} value={s.value}>
                    {s.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {/* Notes */}
          <div className="space-y-2">
            <Label htmlFor="notes">備考</Label>
            <Textarea
              id="notes"
              placeholder="備考があれば入力してください"
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              rows={4}
            />
          </div>

          {/* Actions */}
          <div className="flex gap-3 pt-4 border-t">
            <Button
              type="button"
              variant="outline"
              onClick={() => {
                handleReset()
                onOpenChange(false)
              }}
              disabled={isSubmitting}
              className="flex-1"
            >
              キャンセル
            </Button>
            <Button type="submit" disabled={isSubmitting} className="flex-1">
              {isSubmitting ? '登録中...' : '登録'}
            </Button>
          </div>
        </form>
      </SheetContent>
    </Sheet>
  )
}
