'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { createClient } from '@/lib/supabase/client'
import type { DealWithRelations, DealFilters, DealSort } from '@/types/deals'
import type { TablesInsert, TablesUpdate } from '@/types/database'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import {
  MOCK_DEALS,
  MOCK_USERS,
  MOCK_COMPANIES,
  MOCK_LISTS,
  MOCK_CONTACTS,
  MOCK_FOLLOWUPS,
} from '@/lib/mock-data'

const DEALS_KEY = 'deals'

// Fetch deals list with filters
export function useDeals(filters: DealFilters, sort: DealSort) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [DEALS_KEY, 'list', filters, sort],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        let result = MOCK_DEALS.map((deal) => ({
          ...deal,
          company: MOCK_COMPANIES.find((c) => c.id === deal.company_id) || {
            id: '',
            company_name: '不明',
          },
          contact:
            MOCK_CONTACTS.find((c) => c.id === deal.contact_id) || null,
          closer: MOCK_USERS.find((u) => u.id === deal.closer_id) || null,
          appointer:
            MOCK_USERS.find((u) => u.id === deal.appointer_id) || null,
          list: MOCK_LISTS.find((l) => l.id === deal.list_id) || null,
          followups: MOCK_FOLLOWUPS.filter((f) => f.deal_id === deal.id),
        }))

        // Apply filters
        if (filters.yomiStatus) {
          result = result.filter((d) => d.yomi_status === filters.yomiStatus)
        }
        if (filters.closerId) {
          result = result.filter((d) => d.closer_id === filters.closerId)
        }
        if (filters.appointerId) {
          result = result.filter((d) => d.appointer_id === filters.appointerId)
        }
        if (filters.listId) {
          result = result.filter((d) => d.list_id === filters.listId)
        }
        if (filters.month) {
          result = result.filter(
            (d) =>
              d.expected_close_date && d.expected_close_date.startsWith(filters.month!)
          )
        }
        if (filters.keyword) {
          result = result.filter(
            (d) =>
              d.company.company_name?.includes(filters.keyword!) ||
              String(d.deal_number).includes(filters.keyword!)
          )
        }

        // Apply sort
        const sortKey = sort.key === 'company_name' ? 'company.company_name' : sort.key

        const getNestedValue = (obj: Record<string, unknown>, path: string): unknown => {
          return path.split('.').reduce<unknown>((current, key) => {
            if (current && typeof current === 'object' && key in (current as Record<string, unknown>)) {
              return (current as Record<string, unknown>)[key]
            }
            return undefined
          }, obj)
        }

        result.sort((a, b) => {
          const aVal = sortKey.includes('.')
            ? getNestedValue(a as unknown as Record<string, unknown>, sortKey)
            : (a as unknown as Record<string, unknown>)[sortKey]
          const bVal = sortKey.includes('.')
            ? getNestedValue(b as unknown as Record<string, unknown>, sortKey)
            : (b as unknown as Record<string, unknown>)[sortKey]

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

        return result as unknown as DealWithRelations[]
      }

      // 通常モード: Supabaseから取得
      let query = supabase!
        .from('deals')
        .select(`
          *,
          company:companies(id, company_name),
          contact:contacts(id, last_name, first_name),
          closer:users!deals_closer_id_fkey(id, display_name),
          appointer:users!deals_appointer_id_fkey(id, display_name),
          list:lists(id, list_name)
        `)

      // Apply filters
      if (filters.yomiStatus) {
        query = query.eq('yomi_status', filters.yomiStatus)
      }
      if (filters.closerId) {
        query = query.eq('closer_id', filters.closerId)
      }
      if (filters.appointerId) {
        query = query.eq('appointer_id', filters.appointerId)
      }
      if (filters.listId) {
        query = query.eq('list_id', filters.listId)
      }
      if (filters.month) {
        query = query
          .gte('expected_close_date', `${filters.month}-01`)
          .lt('expected_close_date', getNextMonth(filters.month))
      }
      if (filters.keyword) {
        query = query.or(
          `deal_name.ilike.%${filters.keyword}%,deal_number.ilike.%${filters.keyword}%`
        )
      }

      // Apply sort
      const sortColumn = sort.key === 'company_name' ? 'company_id' : sort.key
      query = query.order(sortColumn, { ascending: sort.order === 'asc' })

      const { data, error } = await query
      if (error) throw error
      return (data || []) as unknown as DealWithRelations[]
    },
    staleTime: 30 * 1000,
  })
}

