'use client';

/**
 * Revenue Calculation Engine v2
 *
 * Comprehensive business metrics calculator for SoloptiLink SFA
 * Calculates all key revenue, performance, and funnel metrics from mock data
 */

import {
  MOCK_DEALS,
  MOCK_COMPANIES,
  MOCK_USERS,
  MOCK_AI_TOOL_ORDERS,
  MOCK_SALES_OUTSOURCING_ORDERS,
  MOCK_FOLLOWUPS,
  MOCK_LISTS,
} from '@/lib/mock-data';
import { YOMI_RATES } from '@/lib/constants/yomi';
import type { YomiStatus } from '@/types/deals';

// ============================================================================
// Types
// ============================================================================

export interface YomiStatusSummary {
  status: YomiStatus;
  count: number;
  totalAmount: number;
  weightedAmount: number;
  monthlyAmount: number;
}

export interface YomiSummary {
  byStatus: YomiStatusSummary[];
  totals: {
    count: number;
    totalAmount: number;
    weightedAmount: number;
    monthlyAmount: number;
  };
  hot: {
    count: number;
    totalAmount: number;
    weightedAmount: number;
  };
  cold: {
    count: number;
    totalAmount: number;
    weightedAmount: number;
  };
}

export interface AIToolProductBreakdown {
  product: string;
  productName: string;
  activeContracts: number;
  mrr: number;
  margin: number;
  avgContractMonths: number;
}

export interface AIToolRevenue {
  totalMRR: number;
  totalARR: number;
  totalMonthlyMargin: number;
  byProduct: AIToolProductBreakdown[];
  churnRate: number;
  newContractsThisMonth: number;
  ltv: number;
}

export interface OutsourcingServiceBreakdown {
  serviceType: string;
  activeContracts: number;
  monthlyCommission: number;
  avgContractValue: number;
}

export interface OutsourcingRevenue {
  totalMonthlyCommission: number;
  totalActiveContracts: number;
  byService: OutsourcingServiceBreakdown[];
  avgContractValue: number;
}

export interface TotalRevenue {
  aiToolsTotal: number;
  outsourcingTotal: number;
  grandTotal: number;
  byCategory: {
    category: string;
    amount: number;
    percentage: number;
  }[];
  monthlyTrend: {
    month: string;
    aiTools: number;
    outsourcing: number;
    total: number;
  }[];
  growthRateMoM: number;
  growthRateYoY: number;
}

export interface FunnelMetrics {
  totalLeads: number;
  appointments: number;
  negotiations: number;
  wonDeals: number;
  conversionRates: {
    leadToAppointment: number;
    appointmentToNegotiation: number;
    negotiationToWon: number;
    leadToWon: number;
  };
  avgDealCycleDays: number;
}

export interface CloserPerformance {
  closerId: string;
  closerName: string;
  dealCount: number;
  winCount: number;
  winRate: number;
  totalRevenue: number;
  avgDealSize: number;
  pipelineValue: number;
  monthlyTrend: {
    month: string;
    revenue: number;
  }[];
}

export interface AppointerPerformance {
  appointerId: string;
  appointerName: string;
  appointmentsSet: number;
  conversionRate: number;
  revenueAttributed: number;
  bestPerformingList: string;
}

export interface ListPerformance {
  listId: string;
  listName: string;
  dealCount: number;
  winRate: number;
  revenueGenerated: number;
  costPerAcquisition: number | null;
  bestCloser: string;
}

export interface MonthlyTargetVsActual {
  month: string;
  target: number;
  actual: number;
  achievementRate: number;
}

export interface TargetVsActual {
  monthly: MonthlyTargetVsActual[];
  cumulativeAchievement: number;
  forecastedYearEnd: number;
}

export interface OverdueAction {
  dealId: string;
  dealName: string;
  companyName: string;
  daysOverdue: number;
  nextActionDate: string;
  nextAction: string;
}

export interface OverdueActions {
  count: number;
  items: OverdueAction[];
  byUrgency: {
    low: OverdueAction[];    // 1-3 days
    medium: OverdueAction[]; // 4-7 days
    high: OverdueAction[];   // 8+ days
  };
}

// ============================================================================
// Helper Functions
// ============================================================================

function getYomiRate(status: YomiStatus): number {
  return YOMI_RATES[status] || 0;
}

function getUserName(userId: string | null): string {
  if (!userId) return '未設定';
  const user = MOCK_USERS.find(u => u.id === userId);
  return user?.display_name || '不明';
}

