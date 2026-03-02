'use client'

import { useState, useRef, useEffect } from 'react'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import type { YomiStatus } from '@/types/deals'
import { YomiBadge } from './yomi-badge'

type Props = {
  value: YomiStatus
  onSave: (value: YomiStatus) => void
}

export function YomiSelectCell({ value, onSave }: Props) {
  const [isOpen, setIsOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (
        containerRef.current &&
        !containerRef.current.contains(e.target as Node)
      ) {
        setIsOpen(false)
      }
    }
    if (isOpen) {
      document.addEventListener('mousedown', handleClickOutside)
    }
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [isOpen])

  return (
    <div className="relative" ref={containerRef}>
      <div
        className="cursor-pointer hover:opacity-80 transition-opacity"
        onClick={() => setIsOpen(!isOpen)}
      >
        <YomiBadge status={value} />
      </div>
      {isOpen && (
        <div className="absolute z-50 top-full left-0 mt-1 bg-background border rounded-md shadow-lg py-1 min-w-[120px]">
          {YOMI_STATUSES.map((status) => (
            <button
              key={status.name}
              className="w-full text-left px-3 py-1.5 hover:bg-accent transition-colors flex items-center gap-2"
              onClick={() => {
                onSave(status.name)
                setIsOpen(false)
              }}
            >
              <div
                className="w-2.5 h-2.5 rounded-full flex-shrink-0"
                style={{ backgroundColor: status.color }}
              />
              <span className="text-sm">{status.label}</span>
            </button>
          ))}
        </div>
      )}
    </div>
  )
}
