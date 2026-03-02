'use client'

import { useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { PRODUCT_OPTIONS } from '@/lib/constants/margins'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import { formatPercent } from '@/lib/utils/format'
import { Palette, Package, Info, List, Plus, Pencil, Trash2, Link2 } from 'lucide-react'
import { useListAll, useDeleteList } from '@/hooks/use-lists'
import { ListFormDialog } from '@/components/settings/list-form-dialog'
import type { Tables } from '@/types/database'
import Link from 'next/link'

export default function SettingsPage() {
  const { data: lists, isLoading: listsLoading } = useListAll()
  const deleteList = useDeleteList()
  const [showListForm, setShowListForm] = useState(false)
  const [editingList, setEditingList] = useState<Tables<'lists'> | null>(null)

  const handleDeleteList = async (id: string) => {
    if (!window.confirm('このリストを削除しますか？')) return
    try {
      await deleteList.mutateAsync(id)
    } catch (error) {
      console.error('Delete list error:', error)
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">マスタ管理</h1>
        <p className="text-muted-foreground text-sm">システムの設定とマスタデータを確認します</p>
      </div>

      {/* ヨミステータスマスタ */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Palette className="h-4 w-4" />
            ヨミステータス設定
          </CardTitle>
          <CardDescription>案件の進捗管理に使用するヨミステータスの定義</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid gap-3 md:grid-cols-2 lg:grid-cols-4">
            {YOMI_STATUSES.map((status) => (
              <div
                key={status.name}
                className="flex items-center gap-3 rounded-lg border p-3"
              >
                <div
                  className="w-4 h-4 rounded-full shrink-0"
                  style={{ backgroundColor: status.color }}
                />
                <div>
                  <p className="text-sm font-medium">{status.name}</p>
                  <p className="text-xs text-muted-foreground">
                    確率: {formatPercent(status.rate, true)}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* リスト管理 */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-base flex items-center gap-2">
                <List className="h-4 w-4" />
                営業リスト管理
              </CardTitle>
              <CardDescription>案件に紐づくリストの管理</CardDescription>
            </div>
            <Button size="sm" onClick={() => { setEditingList(null); setShowListForm(true) }}>
              <Plus className="h-4 w-4 mr-1" />
              追加
            </Button>
          </div>
        </CardHeader>
        <CardContent>
          {listsLoading ? (
            <div className="space-y-2">
              {Array.from({ length: 3 }).map((_, i) => (
                <div key={i} className="h-10 bg-muted animate-pulse rounded" />
              ))}
            </div>
          ) : !lists || lists.length === 0 ? (
            <p className="text-sm text-muted-foreground text-center py-4">リストが登録されていません</p>
          ) : (
            <div className="space-y-2">
              {lists.map((list) => (
                <div key={list.id} className="flex items-center justify-between rounded-lg border p-3">
                  <div>
                    <p className="text-sm font-medium">{list.list_name}</p>
                    {list.source && <p className="text-xs text-muted-foreground">{list.source}</p>}
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge variant={list.is_active ? 'default' : 'secondary'} className="text-xs">
                      {list.is_active ? '有効' : '無効'}
                    </Badge>
                    <Button variant="ghost" size="sm" onClick={() => { setEditingList(list); setShowListForm(true) }}>
                      <Pencil className="h-3.5 w-3.5" />
                    </Button>
                    <Button variant="ghost" size="sm" onClick={() => handleDeleteList(list.id)}>
                      <Trash2 className="h-3.5 w-3.5 text-red-500" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>

      {/* 商品・粗利率マスタ */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Package className="h-4 w-4" />
            商品・粗利率設定
          </CardTitle>
          <CardDescription>取り扱い商品と粗利率の定義</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            {PRODUCT_OPTIONS.map((product) => (
              <div
                key={product.key}
                className="flex items-center justify-between rounded-lg border p-3"
              >
                <div>
                  <p className="text-sm font-medium">{product.name}</p>
                  <p className="text-xs text-muted-foreground font-mono">{product.key}</p>
                </div>
                <Badge variant="outline" className="text-xs">
                  粗利率: {formatPercent(product.marginRate, true)}
                </Badge>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* 外部連携 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Link2 className="h-4 w-4" />
            外部連携
          </CardTitle>
          <CardDescription>Googleカレンダー・AI連携の設定</CardDescription>
        </CardHeader>
        <CardContent>
          <Link href="/settings/integrations">
            <Button variant="outline">
              連携設定を開く
            </Button>
          </Link>
        </CardContent>
      </Card>

      {/* システム情報 */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Info className="h-4 w-4" />
            システム情報
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-2">
            <InfoRow label="システム名" value="SoloptiLink SFA" />
            <InfoRow label="バージョン" value="1.0.0" />
            <InfoRow label="フレームワーク" value="Next.js 14" />
            <InfoRow label="データベース" value="Supabase (PostgreSQL)" />
            <InfoRow label="環境" value={process.env.NEXT_PUBLIC_APP_ENV || 'development'} />
          </div>
        </CardContent>
      </Card>

      <ListFormDialog
        list={editingList}
        open={showListForm}
        onOpenChange={setShowListForm}
      />
    </div>
  )
}

function InfoRow({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex items-center justify-between py-1">
      <span className="text-sm text-muted-foreground">{label}</span>
      <span className="text-sm font-medium">{value}</span>
    </div>
  )
}
