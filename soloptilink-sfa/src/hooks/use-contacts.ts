'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import type { Tables, TablesInsert, TablesUpdate } from '@/types/database'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_CONTACTS } from '@/lib/mock-data'
import { toast } from 'sonner'

const CONTACTS_KEY = 'contacts'

// Fetch contacts by company
export function useContactsByCompany(companyId: string) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [CONTACTS_KEY, 'company', companyId],
    queryFn: async () => {
      if (!companyId) return []

      // デモモード: モックデータをフィルタ
      if (IS_DEMO_MODE) {
        return MOCK_CONTACTS.filter((c) => c.company_id === companyId).sort(
          (a, b) => a.last_name.localeCompare(b.last_name)
        ) as unknown as Tables<'contacts'>[]
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('contacts')
        .select('*')
        .eq('company_id', companyId)
        .order('last_name')

      if (error) throw error
      return data || []
    },
    enabled: !!companyId,
    staleTime: 5 * 60 * 1000,
  })
}

// Fetch single contact
export function useContact(id: string) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [CONTACTS_KEY, 'detail', id],
    queryFn: async () => {
      // デモモード
      if (IS_DEMO_MODE) {
        const contact = MOCK_CONTACTS.find((c) => c.id === id)
        if (!contact) throw new Error('Contact not found')
        return contact as unknown as Tables<'contacts'>
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('contacts')
        .select('*')
        .eq('id', id)
        .single()

      if (error) throw error
      return data
    },
    enabled: !!id,
  })
}

// Create contact mutation
export function useCreateContact() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (contact: TablesInsert<'contacts'>) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        return {
          id: `demo-contact-${Date.now()}`,
          ...contact,
          is_key_person: contact.is_key_person ?? false,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        } as Tables<'contacts'>
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('contacts')
        .insert(contact)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: [CONTACTS_KEY] })
      queryClient.invalidateQueries({
        queryKey: ['contacts', data.company_id],
      })
      toast.success('担当者を追加しました')
    },
    onError: (error: Error) => {
      toast.error(`エラーが発生しました: ${error.message}`)
    },
  })
}

// Update contact mutation
export function useUpdateContact() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({
      id,
      data,
    }: {
      id: string
      data: TablesUpdate<'contacts'>
    }) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        return {
          id,
          ...data,
          updated_at: new Date().toISOString(),
        } as Tables<'contacts'>
      }

      // 通常モード
      const { data: updated, error } = await supabase!
        .from('contacts')
        .update(data)
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return updated
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: [CONTACTS_KEY] })
      queryClient.invalidateQueries({
        queryKey: ['contacts', data.company_id],
      })
      toast.success('担当者を更新しました')
    },
    onError: (error: Error) => {
      toast.error(`エラーが発生しました: ${error.message}`)
    },
  })
}

// Delete contact mutation
export function useDeleteContact() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (id: string) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        return
      }

      // 通常モード
      const { error } = await supabase!.from('contacts').delete().eq('id', id)

      if (error) throw error
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [CONTACTS_KEY] })
      queryClient.invalidateQueries({ queryKey: ['contacts'] })
      toast.success('担当者を削除しました')
    },
    onError: (error: Error) => {
      toast.error(`エラーが発生しました: ${error.message}`)
    },
  })
}