function getListName(listId: string | null): string {
  if (!listId) return '未設定';
  const list = MOCK_LISTS.find(l => l.id === listId);
  return list?.list_name || '不明';
}

function getCompanyName(companyId: string | null): string {
  if (!companyId) return '不明';
  const company = MOCK_COMPANIES.find(c => c.id === companyId);
  return company?.company_name || '不明';
}

function getDaysBetween(date1: string | null, date2: string | null): number {
  if (!date1 || !date2) return 0;
  const d1 = new Date(date1);
  const d2 = new Date(date2);
  return Math.floor((d2.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24));
}

function getMonthKey(date: string | null): string {
  if (!date) return '';
  const d = new Date(date);
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}`;
}

// ============================================================================
// 1. Yomi Summary
// ============================================================================

export function calculateYomiSummary(): YomiSummary {
  const statusGroups = new Map<YomiStatus, {
    count: number;
    totalAmount: number;
    monthlyAmount: number;
  }>();

  // Initialize all statuses
  const allStatuses: YomiStatus[] = ['受注', 'Aヨミ', 'Bヨミ', 'Cヨミ', 'ネタ', '没ネタ', '失注', '消滅'];
  allStatuses.forEach(status => {
    statusGroups.set(status, { count: 0, totalAmount: 0, monthlyAmount: 0 });
  });

  // Aggregate deals by status
  MOCK_DEALS.forEach(deal => {
    const status = deal.yomi_status as YomiStatus;
    const current = statusGroups.get(status) || { count: 0, totalAmount: 0, monthlyAmount: 0 };
    current.count += 1;
    current.totalAmount += deal.amount || 0;
    current.monthlyAmount += deal.monthly_amount || 0;
    statusGroups.set(status, current);
  });

  // Build by-status summary
  const byStatus: YomiStatusSummary[] = allStatuses.map(status => {
    const data = statusGroups.get(status) || { count: 0, totalAmount: 0, monthlyAmount: 0 };
    const rate = getYomiRate(status);
    return {
      status,
      count: data.count,
      totalAmount: data.totalAmount,
      weightedAmount: data.totalAmount * rate,
      monthlyAmount: data.monthlyAmount,
    };
  });

  // Calculate totals
  const totals = byStatus.reduce((acc, item) => ({
    count: acc.count + item.count,
    totalAmount: acc.totalAmount + item.totalAmount,
    weightedAmount: acc.weightedAmount + item.weightedAmount,
    monthlyAmount: acc.monthlyAmount + item.monthlyAmount,
  }), { count: 0, totalAmount: 0, weightedAmount: 0, monthlyAmount: 0 });

  // Hot vs Cold
  const hotStatuses: YomiStatus[] = ['受注', 'Aヨミ', 'Bヨミ'];
  const coldStatuses: YomiStatus[] = ['Cヨミ', 'ネタ', '没ネタ'];

  const hot = byStatus
    .filter(s => hotStatuses.includes(s.status))
    .reduce((acc, item) => ({
      count: acc.count + item.count,
      totalAmount: acc.totalAmount + item.totalAmount,
      weightedAmount: acc.weightedAmount + item.weightedAmount,
    }), { count: 0, totalAmount: 0, weightedAmount: 0 });

  const cold = byStatus
    .filter(s => coldStatuses.includes(s.status))
    .reduce((acc, item) => ({
      count: acc.count + item.count,
      totalAmount: acc.totalAmount + item.totalAmount,
      weightedAmount: acc.weightedAmount + item.weightedAmount,
    }), { count: 0, totalAmount: 0, weightedAmount: 0 });

  return { byStatus, totals, hot, cold };
}

// ============================================================================
// 2. AI Tool Revenue
// ============================================================================

export function calculateAIToolRevenue(): AIToolRevenue {
  const activeOrders = MOCK_AI_TOOL_ORDERS.filter(o => o.status === '契約中');
  const totalOrders = MOCK_AI_TOOL_ORDERS.length;

  // Total MRR and Margin
  const totalMRR = activeOrders.reduce((sum, o) => sum + (o.monthly_fee || 0), 0);
  const totalMonthlyMargin = activeOrders.reduce((sum, o) => sum + (o.monthly_margin || 0), 0);
  const totalARR = totalMRR * 12;

  // By-product breakdown
  const productMap = new Map<string, {
    count: number;
    mrr: number;
    margin: number;
    totalMonths: number;
  }>();

  activeOrders.forEach(order => {
    const product = order.product || '不明';
    const current = productMap.get(product) || { count: 0, mrr: 0, margin: 0, totalMonths: 0 };
    current.count += 1;
    current.mrr += order.monthly_fee || 0;
    current.margin += order.monthly_margin || 0;
    current.totalMonths += order.contract_months || 12;
    productMap.set(product, current);
  });

  const byProduct: AIToolProductBreakdown[] = Array.from(productMap.entries()).map(([product, data]) => ({
    product,
    productName: product,
    activeContracts: data.count,
    mrr: data.mrr,
    margin: data.margin,
    avgContractMonths: data.count > 0 ? data.totalMonths / data.count : 0,
  }));

  // Churn rate
  const churnedOrders = MOCK_AI_TOOL_ORDERS.filter(o => o.status === '解約済み');
  const churnRate = totalOrders > 0 ? churnedOrders.length / totalOrders : 0;

  // New contracts this month
  const thisMonth = new Date();
  const thisMonthKey = getMonthKey(thisMonth.toISOString());
  const newContractsThisMonth = MOCK_AI_TOOL_ORDERS.filter(o => {
    return getMonthKey(o.created_at) === thisMonthKey;
  }).length;

  // LTV estimate (avg monthly margin * avg contract months)
  const totalMargin = activeOrders.reduce((sum, o) => sum + (o.monthly_margin || 0), 0);
  const totalMonths = activeOrders.reduce((sum, o) => sum + (o.contract_months || 12), 0);
  const avgMonthlyMargin = activeOrders.length > 0 ? totalMargin / activeOrders.length : 0;
  const avgContractMonths = activeOrders.length > 0 ? totalMonths / activeOrders.length : 0;
  const ltv = avgMonthlyMargin * avgContractMonths;

  return {
    totalMRR,
    totalARR,
    totalMonthlyMargin,
    byProduct,
    churnRate,
    newContractsThisMonth,
    ltv,
  };
}

// ============================================================================
// 3. Outsourcing Revenue
// ============================================================================

export function calculateOutsourcingRevenue(): OutsourcingRevenue {
  const activeOrders = MOCK_SALES_OUTSOURCING_ORDERS.filter(o => o.status === '契約中');

  const totalMonthlyCommission = activeOrders.reduce((sum, o) => sum + (o.monthly_commission || 0), 0);
  const totalActiveContracts = activeOrders.length;

  // By-service breakdown
  const serviceMap = new Map<string, {
    count: number;
    commission: number;
    totalValue: number;
  }>();

  activeOrders.forEach(order => {
    const service = order.service_type || '不明';
    const current = serviceMap.get(service) || { count: 0, commission: 0, totalValue: 0 };
    current.count += 1;
    current.commission += order.monthly_commission || 0;
    current.totalValue += order.monthly_fee || 0;
    serviceMap.set(service, current);
  });

  const byService: OutsourcingServiceBreakdown[] = Array.from(serviceMap.entries()).map(([serviceType, data]) => ({
    serviceType,
    activeContracts: data.count,
    monthlyCommission: data.commission,
    avgContractValue: data.count > 0 ? data.totalValue / data.count : 0,
  }));

  const totalContractValue = activeOrders.reduce((sum, o) => sum + (o.monthly_fee || 0), 0);
  const avgContractValue = totalActiveContracts > 0 ? totalContractValue / totalActiveContracts : 0;

  return {
    totalMonthlyCommission,
    totalActiveContracts,
    byService,
    avgContractValue,
  };
}

// ============================================================================
// 4. Total Revenue
// ============================================================================

export function calculateTotalRevenue(): TotalRevenue {
  const aiTools = calculateAIToolRevenue();
  const outsourcing = calculateOutsourcingRevenue();

  const aiToolsTotal = aiTools.totalMonthlyMargin;
  const outsourcingTotal = outsourcing.totalMonthlyCommission;
  const grandTotal = aiToolsTotal + outsourcingTotal;

  const byCategory = [
    {
      category: 'AIツール',
      amount: aiToolsTotal,
      percentage: grandTotal > 0 ? (aiToolsTotal / grandTotal) * 100 : 0,
    },
    {
      category: '営業代行',
      amount: outsourcingTotal,
      percentage: grandTotal > 0 ? (outsourcingTotal / grandTotal) * 100 : 0,
    },
  ];

  // Monthly trend (last 12 months from MOCK_MONTHLY_REVENUE if available)
  // Otherwise, calculate from orders
  const monthlyMap = new Map<string, { aiTools: number; outsourcing: number }>();

  MOCK_AI_TOOL_ORDERS.forEach(order => {
    if (order.status !== '契約中') return;
    const month = getMonthKey(order.contract_start_date);
    if (!month) return;
    const current = monthlyMap.get(month) || { aiTools: 0, outsourcing: 0 };
    current.aiTools += order.monthly_margin || 0;
    monthlyMap.set(month, current);
  });

  MOCK_SALES_OUTSOURCING_ORDERS.forEach(order => {
    if (order.status !== '契約中') return;
    const month = getMonthKey(order.contract_start_date);
    if (!month) return;
    const current = monthlyMap.get(month) || { aiTools: 0, outsourcing: 0 };
    current.outsourcing += order.monthly_commission || 0;
    monthlyMap.set(month, current);
  });

  const monthlyTrend = Array.from(monthlyMap.entries())
    .map(([month, data]) => ({
      month,
      aiTools: data.aiTools,
      outsourcing: data.outsourcing,
      total: data.aiTools + data.outsourcing,
    }))
    .sort((a, b) => a.month.localeCompare(b.month))
    .slice(-12);

  // Growth rate calculation
  const growthRateMoM = monthlyTrend.length >= 2
    ? ((monthlyTrend[monthlyTrend.length - 1].total - monthlyTrend[monthlyTrend.length - 2].total) / monthlyTrend[monthlyTrend.length - 2].total) * 100
    : 0;

  const growthRateYoY = monthlyTrend.length >= 12
    ? ((monthlyTrend[monthlyTrend.length - 1].total - monthlyTrend[0].total) / monthlyTrend[0].total) * 100
    : 0;

  return {
    aiToolsTotal,
    outsourcingTotal,
    grandTotal,
    byCategory,
    monthlyTrend,
    growthRateMoM,
    growthRateYoY,
  };
}

// ============================================================================
// 5. Funnel Metrics
// ============================================================================

export function calculateFunnelMetrics(): FunnelMetrics {
  const totalLeads = MOCK_DEALS.length;

  // Appointments: deals that got past "ネタ" (i.e., Cヨミ or better, excluding 失注/消滅)
  const activeStatuses: YomiStatus[] = ['受注', 'Aヨミ', 'Bヨミ', 'Cヨミ', 'ネタ'];
  const appointments = MOCK_DEALS.filter(d => activeStatuses.includes(d.yomi_status as YomiStatus)).length;

  // Negotiations: Bヨミ or above
  const negotiationStatuses: YomiStatus[] = ['受注', 'Aヨミ', 'Bヨミ'];
  const negotiations = MOCK_DEALS.filter(d => negotiationStatuses.includes(d.yomi_status as YomiStatus)).length;

  // Won deals: 受注
  const wonDeals = MOCK_DEALS.filter(d => d.yomi_status === '受注').length;

  // Conversion rates
  const leadToAppointment = totalLeads > 0 ? (appointments / totalLeads) * 100 : 0;
  const appointmentToNegotiation = appointments > 0 ? (negotiations / appointments) * 100 : 0;
  const negotiationToWon = negotiations > 0 ? (wonDeals / negotiations) * 100 : 0;
  const leadToWon = totalLeads > 0 ? (wonDeals / totalLeads) * 100 : 0;

  // Average deal cycle time
  const closedDeals = MOCK_DEALS.filter(d => d.closed_date && d.created_at);
  const totalCycleDays = closedDeals.reduce((sum, deal) => {
    return sum + getDaysBetween(deal.created_at, deal.closed_date);
  }, 0);
  const avgDealCycleDays = closedDeals.length > 0 ? totalCycleDays / closedDeals.length : 0;

  return {
    totalLeads,
    appointments,
    negotiations,
    wonDeals,
    conversionRates: {
      leadToAppointment,
      appointmentToNegotiation,
      negotiationToWon,
      leadToWon,
    },
    avgDealCycleDays,
  };
}

// ============================================================================
// 6. Closer Performance
// ============================================================================

export function calculateCloserPerformance(): CloserPerformance[] {
  type DealType = typeof MOCK_DEALS[number];
  const closerMap = new Map<string, {
    deals: DealType[];
    revenue: number;
    wins: number;
  }>();

  MOCK_DEALS.forEach(deal => {
    const closerId = deal.closer_id || 'unknown';
    let current = closerMap.get(closerId);
    if (!current) {
      current = { deals: [] as DealType[], revenue: 0, wins: 0 };
      closerMap.set(closerId, current);
    }
    current.deals.push(deal);
    if (deal.yomi_status === '受注') {
      current.revenue += deal.amount || 0;
      current.wins += 1;
    }
    closerMap.set(closerId, current);
  });

  return Array.from(closerMap.entries()).map(([closerId, data]) => {
    const dealCount = data.deals.length;
    const winCount = data.wins;
    const winRate = dealCount > 0 ? (winCount / dealCount) * 100 : 0;
    const totalRevenue = data.revenue;
    const avgDealSize = winCount > 0 ? totalRevenue / winCount : 0;

    // Pipeline value (weighted sum of all non-won, non-lost deals)
    const pipelineDeals = data.deals.filter(d =>
      !['受注', '失注', '消滅'].includes(d.yomi_status as YomiStatus)
    );
    const pipelineValue = pipelineDeals.reduce((sum, deal) => {
      const rate = getYomiRate(deal.yomi_status as YomiStatus);
      return sum + (deal.amount || 0) * rate;
    }, 0);

    // Monthly trend
    const monthlyRevenueMap = new Map<string, number>();
    data.deals.forEach(deal => {
      if (deal.yomi_status !== '受注') return;
      const month = getMonthKey(deal.closed_date || deal.created_at);
      if (!month) return;
      monthlyRevenueMap.set(month, (monthlyRevenueMap.get(month) || 0) + (deal.amount || 0));
    });

    const monthlyTrend = Array.from(monthlyRevenueMap.entries())
      .map(([month, revenue]) => ({ month, revenue }))
      .sort((a, b) => a.month.localeCompare(b.month))
      .slice(-12);

    return {
      closerId,
      closerName: getUserName(closerId),
      dealCount,
      winCount,
      winRate,
      totalRevenue,
      avgDealSize,
      pipelineValue,
      monthlyTrend,
    };
  }).sort((a, b) => b.totalRevenue - a.totalRevenue);
}

// ============================================================================
// 7. Appointer Performance
// ============================================================================

export function calculateAppointerPerformance(): AppointerPerformance[] {
  type DealType = typeof MOCK_DEALS[number];
  const appointerMap = new Map<string, {
    deals: DealType[];
    revenue: number;
    wins: number;
  }>();

  MOCK_DEALS.forEach(deal => {
    const appointerId = deal.appointer_id || 'unknown';
    let current = appointerMap.get(appointerId);
    if (!current) {
      current = { deals: [] as DealType[], revenue: 0, wins: 0 };
      appointerMap.set(appointerId, current);
    }
    current.deals.push(deal);
    if (deal.yomi_status === '受注') {
      current.revenue += deal.amount || 0;
      current.wins += 1;
    }
    appointerMap.set(appointerId, current);
  });

  return Array.from(appointerMap.entries()).map(([appointerId, data]) => {
    const appointmentsSet = data.deals.length;
    const wins = data.wins;
    const conversionRate = appointmentsSet > 0 ? (wins / appointmentsSet) * 100 : 0;
    const revenueAttributed = data.revenue;

    // Best performing list
    const listCounts = new Map<string, number>();
    data.deals.forEach(deal => {
      const listId = deal.list_id || 'unknown';
      listCounts.set(listId, (listCounts.get(listId) || 0) + 1);
    });
    const bestList = Array.from(listCounts.entries())
      .sort((a, b) => b[1] - a[1])[0];
    const bestPerformingList = bestList ? getListName(bestList[0]) : '不明';

    return {
      appointerId,
      appointerName: getUserName(appointerId),
      appointmentsSet,
      conversionRate,
      revenueAttributed,
      bestPerformingList,
    };
  }).sort((a, b) => b.revenueAttributed - a.revenueAttributed);
}

// ============================================================================
// 8. List Performance
// ============================================================================

export function calculateListPerformance(): ListPerformance[] {
  type DealType = typeof MOCK_DEALS[number];
  const listMap = new Map<string, {
    deals: DealType[];
    revenue: number;
    wins: number;
    closers: Map<string, number>;
  }>();

  MOCK_DEALS.forEach(deal => {
    const listId = deal.list_id || 'unknown';
    let current = listMap.get(listId);
    if (!current) {
      current = {
        deals: [] as DealType[],
        revenue: 0,
        wins: 0,
        closers: new Map(),
      };
      listMap.set(listId, current);
    }
    current.deals.push(deal);
    if (deal.yomi_status === '受注') {
      current.revenue += deal.amount || 0;
      current.wins += 1;
      const closerId = deal.closer_id || 'unknown';
      current.closers.set(closerId, (current.closers.get(closerId) || 0) + 1);
    }
    listMap.set(listId, current);
  });

  return Array.from(listMap.entries()).map(([listId, data]) => {
    const dealCount = data.deals.length;
    const wins = data.wins;
    const winRate = dealCount > 0 ? (wins / dealCount) * 100 : 0;
    const revenueGenerated = data.revenue;

    // Cost per acquisition (not available in mock data)
    const costPerAcquisition = null;

    // Best closer
    const bestCloserEntry = Array.from(data.closers.entries())
      .sort((a, b) => b[1] - a[1])[0];
    const bestCloser = bestCloserEntry ? getUserName(bestCloserEntry[0]) : '不明';

    return {
      listId,
      listName: getListName(listId),
      dealCount,
      winRate,
      revenueGenerated,
      costPerAcquisition,
      bestCloser,
    };
  }).sort((a, b) => b.revenueGenerated - a.revenueGenerated);
}

// ============================================================================
// 9. Monthly Target vs Actual
// ============================================================================

export function calculateMonthlyTargetVsActual(
  targets: { month: string; target: number }[]
): TargetVsActual {
  // Calculate actual revenue by month
  const actualMap = new Map<string, number>();

  MOCK_AI_TOOL_ORDERS.forEach(order => {
    if (order.status !== '契約中') return;
    const month = getMonthKey(order.contract_start_date);
    if (!month) return;
    actualMap.set(month, (actualMap.get(month) || 0) + (order.monthly_margin || 0));
  });

  MOCK_SALES_OUTSOURCING_ORDERS.forEach(order => {
    if (order.status !== '契約中') return;
    const month = getMonthKey(order.contract_start_date);
    if (!month) return;
    actualMap.set(month, (actualMap.get(month) || 0) + (order.monthly_commission || 0));
  });

  // Build monthly comparison
  const monthly: MonthlyTargetVsActual[] = targets.map(({ month, target }) => {
    const actual = actualMap.get(month) || 0;
    const achievementRate = target > 0 ? (actual / target) * 100 : 0;
    return { month, target, actual, achievementRate };
  });

  // Cumulative achievement
  const totalTarget = targets.reduce((sum, t) => sum + t.target, 0);
  const totalActual = monthly.reduce((sum, m) => sum + m.actual, 0);
  const cumulativeAchievement = totalTarget > 0 ? (totalActual / totalTarget) * 100 : 0;

  // Forecasted year-end (simple linear projection from average monthly achievement)
  const avgMonthlyActual = monthly.length > 0 ? totalActual / monthly.length : 0;
  const forecastedYearEnd = avgMonthlyActual * 12;

  return {
    monthly,
    cumulativeAchievement,
    forecastedYearEnd,
  };
}

// ============================================================================
// 10. Overdue Actions
// ============================================================================

export function calculateOverdueActions(): OverdueActions {
  const today = new Date();
  const overdueItems: OverdueAction[] = [];

  MOCK_FOLLOWUPS.forEach(followup => {
    if (!followup.next_action_date) return;
    if (followup.status === '失注' || followup.status === '受注') return;

    const actionDate = new Date(followup.next_action_date);
    if (actionDate >= today) return;

    const daysOverdue = Math.floor((today.getTime() - actionDate.getTime()) / (1000 * 60 * 60 * 24));
    const deal = MOCK_DEALS.find(d => d.id === followup.deal_id);
    if (!deal) return;

    overdueItems.push({
      dealId: deal.id,
      dealName: deal.deal_name || '不明',
      companyName: getCompanyName(deal.company_id),
      daysOverdue,
      nextActionDate: followup.next_action_date,
      nextAction: followup.next_action || '未設定',
    });
  });

  // Sort by days overdue (most overdue first)
  overdueItems.sort((a, b) => b.daysOverdue - a.daysOverdue);

  // Group by urgency
  const low = overdueItems.filter(item => item.daysOverdue >= 1 && item.daysOverdue <= 3);
  const medium = overdueItems.filter(item => item.daysOverdue >= 4 && item.daysOverdue <= 7);
  const high = overdueItems.filter(item => item.daysOverdue >= 8);

  return {
    count: overdueItems.length,
    items: overdueItems,
    byUrgency: { low, medium, high },
  };
}
