import { z } from 'zod'

export const dealFormSchema = z.object({
  deal_name: z
    .string()
    .min(1, '案件名を入力してください')
    .max(200, '200文字以内で入力してください'),
  company_id: z.string().min(1, '企業を選択してください'),
  contact_id: z.string().min(1).nullable().optional(),
  product: z.string().min(1, '商品を選択してください'),
  yomi_status: z.enum(
    ['受注', 'Aヨミ', 'Bヨミ', 'Cヨミ', 'ネタ', '没ネタ', '失注', '消滅'],
    {
      message: 'ヨミステータスを選択してください',
    }
  ),
  amount: z.coerce
    .number()
    .int()
    .min(0, '0以上の金額を入力してください')
    .default(0),
  monthly_amount: z.coerce
    .number()
    .int()
    .min(0, '0以上の金額を入力してください')
    .default(0),
  initial_amount: z.coerce
    .number()
    .int()
    .min(0, '0以上の金額を入力してください')
    .default(0),
  closer_id: z.string().min(1).nullable().optional(),
  appointer_id: z.string().min(1).nullable().optional(),
  list_id: z.string().min(1).nullable().optional(),
  expected_close_date: z.string().nullable().optional(),
  closed_date: z.string().nullable().optional(),
  contract_start_date: z.string().nullable().optional(),
  contract_months: z.coerce.number().int().min(0).nullable().optional(),
  memo: z
    .string()
    .max(2000, '2000文字以内で入力してください')
    .nullable()
    .optional(),
})

export type DealFormValues = z.infer<typeof dealFormSchema>

export const followupFormSchema = z.object({
  deal_id: z.string().min(1),
  followup_date: z.string().min(1, '日付を入力してください'),
  followup_type: z.enum(['電話', 'メール', '訪問', 'Web会議', 'その他'], {
    message: '種別を選択してください',
  }),
  content: z
    .string()
    .min(1, '内容を入力してください')
    .max(2000, '2000文字以内で入力してください'),
  next_action: z.string().max(500).nullable().optional(),
  next_action_date: z.string().nullable().optional(),
})

export type FollowupFormValues = z.infer<typeof followupFormSchema>
