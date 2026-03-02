"use client";

import { useState, type FormEvent } from "react";
import { useRouter } from "next/navigation";
import { createBrowserClient } from "@supabase/ssr";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { IS_DEMO_MODE } from "@/lib/demo-mode";

const DEMO_EMAIL = "onuki.h@soloptilink.com";
const DEMO_PASSWORD = "Hiro9101";

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const supabase = IS_DEMO_MODE
    ? null
    : createBrowserClient(
        process.env.NEXT_PUBLIC_SUPABASE_URL!,
        process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
      );

  const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    setIsLoading(true);

    try {
      // デモモード: 固定の認証情報でcookieをセット
      if (IS_DEMO_MODE) {
        if (email === DEMO_EMAIL && password === DEMO_PASSWORD) {
          document.cookie = "demo-auth=true; path=/; max-age=86400";
          router.push("/dashboard");
          router.refresh();
        } else {
          setError(
            `デモモードでは email: ${DEMO_EMAIL}, password: ${DEMO_PASSWORD} でログインしてください`
          );
        }
        return;
      }

      // 通常モード: Supabase認証
      const { error: authError } = await supabase!.auth.signInWithPassword({
        email,
        password,
      });

      if (authError) {
        setError(authError.message);
        return;
      }

      router.push("/dashboard");
      router.refresh();
    } catch {
      setError("ログイン中にエラーが発生しました。");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Card>
      <CardHeader className="space-y-1">
        <CardTitle className="text-2xl font-bold text-center">
          SoloptiLink SFA
        </CardTitle>
        <CardDescription className="text-center">
          メールアドレスとパスワードでログイン
        </CardDescription>
        {IS_DEMO_MODE && (
          <div className="mt-3 rounded-md bg-blue-50 p-3 text-sm text-blue-700 border border-blue-200">
            <strong>デモモード</strong>
            <br />
            Email: {DEMO_EMAIL}
            <br />
            Password: {DEMO_PASSWORD}
          </div>
        )}
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="email">メールアドレス</Label>
            <Input
              id="email"
              type="email"
              placeholder="your@email.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              disabled={isLoading}
            />
          </div>
          <div className="space-y-2">
            <Label htmlFor="password">パスワード</Label>
            <Input
              id="password"
              type="password"
              placeholder="パスワードを入力"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              disabled={isLoading}
            />
          </div>
          {error && (
            <div className="rounded-md bg-destructive/10 p-3 text-sm text-destructive">
              {error}
            </div>
          )}
          <Button type="submit" className="w-full" disabled={isLoading}>
            {isLoading ? "ログイン中..." : "ログイン"}
          </Button>
        </form>
      </CardContent>
    </Card>
  );
}
