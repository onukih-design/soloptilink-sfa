import { z } from 'zod'

export const contactFormSchema = z.object({
  company_id: z.string().uuid('会社を選択してください'),
  last_name: z
    .string()
    .min(1, '姓を入力してください')
    .max(50, '50文字以内で入力してください'),
  first_name: z
    .string()
    .max(50, '50文字以内で入力してください')
    .nullable()
    .optional(),
  position: z
    .string()
    .max(100, '100文字以内で入力してください')
    .nullable()
    .optional(),
  department: z
    .string()
    .max(100, '100文字以内で入力してください')
    .nullable()
    .optional(),
  phone: z.string().nullable().optional(),
  mobile: z.string().nullable().optional(),
  email: z
    .string()
    .email('正しいメールアドレスを入力してください')
    .nullable()
    .optional()
    .or(z.literal('')),
  is_key_person: z.boolean().default(false),
  notes: z
    .string()
    .max(2000, '2000文字以内で入力してください')
    .nullable()
    .optional(),
})

export type ContactFormValues = z.infer<typeof contactFormSchema>
