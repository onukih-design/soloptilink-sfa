'use client'

import { useFilterStore } from '@/stores/filter-store'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import { Search, X, Filter } from 'lucide-react'
import { useState, useCallback } from 'react'
// YomiStatus type used implicitly via filter-store

export function DealsFilterBar() {
  const {
    yomiStatus,
    keyword,
    setYomiStatus,
    setKeyword,
    resetFilters,
    hasActiveFilters,
  } = useFilterStore()

  const [searchInput, setSearchInput] = useState(keyword)

  const handleSearch = useCallback(() => {
    setKeyword(searchInput)
  }, [searchInput, setKeyword])

  const handleKeyDown = useCallback(
    (e: React.KeyboardEvent) => {
      if (e.key === 'Enter') {
        handleSearch()
      }
    },
    [handleSearch]
  )

  return (
    <div className="space-y-3">
      {/* 検索とフィルター行 */}
      <div className="flex items-center gap-3">
        <div className="relative flex-1 max-w-sm">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="案件名・案件番号で検索..."
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            onKeyDown={handleKeyDown}
            onBlur={handleSearch}
            className="pl-9"
          />
        </div>
        {hasActiveFilters() && (
          <Button
            variant="ghost"
            size="sm"
            onClick={() => {
              resetFilters()
              setSearchInput('')
            }}
            className="text-muted-foreground"
          >
            <X className="h-4 w-4 mr-1" />
            フィルター解除
          </Button>
        )}
      </div>

      {/* ヨミステータス フィルターチップ */}
      <div className="flex items-center gap-2 flex-wrap">
        <Filter className="h-4 w-4 text-muted-foreground" />
        <Button
          variant={yomiStatus === null ? 'default' : 'outline'}
          size="sm"
          onClick={() => setYomiStatus(null)}
          className="h-7 text-xs"
        >
          すべて
        </Button>
        {YOMI_STATUSES.filter(
          (s) => s.name !== '失注' && s.name !== '消滅'
        ).map((status) => (
          <Button
            key={status.name}
            variant={yomiStatus === status.name ? 'default' : 'outline'}
            size="sm"
            onClick={() =>
              setYomiStatus(
                yomiStatus === status.name ? null : status.name
              )
            }
            className="h-7 text-xs"
            style={
              yomiStatus === status.name
                ? {
                    backgroundColor: status.color,
                    borderColor: status.color,
                    color: 'white',
                  }
                : { borderColor: status.color, color: status.color }
            }
          >
            {status.name}
          </Button>
        ))}
        <Button
          variant={
            yomiStatus === '失注' || yomiStatus === '消滅'
              ? 'default'
              : 'outline'
          }
          size="sm"
          onClick={() =>
            setYomiStatus(yomiStatus === '失注' ? '消滅' : yomiStatus === '消滅' ? null : '失注')
          }
          className="h-7 text-xs text-muted-foreground"
        >
          失注・消滅
        </Button>
      </div>
    </div>
  )
}
