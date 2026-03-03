'use client'

import { useState } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useCreateContact } from '@/hooks/use-contacts'
import { z } from 'zod'

type Props = {
  companyId: string
  open: boolean
  onOpenChange: (open: boolean) => void
  onCreated: (contactId: string) => void
}

const quickContactSchema = z.object({
  last_name: z
    .string()
    .min(1, '姓を入力してください')
    .max(50, '50文字以内で入力してください'),
  first_name: z
    .string()
    .max(50, '50文字以内で入力してください')
    .nullable()
    .optional(),
  position: z.string().max(100).nullable().optional(),
  phone: z.string().nullable().optional(),
})

export function QuickAddContactDialog({
  companyId,
  open,
  onOpenChange,
  onCreated,
}: Props) {
  const createMutation = useCreateContact()

  const [formData, setFormData] = useState({
    last_name: '',
    first_name: '',
    position: '',
    phone: '',
  })

  const [errors, setErrors] = useState<Record<string, string>>({})

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setErrors({})

    // バリデーション
    const result = quickContactSchema.safeParse({
      last_name: formData.last_name,
      first_name: formData.first_name || null,
      position: formData.position || null,
      phone: formData.phone || null,
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
      const newContact = await createMutation.mutateAsync({
        company_id: companyId,
        last_name: formData.last_name,
        first_name: formData.first_name || null,
        position: formData.position || null,
        phone: formData.phone || null,
        mobile: null,
        email: null,
        is_key_person: false,
        notes: null,
      })

      // 成功時にIDを返す
      onCreated(newContact.id)
      onOpenChange(false)

      // フォームをリセット
      setFormData({
        last_name: '',
        first_name: '',
        position: '',
        phone: '',
      })
    } catch (error) {
      console.error('Quick add contact error:', error)
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>担当者を素早く追加</DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label htmlFor="quick_last_name">
                姓 <span className="text-red-500">*</span>
              </Label>
              <Input
                id="quick_last_name"
                value={formData.last_name}
                onChange={(e) =>
                  setFormData({ ...formData, last_name: e.target.value })
                }
                placeholder="山田"
                autoFocus
              />
              {errors.last_name && (
                <p className="text-sm text-red-500 mt-1">{errors.last_name}</p>
              )}
            </div>

            <div>
              <Label htmlFor="quick_first_name">名</Label>
              <Input
                id="quick_first_name"
                value={formData.first_name}
                onChange={(e) =>
                  setFormData({ ...formData, first_name: e.target.value })
                }
                placeholder="太郎"
              />
              {errors.first_name && (
                <p className="text-sm text-red-500 mt-1">{errors.first_name}</p>
              )}
            </div>
          </div>

          <div>
            <Label htmlFor="quick_position">役職</Label>
            <Input
              id="quick_position"
              value={formData.position}
              onChange={(e) =>
                setFormData({ ...formData, position: e.target.value })
              }
              placeholder="営業部長"
            />
            {errors.position && (
              <p className="text-sm text-red-500 mt-1">{errors.position}</p>
            )}
          </div>

          <div>
            <Label htmlFor="quick_phone">電話番号</Label>
            <Input
              id="quick_phone"
              type="tel"
              value={formData.phone}
              onChange={(e) =>
                setFormData({ ...formData, phone: e.target.value })
              }
              placeholder="090-1234-5678"
            />
            {errors.phone && (
              <p className="text-sm text-red-500 mt-1">{errors.phone}</p>
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
            <Button type="submit" disabled={createMutation.isPending}>
              {createMutation.isPending ? '追加中...' : '追加'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
