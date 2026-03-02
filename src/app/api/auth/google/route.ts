import { NextResponse } from 'next/server'

/**
 * GET /api/auth/google
 *
 * Initiates Google OAuth2 flow by redirecting to Google's authorization endpoint
 */
export async function GET() {
  const clientId = process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID

  if (!clientId) {
    return NextResponse.json(
      { error: { code: 'CONFIG_ERROR', message: 'Google OAuth is not configured' } },
      { status: 500 }
    )
  }

  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'}/api/auth/google/callback`

  const params = new URLSearchParams({
    client_id: clientId,
    redirect_uri: redirectUri,
    response_type: 'code',
    scope: [
      'https://www.googleapis.com/auth/calendar.readonly',
      'https://www.googleapis.com/auth/calendar.events',
    ].join(' '),
    access_type: 'offline',
    prompt: 'consent',
    state: 'google-calendar-connect',
  })

  const authUrl = `https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`

  return NextResponse.redirect(authUrl)
}
