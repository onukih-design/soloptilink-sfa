'use client'

import { useRouter } from 'next/navigation'
import { useCreateDeal } from '@/hooks/use-deals'
import { DealForm } from '@/components/deals/deal-form'
import { toast } from 'sonner'
import type { DealFormValues } from '@/lib/validators/deal'

export default function NewDealPage() {
  const router = useRouter()
  const createDeal = useCreateDeal()

  const handleSubmit = async (data: DealFormValues) => {
    try {
      const { memo, ...rest } = data
      const result = await createDeal.mutateAsync({ ...rest, notes: memo ?? null })
      toast.success('案件を登録しました')
      router.push(`/deals/${result.id}`)
    } catch (error) {
      toast.error('案件の登録に失敗しました')
      throw error
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">新規案件登録</h1>
        <p className="text-muted-foreground text-sm">新しい案件を登録します</p>
      </div>
      <DealForm onSubmit={handleSubmit} isSubmitting={createDeal.isPending} />
    </div>
  )
}
