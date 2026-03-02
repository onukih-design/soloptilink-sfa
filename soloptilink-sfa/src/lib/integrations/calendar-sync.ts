/**
 * Calendar Sync Pipeline
 *
 * Matches calendar events to companies and creates activity records.
 */

import type { CalendarEvent } from './google-calendar'
import { extractCompanyNameFromEvent } from './google-calendar'

export interface SyncedEvent {
  event: CalendarEvent
  matchedCompanyId: string | null
  matchedCompanyName: string | null
  extractedCompanyName: string | null
  isNewCompany: boolean
  syncStatus: 'matched' | 'new_company' | 'unmatched'
}

export interface SyncResult {
  totalEvents: number
  matchedEvents: number
  newCompanyEvents: number
  unmatchedEvents: number
  syncedEvents: SyncedEvent[]
}

/**
 * Match events against existing companies
 */
export function matchEventsToCompanies(
  events: CalendarEvent[],
  companies: Array<{ id: string; company_name: string }>
): SyncResult {
  const syncedEvents: SyncedEvent[] = []
  let matched = 0
  let newCompany = 0
  let unmatched = 0

  for (const event of events) {
    const extractedName = extractCompanyNameFromEvent(event)

    if (!extractedName) {
      syncedEvents.push({
        event,
        matchedCompanyId: null,
        matchedCompanyName: null,
        extractedCompanyName: null,
        isNewCompany: false,
        syncStatus: 'unmatched',
      })
      unmatched++
      continue
    }

    // Fuzzy match against existing companies
    const matchedCompany = companies.find((c) => {
      const name = c.company_name.toLowerCase()
      const extracted = extractedName.toLowerCase()
      return (
        name.includes(extracted) ||
        extracted.includes(name) ||
        name === extracted
      )
    })

    if (matchedCompany) {
      syncedEvents.push({
        event,
        matchedCompanyId: matchedCompany.id,
        matchedCompanyName: matchedCompany.company_name,
        extractedCompanyName: extractedName,
        isNewCompany: false,
        syncStatus: 'matched',
      })
      matched++
    } else {
      syncedEvents.push({
        event,
        matchedCompanyId: null,
        matchedCompanyName: null,
        extractedCompanyName: extractedName,
        isNewCompany: true,
        syncStatus: 'new_company',
      })
      newCompany++
    }
  }

  return {
    totalEvents: events.length,
    matchedEvents: matched,
    newCompanyEvents: newCompany,
    unmatchedEvents: unmatched,
    syncedEvents,
  }
}

/**
 * Get event datetime as Date
 */
export function getEventDateTime(
  eventTime: { dateTime: string; timeZone?: string } | { date: string }
): Date {
  if ('dateTime' in eventTime) {
    return new Date(eventTime.dateTime)
  }
  return new Date(eventTime.date)
}

/**
 * Format event time for display
 */
export function formatEventTime(
  eventTime: { dateTime: string; timeZone?: string } | { date: string }
): string {
  const date = getEventDateTime(eventTime)
  if ('date' in eventTime) {
    return date.toLocaleDateString('ja-JP')
  }
  return date.toLocaleString('ja-JP', {
    month: 'numeric',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}
