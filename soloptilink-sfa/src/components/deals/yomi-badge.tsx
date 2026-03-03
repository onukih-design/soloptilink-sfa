'use client'

import { Badge } from '@/components/ui/badge'
import { YOMI_STATUSES } from '@/lib/constants/yomi'
import type { YomiStatus } from '@/types/deals'

type Props = {
  status: YomiStatus | string
  size?: 'sm' | 'md'
}

export function YomiBadge({ status, size = 'md' }: Props) {
  const config = YOMI_STATUSES.find((y) => y.name === status)
  const color = config?.color || '#9CA3AF'

  return (
    <Badge
      variant="outline"
      className={size === 'sm' ? 'text-[10px] px-1.5 py-0' : 'text-xs'}
      style={{
        borderColor: color,
        color: color,
        backgroundColor: `${color}15`,
      }}
    >
      {status}
    </Badge>
  )
}
