import { NextRequest, NextResponse } from 'next/server'

/**
 * POST /api/auth/google/refresh
 *
 * Refreshes Google OAuth2 access token using refresh token
 * Request body: { refresh_token: string }
 */
export async function POST(request: NextRequest) {
  try {
    const { refresh_token } = await request.json()

    if (!refresh_token) {
      return NextResponse.json(
        { error: { code: 'MISSING_TOKEN', message: 'Refresh token is required' } },
        { status: 400 }
      )
    }

    const clientId = process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID
    const clientSecret = process.env.GOOGLE_CLIENT_SECRET

    if (!clientId || !clientSecret) {
      return NextResponse.json(
        { error: { code: 'CONFIG_ERROR', message: 'Google OAuth is not configured' } },
        { status: 500 }
      )
    }

    const tokenResponse = await fetch('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        client_id: clientId,
        client_secret: clientSecret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token',
      }),
    })

    if (!tokenResponse.ok) {
      const errorText = await tokenResponse.text()
      console.error('Token refresh failed:', errorText)
      return NextResponse.json(
        { error: { code: 'REFRESH_FAILED', message: 'Token refresh failed' } },
        { status: 401 }
      )
    }

    const tokenData = await tokenResponse.json()

    return NextResponse.json({
      data: {
        access_token: tokenData.access_token,
        expires_at: Date.now() + tokenData.expires_in * 1000,
        scope: tokenData.scope,
      },
    })
  } catch (err) {
    console.error('Token refresh error:', err)
    return NextResponse.json(
      { error: { code: 'UNEXPECTED', message: 'Unexpected error' } },
      { status: 500 }
    )
  }
}
