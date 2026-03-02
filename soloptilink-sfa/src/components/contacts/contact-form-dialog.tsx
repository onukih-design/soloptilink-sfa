'use client'

import { useState, useEffect } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import type { Tables } from '@/types/database'
import { useCreateContact, useUpdateContact } from '@/hooks/use-contacts'
import { contactFormSchema, type ContactFormValues } from '@/lib/validators/contact'

type Props = {
  companyId: string
  contact?: Tables<'contacts'> | null
  open: boolean
  onOpenChange: (open: boolean) => void
  onSuccess?: () => void
}

export function ContactFormDialog({
  companyId,
  contact,
  open,
  onOpenChange,
  onSuccess,
}: Props) {
  const isEdit = !!contact
  const createMutation = useCreateContact()
  const updateMutation = useUpdateContact()

  const [formData, setFormData] = useState<ContactFormValues>({
    company_id: companyId,
    last_name: '',
    first_name: null,
    position: null,
    department: null,
    phone: null,
    mobile: null,
    email: null,
    is_key_person: false,
    notes: null,
  })

  const [errors, setErrors] = useState<Record<string, string>>({})

  // 編集時にデータを読み込む
  useEffect(() => {
    if (contact && open) {
      setFormData({
        company_id: contact.company_id,
        last_name: contact.last_name,
        first_name: contact.first_name || null,
        position: contact.position || null,
        department: contact.department || null,
        phone: contact.phone || null,
        mobile: contact.mobile || null,
        email: contact.email || null,
        is_key_person: contact.is_key_person,
        notes: contact.notes || null,
      })
    } else if (!contact && open) {
      // 新規作成時はリセット
      setFormData({
        company_id: companyId,
        last_name: '',
        first_name: null,
        position: null,
        department: null,
        phone: null,
        mobile: null,
        email: null,
        is_key_person: false,
        notes: null,
      })
    }
    setErrors({})
  }, [contact, open, companyId])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setErrors({})

    // バリデーション
    const result = contactFormSchema.safeParse(formData)
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
      if (isEdit) {
        await updateMutation.mutateAsync({
          id: contact.id,
          data: {
            last_name: formData.last_name,
            first_name: formData.first_name || null,
            position: formData.position || null,
            department: formData.department || null,
            phone: formData.phone || null,
            mobile: formData.mobile || null,
            email: formData.email || null,
            is_key_person: formData.is_key_person,
            notes: formData.notes || null,
          },
        })
      } else {
        await createMutation.mutateAsync({
          company_id: companyId,
          last_name: formData.last_name,
          first_name: formData.first_name || null,
          position: formData.position || null,
          department: formData.department || null,
          phone: formData.phone || null,
          mobile: formData.mobile || null,
          email: formData.email || null,
          is_key_person: formData.is_key_person,
          notes: formData.notes || null,
        })
      }

      onOpenChange(false)
      onSuccess?.()
    } catch (error) {
      console.error('Contact form submit error:', error)
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>
            {isEdit ? '担当者を編集' : '担当者を追加'}
          </DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="last_name">
                姓 <span className="text-red-500">*</span>
              </Label>
              <Input
                id="last_name"
                value={formData.last_name}
                onChange={(e) =>
                  setFormData({ ...formData, last_name: e.target.value })
                }
                placeholder="山田"
              />
              {errors.last_name && (
                <p className="text-sm text-red-500 mt-1">{errors.last_name}</p>
              )}
            </div>

            <div>
              <Label htmlFor="first_name">名</Label>
              <Input
                id="first_name"
                value={formData.first_name || ''}
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    first_name: e.target.value || null,
                  })
                }
                placeholder="太郎"
              />
              {errors.first_name && (
                <p className="text-sm text-red-500 mt-1">{errors.first_name}</p>
              )}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="position">役職</Label>
              <Input
                id="position"
                value={formData.position || ''}
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    position: e.target.value || null,
                  })
                }
                placeholder="営業部長"
              />
              {errors.position && (
                <p className="text-sm text-red-500 mt-1">{errors.position}</p>
              )}
            </div>

            <div>
              <Label htmlFor="department">部署</Label>
              <Input
                id="department"
                value={formData.department || ''}
                onChange={(e) =>
                  setFormData({
                    ...formData,
                    department: e.target.value || null,
                  })
                }
                placeholder="営業部"
              />
              {errors.department && (
                <p className="text-sm text-red-500 mt-1">{errors.department}</p>
              )}
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="phone">電話番号</Label>
              <Input
                id="phone"
                type="tel"
                value={formData.phone || ''}
                onChange={(e) =>
                  setFormData({ ...formData, phone: e.target.value || null })
                }
                placeholder="03-1234-5678"
              />
              {errors.phone && (
                <p className="text-sm text-red-500 mt-1">{errors.phone}</p>
              )}
            </div>

            <div>
              <Label htmlFor="mobile">携帯番号</Label>
              <Input
                id="mobile"
                type="tel"
                value={formData.mobile || ''}
                onChange={(e) =>
                  setFormData({ ...formData, mobile: e.target.value || null })
                }
                placeholder="090-1234-5678"
              />
              {errors.mobile && (
                <p className="text-sm text-red-500 mt-1">{errors.mobile}</p>
              )}
            </div>
          </div>

          <div>
            <Label htmlFor="email">メールアドレス</Label>
            <Input
              id="email"
              type="email"
              value={formData.email || ''}
              onChange={(e) =>
                setFormData({ ...formData, email: e.target.value || null })
              }
              placeholder="example@example.com"
            />
            {errors.email && (
              <p className="text-sm text-red-500 mt-1">{errors.email}</p>
            )}
          </div>

          <div className="flex items-center space-x-2">
            <input
              type="checkbox"
              id="is_key_person"
              checked={formData.is_key_person}
              onChange={(e) =>
                setFormData({ ...formData, is_key_person: e.target.checked })
              }
              className="h-4 w-4 rounded border-gray-300"
            />
            <Label htmlFor="is_key_person" className="cursor-pointer">
              キーパーソン
            </Label>
          </div>

          <div>
            <Label htmlFor="notes">備考</Label>
            <textarea
              id="notes"
              value={formData.notes || ''}
              onChange={(e) =>
                setFormData({ ...formData, notes: e.target.value || null })
              }
              rows={3}
              className="flex w-full rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
              placeholder="その他メモ"
            />
            {errors.notes && (
              <p className="text-sm text-red-500 mt-1">{errors.notes}</p>
            )}
          </div>

          <div className="flex justify-end gap-2 pt-4">
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
            >
              キャンセル
            </Button>
            <Button
              type="submit"
              disabled={createMutation.isPending || updateMutation.isPending}
            >
              {createMutation.isPending || updateMutation.isPending
                ? '保存中...'
                : isEdit
                  ? '更新'
                  : '追加'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
