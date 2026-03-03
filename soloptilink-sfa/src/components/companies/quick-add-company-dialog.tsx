'use client'

import { useState } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useCreateCompany } from '@/hooks/use-companies'
import { z } from 'zod'

type Props = {
  open: boolean
  onOpenChange: (open: boolean) => void
  onCreated: (companyId: string, companyName: string) => void
}

const quickCompanySchema = z.object({
  company_name: z
    .string()
    .min(1, '会社名を入力してください')
    .max(200, '200文字以内で入力してください'),
  phone: z.string().nullable().optional(),
  industry: z.string().nullable().optional(),
})

export function QuickAddCompanyDialog({
  open,
  onOpenChange,
  onCreated,
}: Props) {
  const createMutation = useCreateCompany()

  const [formData, setFormData] = useState({
    company_name: '',
    phone: '',
    industry: '',
  })

  const [errors, setErrors] = useState<Record<string, string>>({})

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setErrors({})

    const result = quickCompanySchema.safeParse({
      company_name: formData.company_name,
      phone: formData.phone || null,
      industry: formData.industry || null,
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
      const newCompany = await createMutation.mutateAsync({
        company_name: formData.company_name,
        phone: formData.phone || null,
        industry: formData.industry || null,
        email: null,
        website: null,
        address: null,
        employee_count: null,
        annual_revenue: null,
        notes: null,
      })

      onCreated(newCompany.id, formData.company_name)
      onOpenChange(false)

      setFormData({
        company_name: '',
        phone: '',
        industry: '',
      })
    } catch (error) {
      console.error('Quick add company error:', error)
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>会社を素早く追加</DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Label htmlFor="quick_company_name">
              会社名 <span className="text-red-500">*</span>
            </Label>
            <Input
              id="quick_company_name"
              value={formData.company_name}
              onChange={(e) =>
                setFormData({ ...formData, company_name: e.target.value })
              }
              placeholder="株式会社〇〇"
              autoFocus
            />
            {errors.company_name && (
              <p className="text-sm text-red-500 mt-1">{errors.company_name}</p>
            )}
          </div>

          <div>
            <Label htmlFor="quick_company_phone">電話番号</Label>
            <Input
              id="quick_company_phone"
              type="tel"
              value={formData.phone}
              onChange={(e) =>
                setFormData({ ...formData, phone: e.target.value })
              }
              placeholder="03-1234-5678"
            />
          </div>

          <div>
            <Label htmlFor="quick_company_industry">業種</Label>
            <Input
              id="quick_company_industry"
              value={formData.industry}
              onChange={(e) =>
                setFormData({ ...formData, industry: e.target.value })
              }
              placeholder="IT・通信"
            />
          </div>

          <div className="flex justify-end gap-2 pt-4">
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
            >
              キャンセル
            </Button>
            <Button type="submit" disabled={createMutation.isPending}>
              {createMutation.isPending ? '追加中...' : '追加'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
