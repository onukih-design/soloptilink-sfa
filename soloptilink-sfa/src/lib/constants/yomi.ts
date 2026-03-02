/**
 * ヨミステータス定義
 * 8段階のステータス名・表示色・想定受注率
 */

import type { YomiStatus } from '@/types/deals';

/** ヨミステータスの定義 */
export type YomiStatusConfig = {
  readonly name: YomiStatus;
  readonly color: string;
  readonly rate: number;
  readonly label: string;
};

/** ヨミステータス一覧（順序付き） */
export const YOMI_STATUSES: readonly YomiStatusConfig[] = [
  { name: '受注',   color: '#3B82F6', rate: 1.0,  label: '受注' },
  { name: 'Aヨミ',  color: '#EF4444', rate: 0.8,  label: 'Aヨミ (80%)' },
  { name: 'Bヨミ',  color: '#F97316', rate: 0.5,  label: 'Bヨミ (50%)' },
  { name: 'Cヨミ',  color: '#EAB308', rate: 0.2,  label: 'Cヨミ (20%)' },
  { name: 'ネタ',   color: '#22C55E', rate: 0.1,  label: 'ネタ (10%)' },
  { name: '没ネタ', color: '#9CA3AF', rate: 0.05, label: '没ネタ (5%)' },
  { name: '失注',   color: '#6B7280', rate: 0.0,  label: '失注 (0%)' },
  { name: '消滅',   color: '#D1D5DB', rate: 0.0,  label: '消滅 (0%)' },
] as const;

/** ヨミステータス名 → 色のマップ */
export const YOMI_COLORS: Record<YomiStatus, string> = {
  '受注':   '#3B82F6',
  'Aヨミ':  '#EF4444',
  'Bヨミ':  '#F97316',
  'Cヨミ':  '#EAB308',
  'ネタ':   '#22C55E',
  '没ネタ': '#9CA3AF',
  '失注':   '#6B7280',
  '消滅':   '#D1D5DB',
} as const;

/** ヨミステータス名 → 想定受注率のマップ */
export const YOMI_RATES: Record<YomiStatus, number> = {
  '受注':   1.0,
  'Aヨミ':  0.8,
  'Bヨミ':  0.5,
  'Cヨミ':  0.2,
  'ネタ':   0.1,
  '没ネタ': 0.05,
  '失注':   0.0,
  '消滅':   0.0,
} as const;

/** ヨミステータス名の一覧（配列） */
export const YOMI_STATUS_NAMES: readonly YomiStatus[] = YOMI_STATUSES.map(
  (s) => s.name
);

/**
 * 指定ステータスの表示色を取得
 */
export function getYomiColor(status: YomiStatus): string {
  return YOMI_COLORS[status];
}

/**
 * 指定ステータスの想定受注率を取得
 */
export function getYomiRate(status: YomiStatus): number {
  return YOMI_RATES[status];
}
