/**
 * 案件 (Deal) 関連の型定義
 */

import { Tables } from './database';

/** 案件テーブルの行型 */
export type Deal = Tables<'deals'>;

/** 会社情報を含む案件 */
export type DealWithRelations = Deal & {
  company: Tables<'companies'>;
  contact: Tables<'contacts'> | null;
  closer: Tables<'users'> | null;
  appointer: Tables<'users'> | null;
  list: Tables<'lists'> | null;
  followups: DealFollowup[];
};

/** フォローアップ */
export type DealFollowup = Tables<'deal_followups'>;

/** フォローアップとユーザー情報 */
export type DealFollowupWithUser = DealFollowup & {
  created_by_user: Tables<'users'> | null;
};

/** ヨミステータスのリテラル型 */
export type YomiStatus =
  | '受注'
  | 'Aヨミ'
  | 'Bヨミ'
  | 'Cヨミ'
  | 'ネタ'
  | '没ネタ'
  | '失注'
  | '消滅';

/** フォローアップ種別のリテラル型 */
export type FollowupType =
  | '電話'
  | 'メール'
  | '訪問'
  | 'Web会議'
  | 'その他';

/** 案件一覧のフィルタ条件 */
export type DealFilters = {
  yomiStatus: YomiStatus | null;
  closerId: string | null;
  appointerId: string | null;
  listId: string | null;
  month: string | null;
  keyword: string;
};

/** 案件一覧のソート条件 */
export type DealSortKey =
  | 'deal_number'
  | 'company_name'
  | 'yomi_status'
  | 'amount'
  | 'expected_close_date'
  | 'updated_at';

export type DealSortOrder = 'asc' | 'desc';

export type DealSort = {
  key: DealSortKey;
  order: DealSortOrder;
};
