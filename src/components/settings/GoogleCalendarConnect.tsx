/**
 * Google Calendar Connection Component
 *
 * Shows connection status and provides connect/disconnect buttons
 */

'use client'

import { useEffect, useState } from 'react'
import { Button } from '@/components/ui/button'
import { toast } from 'sonner'
import {
  getGoogleAuthUrl,
  isGoogleConnected,
  clearGoogleTokens,
  storeGoogleTokens,
  type GoogleTokens,
} from '@/lib/integrations/google-auth'

export function GoogleCalendarConnect() {
  const [isConnected, setIsConnected] = useState(false)
  const [isLoading, setIsLoading] = useState(false)

  useEffect(() => {
    // Check connection status on mount
    setIsConnected(isGoogleConnected())

    // Handle OAuth callback redirect with tokens
    const params = new URLSearchParams(window.location.search)
    const googleConnected = params.get('google_connected')
    const googleTokensParam = params.get('google_tokens')

    if (googleConnected === 'true' && googleTokensParam) {
      try {
        const tokens = JSON.parse(decodeURIComponent(googleTokensParam)) as GoogleTokens
        storeGoogleTokens(tokens)
        setIsConnected(true)
        toast.success('Googleカレンダーに接続しました')

        // Clean up URL
        const url = new URL(window.location.href)
        url.searchParams.delete('google_connected')
        url.searchParams.delete('google_tokens')
        window.history.replaceState({}, '', url.toString())
      } catch (error) {
        console.error('Failed to parse Google tokens:', error)
        toast.error('接続に失敗しました')
      }
    }

    // Handle OAuth errors
    const error = params.get('error')
    if (error) {
      toast.error(`接続エラー: ${error}`)
      const url = new URL(window.location.href)
      url.searchParams.delete('error')
      window.history.replaceState({}, '', url.toString())
    }
  }, [])

  const handleConnect = async () => {
    try {
      setIsLoading(true)
      const authUrl = getGoogleAuthUrl()
      window.location.href = authUrl
    } catch (error) {
      console.error('Failed to initiate OAuth:', error)
      toast.error('接続の開始に失敗しました')
      setIsLoading(false)
    }
  }

  const handleDisconnect = () => {
    clearGoogleTokens()
    setIsConnected(false)
    toast.success('Googleカレンダーとの接続を解除しました')
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h3 className="text-sm font-medium">Googleカレンダー連携</h3>
          <p className="text-sm text-muted-foreground">
            カレンダーのイベントを自動的に取引先活動として記録します
          </p>
        </div>
        <div className="flex items-center gap-2">
          {isConnected ? (
            <>
              <div className="flex items-center gap-2">
                <div className="h-2 w-2 rounded-full bg-green-500" />
                <span className="text-sm text-muted-foreground">接続済み</span>
              </div>
              <Button
                variant="outline"
                size="sm"
                onClick={handleDisconnect}
                disabled={isLoading}
              >
                接続解除
              </Button>
            </>
          ) : (
            <Button onClick={handleConnect} disabled={isLoading} size="sm">
              {isLoading ? '接続中...' : 'Googleで接続'}
            </Button>
          )}
        </div>
      </div>

      {isConnected && (
        <div className="rounded-lg border bg-muted/50 p-4">
          <p className="text-sm text-muted-foreground">
            カレンダーのイベントから取引先情報を自動抽出し、活動履歴として記録します。
            イベントのタイトルや参加者のメールアドレスから取引先を判定します。
          </p>
        </div>
      )}
    </div>
  )
}
