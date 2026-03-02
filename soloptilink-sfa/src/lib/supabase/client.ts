/**
 * ブラウザ用 Supabase クライアント
 * Client Component から使用する
 */

import { createBrowserClient } from '@supabase/ssr';
import type { Database } from '@/types/database';

function getSupabaseUrl(): string {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  if (!url) {
    throw new Error(
      'Missing environment variable: NEXT_PUBLIC_SUPABASE_URL'
    );
  }
  return url;
}

function getSupabaseAnonKey(): string {
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!key) {
    throw new Error(
      'Missing environment variable: NEXT_PUBLIC_SUPABASE_ANON_KEY'
    );
  }
  return key;
}

/**
 * ブラウザ用 Supabase クライアントを作成
 * シングルトンパターンで同一インスタンスを再利用
 */
export function createClient() {
  return createBrowserClient<Database>(
    getSupabaseUrl(),
    getSupabaseAnonKey()
  );
}
