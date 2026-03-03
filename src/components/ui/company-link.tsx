'use client'

import Link from 'next/link'
import { Building2 } from 'lucide-react'

interface CompanyLinkProps {
  companyId: string
  companyName: string
  showIcon?: boolean
  className?: string
}

export function CompanyLink({ companyId, companyName, showIcon = false, className = '' }: CompanyLinkProps) {
  return (
    <Link
      href={`/companies/${companyId}`}
      className={`text-blue-600 hover:text-blue-800 hover:underline inline-flex items-center gap-1 ${className}`}
      onClick={(e) => e.stopPropagation()}
    >
      {showIcon && <Building2 className="h-3.5 w-3.5" />}
      <span className="truncate">{companyName}</span>
    </Link>
  )
}
