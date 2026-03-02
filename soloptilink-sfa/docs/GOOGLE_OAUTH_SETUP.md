# Google OAuth2 Setup Guide

This guide explains how to set up Google OAuth2 authentication for Google Calendar API integration in SoloptiLink SFA.

## Overview

The Google OAuth integration allows users to:
- Connect their Google Calendar
- Sync calendar events with the SFA system
- Automatically extract company information from calendar events
- Create activity records from meetings

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│  Client-Side (Browser)                                  │
│                                                          │
│  1. User clicks "Connect with Google"                   │
│  2. Redirects to Google OAuth                           │
│  3. User authorizes                                     │
│  4. Google redirects to callback                        │
│  5. Tokens stored in localStorage                       │
│  6. API calls use tokens                                │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  Server-Side API Routes                                 │
│                                                          │
│  GET  /api/auth/google           - Initiate OAuth       │
│  GET  /api/auth/google/callback  - Handle callback      │
│  POST /api/auth/google/refresh   - Refresh token        │
└─────────────────────────────────────────────────────────┘
```

## Step 1: Create Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the **Google Calendar API**:
   - Navigate to "APIs & Services" > "Library"
   - Search for "Google Calendar API"
   - Click "Enable"

## Step 2: Create OAuth 2.0 Credentials

1. Go to "APIs & Services" > "Credentials"
2. Click "Create Credentials" > "OAuth client ID"
3. Configure the OAuth consent screen if prompted:
   - User Type: External (for testing) or Internal (for organization)
   - App name: SoloptiLink SFA
   - Scopes: Add the following scopes:
     - `https://www.googleapis.com/auth/calendar.readonly`
     - `https://www.googleapis.com/auth/calendar.events`
4. Create OAuth client ID:
   - Application type: Web application
   - Name: SoloptiLink SFA
   - Authorized redirect URIs:
     - Development: `http://localhost:3000/api/auth/google/callback`
     - Production: `https://yourdomain.com/api/auth/google/callback`
5. Copy the **Client ID** and **Client Secret**

## Step 3: Configure Environment Variables

Add the following to your `.env.local` file:

```env
# Google OAuth (for Calendar API integration)
NEXT_PUBLIC_GOOGLE_CLIENT_ID=your-client-id.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=your-client-secret
```

**Important:**
- `NEXT_PUBLIC_GOOGLE_CLIENT_ID` - Available on client-side (public)
- `GOOGLE_CLIENT_SECRET` - Server-side only (keep secret!)

## Step 4: Use in Your Application

### Connect Google Calendar

```tsx
import { GoogleCalendarConnect } from '@/components/settings/GoogleCalendarConnect'

export default function SettingsPage() {
  return (
    <div>
      <h1>Settings</h1>
      <GoogleCalendarConnect />
    </div>
  )
}
```

### Fetch Calendar Events

```typescript
import { fetchCalendarEvents } from '@/lib/integrations/google-calendar'
import { getValidAccessToken } from '@/lib/integrations/google-auth'

async function syncCalendar() {
  const accessToken = await getValidAccessToken()
  if (!accessToken) {
    console.error('Not connected to Google Calendar')
    return
  }

  const events = await fetchCalendarEvents(accessToken, {
    timeMin: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
    timeMax: new Date().toISOString(),
    maxResults: 50,
  })

  console.log('Fetched events:', events.items)
}
```

### Match Events to Companies

```typescript
import { matchEventsToCompanies } from '@/lib/integrations/calendar-sync'

async function syncEventsToCompanies(events, companies) {
  const result = matchEventsToCompanies(events, companies)

  console.log(`Total events: ${result.totalEvents}`)
  console.log(`Matched: ${result.matchedEvents}`)
  console.log(`New companies: ${result.newCompanyEvents}`)
  console.log(`Unmatched: ${result.unmatchedEvents}`)

  // Process matched events
  for (const synced of result.syncedEvents) {
    if (synced.syncStatus === 'matched') {
      // Create activity record
      console.log(`Event "${synced.event.summary}" matched to company ${synced.matchedCompanyName}`)
    }
  }
}
```

## Token Management

### Token Storage

Tokens are stored in `localStorage` with the following structure:

```typescript
interface GoogleTokens {
  access_token: string      // Valid for ~1 hour
  refresh_token: string     // Used to get new access tokens
  expires_at: number        // Timestamp when access_token expires
  scope: string            // Granted scopes
}
```

### Automatic Token Refresh

The `getValidAccessToken()` function automatically refreshes expired tokens:

```typescript
import { getValidAccessToken } from '@/lib/integrations/google-auth'

// Automatically handles token refresh if expired
const token = await getValidAccessToken()
if (token) {
  // Use token for API calls
}
```

### Manual Disconnect

```typescript
import { clearGoogleTokens } from '@/lib/integrations/google-auth'

// Remove stored tokens
clearGoogleTokens()
```

## Security Considerations

1. **Client Secret**: Never expose `GOOGLE_CLIENT_SECRET` to the client-side
2. **Token Storage**: In production, consider storing tokens in Supabase instead of localStorage
3. **HTTPS**: Always use HTTPS in production for OAuth redirects
4. **Scope Minimization**: Only request the scopes you need
5. **Token Validation**: The refresh endpoint validates tokens server-side

## Troubleshooting

### "Google OAuth is not configured" error

Check that both environment variables are set:
```bash
echo $NEXT_PUBLIC_GOOGLE_CLIENT_ID
echo $GOOGLE_CLIENT_SECRET
```

### "Redirect URI mismatch" error

Ensure the redirect URI in Google Cloud Console matches exactly:
- Development: `http://localhost:3000/api/auth/google/callback`
- Production: `https://yourdomain.com/api/auth/google/callback`

### Token refresh fails

- Check that `GOOGLE_CLIENT_SECRET` is correct
- Verify the refresh token hasn't been revoked
- Ensure the OAuth consent screen is properly configured

## API Endpoints

### GET /api/auth/google

Initiates OAuth flow by redirecting to Google's authorization endpoint.

**Response:** 302 Redirect to Google OAuth

---

### GET /api/auth/google/callback

Handles OAuth callback from Google and exchanges code for tokens.

**Query Parameters:**
- `code` - Authorization code from Google
- `state` - Should be "google-calendar-connect"
- `error` - Error code if authorization failed

**Response:** 302 Redirect to `/settings` with tokens in query params

---

### POST /api/auth/google/refresh

Refreshes an expired access token using refresh token.

**Request Body:**
```json
{
  "refresh_token": "string"
}
```

**Response:**
```json
{
  "data": {
    "access_token": "string",
    "expires_at": 1234567890,
    "scope": "string"
  }
}
```

## Demo Mode

In demo mode (when `NEXT_PUBLIC_SUPABASE_URL` contains "xxxxx"), the Google integration will still work but tokens will only be stored in localStorage. In production with Supabase configured, consider storing tokens in the database for better security and multi-device support.

## Next Steps

1. [ ] Set up Google Cloud project
2. [ ] Add environment variables
3. [ ] Test OAuth flow in development
4. [ ] Implement calendar sync in settings page
5. [ ] Add activity record creation from calendar events
6. [ ] Consider migrating token storage to Supabase
