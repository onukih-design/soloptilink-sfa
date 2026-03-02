/**
 * デモモード判定ユーティリティ
 *
 * 環境変数 NEXT_PUBLIC_SUPABASE_URL がプレースホルダーの場合はデモモードとする
 */

export const IS_DEMO_MODE =
  !process.env.NEXT_PUBLIC_SUPABASE_URL ||
  process.env.NEXT_PUBLIC_SUPABASE_URL.includes('xxxxx')
