/**
 * 受注 (Order) 関連の型定義
 */

import { Tables } from './database';

/** AIツール受注テーブルの行型 */
export type AiToolOrder = Tables<'ai_tool_orders'>;

/** 営業代行受注テーブルの行型 */
export type SalesOutsourcingOrder = Tables<'sales_outsourcing_orders'>;

/** 月次収益テーブルの行型 */
export type MonthlyRevenue = Tables<'monthly_revenue'>;

/** 営業代行リード */
export type SalesOutsourcingLead = Tables<'sales_outsourcing_leads'>;

/** 会社情報付きAIツール受注 */
export type AiToolOrderWithRelations = AiToolOrder & {
  company: Tables<'companies'>;
  closer: Tables<'users'> | null;
  appointer: Tables<'users'> | null;
};

/** 会社情報付き営業代行受注 */
export type SalesOutsourcingOrderWithRelations = SalesOutsourcingOrder & {
  company: Tables<'companies'>;
  closer: Tables<'users'> | null;
  appointer: Tables<'users'> | null;
};

/** JSONB: 商材別月額費用の構造 */
export type MonthlyFees = {
  [productKey: string]: number;
};

/** JSONB: 商材別マージン額の構造 */
export type MarginAmounts = {
  [productKey: string]: number;
};

/** 受注ステータス */
export type OrderStatus =
  | '契約中'
  | '解約予定'
  | '解約済み'
  | '休止中';

/** リードステータス */
export type LeadStatus =
  | '新規'
  | 'アポ獲得'
  | '商談中'
  | '受注'
  | '失注'
  | '対象外';

/** 受注一覧のフィルタ条件 */
export type OrderFilters = {
  product: string | null;
  status: OrderStatus | null;
  closerId: string | null;
  appointerId: string | null;
  month: string | null;
  keyword: string;
};

/** 受注種別 */
export type OrderType = 'ai_tool' | 'sales_outsourcing';

/** 月次収益サマリ */
export type MonthlyRevenueSummary = {
  yearMonth: string;
  totalMonthlyFee: number;
  totalMarginAmount: number;
  activeCount: number;
  byProduct: {
    product: string;
    monthlyFee: number;
    marginAmount: number;
    count: number;
  }[];
};
