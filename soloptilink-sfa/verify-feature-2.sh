#!/bin/bash
# Feature 2 検証スクリプト

echo "=== Feature 2: 営業代行受注データ反映 - 検証 ==="
echo ""

echo "1. TypeScript コンパイルチェック..."
npx tsc --noEmit 2>&1 | grep -q "error" && echo "❌ エラーあり" || echo "✅ エラーなし"
echo ""

echo "2. Deal #219 データ確認..."
grep -q "deal_number: 219.*amount: 1250000" src/lib/mock-data.ts && echo "✅ Deal #219 の金額が更新されている" || echo "❌ 更新されていない"
grep -q "営業代行契約（新規開拓特化）" src/lib/mock-data.ts && echo "✅ 契約詳細が追加されている" || echo "❌ 追加されていない"
echo ""

echo "3. MOCK_SALES_OUTSOURCING_ORDERS 確認..."
grep -q "export const MOCK_SALES_OUTSOURCING_ORDERS" src/lib/mock-data.ts && echo "✅ エクスポートが追加されている" || echo "❌ 追加されていない"
grep -q "so-001-yuichi" src/lib/mock-data.ts && echo "✅ 営業代行受注データが存在する" || echo "❌ データが存在しない"
echo ""

echo "4. 月次収益データ確認..."
grep -q "rev-so-001-03" src/lib/mock-data.ts && echo "✅ 2026-03 の収益データが追加されている" || echo "❌ 追加されていない"
grep -q "rev-so-001-04" src/lib/mock-data.ts && echo "✅ 2026-04 の収益データが追加されている" || echo "❌ 追加されていない"
grep -q "rev-so-001-05" src/lib/mock-data.ts && echo "✅ 2026-05 の収益データが追加されている" || echo "❌ 追加されていない"
echo ""

echo "5. use-orders.ts の更新確認..."
grep -q "MOCK_SALES_OUTSOURCING_ORDERS" src/hooks/use-orders.ts && echo "✅ import文が更新されている" || echo "❌ 更新されていない"
grep -A5 "デモモード: モックデータを返す" src/hooks/use-orders.ts | grep -q "MOCK_SALES_OUTSOURCING_ORDERS.map" && echo "✅ デモモード処理が更新されている" || echo "❌ 更新されていない"
echo ""

echo "6. ビルド確認..."
npm run build > /tmp/build.log 2>&1 && echo "✅ ビルド成功" || echo "❌ ビルド失敗"
echo ""

echo "=== 検証完了 ==="
