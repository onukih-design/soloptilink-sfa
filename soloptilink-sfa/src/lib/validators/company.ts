import { z } from 'zod'

export const companyFormSchema = z.object({
  company_name: z
    .string()
    .min(1, '会社名を入力してください')
    .max(200, '200文字以内で入力してください'),
  phone: z.string().nullable().optional(),
  email: z
    .string()
    .email('正しいメールアドレスを入力してください')
    .nullable()
    .optional()
    .or(z.literal('')),
  website: z
    .string()
    .url('正しいURLを入力してください')
    .nullable()
    .optional()
    .or(z.literal('')),
  address: z
    .string()
    .max(500, '500文字以内で入力してください')
    .nullable()
    .optional(),
  industry: z.string().nullable().optional(),
  employee_count: z.coerce
    .number()
    .int()
    .min(0, '0以上の数値を入力してください')
    .nullable()
    .optional(),
  annual_revenue: z.coerce
    .number()
    .int()
    .min(0, '0以上の金額を入力してください')
    .nullable()
    .optional(),
  notes: z
    .string()
    .max(2000, '2000文字以内で入力してください')
    .nullable()
    .optional(),
})

export type CompanyFormValues = z.infer<typeof companyFormSchema>
