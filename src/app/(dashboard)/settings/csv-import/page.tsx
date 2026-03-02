'use client'

import { useState, useRef, ChangeEvent } from 'react'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table'
import { IS_DEMO_MODE } from '@/lib/demo-mode'
import { toast } from 'sonner'
import { Upload, FileText, Download, AlertCircle, CheckCircle2, ArrowLeft } from 'lucide-react'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import type { TablesInsert } from '@/types/database'

type ImportType = 'companies' | 'deals' | 'contacts'

type FieldMapping = {
  csvColumn: string
  dbField: string
}

type CSVRow = Record<string, string>

// フィールド定義
const FIELD_DEFINITIONS: Record<ImportType, { label: string; fields: { key: string; label: string; required?: boolean }[] }> = {
  companies: {
    label: '会社情報',
    fields: [
      { key: 'company_name', label: '会社名', required: true },
      { key: 'phone', label: '電話番号' },
      { key: 'email', label: 'メール' },
      { key: 'website', label: 'URL' },
      { key: 'address', label: '住所' },
      { key: 'industry', label: '業種' },
      { key: 'notes', label: '備考' },
    ],
  },
  deals: {
    label: '案件情報',
    fields: [
      { key: 'deal_number', label: '番号' },
      { key: 'company_name', label: '企業名', required: true },
      { key: 'deal_name', label: '案件名', required: true },
      { key: 'yomi_status', label: 'ヨミステータス' },
      { key: 'amount', label: '金額' },
      { key: 'monthly_amount', label: '月額' },
      { key: 'notes', label: '備考' },
      { key: 'expected_close_date', label: '商談日' },
      { key: 'closer_name', label: 'クローザー' },
      { key: 'appointer_name', label: 'アポインター' },
    ],
  },
  contacts: {
    label: '連絡先',
    fields: [
      { key: 'company_name', label: '企業名', required: true },
      { key: 'last_name', label: '姓', required: true },
      { key: 'first_name', label: '名' },
      { key: 'position', label: '役職' },
      { key: 'mobile', label: '携帯' },
      { key: 'email', label: 'メール' },
    ],
  },
}

