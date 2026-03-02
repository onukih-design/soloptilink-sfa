# Google Calendar Integration - Implementation Summary

## Files Created

### 1. Core Integration Libraries

#### `/src/lib/integrations/google-calendar.ts`
- **CalendarEvent interface**: Complete type definition for Google Calendar events
- **fetchCalendarEvents()**: Fetches events from Google Calendar API with pagination support
- **createCalendarEvent()**: Creates new calendar events with optional Google Meet links
- **extractCompanyNameFromEvent()**: Intelligent heuristic to extract company names from event titles and attendee domains

**Key Features:**
- Supports date-based and time-based events
- Handles attendees, locations, conference data
- Pattern matching for Japanese business event formats (【会社名】, "会社名 -")
- Domain-based company extraction from attendee emails

#### `/src/lib/integrations/calendar-sync.ts`
- **matchEventsToCompanies()**: Fuzzy matching algorithm to link events with existing companies
- **getEventDateTime()**: Normalizes event time to Date objects
- **formatEventTime()**: Japanese locale formatting for event times

**Sync Pipeline:**
- Extracts company names from events
- Fuzzy matches against existing company database
- Classifies events as: matched, new_company, or unmatched
- Returns detailed sync statistics

### 2. API Endpoints

#### `/src/app/api/integrations/calendar/sync/route.ts`
**POST /api/integrations/calendar/sync**

Request:
```json
{
  "access_token": "ya29.xxx",
  "timeMin": "2026-02-01T00:00:00Z",  // optional
  "timeMax": "2026-04-01T00:00:00Z"   // optional
}
```

Response:
```json
{
  "data": {
    "events": [...],
    "nextPageToken": "token" | null
  }
}
```

**Features:**
- Default: 30 days before/after current date
- Max 100 events per request
- Pagination support
- Error handling with standardized error codes

#### `/src/app/api/integrations/calendar/create-event/route.ts`
**POST /api/integrations/calendar/create-event**

Request:
```json
{
  "access_token": "ya29.xxx",
  "event": {
    "summary": "営業MTG with ABC株式会社",
    "description": "...",
    "start": { "dateTime": "2026-03-15T14:00:00+09:00" },
    "end": { "dateTime": "2026-03-15T15:00:00+09:00" },
    "attendees": [{ "email": "client@example.com" }],
    "location": "東京オフィス",
    "requestMeetLink": true
  }
}
```

Response:
```json
{
  "data": {
    "eventId": "evt_123",
    "htmlLink": "https://calendar.google.com/...",
    "hangoutLink": "https://meet.google.com/...",
    "meetLink": "https://meet.google.com/..."
  }
}
```

**Features:**
- Automatic Google Meet link creation (conferenceDataVersion=1)
- Unique request ID generation
- Full attendee/location support

## Integration Points

### Works with:
- **google-auth.ts**: Uses OAuth tokens from localStorage
- **MOCK_COMPANIES**: Can match events against demo company data
- **IS_DEMO_MODE**: Ready for demo/production mode switching

### Ready for:
- Activity logging (events → activities table)
- Company auto-creation from unmatched events
- Calendar widget in dashboard
- Activity timeline with calendar events

## Usage Example

```typescript
import { fetchCalendarEvents, extractCompanyNameFromEvent } from '@/lib/integrations/google-calendar'
import { matchEventsToCompanies } from '@/lib/integrations/calendar-sync'
import { MOCK_COMPANIES } from '@/lib/mock-data'

// Fetch events
const { items } = await fetchCalendarEvents(accessToken, {
  timeMin: new Date('2026-03-01').toISOString(),
  timeMax: new Date('2026-03-31').toISOString(),
})

// Match to companies
const syncResult = matchEventsToCompanies(items, MOCK_COMPANIES)

console.log(`Matched: ${syncResult.matchedEvents}/${syncResult.totalEvents}`)
console.log(`New companies detected: ${syncResult.newCompanyEvents}`)

// Create event
const response = await fetch('/api/integrations/calendar/create-event', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    access_token: accessToken,
    event: {
      summary: '【Acme Inc】商談',
      start: { dateTime: '2026-03-15T14:00:00+09:00' },
      end: { dateTime: '2026-03-15T15:00:00+09:00' },
      requestMeetLink: true,
    },
  }),
})
```

## Error Handling

All API endpoints return standardized error format:

```json
{
  "error": {
    "code": "MISSING_TOKEN" | "CALENDAR_ERROR" | "CREATE_FAILED" | "UNEXPECTED",
    "message": "Human-readable error message"
  }
}
```

## TypeScript Compliance

- All files pass `npx tsc --noEmit` with strict mode
- Comprehensive type definitions
- No any types used
- Proper error handling

## Next Steps

Ready for frontend integration:
1. Calendar sync UI component
2. Event creation form
3. Company matching review interface
4. Activity timeline with calendar events
5. Webhook listener for real-time sync (future enhancement)

## Cost Optimization

- Uses Google Calendar API (free up to 1M requests/day)
- No AI API calls (purely rule-based extraction)
- Efficient pagination (max 100 events per request)
- Client-side caching recommended for repeated syncs
