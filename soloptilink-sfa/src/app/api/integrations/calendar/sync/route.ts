import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  try {
    const { access_token, timeMin, timeMax } = await request.json()

    if (!access_token) {
      return NextResponse.json(
        { error: { code: 'MISSING_TOKEN', message: 'Access token is required' } },
        { status: 400 }
      )
    }

    // Fetch events from Google Calendar API
    const params = new URLSearchParams({
      timeMin: timeMin || new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString(),
      timeMax: timeMax || new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
      maxResults: '100',
      singleEvents: 'true',
      orderBy: 'startTime',
    })

    const response = await fetch(
      `https://www.googleapis.com/calendar/v3/calendars/primary/events?${params}`,
      {
        headers: {
          Authorization: `Bearer ${access_token}`,
          'Content-Type': 'application/json',
        },
      }
    )

    if (!response.ok) {
      const errorText = await response.text()
      console.error('Calendar sync API error:', errorText)
      return NextResponse.json(
        { error: { code: 'CALENDAR_ERROR', message: 'Failed to fetch calendar events' } },
        { status: response.status }
      )
    }

    const data = await response.json()

    return NextResponse.json({
      data: {
        events: data.items || [],
        nextPageToken: data.nextPageToken || null,
      },
    })
  } catch (err) {
    console.error('Calendar sync error:', err)
    return NextResponse.json(
      { error: { code: 'UNEXPECTED', message: 'Unexpected error' } },
      { status: 500 }
    )
  }
}
