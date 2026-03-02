/**
 * AI Service - Meeting Summarization & Next Action Suggestions
 *
 * Uses DeepSeek V3 for text generation (cost-optimized).
 * Claude/OpenAI PROHIBITED per CLAUDE.md cost rules.
 */

export interface MeetingSummary {
  summary: string
  keyPoints: string[]
  nextActions: Array<{
    action: string
    deadline: string | null
    assignee: string | null
  }>
  sentiment: 'positive' | 'neutral' | 'negative'
  dealStage: string | null
}

const DEEPSEEK_API_URL = 'https://api.deepseek.com/v1/chat/completions'

/**
 * Summarize meeting notes and suggest next actions
 */
export async function summarizeMeeting(
  meetingNotes: string,
  companyName: string,
  currentStage?: string
): Promise<MeetingSummary> {
  const apiKey = process.env.DEEPSEEK_API_KEY

  if (!apiKey) {
    // Fallback: return basic extraction without AI
    return fallbackSummarize(meetingNotes)
  }

  const systemPrompt = `あなたは営業支援AIアシスタントです。商談メモを分析し、以下のJSON形式で返してください。
必ず有効なJSONで返してください。他のテキストは含めないでください。

{
  "summary": "2-3文の要約",
  "keyPoints": ["ポイント1", "ポイント2", "ポイント3"],
  "nextActions": [
    {"action": "次のアクション", "deadline": "YYYY-MM-DD or null", "assignee": "担当者名 or null"}
  ],
  "sentiment": "positive/neutral/negative",
  "dealStage": "受注/Aヨミ/Bヨミ/Cヨミ/ネタ or null"
}`

  const userPrompt = `会社名: ${companyName}
${currentStage ? `現在のステージ: ${currentStage}` : ''}

商談メモ:
${meetingNotes}`

  try {
    const response = await fetch(DEEPSEEK_API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: 'deepseek-chat',
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userPrompt },
        ],
        temperature: 0.3,
        max_tokens: 1000,
      }),
    })

    if (!response.ok) {
      console.error('DeepSeek API error:', await response.text())
      return fallbackSummarize(meetingNotes)
    }

    const data = await response.json()
    const content = data.choices?.[0]?.message?.content || ''

    // Parse JSON response
    const jsonMatch = content.match(/\{[\s\S]*\}/)
    if (jsonMatch) {
      const parsed = JSON.parse(jsonMatch[0])
      return {
        summary: parsed.summary || meetingNotes.slice(0, 100),
        keyPoints: parsed.keyPoints || [],
        nextActions: parsed.nextActions || [],
        sentiment: parsed.sentiment || 'neutral',
        dealStage: parsed.dealStage || null,
      }
    }

    return fallbackSummarize(meetingNotes)
  } catch (error) {
    console.error('AI summarization error:', error)
    return fallbackSummarize(meetingNotes)
  }
}

/**
 * Fallback summarization (no AI required)
 */
function fallbackSummarize(notes: string): MeetingSummary {
  const sentences = notes
    .split(/[。\n]/)
    .filter((s) => s.trim().length > 0)
    .map((s) => s.trim())

  return {
    summary: sentences.slice(0, 2).join('。') + (sentences.length > 2 ? '...' : ''),
    keyPoints: sentences.slice(0, 3),
    nextActions: [],
    sentiment: 'neutral',
    dealStage: null,
  }
}

/**
 * Generate next meeting agenda suggestion
 */
export async function suggestNextMeetingAgenda(
  companyName: string,
  recentNotes: string[],
  currentStage?: string
): Promise<string> {
  const apiKey = process.env.DEEPSEEK_API_KEY

  if (!apiKey) {
    return `${companyName}様 フォローアップMTG`
  }

  try {
    const response = await fetch(DEEPSEEK_API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: 'deepseek-chat',
        messages: [
          {
            role: 'system',
            content: '次回MTGのアジェンダを1-2文で簡潔に提案してください。日本語で回答してください。',
          },
          {
            role: 'user',
            content: `会社: ${companyName}\nステージ: ${currentStage || '不明'}\n最近の商談メモ:\n${recentNotes.join('\n---\n')}`,
          },
        ],
        temperature: 0.5,
        max_tokens: 200,
      }),
    })

    if (!response.ok) return `${companyName}様 フォローアップMTG`

    const data = await response.json()
    return data.choices?.[0]?.message?.content || `${companyName}様 フォローアップMTG`
  } catch {
    return `${companyName}様 フォローアップMTG`
  }
}
