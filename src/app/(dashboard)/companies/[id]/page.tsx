'use client'

import { useState } from 'react'
import { useParams, useRouter } from 'next/navigation'
import {
  useCompany,
  useDeleteCompany,
  useUpdateCompany,
} from '@/hooks/use-companies'
import { useAiToolOrdersByCompany, useOutsourcingOrdersByCompany } from '@/hooks/use-orders'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from '@/components/ui/tabs'
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
  DialogFooter,
  DialogClose,
} from '@/components/ui/dialog'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'
import { formatCurrency, formatDate } from '@/lib/utils/format'
import { ArrowLeft, Trash2, Loader2, Building2, TrendingUp, Briefcase, Save } from 'lucide-react'
import Link from 'next/link'
import { toast } from 'sonner'
import { ContactsList } from '@/components/contacts/contacts-list'
import { DealLink } from '@/components/ui/deal-link'
import { companyFormSchema, type CompanyFormValues } from '@/lib/validators/company'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'

function InfoRow({
  label,
  value,
  mono,
}: {
  label: string
  value: string
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

export default function CompanyHubPage() {
  const params = useParams()
  const router = useRouter()
  const id = params.id as string

  const { data: company, isLoading, error } = useCompany(id)
  const { data: aiToolOrders, isLoading: isLoadingAiTools } = useAiToolOrdersByCompany(id)
  const { data: outsourcingOrders, isLoading: isLoadingOutsourcing } = useOutsourcingOrdersByCompany(id)
  const deleteCompany = useDeleteCompany()
  const updateCompany = useUpdateCompany()

  const [activeTab, setActiveTab] = useState('overview')
  const [showDeleteDialog, setShowDeleteDialog] = useState(false)

  // Edit form state
  const [formData, setFormData] = useState<Partial<CompanyFormValues>>({})
  const [formErrors, setFormErrors] = useState<Record<string, string>>({})

  // Initialize form data when company loads
  useState(() => {
    if (company) {
      setFormData({
        company_name: company.company_name,
        phone: company.phone || '',
        email: company.email || '',
        website: company.website || '',
        address: company.address || '',
        industry: company.industry || '',
        employee_count: company.employee_count,
        annual_revenue: company.annual_revenue,
        notes: company.notes || '',
      })
    }
  })

  const handleFormReset = () => {
    if (company) {
      setFormData({
        company_name: company.company_name,
        phone: company.phone || '',
        email: company.email || '',
        website: company.website || '',
        address: company.address || '',
        industry: company.industry || '',
        employee_count: company.employee_count,
        annual_revenue: company.annual_revenue,
        notes: company.notes || '',
      })
      setFormErrors({})
    }
  }

  const handleFormSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setFormErrors({})

    const result = companyFormSchema.safeParse({
      ...formData,
      phone: formData.phone || null,
      email: formData.email || null,
      website: formData.website || null,
      address: formData.address || null,
      industry: formData.industry || null,
      notes: formData.notes || null,
      employee_count: formData.employee_count || null,
      annual_revenue: formData.annual_revenue || null,
    })

    if (!result.success) {
      const fieldErrors: Record<string, string> = {}
      result.error.issues.forEach((err) => {
        if (err.path[0]) {
          fieldErrors[err.path[0] as string] = err.message
        }
      })
      setFormErrors(fieldErrors)
      return
    }

    try {
      await updateCompany.mutateAsync({
        id,
        data: {
          company_name: formData.company_name!,
          phone: formData.phone || null,
          email: formData.email || null,
          website: formData.website || null,
          address: formData.address || null,
          industry: formData.industry || null,
          employee_count: formData.employee_count || null,
          annual_revenue: formData.annual_revenue || null,
          notes: formData.notes || null,
        },
      })
      // Success toast is shown by the mutation
      setActiveTab('overview')
    } catch {
      // Error is handled by mutation's onError
    }
  }

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="h-8 w-48 bg-muted animate-pulse rounded" />
        <div className="h-[400px] bg-muted animate-pulse rounded" />
      </div>
    )
  }

  if (error || !company) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <p className="text-destructive font-medium">会社が見つかりません</p>
          <Link href="/companies">
            <Button variant="outline" className="mt-4">
              <ArrowLeft className="h-4 w-4 mr-2" />
              一覧に戻る
            </Button>
          </Link>
        </div>
      </div>
    )
  }

  const handleDelete = async () => {
    try {
      await deleteCompany.mutateAsync(id)
      router.push('/companies')
    } catch {
      toast.error('削除に失敗しました')
    }
  }

  const contacts = company.contacts || []
  const deals = company.deals || []

  // Calculate KPIs from active orders
  const activeAiToolOrders = (aiToolOrders || []).filter((o) => o.status === '契約中')
  const activeOutsourcingOrders = (outsourcingOrders || []).filter((o) => o.status === '契約中')

  const totalMonthlyRevenue =
    activeAiToolOrders.reduce((sum, o) => sum + (o.monthly_fee || 0), 0) +
    activeOutsourcingOrders.reduce((sum, o) => sum + (o.monthly_fee || 0), 0)

  const totalMonthlyMargin =
    activeAiToolOrders.reduce((sum, o) => sum + (o.monthly_margin || 0), 0) +
    activeOutsourcingOrders.reduce((sum, o) => sum + (o.monthly_commission || 0), 0)

  const totalActiveOrders = activeAiToolOrders.length + activeOutsourcingOrders.length

  return (
    <div className="space-y-6">
      {/* ヘッダー */}
      <div className="flex items-start justify-between">
        <div>
          <div className="flex items-center gap-3 mb-1">
            <Link href="/companies">
              <Button variant="ghost" size="sm">
                <ArrowLeft className="h-4 w-4" />
              </Button>
            </Link>
            <Building2 className="h-6 w-6 text-muted-foreground" />
            <h1 className="text-2xl font-bold tracking-tight">
              {company.company_name}
            </h1>
            {totalActiveOrders > 0 && (
              <Badge variant="secondary" className="ml-2">
                {totalActiveOrders}件受注
              </Badge>
            )}
          </div>
          <p className="text-muted-foreground text-sm ml-11">
            {company.industry || '業種未登録'}
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
              <DialogTitle>会社を削除しますか?</DialogTitle>
            </DialogHeader>
            <p className="text-sm text-muted-foreground">
              「{company.company_name}」を削除します。この操作は取り消せません。
            </p>
            <DialogFooter>
              <DialogClose asChild>
                <Button variant="outline">キャンセル</Button>
              </DialogClose>
              <Button
                variant="destructive"
                onClick={handleDelete}
                disabled={deleteCompany.isPending}
              >
                {deleteCompany.isPending && (
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
          <TabsTrigger value="overview">概要</TabsTrigger>
          <TabsTrigger value="orders">案件・受注</TabsTrigger>
          <TabsTrigger value="contacts">
            担当者一覧
            {contacts.length > 0 && (
              <Badge variant="secondary" className="ml-1.5 text-[10px] h-4 px-1">
                {contacts.length}
              </Badge>
            )}
          </TabsTrigger>
          <TabsTrigger value="edit">編集</TabsTrigger>
        </TabsList>

        {/* Tab 1: 概要 (Overview) */}
        <TabsContent value="overview" className="space-y-4">
          {/* KPI Summary Cards */}
          <div className="grid gap-4 md:grid-cols-3">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">月額売上合計</CardTitle>
                <TrendingUp className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold font-mono">
                  {formatCurrency(totalMonthlyRevenue)}
                </div>
                <p className="text-xs text-muted-foreground mt-1">
                  契約中 {totalActiveOrders}件
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">月額粗利合計</CardTitle>
                <TrendingUp className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold font-mono">
                  {formatCurrency(totalMonthlyMargin)}
                </div>
                <p className="text-xs text-muted-foreground mt-1">
                  粗利率 {totalMonthlyRevenue > 0 ? `${((totalMonthlyMargin / totalMonthlyRevenue) * 100).toFixed(1)}%` : '-'}
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">案件数</CardTitle>
                <Briefcase className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">
                  {deals.length}
                </div>
                <p className="text-xs text-muted-foreground mt-1">
                  うち受注 {totalActiveOrders}件
                </p>
              </CardContent>
            </Card>
          </div>

          {/* Basic Info + Quick Actions */}
          <div className="grid gap-4 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle className="text-base">基本情報</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <InfoRow label="会社名" value={company.company_name} />
                <InfoRow label="業種" value={company.industry || '-'} />
                <InfoRow label="電話番号" value={company.phone || '-'} />
                <InfoRow label="メール" value={company.email || '-'} />
                <InfoRow
                  label="ウェブサイト"
                  value={company.website || '-'}
                />
                <InfoRow
                  label="従業員数"
                  value={
                    company.employee_count
                      ? `${company.employee_count}名`
                      : '-'
                  }
                />
                <InfoRow
                  label="年商"
                  value={formatCurrency(company.annual_revenue)}
                  mono
                />
                <InfoRow label="住所" value={company.address || '-'} />
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle className="text-base">クイックアクション</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <Button
                  variant="outline"
                  className="w-full justify-start"
                  onClick={() => setActiveTab('orders')}
                >
                  <Briefcase className="h-4 w-4 mr-2" />
                  案件・受注を見る
                </Button>
                <Button
                  variant="outline"
                  className="w-full justify-start"
                  onClick={() => setActiveTab('contacts')}
                >
                  担当者一覧を見る ({contacts.length})
                </Button>
                <Button
                  variant="outline"
                  className="w-full justify-start"
                  onClick={() => setActiveTab('edit')}
                >
                  <Save className="h-4 w-4 mr-2" />
                  会社情報を編集
                </Button>
              </CardContent>
            </Card>
          </div>

          {/* Notes */}
          {company.notes && (
            <Card>
              <CardHeader>
                <CardTitle className="text-base">備考</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm whitespace-pre-wrap">{company.notes}</p>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        {/* Tab 2: 案件・受注 (Deals & Orders) */}
        <TabsContent value="orders" className="space-y-6">
          {/* Section 1: 関連案件 */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base flex items-center gap-2">
                <Briefcase className="h-4 w-4" />
                関連案件
                <Badge variant="secondary" className="text-[10px] h-4 px-1">
                  {deals.length}
                </Badge>
              </CardTitle>
            </CardHeader>
            <CardContent>
              {deals.length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  関連案件がありません
                </p>
              ) : (
                <div className="space-y-2">
                  {deals.map((deal) => (
                    <div
                      key={deal.id}
                      className="flex items-center justify-between p-3 rounded border hover:bg-muted/30 transition-colors"
                    >
                      <div className="flex-1">
                        <DealLink dealId={deal.id} dealName={deal.deal_name} />
                        {deal.notes && (
                          <p className="text-xs text-muted-foreground mt-1 truncate">
                            {deal.notes}
                          </p>
                        )}
                      </div>
                      <Badge variant="outline" className="text-xs ml-2">
                        {deal.yomi_status}
                      </Badge>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>

          {/* Section 2: AIツール受注 */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">AIツール受注</CardTitle>
            </CardHeader>
            <CardContent>
              {isLoadingAiTools ? (
                <div className="h-32 bg-muted animate-pulse rounded" />
              ) : !aiToolOrders || aiToolOrders.length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  AIツール受注がありません
                </p>
              ) : (
                <div className="overflow-x-auto">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>商品</TableHead>
                        <TableHead>プラン</TableHead>
                        <TableHead className="text-right">月額</TableHead>
                        <TableHead className="text-right">粗利</TableHead>
                        <TableHead>ステータス</TableHead>
                        <TableHead>契約開始</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {aiToolOrders.map((order) => (
                        <TableRow key={order.id}>
                          <TableCell className="font-medium">
                            {order.product}
                          </TableCell>
                          <TableCell>{order.plan || '-'}</TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(order.monthly_fee)}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(order.monthly_margin)}
                          </TableCell>
                          <TableCell>
                            <Badge
                              variant={
                                order.status === '契約中'
                                  ? 'default'
                                  : order.status === '解約済'
                                  ? 'secondary'
                                  : 'outline'
                              }
                            >
                              {order.status}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            {order.contract_start_date
                              ? formatDate(order.contract_start_date)
                              : '-'}
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Section 3: 営業代行受注 */}
          <Card>
            <CardHeader>
              <CardTitle className="text-base">営業代行受注</CardTitle>
            </CardHeader>
            <CardContent>
              {isLoadingOutsourcing ? (
                <div className="h-32 bg-muted animate-pulse rounded" />
              ) : !outsourcingOrders || outsourcingOrders.length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  営業代行受注がありません
                </p>
              ) : (
                <div className="overflow-x-auto">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>サービス種別</TableHead>
                        <TableHead className="text-right">月額</TableHead>
                        <TableHead className="text-right">手数料</TableHead>
                        <TableHead>ステータス</TableHead>
                        <TableHead>契約開始</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {outsourcingOrders.map((order) => (
                        <TableRow key={order.id}>
                          <TableCell className="font-medium">
                            {order.service_type}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(order.monthly_fee)}
                          </TableCell>
                          <TableCell className="text-right font-mono">
                            {formatCurrency(order.monthly_commission)}
                          </TableCell>
                          <TableCell>
                            <Badge
                              variant={
                                order.status === '契約中'
                                  ? 'default'
                                  : order.status === '解約済'
                                  ? 'secondary'
                                  : 'outline'
                              }
                            >
                              {order.status}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            {order.contract_start_date
                              ? formatDate(order.contract_start_date)
                              : '-'}
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        {/* Tab 3: 担当者一覧 (Contacts) */}
        <TabsContent value="contacts">
          <ContactsList companyId={id} />
        </TabsContent>

        {/* Tab 4: 編集 (Edit) */}
        <TabsContent value="edit">
          <form onSubmit={handleFormSubmit}>
            <div className="grid gap-6 md:grid-cols-2">
              <Card>
                <CardHeader>
                  <CardTitle className="text-base">基本情報</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div>
                    <Label htmlFor="edit_company_name">
                      会社名 <span className="text-red-500">*</span>
                    </Label>
                    <Input
                      id="edit_company_name"
                      value={formData.company_name || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, company_name: e.target.value })
                      }
                      placeholder="株式会社〇〇"
                    />
                    {formErrors.company_name && (
                      <p className="text-sm text-red-500 mt-1">
                        {formErrors.company_name}
                      </p>
                    )}
                  </div>

                  <div>
                    <Label htmlFor="edit_industry">業種</Label>
                    <Input
                      id="edit_industry"
                      value={formData.industry || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, industry: e.target.value })
                      }
                      placeholder="IT・通信"
                    />
                  </div>

                  <div>
                    <Label htmlFor="edit_phone">電話番号</Label>
                    <Input
                      id="edit_phone"
                      type="tel"
                      value={formData.phone || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, phone: e.target.value })
                      }
                      placeholder="03-1234-5678"
                    />
                  </div>

                  <div>
                    <Label htmlFor="edit_email">メールアドレス</Label>
                    <Input
                      id="edit_email"
                      type="email"
                      value={formData.email || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, email: e.target.value })
                      }
                      placeholder="info@example.com"
                    />
                    {formErrors.email && (
                      <p className="text-sm text-red-500 mt-1">{formErrors.email}</p>
                    )}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="text-base">詳細情報</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div>
                    <Label htmlFor="edit_website">ウェブサイト</Label>
                    <Input
                      id="edit_website"
                      value={formData.website || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, website: e.target.value })
                      }
                      placeholder="https://example.com"
                    />
                    {formErrors.website && (
                      <p className="text-sm text-red-500 mt-1">
                        {formErrors.website}
                      </p>
                    )}
                  </div>

                  <div>
                    <Label htmlFor="edit_address">住所</Label>
                    <Input
                      id="edit_address"
                      value={formData.address || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, address: e.target.value })
                      }
                      placeholder="東京都渋谷区..."
                    />
                  </div>

                  <div>
                    <Label htmlFor="edit_employee_count">従業員数</Label>
                    <Input
                      id="edit_employee_count"
                      type="number"
                      value={formData.employee_count ?? ''}
                      onChange={(e) =>
                        setFormData({
                          ...formData,
                          employee_count: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                      placeholder="100"
                    />
                  </div>

                  <div>
                    <Label htmlFor="edit_annual_revenue">年商（円）</Label>
                    <Input
                      id="edit_annual_revenue"
                      type="number"
                      value={formData.annual_revenue ?? ''}
                      onChange={(e) =>
                        setFormData({
                          ...formData,
                          annual_revenue: e.target.value
                            ? Number(e.target.value)
                            : null,
                        })
                      }
                      placeholder="100000000"
                    />
                  </div>

                  <div>
                    <Label htmlFor="edit_notes">備考</Label>
                    <textarea
                      id="edit_notes"
                      value={formData.notes || ''}
                      onChange={(e) =>
                        setFormData({ ...formData, notes: e.target.value })
                      }
                      rows={4}
                      className="flex w-full rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
                      placeholder="その他メモ"
                    />
                  </div>
                </CardContent>
              </Card>
            </div>

            <div className="flex justify-end gap-2 mt-6">
              <Button
                type="button"
                variant="outline"
                onClick={handleFormReset}
                disabled={updateCompany.isPending}
              >
                リセット
              </Button>
              <Button type="submit" disabled={updateCompany.isPending}>
                {updateCompany.isPending ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                    保存中...
                  </>
                ) : (
                  <>
                    <Save className="h-4 w-4 mr-2" />
                    保存
                  </>
                )}
              </Button>
            </div>
          </form>
        </TabsContent>
      </Tabs>
    </div>
  )
}
