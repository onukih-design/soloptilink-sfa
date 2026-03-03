/**
 * ブラウザ用 Supabase クライアント
 * Client Component から使用する
 */

import { createBrowserClient } from '@supabase/ssr';
import type { Database } from '@/types/database';
function getSupabaseUrl(): string {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  if (!url || url.includes('xxxxx')) {
    return 'https://placeholder.supabase.co';
  }
  return url;
}

function getSupabaseAnonKey(): string {
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!key) {
    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.placeholder';
  }
  return key;
}

/**
 * ブラウザ用 Supabase クライアントを作成
 * デモモード時はダミー接続先を使用（実際には使われない）
 */
export function createClient() {
  return createBrowserClient<Database>(
    getSupabaseUrl(),
    getSupabaseAnonKey()
  );
}
