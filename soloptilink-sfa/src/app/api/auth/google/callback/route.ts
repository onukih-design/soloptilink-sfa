import { NextRequest, NextResponse } from 'next/server'

/**
 * GET /api/auth/google/callback
 *
 * Handles OAuth2 callback from Google
 * Exchanges authorization code for access & refresh tokens
 */
export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const code = searchParams.get('code')
  const error = searchParams.get('error')
  const state = searchParams.get('state')

  // Handle errors from Google
  if (error) {
    return NextResponse.redirect(
      new URL(`/settings?error=${encodeURIComponent(error)}`, request.url)
    )
  }

  // Validate request
  if (!code || state !== 'google-calendar-connect') {
    return NextResponse.redirect(
      new URL('/settings?error=invalid_request', request.url)
    )
  }

  const clientId = process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID
  const clientSecret = process.env.GOOGLE_CLIENT_SECRET

  if (!clientId || !clientSecret) {
    return NextResponse.redirect(
      new URL('/settings?error=config_error', request.url)
    )
  }

  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000'}/api/auth/google/callback`

  try {
    // Exchange code for tokens
    const tokenResponse = await fetch('https://oauth2.googleapis.com/token', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        code,
        client_id: clientId,
        client_secret: clientSecret,
        redirect_uri: redirectUri,
        grant_type: 'authorization_code',
      }),
    })

    if (!tokenResponse.ok) {
      const errorData = await tokenResponse.text()
      console.error('Token exchange failed:', errorData)
      return NextResponse.redirect(
        new URL('/settings?error=token_exchange_failed', request.url)
      )
    }

    const tokenData = await tokenResponse.json()

    // Build redirect URL with tokens (they'll be stored client-side)
    const redirectUrl = new URL('/settings', request.url)
    redirectUrl.searchParams.set('google_connected', 'true')
    redirectUrl.searchParams.set(
      'google_tokens',
      encodeURIComponent(
        JSON.stringify({
          access_token: tokenData.access_token,
          refresh_token: tokenData.refresh_token,
          expires_at: Date.now() + tokenData.expires_in * 1000,
          scope: tokenData.scope,
        })
      )
    )

    return NextResponse.redirect(redirectUrl)
  } catch (err) {
    console.error('OAuth callback error:', err)
    return NextResponse.redirect(
      new URL('/settings?error=unexpected_error', request.url)
    )
  }
}
