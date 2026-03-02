'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { useCreateCompany } from '@/hooks/use-companies'
import { companyFormSchema, type CompanyFormValues } from '@/lib/validators/company'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { ArrowLeft, Save, Loader2 } from 'lucide-react'
import Link from 'next/link'

export default function NewCompanyPage() {
  const router = useRouter()
  const createCompany = useCreateCompany()

  const [formData, setFormData] = useState<Partial<CompanyFormValues>>({
    company_name: '',
    phone: '',
    email: '',
    website: '',
    address: '',
    industry: '',
    employee_count: null,
    annual_revenue: null,
    notes: '',
  })

  const [errors, setErrors] = useState<Record<string, string>>({})

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setErrors({})

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
      setErrors(fieldErrors)
      return
    }

    try {
      await createCompany.mutateAsync({
        company_name: formData.company_name!,
        phone: formData.phone || null,
        email: formData.email || null,
        website: formData.website || null,
        address: formData.address || null,
        industry: formData.industry || null,
        employee_count: formData.employee_count || null,
        annual_revenue: formData.annual_revenue || null,
        notes: formData.notes || null,
      })
      router.push('/companies')
    } catch {
      // error is handled by mutation's onError
    }
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <Link href="/companies">
          <Button variant="ghost" size="sm">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div>
          <h1 className="text-2xl font-bold tracking-tight">新規会社追加</h1>
          <p className="text-muted-foreground text-sm">
            新しい取引先企業を登録します
          </p>
        </div>
      </div>

      <form onSubmit={handleSubmit}>
        <div className="grid gap-6 md:grid-cols-2">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">基本情報</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label htmlFor="company_name">
                  会社名 <span className="text-red-500">*</span>
                </Label>
                <Input
                  id="company_name"
                  value={formData.company_name || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, company_name: e.target.value })
                  }
                  placeholder="株式会社〇〇"
                />
                {errors.company_name && (
                  <p className="text-sm text-red-500 mt-1">{errors.company_name}</p>
                )}
              </div>

              <div>
                <Label htmlFor="industry">業種</Label>
                <Input
                  id="industry"
                  value={formData.industry || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, industry: e.target.value })
                  }
                  placeholder="IT・通信"
                />
              </div>

              <div>
                <Label htmlFor="phone">電話番号</Label>
                <Input
                  id="phone"
                  type="tel"
                  value={formData.phone || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, phone: e.target.value })
                  }
                  placeholder="03-1234-5678"
                />
              </div>

              <div>
                <Label htmlFor="email">メールアドレス</Label>
                <Input
                  id="email"
                  type="email"
                  value={formData.email || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, email: e.target.value })
                  }
                  placeholder="info@example.com"
                />
                {errors.email && (
                  <p className="text-sm text-red-500 mt-1">{errors.email}</p>
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
                <Label htmlFor="website">ウェブサイト</Label>
                <Input
                  id="website"
                  value={formData.website || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, website: e.target.value })
                  }
                  placeholder="https://example.com"
                />
                {errors.website && (
                  <p className="text-sm text-red-500 mt-1">{errors.website}</p>
                )}
              </div>

              <div>
                <Label htmlFor="address">住所</Label>
                <Input
                  id="address"
                  value={formData.address || ''}
                  onChange={(e) =>
                    setFormData({ ...formData, address: e.target.value })
                  }
                  placeholder="東京都渋谷区..."
                />
              </div>

              <div>
                <Label htmlFor="employee_count">従業員数</Label>
                <Input
                  id="employee_count"
                  type="number"
                  value={formData.employee_count ?? ''}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      employee_count: e.target.value ? Number(e.target.value) : null,
                    })
                  }
                  placeholder="100"
                />
              </div>

              <div>
                <Label htmlFor="annual_revenue">年商（円）</Label>
                <Input
                  id="annual_revenue"
                  type="number"
                  value={formData.annual_revenue ?? ''}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      annual_revenue: e.target.value ? Number(e.target.value) : null,
                    })
                  }
                  placeholder="100000000"
                />
              </div>

              <div>
                <Label htmlFor="notes">備考</Label>
                <textarea
                  id="notes"
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
          <Link href="/companies">
            <Button type="button" variant="outline">
              キャンセル
            </Button>
          </Link>
          <Button type="submit" disabled={createCompany.isPending}>
            {createCompany.isPending ? (
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
    </div>
  )
}
