/**
 * フォーマット関数群
 * 日付・金額・パーセントの表示整形
 */

/**
 * 日付を YYYY/MM/DD 形式にフォーマット
 * @param date - Date オブジェクト、または ISO 文字列
 * @returns フォーマット済み文字列。無効な日付の場合は '-'
 */
export function formatDate(date: Date | string | null | undefined): string {
  if (!date) return '-';

  const d = typeof date === 'string' ? new Date(date) : date;

  if (isNaN(d.getTime())) return '-';

  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');

  return `${year}/${month}/${day}`;
}

/**
 * 日時を YYYY/MM/DD HH:mm 形式にフォーマット
 * @param date - Date オブジェクト、または ISO 文字列
 * @returns フォーマット済み文字列。無効な日付の場合は '-'
 */
export function formatDateTime(date: Date | string | null | undefined): string {
  if (!date) return '-';

  const d = typeof date === 'string' ? new Date(date) : date;

  if (isNaN(d.getTime())) return '-';

  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  const hours = String(d.getHours()).padStart(2, '0');
  const minutes = String(d.getMinutes()).padStart(2, '0');

  return `${year}/${month}/${day} ${hours}:${minutes}`;
}

/**
 * 金額を日本円形式にフォーマット
 * @param amount - 金額（数値）
 * @returns '¥1,234,567' 形式の文字列。null/undefined の場合は '¥0'
 */
export function formatCurrency(amount: number | null | undefined): string {
  if (amount === null || amount === undefined) return '¥0';

  return `¥${amount.toLocaleString('ja-JP')}`;
}

/**
 * 数値をパーセント形式にフォーマット
 * @param value - 0.0〜1.0 の小数、または 0〜100 のパーセント値
 * @param asDecimal - true の場合 0.0〜1.0 を 0%〜100% に変換（デフォルト: true）
 * @param digits - 小数点以下の桁数（デフォルト: 1）
 * @returns '80.0%' 形式の文字列
 */
export function formatPercent(
  value: number | null | undefined,
  asDecimal: boolean = true,
  digits: number = 1
): string {
  if (value === null || value === undefined) return '0.0%';

  const percentage = asDecimal ? value * 100 : value;

  return `${percentage.toFixed(digits)}%`;
}

/**
 * 年月を YYYY年MM月 形式にフォーマット
 * @param yearMonth - 'YYYY-MM' 形式の文字列
 * @returns 'YYYY年MM月' 形式の文字列
 */
export function formatYearMonth(yearMonth: string | null | undefined): string {
  if (!yearMonth) return '-';

  const parts = yearMonth.split('-');
  if (parts.length < 2) return yearMonth;

  return `${parts[0]}年${parts[1]}月`;
}
