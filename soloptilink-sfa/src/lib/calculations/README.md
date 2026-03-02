# 売上計算エンジン (Revenue Engine)

SoloptiLink SFAの売上・粗利計算を行う純粋関数群。

## 概要

ビジネスロジック（FULL_REQUIREMENTS.md Section 8）に基づき、以下の計算を実装:

- **ショット売上**: 初期費用 × マージン率(50%) → 受注月に計上
- **ストック売上**: 月額 × マージン率 → 契約開始月から毎月計上
- **ヨミ加重**: 受注(100%), Aヨミ(80%), Bヨミ(50%), Cヨミ(20%), ネタ(10%), 没ネタ(5%), 失注/消滅(0%)

## 関数一覧

### 1. `calculateMonthlyRevenue(deals, orders, targetMonth)`

指定月の売上・粗利を計算する。

```typescript
import { calculateMonthlyRevenue } from '@/lib/calculations/revenue-engine';

const result = calculateMonthlyRevenue(
  deals,        // Deal[]
  orders,       // AiToolOrder[]
  '2025-01'     // YYYY-MM形式
);

console.log(result);
// {
//   yearMonth: '2025-01',
//   shotRevenue: 150000,      // ショット売上
//   shotMargin: 75000,        // ショット粗利
//   stockRevenue: 280000,     // ストック売上
//   stockMargin: 70000,       // ストック粗利
//   totalRevenue: 430000,     // 合計売上
//   totalMargin: 145000,      // 合計粗利
//   marginRate: 0.337,        // 粗利率
//   newContracts: 2,          // 新規契約数
//   activeContracts: 5        // 契約中件数
// }
```

### 2. `calculateRevenueTrend(deals, orders, months)`

過去N月分の売上推移を計算する。

```typescript
import { calculateRevenueTrend } from '@/lib/calculations/revenue-engine';

const trend = calculateRevenueTrend(
  deals,
  orders,
  12  // 過去12ヶ月
);

// グラフ描画用にそのまま使える
<LineChart data={trend}>
  <Line dataKey="totalRevenue" />
  <Line dataKey="totalMargin" />
</LineChart>
```

### 3. `calculateWeightedPipeline(deals)`

ヨミ加重金額を計算する（売上予測）。

```typescript
import { calculateWeightedPipeline } from '@/lib/calculations/revenue-engine';

const pipeline = calculateWeightedPipeline(deals);

console.log(pipeline);
// {
//   totalPipeline: 10000000,        // パイプライン総額
//   weightedPipeline: 6500000,      // 加重パイプライン（想定受注金額）
//   byYomi: {
//     '受注': {
//       count: 3,
//       totalAmount: 3000000,
//       weightedAmount: 3000000,
//       rate: 1.0
//     },
//     'Aヨミ': {
//       count: 5,
//       totalAmount: 4000000,
//       weightedAmount: 3200000,
//       rate: 0.8
//     },
//     ...
//   }
// }
```

### 4. `calculateProductRevenue(orders)`

商材別の収益分析を行う。

```typescript
import { calculateProductRevenue } from '@/lib/calculations/revenue-engine';

const products = calculateProductRevenue(orders);

console.log(products);
// [
//   {
//     product: 'ai_teleapo',
//     productName: 'AIテレアポ',
//     activeCount: 15,
//     monthlyFee: 3000000,
//     monthlyMargin: 600000,
//     marginRate: 0.2
//   },
//   ...
// ]
// ※月額粗利が大きい順にソート済み
```

### 5. `calculateShotStockRevenue(deals, orders, targetMonth)`

ショット/ストックを分離して計算する。

```typescript
import { calculateShotStockRevenue } from '@/lib/calculations/revenue-engine';

const result = calculateShotStockRevenue(deals, orders, '2025-01');

console.log(result);
// {
//   yearMonth: '2025-01',
//   shot: { revenue: 150000, margin: 75000, count: 2 },
//   stock: { revenue: 280000, margin: 70000, count: 5 },
//   total: { revenue: 430000, margin: 145000 }
// }
```

## 型定義

