'use client'

import { useState, useRef, useEffect, useCallback } from 'react'
import { Input } from '@/components/ui/input'

type Props = {
  value: string | number | null
  onSave: (value: string) => void
  type?: 'text' | 'number' | 'currency'
  className?: string
}

export function InlineEditCell({
  value,
  onSave,
  type = 'text',
  className = '',
}: Props) {
  const [isEditing, setIsEditing] = useState(false)
  const [editValue, setEditValue] = useState(String(value ?? ''))
  const inputRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    if (isEditing && inputRef.current) {
      inputRef.current.focus()
      inputRef.current.select()
    }
  }, [isEditing])

  const handleSave = useCallback(() => {
    setIsEditing(false)
    const newValue = editValue.trim()
    if (newValue !== String(value ?? '')) {
      onSave(newValue)
    }
  }, [editValue, value, onSave])

  const handleKeyDown = useCallback(
    (e: React.KeyboardEvent) => {
      if (e.key === 'Enter') {
        handleSave()
      } else if (e.key === 'Escape') {
        setEditValue(String(value ?? ''))
        setIsEditing(false)
      }
    },
    [handleSave, value]
  )

  if (isEditing) {
    return (
      <Input
        ref={inputRef}
        value={editValue}
        onChange={(e) => setEditValue(e.target.value)}
        onBlur={handleSave}
        onKeyDown={handleKeyDown}
        type={type === 'currency' || type === 'number' ? 'number' : 'text'}
        className={`h-7 text-sm px-1 ${
          type === 'currency' || type === 'number' ? 'text-right' : ''
        } ${className}`}
      />
    )
  }

  const displayValue =
    type === 'currency'
      ? `¥${Number(value || 0).toLocaleString()}`
      : String(value ?? '-')

  return (
    <div
      className={`cursor-pointer rounded px-1 py-0.5 hover:bg-accent transition-colors text-sm ${
        type === 'currency' || type === 'number' ? 'text-right font-mono' : ''
      } ${className}`}
      onClick={() => {
        setEditValue(String(value ?? ''))
        setIsEditing(true)
      }}
    >
      {displayValue || <span className="text-muted-foreground">-</span>}
    </div>
  )
}
