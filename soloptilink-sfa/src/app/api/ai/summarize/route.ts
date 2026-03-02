import { NextRequest, NextResponse } from 'next/server'
import { summarizeMeeting } from '@/lib/ai/ai-service'

export async function POST(request: NextRequest) {
  try {
    const { notes, companyName, currentStage } = await request.json()

    if (!notes || !companyName) {
      return NextResponse.json(
        { error: { code: 'INVALID_INPUT', message: 'Notes and company name are required' } },
        { status: 400 }
      )
    }

    const result = await summarizeMeeting(notes, companyName, currentStage)

    return NextResponse.json({ data: result })
  } catch (err) {
    console.error('Summarize API error:', err)
    return NextResponse.json(
      { error: { code: 'UNEXPECTED', message: 'Unexpected error' } },
      { status: 500 }
    )
  }
}