```typescript
export type MonthlyRevenueResult = {
  yearMonth: string;
  shotRevenue: number;
  shotMargin: number;
  stockRevenue: number;
  stockMargin: number;
  totalRevenue: number;
  totalMargin: number;
  marginRate: number;
  newContracts: number;
  activeContracts: number;
};

export type WeightedPipelineResult = {
  totalPipeline: number;
  weightedPipeline: number;
  byYomi: Record<string, {
    count: number;
    totalAmount: number;
    weightedAmount: number;
    rate: number;
  }>;
};

export type ProductRevenueResult = {
  product: string;
  productName: string;
  activeCount: number;
  monthlyFee: number;
  monthlyMargin: number;
  marginRate: number;
};

export type ShotStockResult = {
  yearMonth: string;
  shot: { revenue: number; margin: number; count: number };
  stock: { revenue: number; margin: number; count: number };
  total: { revenue: number; margin: number };
};
```

## 使用例

### ダッシュボードでの利用

```typescript
// src/app/(dashboard)/dashboard/page.tsx
import { calculateMonthlyRevenue, calculateWeightedPipeline } from '@/lib/calculations/revenue-engine';

export default function DashboardPage() {
  const { data: deals } = useDeals();
  const { data: orders } = useOrders();

  const currentMonth = '2025-01';
  const revenue = calculateMonthlyRevenue(deals, orders, currentMonth);
  const pipeline = calculateWeightedPipeline(deals);

  return (
    <div>
      <KpiCard title="今月売上" value={revenue.totalRevenue} />
      <KpiCard title="今月粗利" value={revenue.totalMargin} />
      <KpiCard title="粗利率" value={`${(revenue.marginRate * 100).toFixed(1)}%`} />
      <KpiCard title="想定受注" value={pipeline.weightedPipeline} />
    </div>
  );
}
```

### 売上ダッシュボードでの利用

```typescript
// src/app/(dashboard)/revenue/page.tsx
import { calculateRevenueTrend, calculateProductRevenue } from '@/lib/calculations/revenue-engine';

export default function RevenuePage() {
  const { data: deals } = useDeals();
  const { data: orders } = useOrders();

  const trend = calculateRevenueTrend(deals, orders, 12);
  const products = calculateProductRevenue(orders);

  return (
    <div>
      <LineChart data={trend}>
        <Line dataKey="totalRevenue" name="売上" />
        <Line dataKey="totalMargin" name="粗利" />
      </LineChart>

      <BarChart data={products}>
        <Bar dataKey="monthlyMargin" name="月額粗利" />
      </BarChart>
    </div>
  );
}
```

## テスト

純粋関数のため、副作用なしでテスト可能です。

```typescript
// 手動テスト例
const mockDeals = [
  {
    id: '1',
    yomi_status: '受注',
    amount: 1000000,
    initial_amount: 100000,
    closed_date: '2025-01-15',
    // ...
  },
];

const mockOrders = [
  {
    id: '1',
    status: '契約中',
    monthly_fee: 200000,
    margin_rate: 0.2,
    contract_start_date: '2025-01-01',
    contract_end_date: null,
    // ...
  },
];

const result = calculateMonthlyRevenue(mockDeals, mockOrders, '2025-01');
console.assert(result.shotRevenue === 100000);
console.assert(result.shotMargin === 50000);
console.assert(result.stockRevenue === 200000);
console.assert(result.stockMargin === 40000);
```

## 注意事項

- 金額はすべて整数（円単位）で計算
- 日付は ISO 8601形式（YYYY-MM-DD）を想定
- `targetMonth` は 'YYYY-MM' 形式で指定
- 契約開始/終了日が `null` の場合は、適切にハンドリングされる
- マージン率は `constants/margins.ts` から自動取得

## 参照

- [FULL_REQUIREMENTS.md Section 8](../../../docs/FULL_REQUIREMENTS.md#8-ヨミ定義ビジネスロジック)
- [商材マージン率定義](../constants/margins.ts)
- [ヨミステータス定義](../constants/yomi.ts)
