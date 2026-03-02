'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import type { Tables, TablesInsert, TablesUpdate } from '@/types/database'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_LISTS } from '@/lib/mock-data'
import { toast } from 'sonner'

const LISTS_KEY = 'lists'

export function useListAll() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [LISTS_KEY, 'all'],
    queryFn: async () => {
      if (IS_DEMO_MODE) {
        return MOCK_LISTS.map((list) => ({
          ...list,
          description: null,
          source: null,
          total_count: 0,
          created_by: null,
          created_at: '2025-01-01T00:00:00Z',
          updated_at: '2025-01-01T00:00:00Z',
        })) as unknown as Tables<'lists'>[]
      }

      const { data, error } = await supabase!
        .from('lists')
        .select('*')
        .order('list_name')

      if (error) throw error
      return data || []
    },
    staleTime: 5 * 60 * 1000,
  })
}

export function useCreateList() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (list: TablesInsert<'lists'>) => {
      if (IS_DEMO_MODE) {
        return {
          id: `demo-list-${Date.now()}`,
          ...list,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        } as Tables<'lists'>
      }

      const { data, error } = await supabase!
        .from('lists')
        .insert(list)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [LISTS_KEY] })
      toast.success('リストを追加しました')
    },
    onError: (error: Error) => {
      toast.error(`エラー: ${error.message}`)
    },
  })
}

export function useUpdateList() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({ id, data }: { id: string; data: TablesUpdate<'lists'> }) => {
      if (IS_DEMO_MODE) {
        return { id, ...data } as unknown as Tables<'lists'>
      }

      const { data: updated, error } = await supabase!
        .from('lists')
        .update(data)
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return updated
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [LISTS_KEY] })
      toast.success('リストを更新しました')
    },
    onError: (error: Error) => {
      toast.error(`エラー: ${error.message}`)
    },
  })
}

export function useDeleteList() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (id: string) => {
      if (IS_DEMO_MODE) return

      const { error } = await supabase!.from('lists').delete().eq('id', id)
      if (error) throw error
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [LISTS_KEY] })
      toast.success('リストを削除しました')
    },
    onError: (error: Error) => {
      toast.error(`エラー: ${error.message}`)
    },
  })
}
