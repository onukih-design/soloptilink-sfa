'use client'

import { useEffect, useState } from 'react'
import { useSearchParams, useRouter } from 'next/navigation'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import {
  getGoogleAuthUrl,
  storeGoogleTokens,
  clearGoogleTokens,
  isGoogleConnected,
  type GoogleTokens,
} from '@/lib/integrations/google-auth'
import {
  Calendar,
  ExternalLink,
  CheckCircle2,
  XCircle,
  Loader2,
  Brain,
  ArrowLeft,
} from 'lucide-react'
import Link from 'next/link'
import { toast } from 'sonner'

export default function IntegrationsPage() {
  const searchParams = useSearchParams()
  const router = useRouter()
  const [connected, setConnected] = useState(false)
  const [checking, setChecking] = useState(true)

  // Handle OAuth callback tokens
  useEffect(() => {
    const googleTokens = searchParams.get('google_tokens')
    const googleConnected = searchParams.get('google_connected')
    const error = searchParams.get('error')

    if (error) {
      toast.error(`Google連携エラー: ${error}`)
      router.replace('/settings/integrations')
      return
    }

    if (googleConnected === 'true' && googleTokens) {
      try {
        const tokens: GoogleTokens = JSON.parse(decodeURIComponent(googleTokens))
        storeGoogleTokens(tokens)
        setConnected(true)
        toast.success('Googleカレンダーと連携しました')
        router.replace('/settings/integrations')
      } catch (e) {
        console.error('Token parse error:', e)
        toast.error('トークンの保存に失敗しました')
      }
    }
  }, [searchParams, router])

  // Check current connection status
  useEffect(() => {
    setConnected(isGoogleConnected())
    setChecking(false)
  }, [])

  const handleConnect = () => {
    try {
      const url = getGoogleAuthUrl()
      window.location.href = url
    } catch (error) {
      toast.error('Google OAuth設定が見つかりません。環境変数を確認してください。')
      console.error(error)
    }
  }

  const handleDisconnect = () => {
    clearGoogleTokens()
    setConnected(false)
    toast.success('Googleカレンダーの連携を解除しました')
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <Link href="/settings">
          <Button variant="ghost" size="sm">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div>
          <h1 className="text-2xl font-bold tracking-tight">外部連携設定</h1>
          <p className="text-muted-foreground text-sm">
            外部サービスとの連携を管理します
          </p>
        </div>
      </div>

      {/* Google Calendar */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-base flex items-center gap-2">
                <Calendar className="h-5 w-5 text-blue-600" />
                Googleカレンダー連携
              </CardTitle>
              <CardDescription className="mt-1">
                カレンダーの予定を自動取得し、会社情報とマッチングします
              </CardDescription>
            </div>
            {checking ? (
              <Loader2 className="h-5 w-5 animate-spin text-muted-foreground" />
            ) : connected ? (
              <Badge className="bg-green-100 text-green-800 border-green-200">
                <CheckCircle2 className="h-3.5 w-3.5 mr-1" />
                接続済み
              </Badge>
            ) : (
              <Badge variant="outline" className="text-muted-foreground">
                <XCircle className="h-3.5 w-3.5 mr-1" />
                未接続
              </Badge>
            )}
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="bg-muted/50 rounded-lg p-4">
            <h4 className="text-sm font-medium mb-2">連携でできること:</h4>
            <ul className="text-sm text-muted-foreground space-y-1">
              <li>• カレンダー予定から会社情報を自動抽出</li>
              <li>• 既存の会社とのマッチング・新規登録</li>
              <li>• 次回MTG日程のカレンダー自動登録</li>
              <li>• Web会議URL（Google Meet）の自動取得</li>
            </ul>
          </div>

          {connected ? (
            <div className="flex items-center gap-2">
              <Button variant="outline" onClick={handleDisconnect}>
                連携を解除
              </Button>
              <Link href="/settings/integrations">
                <Button variant="ghost" size="sm">
                  <ExternalLink className="h-4 w-4 mr-1" />
                  カレンダー設定を開く
                </Button>
              </Link>
            </div>
          ) : (
            <Button onClick={handleConnect}>
              <Calendar className="h-4 w-4 mr-2" />
              Googleアカウントと連携
            </Button>
          )}
        </CardContent>
      </Card>

      {/* AI Service */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-base flex items-center gap-2">
                <Brain className="h-5 w-5 text-purple-600" />
                AI自動化（DeepSeek）
              </CardTitle>
              <CardDescription className="mt-1">
                商談メモの自動要約と次回アクション提案
              </CardDescription>
            </div>
            <Badge variant="outline" className="text-muted-foreground">
              {process.env.NEXT_PUBLIC_DEEPSEEK_ENABLED === 'true' ? (
                <>
                  <CheckCircle2 className="h-3.5 w-3.5 mr-1 text-green-600" />
                  有効
                </>
              ) : (
                <>設定待ち</>
              )}
            </Badge>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="bg-muted/50 rounded-lg p-4">
            <h4 className="text-sm font-medium mb-2">AI機能:</h4>
            <ul className="text-sm text-muted-foreground space-y-1">
              <li>• 商談メモ → 要約 + 重要ポイント抽出</li>
              <li>• 次回アクション自動提案</li>
              <li>• 商談進捗ステージの自動判定</li>
              <li>• 次回MTGアジェンダ提案</li>
            </ul>
          </div>

          <div className="text-xs text-muted-foreground">
            <p>
              使用モデル: DeepSeek V3 (コスト最適化 — $0.28/M tokens)
            </p>
            <p className="mt-1">
              環境変数 <code className="bg-muted px-1 py-0.5 rounded">DEEPSEEK_API_KEY</code> を設定してください
            </p>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
