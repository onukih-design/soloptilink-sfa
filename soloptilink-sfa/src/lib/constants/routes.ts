/**
 * ルーティング定数
 * 全画面のパスとラベルを一元管理
 */

export type RouteConfig = {
  readonly path: string;
  readonly label: string;
  readonly icon?: string;
};

/** 認証前のルート */
export const AUTH_ROUTES = {
  LOGIN: { path: '/login', label: 'ログイン' },
} as const;

/** メインルート */
export const ROUTES = {
  DASHBOARD: {
    path: '/dashboard',
    label: 'ダッシュボード',
  },
  DEALS: {
    path: '/deals',
    label: '案件一覧',
  },
  DEAL_DETAIL: {
    path: '/deals/[id]',
    label: '案件詳細',
  },
  DEAL_NEW: {
    path: '/deals/new',
    label: '案件登録',
  },
  ORDERS: {
    path: '/orders',
    label: '受注一覧',
  },
  ORDER_DETAIL: {
    path: '/orders/[id]',
    label: '受注詳細',
  },
  COMPANIES: {
    path: '/companies',
    label: '企業一覧',
  },
  COMPANY_DETAIL: {
    path: '/companies/[id]',
    label: '企業詳細',
  },
  CONTACTS: {
    path: '/contacts',
    label: '担当者一覧',
  },
  REVENUE: {
    path: '/revenue',
    label: '売上管理',
  },
  YOMI_TABLE: {
    path: '/yomi',
    label: 'ヨミ表',
  },
  LISTS: {
    path: '/lists',
    label: 'リスト管理',
  },
  SETTINGS: {
    path: '/settings',
    label: '設定',
  },
} as const;

/** サイドバーに表示するナビゲーション項目 */
export const SIDEBAR_NAV_ITEMS: readonly RouteConfig[] = [
  ROUTES.DASHBOARD,
  ROUTES.DEALS,
  ROUTES.ORDERS,
  ROUTES.COMPANIES,
  ROUTES.CONTACTS,
  ROUTES.REVENUE,
  ROUTES.YOMI_TABLE,
  ROUTES.LISTS,
  ROUTES.SETTINGS,
];

/**
 * 動的ルートのパスを生成
 * 例: buildPath('/deals/[id]', { id: '123' }) => '/deals/123'
 */
export function buildPath(
  template: string,
  params: Record<string, string>
): string {
  let result = template;
  for (const [key, value] of Object.entries(params)) {
    result = result.replace(`[${key}]`, encodeURIComponent(value));
  }
  return result;
}
