import Link from "next/link";
import { Button } from "@/components/ui/button";

export default function NotFound() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-6 bg-gray-50">
      <div className="text-center space-y-3">
        <h1 className="text-6xl font-bold text-gray-300">404</h1>
        <h2 className="text-xl font-semibold text-gray-900">
          ページが見つかりません
        </h2>
        <p className="text-sm text-muted-foreground">
          お探しのページは存在しないか、移動した可能性があります。
        </p>
      </div>
      <Button asChild>
        <Link href="/dashboard">ダッシュボードに戻る</Link>
      </Button>
    </div>
  );
}
