/**
 * Google OAuth2 Token Management
 *
 * Handles OAuth2 flow for Google Calendar API access.
 * Tokens are stored in localStorage (or Supabase in production).
 */

const GOOGLE_AUTH_SCOPES = [
  'https://www.googleapis.com/auth/calendar.readonly',
  'https://www.googleapis.com/auth/calendar.events',
]

export interface GoogleTokens {
  access_token: string
  refresh_token: string
  expires_at: number
  scope: string
}

/**
 * Generate OAuth2 authorization URL
 * @throws Error if NEXT_PUBLIC_GOOGLE_CLIENT_ID is not set
 */
export function getGoogleAuthUrl(): string {
  const clientId = process.env.NEXT_PUBLIC_GOOGLE_CLIENT_ID
  if (!clientId) {
    throw new Error('NEXT_PUBLIC_GOOGLE_CLIENT_ID is not set')
  }

  const redirectUri = `${window.location.origin}/api/auth/google/callback`

  const params = new URLSearchParams({
    client_id: clientId,
    redirect_uri: redirectUri,
    response_type: 'code',
    scope: GOOGLE_AUTH_SCOPES.join(' '),
    access_type: 'offline',
    prompt: 'consent',
    state: 'google-calendar-connect',
  })

  return `https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`
}

/**
 * Store tokens in localStorage
 */
export function storeGoogleTokens(tokens: GoogleTokens): void {
  localStorage.setItem('google_tokens', JSON.stringify(tokens))
}

/**
 * Retrieve stored tokens
 */
export function getStoredGoogleTokens(): GoogleTokens | null {
  try {
    const stored = localStorage.getItem('google_tokens')
    if (!stored) return null
    return JSON.parse(stored) as GoogleTokens
  } catch {
    return null
  }
}

/**
 * Check if tokens are expired (with 5 min buffer)
 */
export function isTokenExpired(tokens: GoogleTokens): boolean {
  return Date.now() >= tokens.expires_at - 5 * 60 * 1000
}

/**
 * Remove stored tokens (disconnect)
 */
export function clearGoogleTokens(): void {
  localStorage.removeItem('google_tokens')
}

/**
 * Check if Google Calendar is connected
 */
export function isGoogleConnected(): boolean {
  const tokens = getStoredGoogleTokens()
  return tokens !== null
}

/**
 * Refresh access token using refresh token
 */
export async function refreshGoogleToken(refreshToken: string): Promise<GoogleTokens | null> {
  try {
    const response = await fetch('/api/auth/google/refresh', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ refresh_token: refreshToken }),
    })

    if (!response.ok) {
      console.error('Token refresh failed:', response.status)
      return null
    }

    const { data } = await response.json()

    const currentTokens = getStoredGoogleTokens()
    if (!currentTokens) return null

    const newTokens: GoogleTokens = {
      ...currentTokens,
      access_token: data.access_token,
      expires_at: data.expires_at,
      scope: data.scope,
    }

    storeGoogleTokens(newTokens)
    return newTokens
  } catch (error) {
    console.error('Token refresh error:', error)
    return null
  }
}

/**
 * Get valid access token (refresh if needed)
 */
export async function getValidAccessToken(): Promise<string | null> {
  const tokens = getStoredGoogleTokens()
  if (!tokens) return null

  if (isTokenExpired(tokens)) {
    const newTokens = await refreshGoogleToken(tokens.refresh_token)
    if (!newTokens) {
      clearGoogleTokens()
      return null
    }
    return newTokens.access_token
  }

  return tokens.access_token
}
