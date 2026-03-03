'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Badge } from '@/components/ui/badge'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { useAddFollowup } from '@/hooks/use-deals'
import { formatDate } from '@/lib/utils/format'
import { Phone, Mail, Video, Users, MessageSquare, Plus } from 'lucide-react'
import { toast } from 'sonner'

type Followup = {
  id: string
  followup_date: string
  followup_type: string
  content: string
  next_action: string | null
  next_action_date: string | null
  created_at: string
  created_by_user?: { display_name: string } | null
}

type Props = {
  dealId: string
  followups: Followup[]
}

const typeIcons: Record<string, typeof Phone> = {
  '電話': Phone,
  'メール': Mail,
  'Web会議': Video,
  '訪問': Users,
  'その他': MessageSquare,
}

const typeColors: Record<string, string> = {
  '電話': 'bg-blue-100 text-blue-800',
  'メール': 'bg-green-100 text-green-800',
  'Web会議': 'bg-purple-100 text-purple-800',
  '訪問': 'bg-orange-100 text-orange-800',
  'その他': 'bg-gray-100 text-gray-800',
}

export function OutsourcingFollowupSection({ dealId, followups }: Props) {
  const [showForm, setShowForm] = useState(false)
  const [followupDate, setFollowupDate] = useState(new Date().toISOString().split('T')[0])
  const [followupType, setFollowupType] = useState('電話')
  const [content, setContent] = useState('')
  const [nextAction, setNextAction] = useState('')
  const [nextActionDate, setNextActionDate] = useState('')
  const addFollowup = useAddFollowup()

  const handleSubmit = () => {
    if (!content.trim()) {
      toast.error('対応内容を入力してください')
      return
    }
    addFollowup.mutate(
      {
        deal_id: dealId,
        followup_date: followupDate,
        followup_type: followupType,
        content: content,
        next_action: nextAction || null,
        next_action_date: nextActionDate || null,
      },
      {
        onSuccess: () => {
          toast.success('対応履歴を追加しました')
          setContent('')
          setNextAction('')
          setNextActionDate('')
          setFollowupDate(new Date().toISOString().split('T')[0])
          setShowForm(false)
        },
      }
    )
  }

  const sorted = [...followups].sort(
    (a, b) => new Date(b.followup_date).getTime() - new Date(a.followup_date).getTime()
  )

  return (
    <div className="space-y-4">
      {!showForm && (
        <Button variant="outline" size="sm" onClick={() => setShowForm(true)}>
          <Plus className="h-4 w-4 mr-1" />
          対応履歴を追加
        </Button>
      )}

      {showForm && (
        <div className="border rounded-lg p-4 space-y-3 bg-muted/30">
          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="text-xs">種別</Label>
              <Select value={followupType} onValueChange={setFollowupType}>
                <SelectTrigger className="h-8 text-sm">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {['電話', 'メール', 'Web会議', '訪問', 'その他'].map((t) => (
                    <SelectItem key={t} value={t}>{t}</SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <div>
              <Label className="text-xs">日付</Label>
              <Input
                type="date"
                className="h-8 text-sm"
                value={followupDate}
                onChange={(e) => setFollowupDate(e.target.value)}
              />
            </div>
          </div>
          <div>
            <Label className="text-xs">対応内容 *</Label>
            <textarea
              className="w-full rounded-md border bg-background px-3 py-2 text-sm min-h-[80px] resize-y"
              value={content}
              onChange={(e) => setContent(e.target.value)}
              placeholder="対応内容を入力..."
            />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="text-xs">次アクション</Label>
              <Input
                className="h-8 text-sm"
                value={nextAction}
                onChange={(e) => setNextAction(e.target.value)}
                placeholder="次のアクション"
              />
            </div>
            <div>
              <Label className="text-xs">次アクション日</Label>
              <Input
                type="date"
                className="h-8 text-sm"
                value={nextActionDate}
                onChange={(e) => setNextActionDate(e.target.value)}
              />
            </div>
          </div>
          <div className="flex gap-2 justify-end">
            <Button variant="ghost" size="sm" onClick={() => setShowForm(false)}>
              キャンセル
            </Button>
            <Button size="sm" onClick={handleSubmit} disabled={addFollowup.isPending}>
              追加
            </Button>
          </div>
        </div>
      )}

      {sorted.length === 0 ? (
        <p className="text-sm text-muted-foreground text-center py-6">対応履歴がありません</p>
      ) : (
        <div className="space-y-3">
          {sorted.map((f) => {
            const Icon = typeIcons[f.followup_type] || MessageSquare
            return (
              <div key={f.id} className="border rounded-lg p-3">
                <div className="flex items-center gap-2 mb-1">
                  <Icon className="h-3.5 w-3.5 text-muted-foreground" />
                  <Badge variant="outline" className={`text-[10px] ${typeColors[f.followup_type] || ''}`}>
                    {f.followup_type}
                  </Badge>
                  <span className="text-xs text-muted-foreground ml-auto">
                    {formatDate(f.followup_date)}
                  </span>
                </div>
                <p className="text-sm whitespace-pre-wrap">{f.content}</p>
                {f.next_action && (
                  <div className="mt-2 text-xs bg-muted/50 rounded p-2">
                    <span className="font-medium">次アクション:</span> {f.next_action}
                    {f.next_action_date && ` (${formatDate(f.next_action_date)})`}
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
