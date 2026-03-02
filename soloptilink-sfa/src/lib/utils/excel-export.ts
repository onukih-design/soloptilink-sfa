import * as XLSX from 'xlsx'

type ExportColumn = {
  header: string
  key: string
  width?: number
  formatter?: (value: unknown) => string | number
}

export function exportToExcel(
  data: Record<string, unknown>[],
  columns: ExportColumn[],
  fileName: string,
  sheetName: string = 'Sheet1'
) {
  // Create header row
  const headers = columns.map((col) => col.header)

  // Create data rows
  const rows = data.map((row) =>
    columns.map((col) => {
      const value = row[col.key]
      if (col.formatter) {
        return col.formatter(value)
      }
      return value ?? ''
    })
  )

  // Create worksheet
  const ws = XLSX.utils.aoa_to_sheet([headers, ...rows])

  // Set column widths
  ws['!cols'] = columns.map((col) => ({
    wch: col.width || 15,
  }))

  // Create workbook
  const wb = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(wb, ws, sheetName)

  // Download
  XLSX.writeFile(wb, `${fileName}.xlsx`)
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function exportDealsToExcel(deals: Record<string, any>[]) {
  const columns: ExportColumn[] = [
    { header: '案件番号', key: 'deal_number', width: 12 },
    { header: '企業名', key: 'company_name', width: 25 },
    { header: '案件名', key: 'deal_name', width: 30 },
    { header: '商品', key: 'product_name', width: 20 },
    { header: 'ヨミステータス', key: 'yomi_status', width: 14 },
    { header: '総額', key: 'amount', width: 14, formatter: (v) => Number(v) || 0 },
    { header: '月額', key: 'monthly_amount', width: 14, formatter: (v) => Number(v) || 0 },
    { header: '初期費用', key: 'initial_amount', width: 14, formatter: (v) => Number(v) || 0 },
    { header: 'クローザー', key: 'closer_name', width: 12 },
    { header: 'アポインター', key: 'appointer_name', width: 12 },
    { header: 'リスト', key: 'list_name', width: 15 },
    { header: '受注予定日', key: 'expected_close_date', width: 12 },
    { header: '受注日', key: 'closed_date', width: 12 },
    { header: '更新日', key: 'updated_at', width: 12 },
  ]

  const data = deals.map((d) => ({
    deal_number: d.deal_number || '',
    company_name: d.company?.company_name || '',
    deal_name: d.deal_name || '',
    product_name: d.product || '',
    yomi_status: d.yomi_status || '',
    amount: d.amount || 0,
    monthly_amount: d.monthly_amount || 0,
    initial_amount: d.initial_amount || 0,
    closer_name: d.closer?.display_name || '',
    appointer_name: d.appointer?.display_name || '',
    list_name: d.list?.list_name || '',
    expected_close_date: d.expected_close_date || '',
    closed_date: d.closed_date || '',
    updated_at: d.updated_at ? new Date(d.updated_at).toLocaleDateString('ja-JP') : '',
  }))

  const dateStr = new Date().toISOString().split('T')[0].replace(/-/g, '')
  exportToExcel(data, columns, `案件一覧_${dateStr}`, '案件一覧')
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function exportOrdersToExcel(orders: Record<string, any>[], type: 'ai' | 'outsourcing') {
  const aiColumns: ExportColumn[] = [
    { header: '企業名', key: 'company_name', width: 25 },
    { header: '商品', key: 'product_name', width: 20 },
    { header: 'プラン', key: 'plan', width: 15 },
    { header: '月額', key: 'monthly_fee', width: 14 },
    { header: '月額粗利', key: 'monthly_margin', width: 14 },
    { header: '粗利率', key: 'margin_rate', width: 10 },
    { header: '初期費用', key: 'initial_fee', width: 14 },
    { header: '初期粗利', key: 'initial_margin', width: 14 },
    { header: '契約開始日', key: 'contract_start_date', width: 12 },
    { header: '契約終了日', key: 'contract_end_date', width: 12 },
    { header: 'ステータス', key: 'status', width: 12 },
    { header: 'クローザー', key: 'closer_name', width: 12 },
  ]

  const outColumns: ExportColumn[] = [
    { header: '企業名', key: 'company_name', width: 25 },
    { header: 'サービス種別', key: 'service_type', width: 20 },
    { header: '月額', key: 'monthly_fee', width: 14 },
    { header: '月額手数料', key: 'monthly_commission', width: 14 },
    { header: '手数料率', key: 'commission_rate', width: 10 },
    { header: '初期費用', key: 'initial_fee', width: 14 },
    { header: '契約開始日', key: 'contract_start_date', width: 12 },
    { header: 'ステータス', key: 'status', width: 12 },
    { header: 'クローザー', key: 'closer_name', width: 12 },
  ]

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const data = orders.map((o: Record<string, any>) => ({
    company_name: o.company?.company_name || '',
    product_name: o.product || '',
    plan: o.plan || '',
    monthly_fee: o.monthly_fee || 0,
    monthly_margin: o.monthly_margin || 0,
    margin_rate: o.margin_rate ? `${Math.floor(o.margin_rate * 100)}%` : '',
    initial_fee: o.initial_fee || 0,
    initial_margin: o.initial_margin || 0,
    contract_start_date: o.contract_start_date || '',
    contract_end_date: o.contract_end_date || '',
    status: o.status || '契約中',
    closer_name: o.closer?.display_name || '',
    service_type: o.service_type || '',
    monthly_commission: o.monthly_commission || 0,
    commission_rate: o.commission_rate ? `${Math.floor(o.commission_rate * 100)}%` : '',
  }))

  const dateStr = new Date().toISOString().split('T')[0].replace(/-/g, '')
  const isAi = type === 'ai'
  exportToExcel(
    data,
    isAi ? aiColumns : outColumns,
    isAi ? `AIツール受注_${dateStr}` : `営業代行受注_${dateStr}`,
    isAi ? 'AIツール受注' : '営業代行受注'
  )
}
