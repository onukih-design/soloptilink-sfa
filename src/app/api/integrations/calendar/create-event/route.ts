import { NextRequest, NextResponse } from 'next/server'

export async function POST(request: NextRequest) {
  try {
    const { access_token, event } = await request.json()

    if (!access_token || !event) {
      return NextResponse.json(
        { error: { code: 'INVALID_INPUT', message: 'Access token and event data are required' } },
        { status: 400 }
      )
    }

    const response = await fetch(
      'https://www.googleapis.com/calendar/v3/calendars/primary/events?conferenceDataVersion=1',
      {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${access_token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          summary: event.summary,
          description: event.description || '',
          start: event.start,
          end: event.end,
          attendees: event.attendees || [],
          location: event.location || '',
          conferenceData: event.requestMeetLink
            ? {
                createRequest: {
                  requestId: `soloptilink-${Date.now()}`,
                  conferenceSolutionKey: { type: 'hangoutsMeet' },
                },
              }
            : undefined,
        }),
      }
    )

    if (!response.ok) {
      const errorText = await response.text()
      console.error('Create event error:', errorText)
      return NextResponse.json(
        { error: { code: 'CREATE_FAILED', message: 'Failed to create calendar event' } },
        { status: response.status }
      )
    }

    const data = await response.json()

    return NextResponse.json({
      data: {
        eventId: data.id,
        htmlLink: data.htmlLink,
        hangoutLink: data.hangoutLink || null,
        meetLink: data.conferenceData?.entryPoints?.[0]?.uri || null,
      },
    })
  } catch (err) {
    console.error('Create event error:', err)
    return NextResponse.json(
      { error: { code: 'UNEXPECTED', message: 'Unexpected error' } },
      { status: 500 }
    )
  }
}
