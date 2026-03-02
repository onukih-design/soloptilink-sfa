'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import type { Tables, TablesInsert, TablesUpdate } from '@/types/database'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { MOCK_COMPANIES, MOCK_CONTACTS, MOCK_DEALS } from '@/lib/mock-data'
import { toast } from 'sonner'

const COMPANIES_KEY = 'companies'

// Company with relations
export type CompanyWithRelations = Tables<'companies'> & {
  contacts?: Array<{
    id: string
    last_name: string
    first_name: string | null
    position: string | null
  }>
  deals?: Array<{
    id: string
    deal_name: string
    yomi_status: string
  }>
}

// Filters
export interface CompanyFilters {
  keyword?: string
}

// Sort
export interface CompanySort {
  key: string
  order: 'asc' | 'desc'
}

// Fetch companies list with filters
export function useCompanyList(filters: CompanyFilters, sort: CompanySort) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [COMPANIES_KEY, 'list', filters, sort],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        let result = MOCK_COMPANIES.map((company) => ({
          ...company,
          email: null,
          website: null,
          industry: null,
          employee_count: null,
          annual_revenue: null,
          notes: null,
          created_by: null,
          created_at: '2025-01-01T00:00:00Z',
          updated_at: '2025-01-01T00:00:00Z',
        }))

        // Apply filters
        if (filters.keyword) {
          result = result.filter((c) =>
            c.company_name.toLowerCase().includes(filters.keyword!.toLowerCase())
          )
        }

        // Apply sort
        result.sort((a, b) => {
          const aVal = a[sort.key as keyof typeof a]
          const bVal = b[sort.key as keyof typeof b]

          if (aVal == null && bVal == null) return 0
          if (aVal == null) return sort.order === 'asc' ? 1 : -1
          if (bVal == null) return sort.order === 'asc' ? -1 : 1

          if (typeof aVal === 'string' && typeof bVal === 'string') {
            return sort.order === 'asc'
              ? aVal.localeCompare(bVal)
              : bVal.localeCompare(aVal)
          }

          return sort.order === 'asc' ? (aVal > bVal ? 1 : -1) : (bVal > aVal ? 1 : -1)
        })

        return result as unknown as Tables<'companies'>[]
      }

      // 通常モード: Supabaseから取得
      let query = supabase!
        .from('companies')
        .select('*')

      // Apply filters
      if (filters.keyword) {
        query = query.ilike('company_name', `%${filters.keyword}%`)
      }

      // Apply sort
      query = query.order(sort.key, { ascending: sort.order === 'asc' })

      const { data, error } = await query
      if (error) throw error
      return (data || []) as Tables<'companies'>[]
    },
    staleTime: 30 * 1000,
  })
}

// Fetch single company with all relations
export function useCompany(id: string) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [COMPANIES_KEY, 'detail', id],
    queryFn: async () => {
      // デモモード: IDから探す
      if (IS_DEMO_MODE) {
        const company = MOCK_COMPANIES.find((c) => c.id === id)
        if (!company) throw new Error('Company not found')

        return {
          ...company,
          email: null,
          website: null,
          industry: null,
          employee_count: null,
          annual_revenue: null,
          notes: null,
          created_by: null,
          created_at: '2025-01-01T00:00:00Z',
          updated_at: '2025-01-01T00:00:00Z',
          contacts: MOCK_CONTACTS.filter((c) => c.company_id === id).map((c) => ({
            id: c.id,
            last_name: c.last_name,
            first_name: c.first_name,
            position: c.position,
          })),
          deals: MOCK_DEALS.filter((d) => d.company_id === id).map((d) => ({
            id: d.id,
            deal_name: d.deal_name,
            yomi_status: d.yomi_status,
          })),
        } as unknown as CompanyWithRelations
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('companies')
        .select(`
          *,
          contacts:contacts(id, last_name, first_name, position),
          deals:deals(id, deal_name, yomi_status)
        `)
        .eq('id', id)
        .single()

      if (error) throw error
      return data as unknown as CompanyWithRelations
    },
    enabled: !!id,
  })
}

// Create company mutation
export function useCreateCompany() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (company: TablesInsert<'companies'>) => {
      // デモモード: 成功を返す（実際には何もしない）
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id: 'demo-company-new', ...company } as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('companies')
        .insert(company)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [COMPANIES_KEY] })
      toast.success('会社を登録しました')
    },
  })
}

// Update company mutation
export function useUpdateCompany() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({
      id,
      data,
    }: {
      id: string
      data: TablesUpdate<'companies'>
    }) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id, ...data } as any
      }

      // 通常モード
      const { data: updated, error } = await supabase!
        .from('companies')
        .update(data)
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return updated
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [COMPANIES_KEY] })
      toast.success('会社情報を更新しました')
    },
  })
}

// Delete company mutation
export function useDeleteCompany() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (id: string) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        return
      }

      // 通常モード
      const { error } = await supabase!.from('companies').delete().eq('id', id)

      if (error) throw error
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [COMPANIES_KEY] })
      toast.success('会社を削除しました')
    },
  })
}
