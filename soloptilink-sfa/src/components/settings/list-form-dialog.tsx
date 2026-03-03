'use client'

import { useState, useEffect } from 'react'
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useCreateList, useUpdateList } from '@/hooks/use-lists'
import type { Tables } from '@/types/database'
import { z } from 'zod'

type Props = {
  list?: Tables<'lists'> | null
  open: boolean
  onOpenChange: (open: boolean) => void
}

const listSchema = z.object({
  list_name: z
    .string()
    .min(1, 'リスト名を入力してください')
    .max(200, '200文字以内で入力してください'),
  description: z.string().max(500).nullable().optional(),
  source: z.string().max(200).nullable().optional(),
})

export function ListFormDialog({ list, open, onOpenChange }: Props) {
  const isEdit = !!list
  const createMutation = useCreateList()
  const updateMutation = useUpdateList()

  const [formData, setFormData] = useState({
    list_name: '',
    description: '',
    source: '',
  })

  const [errors, setErrors] = useState<Record<string, string>>({})

  useEffect(() => {
    if (list && open) {
      setFormData({
        list_name: list.list_name,
        description: list.description || '',
        source: list.source || '',
      })
    } else if (!list && open) {
      setFormData({ list_name: '', description: '', source: '' })
    }
    setErrors({})
  }, [list, open])

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setErrors({})

    const result = listSchema.safeParse({
      list_name: formData.list_name,
      description: formData.description || null,
      source: formData.source || null,
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
      if (isEdit) {
        await updateMutation.mutateAsync({
          id: list.id,
          data: {
            list_name: formData.list_name,
            description: formData.description || null,
            source: formData.source || null,
          },
        })
      } else {
        await createMutation.mutateAsync({
          list_name: formData.list_name,
          description: formData.description || null,
          source: formData.source || null,
          is_active: true,
          total_count: 0,
        })
      }
      onOpenChange(false)
    } catch (error) {
      console.error('List form submit error:', error)
    }
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>{isEdit ? 'リストを編集' : 'リストを追加'}</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <Label htmlFor="list_name">
              リスト名 <span className="text-red-500">*</span>
            </Label>
            <Input
              id="list_name"
              value={formData.list_name}
              onChange={(e) => setFormData({ ...formData, list_name: e.target.value })}
              placeholder="営業リストNO.1"
              autoFocus
            />
            {errors.list_name && (
              <p className="text-sm text-red-500 mt-1">{errors.list_name}</p>
            )}
          </div>
          <div>
            <Label htmlFor="source">取得元</Label>
            <Input
              id="source"
              value={formData.source}
              onChange={(e) => setFormData({ ...formData, source: e.target.value })}
              placeholder="展示会、Web問い合わせ等"
            />
          </div>
          <div>
            <Label htmlFor="description">説明</Label>
            <textarea
              id="description"
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              rows={3}
              className="flex w-full rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
              placeholder="リストの説明"
            />
          </div>
          <div className="flex justify-end gap-2 pt-4">
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
              キャンセル
            </Button>
            <Button type="submit" disabled={createMutation.isPending || updateMutation.isPending}>
              {createMutation.isPending || updateMutation.isPending
                ? '保存中...'
                : isEdit ? '更新' : '追加'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  )
}