export default function CSVImportPage() {
  const [importType, setImportType] = useState<ImportType>('companies')
  const [csvData, setCSVData] = useState<CSVRow[]>([])
  const [csvHeaders, setCSVHeaders] = useState<string[]>([])
  const [mappings, setMappings] = useState<FieldMapping[]>([])
  const [isProcessing, setIsProcessing] = useState(false)
  const fileInputRef = useRef<HTMLInputElement>(null)

  // CSVパース関数（UTF-8 BOM、Shift-JIS対応）
  const parseCSV = (text: string): { headers: string[]; rows: CSVRow[] } => {
    const lines = text.split(/\r?\n/).filter(line => line.trim())
    if (lines.length === 0) throw new Error('CSVファイルが空です')

    const headers = parseCSVLine(lines[0])
    const rows: CSVRow[] = []

    for (let i = 1; i < lines.length; i++) {
      const values = parseCSVLine(lines[i])
      if (values.length === 0) continue

      const row: CSVRow = {}
      headers.forEach((header, index) => {
        row[header] = values[index] || ''
      })
      rows.push(row)
    }

    return { headers, rows }
  }

  // CSV行のパース（カンマ、タブ、クォート対応）
  const parseCSVLine = (line: string): string[] => {
    const result: string[] = []
    let current = ''
    let inQuotes = false

    // タブ区切りの可能性をチェック
    const delimiter = line.includes('\t') ? '\t' : ','

    for (let i = 0; i < line.length; i++) {
      const char = line[i]
      const nextChar = line[i + 1]

      if (char === '"') {
        if (inQuotes && nextChar === '"') {
          current += '"'
          i++ // skip next quote
        } else {
          inQuotes = !inQuotes
        }
      } else if (char === delimiter && !inQuotes) {
        result.push(current.trim())
        current = ''
      } else {
        current += char
      }
    }
    result.push(current.trim())
    return result
  }

  // ファイル処理の共通ロジック
  const processFile = async (file: File) => {

    try {
      // UTF-8で試す
      let text = await file.text()

      // BOM除去
      if (text.charCodeAt(0) === 0xFEFF) {
        text = text.slice(1)
      }

      // Shift-JISの可能性をチェック（文字化けしている場合）
      if (text.includes('�')) {
        const arrayBuffer = await file.arrayBuffer()
        const decoder = new TextDecoder('shift-jis')
        text = decoder.decode(arrayBuffer)
      }

      const { headers, rows } = parseCSV(text)

      if (rows.length === 0) {
        toast.error('有効なデータが見つかりませんでした')
        return
      }

      setCSVHeaders(headers)
      setCSVData(rows)

      // 自動マッピング
      const autoMappings: FieldMapping[] = FIELD_DEFINITIONS[importType].fields.map(field => {
        const matchedHeader = headers.find(h =>
          h.toLowerCase().includes(field.label.toLowerCase()) ||
          h.toLowerCase().includes(field.key.toLowerCase())
        )
        return {
          csvColumn: matchedHeader || '',
          dbField: field.key,
        }
      })
      setMappings(autoMappings)

      toast.success(`${rows.length}件のデータを読み込みました`)
    } catch (error) {
      console.error('CSV parse error:', error)
      toast.error('CSVファイルの読み込みに失敗しました')
    }
  }

  // ファイルアップロード処理
  const handleFileUpload = async (e: ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return
    await processFile(file)
  }

  // マッピング変更
  const handleMappingChange = (dbField: string, csvColumn: string) => {
    setMappings(prev =>
      prev.map(m => m.dbField === dbField ? { ...m, csvColumn } : m)
    )
  }

  // インポート実行
  const handleImport = async () => {
    if (csvData.length === 0) {
      toast.error('CSVファイルを読み込んでください')
      return
    }

    // 必須フィールドのチェック
    const requiredFields = FIELD_DEFINITIONS[importType].fields
      .filter(f => f.required)
      .map(f => f.key)

    const missingFields = requiredFields.filter(field => {
      const mapping = mappings.find(m => m.dbField === field)
      return !mapping?.csvColumn
    })

    if (missingFields.length > 0) {
      const fieldLabels = missingFields.map(field =>
        FIELD_DEFINITIONS[importType].fields.find(f => f.key === field)?.label
      ).join(', ')
      toast.error(`必須フィールドのマッピングが不足しています: ${fieldLabels}`)
      return
    }

    setIsProcessing(true)

    try {
      if (IS_DEMO_MODE) {
        // デモモード: シミュレーション
        await new Promise(resolve => setTimeout(resolve, 1500))
        toast.success(`${csvData.length}件のデータをインポートしました（デモモード）`, {
          description: '実際のデータベースには保存されていません',
        })
      } else {
        // 本番モード: Supabaseへ保存
        await importToSupabase()
        toast.success(`${csvData.length}件のデータをインポートしました`)
      }

      // リセット
      setCSVData([])
      setCSVHeaders([])
      setMappings([])
      if (fileInputRef.current) {
        fileInputRef.current.value = ''
      }
    } catch (error) {
      console.error('Import error:', error)
      toast.error('インポートに失敗しました')
    } finally {
      setIsProcessing(false)
    }
  }

  // Supabaseへのインポート
  const importToSupabase = async () => {
    const supabase = createClient()

    if (importType === 'companies') {
      const companies: Partial<TablesInsert<'companies'>>[] = csvData.map(row => {
        const data: Partial<TablesInsert<'companies'>> = {}
        mappings.forEach(m => {
          if (m.csvColumn && row[m.csvColumn]) {
            const value = row[m.csvColumn]
            if (m.dbField === 'company_name') {
              data.company_name = value
            } else if (m.dbField === 'phone') {
              data.phone = value
            } else if (m.dbField === 'email') {
              data.email = value
            } else if (m.dbField === 'website') {
              data.website = value
            } else if (m.dbField === 'address') {
              data.address = value
            } else if (m.dbField === 'industry') {
              data.industry = value
            } else if (m.dbField === 'notes') {
              data.notes = value
            }
          }
        })
        return data
      })

      const { error } = await supabase.from('companies').insert(companies.filter(c => c.company_name) as TablesInsert<'companies'>[])
      if (error) throw error
    } else if (importType === 'contacts') {
      // 企業名からcompany_idを解決
      const companyNameSet = new Set<string>()
      csvData.forEach(row => {
        const mapping = mappings.find(m => m.dbField === 'company_name')
        const name = mapping?.csvColumn ? row[mapping.csvColumn] : ''
        if (name) companyNameSet.add(name)
      })
      const companyNames = Array.from(companyNameSet)

      const { data: companies } = await supabase
        .from('companies')
        .select('id, company_name')
        .in('company_name', companyNames)

      const companyMap = new Map(companies?.map(c => [c.company_name, c.id]) || [])

      const contacts: Partial<TablesInsert<'contacts'>>[] = csvData.map(row => {
        const data: Partial<TablesInsert<'contacts'>> = {}
        let companyName = ''

        mappings.forEach(m => {
          if (m.csvColumn && row[m.csvColumn]) {
            const value = row[m.csvColumn]
            if (m.dbField === 'company_name') {
              companyName = value
            } else if (m.dbField === 'last_name') {
              data.last_name = value
            } else if (m.dbField === 'first_name') {
              data.first_name = value
            } else if (m.dbField === 'position') {
              data.position = value
            } else if (m.dbField === 'mobile') {
              data.mobile = value
            } else if (m.dbField === 'email') {
              data.email = value
            }
          }
        })

        const companyId = companyMap.get(companyName)
        if (!companyId) {
          throw new Error(`企業が見つかりません: ${companyName}`)
        }
        data.company_id = companyId
        return data
      })

      const validContacts = contacts.filter(c => c.company_id && c.last_name) as TablesInsert<'contacts'>[]
      const { error } = await supabase.from('contacts').insert(validContacts)
      if (error) throw error
    } else if (importType === 'deals') {
      // 企業名からcompany_idを解決
      const companyNameSet = new Set<string>()
      csvData.forEach(row => {
        const mapping = mappings.find(m => m.dbField === 'company_name')
        const name = mapping?.csvColumn ? row[mapping.csvColumn] : ''
        if (name) companyNameSet.add(name)
      })
      const companyNames = Array.from(companyNameSet)

      const { data: companies } = await supabase
        .from('companies')
        .select('id, company_name')
        .in('company_name', companyNames)

      const companyMap = new Map(companies?.map(c => [c.company_name, c.id]) || [])

      const deals: Partial<TablesInsert<'deals'>>[] = csvData.map(row => {
        const data: Partial<TablesInsert<'deals'>> = { yomi_status: 'A' } // デフォルト値
        let companyName = ''

        mappings.forEach(m => {
          if (m.csvColumn && row[m.csvColumn]) {
            const value = row[m.csvColumn]
            if (m.dbField === 'company_name') {
              companyName = value
            } else if (m.dbField === 'deal_name') {
              data.deal_name = value
            } else if (m.dbField === 'yomi_status') {
              data.yomi_status = value
            } else if (m.dbField === 'amount') {
              const num = parseFloat(value.replace(/[^\d.-]/g, ''))
              if (!isNaN(num)) data.amount = num
            } else if (m.dbField === 'monthly_amount') {
              const num = parseFloat(value.replace(/[^\d.-]/g, ''))
              if (!isNaN(num)) data.monthly_amount = num
            } else if (m.dbField === 'deal_number') {
              const num = parseInt(value.replace(/[^\d-]/g, ''), 10)
              if (!isNaN(num)) data.deal_number = num
            } else if (m.dbField === 'notes') {
              data.notes = value
            } else if (m.dbField === 'expected_close_date') {
              data.expected_close_date = value
            }
          }
        })

        const companyId = companyMap.get(companyName)
        if (!companyId) {
          throw new Error(`企業が見つかりません: ${companyName}`)
        }
        data.company_id = companyId
        return data
      })

      const validDeals = deals.filter(d => d.company_id && d.deal_name) as TablesInsert<'deals'>[]
      const { error } = await supabase.from('deals').insert(validDeals)
      if (error) throw error
    }
  }

  // ドラッグ&ドロップ
  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault()
    e.stopPropagation()
  }

  const handleDrop = async (e: React.DragEvent) => {
    e.preventDefault()
    e.stopPropagation()

    const files = e.dataTransfer.files
    if (files.length > 0 && files[0].name.endsWith('.csv')) {
      await processFile(files[0])
    } else {
      toast.error('CSVファイルをドロップしてください')
    }
  }

  const currentFields = FIELD_DEFINITIONS[importType].fields

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/settings">
          <Button variant="ghost" size="sm">
            <ArrowLeft className="h-4 w-4 mr-1" />
            設定に戻る
          </Button>
        </Link>
        <div>
          <h1 className="text-2xl font-bold tracking-tight">CSVインポート</h1>
          <p className="text-muted-foreground text-sm">CSVファイルから一括データインポート</p>
        </div>
      </div>

      {IS_DEMO_MODE && (
        <Card className="border-yellow-200 bg-yellow-50">
          <CardContent className="pt-6">
            <div className="flex items-start gap-3">
              <AlertCircle className="h-5 w-5 text-yellow-600 mt-0.5" />
              <div>
                <p className="text-sm font-medium text-yellow-900">デモモード</p>
                <p className="text-sm text-yellow-700">
                  インポート処理はシミュレーションのみで、実際のデータベースには保存されません。
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      )}

      {/* インポートタイプ選択 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base">インポートタイプ</CardTitle>
          <CardDescription>インポートするデータの種類を選択してください</CardDescription>
        </CardHeader>
        <CardContent>
          <Select value={importType} onValueChange={(v) => setImportType(v as ImportType)}>
            <SelectTrigger className="w-full md:w-64">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {Object.entries(FIELD_DEFINITIONS).map(([key, def]) => (
                <SelectItem key={key} value={key}>
                  {def.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </CardContent>
      </Card>

      {/* ファイルアップロード */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Upload className="h-4 w-4" />
            ファイルアップロード
          </CardTitle>
          <CardDescription>CSVファイルを選択またはドラッグ&ドロップ</CardDescription>
        </CardHeader>
        <CardContent>
          <div
            className="border-2 border-dashed rounded-lg p-8 text-center cursor-pointer hover:border-primary hover:bg-accent/50 transition-colors"
            onClick={() => fileInputRef.current?.click()}
            onDragOver={handleDragOver}
            onDrop={handleDrop}
          >
            <FileText className="h-12 w-12 mx-auto mb-4 text-muted-foreground" />
            <p className="text-sm font-medium mb-1">CSVファイルを選択</p>
            <p className="text-xs text-muted-foreground mb-4">
              またはここにドラッグ&ドロップ
            </p>
            <Button variant="outline" size="sm" type="button">
              ファイルを選択
            </Button>
            <input
              ref={fileInputRef}
              type="file"
              accept=".csv"
              onChange={handleFileUpload}
              className="hidden"
            />
          </div>
          {csvData.length > 0 && (
            <div className="mt-4 flex items-center gap-2">
              <CheckCircle2 className="h-4 w-4 text-green-600" />
              <span className="text-sm font-medium">
                {csvData.length}件のデータを読み込みました
              </span>
            </div>
          )}
        </CardContent>
      </Card>

      {/* カラムマッピング */}
      {csvHeaders.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">カラムマッピング</CardTitle>
            <CardDescription>
              CSVのカラムとデータベースフィールドの対応を設定してください
              <span className="text-red-500 ml-2">*は必須項目</span>
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {currentFields.map(field => {
                const mapping = mappings.find(m => m.dbField === field.key)
                return (
                  <div key={field.key} className="flex items-center gap-4">
                    <div className="w-48 flex items-center gap-1">
                      <span className="text-sm font-medium">{field.label}</span>
                      {field.required && <span className="text-red-500">*</span>}
                    </div>
                    <span className="text-muted-foreground">→</span>
                    <Select
                      value={mapping?.csvColumn || ''}
                      onValueChange={(v) => handleMappingChange(field.key, v)}
                    >
                      <SelectTrigger className="flex-1 max-w-sm">
                        <SelectValue placeholder="CSVのカラムを選択..." />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="">（マッピングなし）</SelectItem>
                        {csvHeaders.map(header => (
                          <SelectItem key={header} value={header}>
                            {header}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>
                )
              })}
            </div>
          </CardContent>
        </Card>
      )}

      {/* プレビュー */}
      {csvData.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">データプレビュー（最大10件）</CardTitle>
            <CardDescription>インポートされるデータの確認</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="overflow-x-auto">
              <Table>
                <TableHeader>
                  <TableRow>
                    {csvHeaders.map(header => (
                      <TableHead key={header} className="whitespace-nowrap">
                        {header}
                      </TableHead>
                    ))}
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {csvData.slice(0, 10).map((row, i) => (
                    <TableRow key={i}>
                      {csvHeaders.map(header => (
                        <TableCell key={header} className="whitespace-nowrap">
                          {row[header]}
                        </TableCell>
                      ))}
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </div>
            {csvData.length > 10 && (
              <p className="text-xs text-muted-foreground mt-4 text-center">
                他 {csvData.length - 10}件のデータ
              </p>
            )}
          </CardContent>
        </Card>
      )}

      {/* インポート実行 */}
      {csvData.length > 0 && (
        <Card>
          <CardContent className="pt-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium">
                  {csvData.length}件のデータをインポートします
                </p>
                <p className="text-xs text-muted-foreground mt-1">
                  インポートタイプ: {FIELD_DEFINITIONS[importType].label}
                </p>
              </div>
              <Button
                onClick={handleImport}
                disabled={isProcessing}
                size="lg"
              >
                {isProcessing ? (
                  <>
                    <Download className="h-4 w-4 mr-2 animate-spin" />
                    処理中...
                  </>
                ) : (
                  <>
                    <Download className="h-4 w-4 mr-2" />
                    インポート実行
                  </>
                )}
              </Button>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}
