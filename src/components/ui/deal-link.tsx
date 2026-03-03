'use client'

import Link from 'next/link'
import { Briefcase } from 'lucide-react'

interface DealLinkProps {
  dealId: string
  dealName: string
  showIcon?: boolean
  className?: string
}

export function DealLink({ dealId, dealName, showIcon = false, className = '' }: DealLinkProps) {
  return (
    <Link
      href={`/deals/${dealId}`}
      className={`text-blue-600 hover:text-blue-800 hover:underline inline-flex items-center gap-1 ${className}`}
      onClick={(e) => e.stopPropagation()}
    >
      {showIcon && <Briefcase className="h-3.5 w-3.5" />}
      <span className="truncate">{dealName}</span>
    </Link>
  )
}
