/**
 * Google Calendar API Client
 *
 * Provides methods to interact with Google Calendar API.
 */

export interface CalendarEvent {
  id: string
  summary: string
  description: string | null
  start: { dateTime: string; timeZone?: string } | { date: string }
  end: { dateTime: string; timeZone?: string } | { date: string }
  attendees?: Array<{
    email: string
    displayName?: string
    responseStatus?: string
  }>
  location?: string
  htmlLink?: string
  hangoutLink?: string
  conferenceData?: {
    entryPoints?: Array<{ uri: string; entryPointType: string }>
  }
  organizer?: { email: string; displayName?: string }
  created?: string
  updated?: string
}

export interface CalendarListResponse {
  items: CalendarEvent[]
  nextPageToken?: string
}

const CALENDAR_API_BASE = 'https://www.googleapis.com/calendar/v3'

/**
 * Fetch events from Google Calendar
 */
export async function fetchCalendarEvents(
  accessToken: string,
  options: {
    calendarId?: string
    timeMin?: string
    timeMax?: string
    maxResults?: number
    pageToken?: string
  } = {}
): Promise<CalendarListResponse> {
  const {
    calendarId = 'primary',
    timeMin = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString(),
    timeMax = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
    maxResults = 50,
    pageToken,
  } = options

  const params = new URLSearchParams({
    timeMin,
    timeMax,
    maxResults: maxResults.toString(),
    singleEvents: 'true',
    orderBy: 'startTime',
  })

  if (pageToken) {
    params.set('pageToken', pageToken)
  }

  const response = await fetch(
    `${CALENDAR_API_BASE}/calendars/${encodeURIComponent(calendarId)}/events?${params}`,
    {
      headers: {
        Authorization: `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
      },
    }
  )

  if (!response.ok) {
    const errorText = await response.text()
    throw new Error(`Calendar API error: ${response.status} ${errorText}`)
  }

  return response.json()
}

/**
 * Create a new calendar event
 */
export async function createCalendarEvent(
  accessToken: string,
  event: {
    summary: string
    description?: string
    start: { dateTime: string; timeZone?: string }
    end: { dateTime: string; timeZone?: string }
    attendees?: Array<{ email: string }>
    location?: string
    conferenceDataVersion?: number
  },
  calendarId: string = 'primary'
): Promise<CalendarEvent> {
  const body: Record<string, unknown> = {
    summary: event.summary,
    description: event.description || '',
    start: event.start,
    end: event.end,
  }

  if (event.attendees) body.attendees = event.attendees
  if (event.location) body.location = event.location

  const params = new URLSearchParams()
  if (event.conferenceDataVersion) {
    params.set('conferenceDataVersion', event.conferenceDataVersion.toString())
  }

  const url = `${CALENDAR_API_BASE}/calendars/${encodeURIComponent(calendarId)}/events${params.toString() ? '?' + params : ''}`

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body),
  })

  if (!response.ok) {
    const errorText = await response.text()
    throw new Error(`Calendar create error: ${response.status} ${errorText}`)
  }

  return response.json()
}

/**
 * Extract company name from calendar event
 * Heuristic: look at attendee domains, event title patterns
 */
export function extractCompanyNameFromEvent(event: CalendarEvent): string | null {
  // 1. Check event summary for common patterns: "会社名 - MTG" or "【会社名】..."
  const summary = event.summary || ''

  // Pattern: 【会社名】...
  const bracketMatch = summary.match(/[【\[](.+?)[】\]]/)
  if (bracketMatch) return bracketMatch[1]

  // Pattern: "会社名 様" or "会社名 - "
  const dashMatch = summary.match(/^(.+?)[\s]*[-–—]/)
  if (dashMatch && dashMatch[1].length >= 2 && dashMatch[1].length <= 30) {
    return dashMatch[1].trim()
  }

  // 2. Check attendees for company domains (skip common domains)
  const commonDomains = ['gmail.com', 'yahoo.co.jp', 'hotmail.com', 'outlook.com', 'icloud.com']
  if (event.attendees) {
    for (const attendee of event.attendees) {
      if (attendee.email) {
        const domain = attendee.email.split('@')[1]
        if (domain && !commonDomains.includes(domain)) {
          // Use domain as company hint
          const companyPart = domain.split('.')[0]
          if (companyPart.length >= 2) {
            return companyPart
          }
        }
      }
    }
  }

  return null
}
