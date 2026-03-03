'use client'

/**
 * Mutable Mock Store for SoloptiLink SFA Demo Mode
 *
 * セッション内で変更可能なモックデータストア。
 * 既存の MOCK_ 配列をラップし、新規レコード追加を可能にする。
 */

import {
  MOCK_COMPANIES,
  MOCK_CONTACTS,
  MOCK_DEALS,
  MOCK_AI_TOOL_ORDERS,
  MOCK_SALES_OUTSOURCING_ORDERS,
  MOCK_MONTHLY_REVENUE,
  MOCK_USERS,
  MOCK_LISTS,
} from '@/lib/mock-data'

// ========================================
// UUID Generator
// ========================================

/**
 * UUID v4 を生成する（ブラウザ環境）
 */
export function generateId(): string {
  if (typeof crypto !== 'undefined' && crypto.randomUUID) {
    return crypto.randomUUID()
  }
  // フォールバック: Date.now + random
  return `${Date.now().toString(36)}-${Math.random().toString(36).substring(2, 15)}`
}

// ========================================
// Mutable Module-Level Stores
// ========================================

let companies = [...MOCK_COMPANIES]
let contacts = [...MOCK_CONTACTS]
let deals = [...MOCK_DEALS]
let aiToolOrders = [...MOCK_AI_TOOL_ORDERS]
let salesOutsourcingOrders = [...MOCK_SALES_OUTSOURCING_ORDERS]
let monthlyRevenue = [...MOCK_MONTHLY_REVENUE]
let users = [...MOCK_USERS]
let lists = [...MOCK_LISTS]

// ========================================
// Getter Functions
// ========================================

export function getCompanies() {
  return companies
}

export function getDeals() {
  return deals
}

export function getContacts() {
  return contacts
}

export function getAiToolOrders() {
  return aiToolOrders
}

export function getSalesOutsourcingOrders() {
  return salesOutsourcingOrders
}

export function getMonthlyRevenue() {
  return monthlyRevenue
}

export function getUsers() {
  return users
}

export function getLists() {
  return lists
}

// ========================================
// Add Functions
// ========================================

/**
 * 企業を追加
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function addCompany(data: Record<string, any>) {
  const newCompany = {
    id: generateId(),
    ...data,
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  companies.push(newCompany as any)
  return newCompany
}

/**
 * 連絡先を追加
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function addContact(data: Record<string, any>) {
  const newContact = {
    id: generateId(),
    ...data,
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  contacts.push(newContact as any)
  return newContact
}

/**
 * 案件を追加
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function addDeal(data: Record<string, any>) {
  const now = new Date().toISOString()

  // deal_number を自動生成（数値型）
  const maxNum = deals
    .map(d => (typeof d.deal_number === 'number' ? d.deal_number : 0))
    .reduce((max, num) => Math.max(max, num), 0)

  const newDeal = {
    id: generateId(),
    deal_number: maxNum + 1,
    created_at: now,
    updated_at: now,
    ...data,
  }
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  deals.push(newDeal as any)
  return newDeal
}

/**
 * AIツール受注を追加
 */
export function addAiToolOrder(data: Omit<typeof MOCK_AI_TOOL_ORDERS[0], 'id' | 'created_at' | 'updated_at'>) {
  const now = new Date().toISOString()
  const newOrder = {
    id: generateId(),
    created_at: now,
    updated_at: now,
    ...data,
  }
  aiToolOrders.push(newOrder)
  return newOrder
}

/**
 * 営業代行受注を追加
 */
export function addSalesOutsourcingOrder(data: Omit<typeof MOCK_SALES_OUTSOURCING_ORDERS[0], 'id' | 'created_at' | 'updated_at'>) {
  const now = new Date().toISOString()
  const newOrder = {
    id: generateId(),
    created_at: now,
    updated_at: now,
    ...data,
  }
  salesOutsourcingOrders.push(newOrder)
  return newOrder
}

/**
 * 月次売上を追加
 */
export function addMonthlyRevenue(data: Omit<typeof MOCK_MONTHLY_REVENUE[0], 'id'>) {
  const newRevenue = {
    id: generateId(),
    ...data,
  }
  monthlyRevenue.push(newRevenue)
  return newRevenue
}

// ========================================
// Reset Function (for testing/debug)
// ========================================

/**
 * 全データを初期状態にリセット（デバッグ用）
 */
export function resetStore() {
  companies = [...MOCK_COMPANIES]
  contacts = [...MOCK_CONTACTS]
  deals = [...MOCK_DEALS]
  aiToolOrders = [...MOCK_AI_TOOL_ORDERS]
  salesOutsourcingOrders = [...MOCK_SALES_OUTSOURCING_ORDERS]
  monthlyRevenue = [...MOCK_MONTHLY_REVENUE]
  users = [...MOCK_USERS]
  lists = [...MOCK_LISTS]
}
