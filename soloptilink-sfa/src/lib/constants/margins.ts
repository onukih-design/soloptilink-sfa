/**
 * 11商材のマージン率定義
 */

/** 商材キーのリテラル型 */
export type ProductKey =
  | 'ai_teleapo'
  | 'form_sales_ai'
  | 'l_sync'
  | 'sales_list_ai'
  | 'ceo_copy_ai'
  | 'card_follow_ai'
  | 'ai_management_advisor'
  | 'meo'
  | 'recruit_auto_ai'
  | 'hachidori_ai'
  | 'ai_stepup_training';

/** 商材別マージン率（月額） */
export const MARGIN_RATES: Record<ProductKey, number> = {
  ai_teleapo:             0.20,
  form_sales_ai:          0.30,
  l_sync:                 0.30,
  sales_list_ai:          0.50,
  ceo_copy_ai:            0.50,
  card_follow_ai:         0.50,
  ai_management_advisor:  0.50,
  meo:                    0.50,
  recruit_auto_ai:        0.50,
  hachidori_ai:           0.50,
  ai_stepup_training:     0.50,
} as const;

/** 初期費用のマージン率 */
export const INITIAL_FEE_MARGIN_RATE = 0.50 as const;

/** 商材キー → 表示名 */
export const PRODUCT_NAMES: Record<ProductKey, string> = {
  ai_teleapo:             'AIテレアポ',
  form_sales_ai:          'フォーム営業AI',
  l_sync:                 'Lシンク',
  sales_list_ai:          '営業リスト生成AI',
  ceo_copy_ai:            '社長コピーAI',
  card_follow_ai:         '名刺フォローAI',
  ai_management_advisor:  'AI経営参謀',
  meo:                    'MEO',
  recruit_auto_ai:        '採用募集自動化AI',
  hachidori_ai:           'ハチドリAI',
  ai_stepup_training:     'AIステップアップ研修',
} as const;

/** 商材キーの一覧 */
export const PRODUCT_KEYS: readonly ProductKey[] = Object.keys(MARGIN_RATES) as ProductKey[];

/** 商材の表示用リスト */
export const PRODUCT_OPTIONS: readonly { key: ProductKey; name: string; marginRate: number }[] =
  PRODUCT_KEYS.map((key) => ({
    key,
    name: PRODUCT_NAMES[key],
    marginRate: MARGIN_RATES[key],
  }));

/**
 * 商材キーから表示名を取得
 */
export function getProductName(key: ProductKey): string {
  return PRODUCT_NAMES[key];
}

/**
 * 商材キーからマージン率を取得
 */
export function getMarginRate(key: ProductKey): number {
  return MARGIN_RATES[key];
}
