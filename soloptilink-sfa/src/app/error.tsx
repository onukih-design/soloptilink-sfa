"use client";

import { useEffect } from "react";
import { Button } from "@/components/ui/button";

interface ErrorPageProps {
  error: Error & { digest?: string };
  reset: () => void;
}

export default function ErrorPage({ error, reset }: ErrorPageProps) {
  useEffect(() => {
    console.error("Application error:", error);
  }, [error]);

  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-6 bg-gray-50">
      <div className="text-center space-y-3">
        <h1 className="text-6xl font-bold text-gray-300">500</h1>
        <h2 className="text-xl font-semibold text-gray-900">
          エラーが発生しました
        </h2>
        <p className="text-sm text-muted-foreground">
          予期しないエラーが発生しました。もう一度お試しください。
        </p>
      </div>
      <Button onClick={reset}>再試行</Button>
    </div>
  );
}
