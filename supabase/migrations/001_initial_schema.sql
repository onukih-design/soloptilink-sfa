-- ============================================================
-- SolOptiLink SFA - Initial Schema Migration
-- ============================================================

-- ============================================================
-- 0. updated_at 自動更新トリガー関数
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- 1. users テーブル
-- ============================================================
CREATE TABLE users (
  id         uuid        PRIMARY KEY REFERENCES auth.users(id),
  email      text        NOT NULL,
  name       text        NOT NULL,
  role       text        NOT NULL CHECK (role IN ('admin', 'closer', 'appointer', 'manager')),
  is_active  boolean     NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_users_updated_at
  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 2. companies テーブル
-- ============================================================
CREATE TABLE companies (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  phone      text,
  mobile     text,
  address    text,
  url        text,
  industry   text,
  notes      text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_companies_updated_at
  BEFORE UPDATE ON companies
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 3. contacts テーブル
-- ============================================================
CREATE TABLE contacts (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid        NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name       text        NOT NULL,
  position   text,
  department text,
  email      text,
  phone      text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_contacts_updated_at
  BEFORE UPDATE ON contacts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 4. lists テーブル
-- ============================================================
CREATE TABLE lists (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  type       text,
  is_active  boolean     NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_lists_updated_at
  BEFORE UPDATE ON lists
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 5. dropdown_options テーブル
-- ============================================================
CREATE TABLE dropdown_options (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  category   text        NOT NULL,
  value      text        NOT NULL,
  sort_order int         NOT NULL DEFAULT 0,
  is_active  boolean     NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- ============================================================
-- 6. deals テーブル
-- ============================================================
CREATE SEQUENCE deals_deal_number_seq;

CREATE TABLE deals (
  id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  deal_number     int         NOT NULL DEFAULT nextval('deals_deal_number_seq'),
  company_id      uuid        NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  contact_id      uuid        REFERENCES contacts(id) ON DELETE SET NULL,
  gender          text,
  appointer_id    uuid        NOT NULL REFERENCES users(id),
  appo_date       date        NOT NULL,
  meeting_date    date,
  meeting_time    time,
  appo_type       text,
  appo_target     text,
  list_id         uuid        REFERENCES lists(id) ON DELETE SET NULL,
  memo            text,
  reminder_status text,
  closer_id       uuid        REFERENCES users(id),
  meeting_result  text,
  order_result    text,
  yomi_status     text        NOT NULL DEFAULT 'ネタ',
  loss_reason     text,
  next_action     text,
  next_action_date date,
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now()
);

ALTER SEQUENCE deals_deal_number_seq OWNED BY deals.deal_number;

CREATE TRIGGER trg_deals_updated_at
  BEFORE UPDATE ON deals
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 7. deal_followups テーブル
-- ============================================================
CREATE TABLE deal_followups (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  deal_id          uuid        NOT NULL REFERENCES deals(id) ON DELETE CASCADE,
  followup_number  int         NOT NULL CHECK (followup_number BETWEEN 1 AND 5),
  followup_date    date,
  assignee_id      uuid        REFERENCES users(id),
  status           text,
  note             text,
  email_content    text,
  email_attachment text,
  loss_reason      text,
  next_action      text,
  next_action_date date,
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now(),
  UNIQUE (deal_id, followup_number)
);

CREATE TRIGGER trg_deal_followups_updated_at
  BEFORE UPDATE ON deal_followups
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 8. ai_tool_orders テーブル
-- ============================================================
CREATE TABLE ai_tool_orders (
  id                       uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id               uuid        NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  list_source              text,
  verbal_agreement_date    date,
  status                   text,
  cancellation_month       date,
  initial_payment_date     date,
  monthly_payment_start    date,
  initial_fee_lightup      int         NOT NULL DEFAULT 0,
  initial_fee_ai_teleapo   int         NOT NULL DEFAULT 0,
  monthly_fees             jsonb       NOT NULL DEFAULT '{}',
  margin_amounts           jsonb       NOT NULL DEFAULT '{}',
  created_at               timestamptz NOT NULL DEFAULT now(),
  updated_at               timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_ai_tool_orders_updated_at
  BEFORE UPDATE ON ai_tool_orders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 9. sales_outsourcing_orders テーブル
-- ============================================================
CREATE TABLE sales_outsourcing_orders (
  id                  uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id          uuid        NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  initial_fee         int         NOT NULL DEFAULT 0,
  monthly_fee         int         NOT NULL DEFAULT 0,
  contract_start_date date,
  contract_end_date   date,
  project_status      text,
  notes               text,
  created_at          timestamptz NOT NULL DEFAULT now(),
  updated_at          timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_sales_outsourcing_orders_updated_at
  BEFORE UPDATE ON sales_outsourcing_orders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 10. monthly_revenue テーブル
-- ============================================================
CREATE TABLE monthly_revenue (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id      uuid        NOT NULL,
  order_type    text        NOT NULL CHECK (order_type IN ('ai_tool', 'outsourcing')),
  year_month    date        NOT NULL,
  shot_revenue  int         NOT NULL DEFAULT 0,
  stock_revenue int         NOT NULL DEFAULT 0,
  total_revenue int         NOT NULL DEFAULT 0,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_monthly_revenue_updated_at
  BEFORE UPDATE ON monthly_revenue
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 11. sales_outsourcing_leads テーブル
-- ============================================================
CREATE TABLE sales_outsourcing_leads (
  id                   uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  deal_id              uuid        NOT NULL REFERENCES deals(id) ON DELETE CASCADE,
  outsourcing_order_id uuid        REFERENCES sales_outsourcing_orders(id) ON DELETE SET NULL,
  lead_status          text,
  meeting_notes        text,
  extracted_at         timestamptz,
  created_at           timestamptz NOT NULL DEFAULT now(),
  updated_at           timestamptz NOT NULL DEFAULT now()
);

CREATE TRIGGER trg_sales_outsourcing_leads_updated_at
  BEFORE UPDATE ON sales_outsourcing_leads
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 12. activity_logs テーブル
-- ============================================================
CREATE TABLE activity_logs (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      uuid        NOT NULL REFERENCES users(id),
  action_type  text        NOT NULL,
  target_table text        NOT NULL,
  target_id    uuid        NOT NULL,
  changes      jsonb,
  description  text,
  ip_address   text,
  created_at   timestamptz NOT NULL DEFAULT now()
);

-- ============================================================
-- インデックス
-- ============================================================
CREATE INDEX idx_deals_yomi_status   ON deals (yomi_status);
CREATE INDEX idx_deals_company_id    ON deals (company_id);
CREATE INDEX idx_deals_closer_id     ON deals (closer_id);
CREATE INDEX idx_deals_appointer_id  ON deals (appointer_id);
CREATE INDEX idx_deals_appo_date     ON deals (appo_date);
CREATE INDEX idx_ai_tool_orders_company_id ON ai_tool_orders (company_id);
CREATE INDEX idx_activity_logs_target      ON activity_logs (target_table, target_id);

-- ============================================================
-- RLS (Row Level Security) 有効化
-- ============================================================
ALTER TABLE users                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE companies               ENABLE ROW LEVEL SECURITY;
ALTER TABLE contacts                ENABLE ROW LEVEL SECURITY;
ALTER TABLE lists                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE dropdown_options        ENABLE ROW LEVEL SECURITY;
ALTER TABLE deals                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE deal_followups          ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_tool_orders          ENABLE ROW LEVEL SECURITY;
ALTER TABLE sales_outsourcing_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE monthly_revenue         ENABLE ROW LEVEL SECURITY;
ALTER TABLE sales_outsourcing_leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_logs           ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- RLS ポリシー: 認証済みユーザーは全データ閲覧・操作可能（社内ツール）
-- ============================================================

-- users
CREATE POLICY "authenticated_select_users" ON users
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_users" ON users
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_users" ON users
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_users" ON users
  FOR DELETE TO authenticated USING (true);

-- companies
CREATE POLICY "authenticated_select_companies" ON companies
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_companies" ON companies
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_companies" ON companies
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_companies" ON companies
  FOR DELETE TO authenticated USING (true);

-- contacts
CREATE POLICY "authenticated_select_contacts" ON contacts
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_contacts" ON contacts
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_contacts" ON contacts
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_contacts" ON contacts
  FOR DELETE TO authenticated USING (true);

-- lists
CREATE POLICY "authenticated_select_lists" ON lists
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_lists" ON lists
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_lists" ON lists
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_lists" ON lists
  FOR DELETE TO authenticated USING (true);

-- dropdown_options
CREATE POLICY "authenticated_select_dropdown_options" ON dropdown_options
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_dropdown_options" ON dropdown_options
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_dropdown_options" ON dropdown_options
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_dropdown_options" ON dropdown_options
  FOR DELETE TO authenticated USING (true);

-- deals
CREATE POLICY "authenticated_select_deals" ON deals
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_deals" ON deals
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_deals" ON deals
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_deals" ON deals
  FOR DELETE TO authenticated USING (true);

-- deal_followups
CREATE POLICY "authenticated_select_deal_followups" ON deal_followups
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_deal_followups" ON deal_followups
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_deal_followups" ON deal_followups
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_deal_followups" ON deal_followups
  FOR DELETE TO authenticated USING (true);

-- ai_tool_orders
CREATE POLICY "authenticated_select_ai_tool_orders" ON ai_tool_orders
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_ai_tool_orders" ON ai_tool_orders
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_ai_tool_orders" ON ai_tool_orders
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_ai_tool_orders" ON ai_tool_orders
  FOR DELETE TO authenticated USING (true);

-- sales_outsourcing_orders
CREATE POLICY "authenticated_select_sales_outsourcing_orders" ON sales_outsourcing_orders
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_sales_outsourcing_orders" ON sales_outsourcing_orders
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_sales_outsourcing_orders" ON sales_outsourcing_orders
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_sales_outsourcing_orders" ON sales_outsourcing_orders
  FOR DELETE TO authenticated USING (true);

-- monthly_revenue
CREATE POLICY "authenticated_select_monthly_revenue" ON monthly_revenue
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_monthly_revenue" ON monthly_revenue
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_monthly_revenue" ON monthly_revenue
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_monthly_revenue" ON monthly_revenue
  FOR DELETE TO authenticated USING (true);

-- sales_outsourcing_leads
CREATE POLICY "authenticated_select_sales_outsourcing_leads" ON sales_outsourcing_leads
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_sales_outsourcing_leads" ON sales_outsourcing_leads
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_sales_outsourcing_leads" ON sales_outsourcing_leads
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_sales_outsourcing_leads" ON sales_outsourcing_leads
  FOR DELETE TO authenticated USING (true);

-- activity_logs
CREATE POLICY "authenticated_select_activity_logs" ON activity_logs
  FOR SELECT TO authenticated USING (true);
CREATE POLICY "authenticated_insert_activity_logs" ON activity_logs
  FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "authenticated_update_activity_logs" ON activity_logs
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "authenticated_delete_activity_logs" ON activity_logs
  FOR DELETE TO authenticated USING (true);

-- ============================================================
-- dropdown_options 初期データ
-- ============================================================

-- yomi_status
INSERT INTO dropdown_options (category, value, sort_order) VALUES
  ('yomi_status', '受注',   1),
  ('yomi_status', 'Aヨミ',  2),
  ('yomi_status', 'Bヨミ',  3),
  ('yomi_status', 'Cヨミ',  4),
  ('yomi_status', 'ネタ',   5),
  ('yomi_status', '没ネタ', 6),
  ('yomi_status', '失注',   7),
  ('yomi_status', '消滅',   8);

-- appo_type
INSERT INTO dropdown_options (category, value, sort_order) VALUES
  ('appo_type', '確定アポ', 1),
  ('appo_type', 'アポ調',   2);

-- appo_target
INSERT INTO dropdown_options (category, value, sort_order) VALUES
  ('appo_target', '社長',   1),
  ('appo_target', '責任者', 2),
  ('appo_target', '担当者', 3);

-- meeting_result
INSERT INTO dropdown_options (category, value, sort_order) VALUES
  ('meeting_result', '商談可',   1),
  ('meeting_result', '商談不可', 2);

-- order_result
INSERT INTO dropdown_options (category, value, sort_order) VALUES
  ('order_result', '受注', 1),
  ('order_result', '失注', 2);

-- reminder_status
INSERT INTO dropdown_options (category, value, sort_order) VALUES
  ('reminder_status', '済', 1),
  ('reminder_status', '未', 2);