// Fetch single deal with all relations
export function useDeal(id: string) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: [DEALS_KEY, 'detail', id],
    queryFn: async () => {
      // デモモード: IDから探す
      if (IS_DEMO_MODE) {
        const deal = MOCK_DEALS.find((d) => d.id === id)
        if (!deal) throw new Error('Deal not found')

        return {
          ...deal,
          company: MOCK_COMPANIES.find((c) => c.id === deal.company_id) || null,
          contact: MOCK_CONTACTS.find((c) => c.id === deal.contact_id) || null,
          closer: MOCK_USERS.find((u) => u.id === deal.closer_id) || null,
          appointer: MOCK_USERS.find((u) => u.id === deal.appointer_id) || null,
          list: MOCK_LISTS.find((l) => l.id === deal.list_id) || null,
          followups: MOCK_FOLLOWUPS.filter((f) => f.deal_id === deal.id).sort((a, b) =>
            new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
          ),
        } as unknown as DealWithRelations
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('deals')
        .select(`
          *,
          company:companies(*),
          contact:contacts(*),
          closer:users!deals_closer_id_fkey(id, display_name, email),
          appointer:users!deals_appointer_id_fkey(id, display_name, email),
          list:lists(id, list_name),
          followups:deal_followups(*, created_by_user:users!deal_followups_created_by_fkey(id, display_name))
        `)
        .eq('id', id)
        .single()

      if (error) throw error
      return data as unknown as DealWithRelations
    },
    enabled: !!id,
  })
}

// Create deal mutation
export function useCreateDeal() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (deal: TablesInsert<'deals'>) => {
      // デモモード: 成功を返す（実際には何もしない）
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id: 'demo-new-deal', ...deal } as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('deals')
        .insert(deal)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [DEALS_KEY] })
    },
  })
}

// Update deal mutation
export function useUpdateDeal() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({
      id,
      data,
    }: {
      id: string
      data: TablesUpdate<'deals'>
    }) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id, ...data } as any
      }

      // 通常モード
      const { data: updated, error } = await supabase!
        .from('deals')
        .update(data)
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return updated
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [DEALS_KEY] })
    },
  })
}

// Delete deal mutation
export function useDeleteDeal() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (id: string) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        return
      }

      // 通常モード
      const { error } = await supabase!.from('deals').delete().eq('id', id)

      if (error) throw error
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [DEALS_KEY] })
    },
  })
}

// Inline update (for spreadsheet-style editing)
export function useInlineUpdateDeal() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async ({
      id,
      field,
      value,
    }: {
      id: string
      field: string
      value: unknown
    }) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id, [field]: value } as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('deals')
        .update({ [field]: value } as TablesUpdate<'deals'>)
        .eq('id', id)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: [DEALS_KEY] })
    },
  })
}

// Add followup
export function useAddFollowup() {
  const queryClient = useQueryClient()
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useMutation({
    mutationFn: async (followup: TablesInsert<'deal_followups'>) => {
      // デモモード: 成功を返す
      if (IS_DEMO_MODE) {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        return { id: 'demo-followup', ...followup } as any
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('deal_followups')
        .insert(followup)
        .select()
        .single()

      if (error) throw error
      return data
    },
    onSuccess: (_, variables) => {
      queryClient.invalidateQueries({
        queryKey: [DEALS_KEY, 'detail', variables.deal_id],
      })
    },
  })
}

// Fetch users for dropdowns
export function useUsers() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['users'],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        return MOCK_USERS.map((u) => ({
          id: u.id,
          display_name: u.display_name,
          email: u.email,
          role: u.role,
        }))
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('users')
        .select('id, display_name, email, role')
        .eq('is_active', true)
        .order('display_name')

      if (error) throw error
      return data || []
    },
    staleTime: 5 * 60 * 1000,
  })
}

// Fetch companies for dropdowns
export function useCompanies() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['companies'],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        return MOCK_COMPANIES.map((c) => ({
          id: c.id,
          company_name: c.company_name,
        })).sort((a, b) => a.company_name.localeCompare(b.company_name))
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('companies')
        .select('id, company_name')
        .order('company_name')

      if (error) throw error
      return data || []
    },
    staleTime: 5 * 60 * 1000,
  })
}

// Fetch lists for dropdowns
export function useLists() {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['lists'],
    queryFn: async () => {
      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        return MOCK_LISTS.filter((l) => l.is_active).map((l) => ({
          id: l.id,
          list_name: l.list_name,
        })).sort((a, b) => a.list_name.localeCompare(b.list_name))
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('lists')
        .select('id, list_name')
        .eq('is_active', true)
        .order('list_name')

      if (error) throw error
      return data || []
    },
    staleTime: 5 * 60 * 1000,
  })
}

// Fetch contacts for a company
export function useContacts(companyId: string | null) {
  const supabase = IS_DEMO_MODE ? null : createClient()

  return useQuery({
    queryKey: ['contacts', companyId],
    queryFn: async () => {
      if (!companyId) return []

      // デモモード: モックデータを返す
      if (IS_DEMO_MODE) {
        return MOCK_CONTACTS.filter((c) => c.company_id === companyId)
          .map((c) => ({
            id: c.id,
            last_name: c.last_name,
            first_name: c.first_name,
            position: c.position,
          }))
          .sort((a, b) => a.last_name.localeCompare(b.last_name))
      }

      // 通常モード
      const { data, error } = await supabase!
        .from('contacts')
        .select('id, last_name, first_name, position')
        .eq('company_id', companyId)
        .order('last_name')

      if (error) throw error
      return data || []
    },
    enabled: !!companyId,
    staleTime: 5 * 60 * 1000,
  })
}

// Helper
function getNextMonth(yearMonth: string): string {
  const [year, month] = yearMonth.split('-').map(Number)
  const next = new Date(year, month, 1)
  return `${next.getFullYear()}-${String(next.getMonth() + 1).padStart(2, '0')}-01`
}
