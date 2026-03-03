# Order Forms

This directory contains form components for creating new orders in the SoloptiLink SFA system.

## Components

### AiToolOrderForm

Sheet-based form for creating AI tool orders.

**Usage:**

```tsx
import { AiToolOrderForm } from '@/components/orders/ai-tool-order-form'
import type { AiToolOrderFormData } from '@/components/orders/ai-tool-order-form'

function MyComponent() {
  const [open, setOpen] = useState(false)

  const handleSubmit = (data: AiToolOrderFormData) => {
    console.log('AI Tool Order:', data)
    // Submit to API
    setOpen(false)
  }

  return (
    <>
      <Button onClick={() => setOpen(true)}>New AI Tool Order</Button>
      <AiToolOrderForm
        open={open}
        onOpenChange={setOpen}
        onSubmit={handleSubmit}
        isSubmitting={false}
      />
    </>
  )
}
```

**Features:**

- Company search with live filtering
- Product selection from predefined AI tools (PRODUCT_OPTIONS)
- Auto-calculation of margins based on product margin rates
- Auto-calculation of initial margin (50% of initial fee)
- Contract date and duration tracking
- Order status management
- Toast notifications for validation errors

**Form Data:**

```ts
type AiToolOrderFormData = {
  company_id: string
  product: string // Product key from PRODUCT_OPTIONS
  plan: string | null
  monthly_fee: number
  initial_fee: number
  margin_rate: number // Auto-populated from product, editable
  monthly_margin: number // Auto-calculated: monthly_fee * margin_rate
  initial_margin: number // Auto-calculated: initial_fee * 0.5
  contract_start_date: string | null
  contract_months: number | null
  status: string // 契約中, 解約予定, 解約済み, 休止中
  closer_id: string | null
  appointer_id: string | null
  notes: string | null
}
```

---

### OutsourcingOrderForm

Sheet-based form for creating sales outsourcing orders.

**Usage:**

```tsx
import { OutsourcingOrderForm } from '@/components/orders/outsourcing-order-form'
import type { OutsourcingOrderFormData } from '@/components/orders/outsourcing-order-form'

function MyComponent() {
  const [open, setOpen] = useState(false)

  const handleSubmit = (data: OutsourcingOrderFormData) => {
    console.log('Outsourcing Order:', data)
    // Submit to API
    setOpen(false)
  }

  return (
    <>
      <Button onClick={() => setOpen(true)}>New Outsourcing Order</Button>
      <OutsourcingOrderForm
        open={open}
        onOpenChange={setOpen}
        onSubmit={handleSubmit}
        isSubmitting={false}
      />
    </>
  )
}
```

**Features:**

- Company search with live filtering
- Free-text product input (outsourcing products vary)
- Default margin rate of 50% (editable)
- Auto-calculation of margins
- Auto-calculation of initial margin (50% of initial fee)
- Default contract duration of 6 months
- Order status management
- Toast notifications for validation errors

**Form Data:**

```ts
type OutsourcingOrderFormData = {
  company_id: string
  product: string // Free text
  monthly_fee: number
  initial_fee: number
  margin_rate: number // Default 0.5, editable
  monthly_margin: number // Auto-calculated: monthly_fee * margin_rate
  initial_margin: number // Auto-calculated: initial_fee * 0.5
  contract_start_date: string | null
  contract_months: number | null // Default 6
  status: string // 契約中, 解約予定, 解約済み, 休止中
  closer_id: string | null
  appointer_id: string | null
  notes: string | null
}
```

---

## Dependencies

Both forms rely on:

- `@/components/ui/sheet` - Radix UI Sheet component
- `@/components/ui/button` - Button component
- `@/components/ui/input` - Input component
- `@/components/ui/label` - Label component with `.required` CSS class for asterisk
- `@/components/ui/select` - Radix UI Select component
- `@/components/ui/textarea` - Textarea component
- `@/hooks/use-companies` - Company list query hook
- `@/lib/constants/margins` - Product options and margin rates
- `sonner` - Toast notifications
- `lucide-react` - Search icon

## Validation

Both forms validate:

- Company must be selected
- Product must be provided (selected or entered)
- Monthly fee must be greater than 0
- Margin rate must be provided

Validation errors are shown via toast notifications.

## Auto-calculations

### Monthly Margin
`monthly_margin = monthly_fee × margin_rate`

### Initial Margin
`initial_margin = initial_fee × 0.5` (50% fixed rate)

### Margin Rate (AI Tool only)
When a product is selected from PRODUCT_OPTIONS, the margin_rate is automatically populated based on the product's defined margin rate. Users can still edit this value if needed.
