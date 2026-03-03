/**
 * Supabase Database 型定義
 * 全テーブルに Row / Insert / Update / Relationships を定義
 */

export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export type Database = {
  public: {
    Tables: {
      companies: {
        Row: {
          id: string;
          company_name: string;
          phone: string | null;
          email: string | null;
          website: string | null;
          address: string | null;
          industry: string | null;
          employee_count: number | null;
          annual_revenue: number | null;
          notes: string | null;
          created_by: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          company_name: string;
          phone?: string | null;
          email?: string | null;
          website?: string | null;
          address?: string | null;
          industry?: string | null;
          employee_count?: number | null;
          annual_revenue?: number | null;
          notes?: string | null;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          company_name?: string;
          phone?: string | null;
          email?: string | null;
          website?: string | null;
          address?: string | null;
          industry?: string | null;
          employee_count?: number | null;
          annual_revenue?: number | null;
          notes?: string | null;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'companies_created_by_fkey';
            columns: ['created_by'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      contacts: {
        Row: {
          id: string;
          company_id: string;
          last_name: string;
          first_name: string | null;
          position: string | null;
          department: string | null;
          phone: string | null;
          mobile: string | null;
          email: string | null;
          is_key_person: boolean;
          notes: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          company_id: string;
          last_name: string;
          first_name?: string | null;
          position?: string | null;
          department?: string | null;
          phone?: string | null;
          mobile?: string | null;
          email?: string | null;
          is_key_person?: boolean;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          company_id?: string;
          last_name?: string;
          first_name?: string | null;
          position?: string | null;
          department?: string | null;
          phone?: string | null;
          mobile?: string | null;
          email?: string | null;
          is_key_person?: boolean;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'contacts_company_id_fkey';
            columns: ['company_id'];
            isOneToOne: false;
            referencedRelation: 'companies';
            referencedColumns: ['id'];
          },
        ];
      };

      deals: {
        Row: {
          id: string;
          deal_number: number;
          company_id: string;
          contact_id: string | null;
          deal_name: string;
          product: string | null;
          yomi_status: string;
          amount: number | null;
          monthly_amount: number | null;
          initial_amount: number | null;
          closer_id: string | null;
          appointer_id: string | null;
          list_id: string | null;
          expected_close_date: string | null;
          closed_date: string | null;
          contract_start_date: string | null;
          contract_months: number | null;
          notes: string | null;
          lost_reason: string | null;
          created_by: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          deal_number?: number;
          company_id: string;
          contact_id?: string | null;
          deal_name: string;
          product?: string | null;
          yomi_status?: string;
          amount?: number | null;
          monthly_amount?: number | null;
          initial_amount?: number | null;
          closer_id?: string | null;
          appointer_id?: string | null;
          list_id?: string | null;
          expected_close_date?: string | null;
          closed_date?: string | null;
          contract_start_date?: string | null;
          contract_months?: number | null;
          notes?: string | null;
          lost_reason?: string | null;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          deal_number?: number;
          company_id?: string;
          contact_id?: string | null;
          deal_name?: string;
          product?: string | null;
          yomi_status?: string;
          amount?: number | null;
          monthly_amount?: number | null;
          initial_amount?: number | null;
          closer_id?: string | null;
          appointer_id?: string | null;
          list_id?: string | null;
          expected_close_date?: string | null;
          closed_date?: string | null;
          contract_start_date?: string | null;
          contract_months?: number | null;
          notes?: string | null;
          lost_reason?: string | null;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'deals_company_id_fkey';
            columns: ['company_id'];
            isOneToOne: false;
            referencedRelation: 'companies';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'deals_contact_id_fkey';
            columns: ['contact_id'];
            isOneToOne: false;
            referencedRelation: 'contacts';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'deals_closer_id_fkey';
            columns: ['closer_id'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'deals_appointer_id_fkey';
            columns: ['appointer_id'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'deals_list_id_fkey';
            columns: ['list_id'];
            isOneToOne: false;
            referencedRelation: 'lists';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'deals_created_by_fkey';
            columns: ['created_by'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      deal_followups: {
        Row: {
          id: string;
          deal_id: string;
          company_id?: string;
          followup_date?: string;
          followup_type: string;
          content?: string;
          notes: string | null;
          status: string | null;
          round: string;
          next_action: string | null;
          next_action_date: string | null;
          created_by: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          deal_id: string;
          company_id?: string;
          followup_date?: string;
          followup_type: string;
          content?: string;
          notes?: string | null;
          status?: string | null;
          round?: string;
          next_action?: string | null;
          next_action_date?: string | null;
          created_by?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          deal_id?: string;
          company_id?: string;
          followup_date?: string;
          followup_type?: string;
          content?: string;
          notes?: string | null;
          status?: string | null;
          round?: string;
          next_action?: string | null;
          next_action_date?: string | null;
          created_by?: string | null;
          created_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'deal_followups_deal_id_fkey';
            columns: ['deal_id'];
            isOneToOne: false;
            referencedRelation: 'deals';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'deal_followups_created_by_fkey';
            columns: ['created_by'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      ai_tool_orders: {
        Row: {
          id: string;
          deal_id: string;
          company_id: string;
          product: string;
          plan: string | null;
          monthly_fee: number;
          initial_fee: number;
          margin_rate: number;
          monthly_margin: number;
          initial_margin: number;
          contract_start_date: string | null;
          contract_end_date: string | null;
          contract_months: number | null;
          status: string;
          closer_id: string | null;
          appointer_id: string | null;
          notes: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          deal_id: string;
          company_id: string;
          product: string;
          plan?: string | null;
          monthly_fee: number;
          initial_fee?: number;
          margin_rate: number;
          monthly_margin: number;
          initial_margin?: number;
          contract_start_date?: string | null;
          contract_end_date?: string | null;
          contract_months?: number | null;
          status?: string;
          closer_id?: string | null;
          appointer_id?: string | null;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          deal_id?: string;
          company_id?: string;
          product?: string;
          plan?: string | null;
          monthly_fee?: number;
          initial_fee?: number;
          margin_rate?: number;
          monthly_margin?: number;
          initial_margin?: number;
          contract_start_date?: string | null;
          contract_end_date?: string | null;
          contract_months?: number | null;
          status?: string;
          closer_id?: string | null;
          appointer_id?: string | null;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'ai_tool_orders_deal_id_fkey';
            columns: ['deal_id'];
            isOneToOne: false;
            referencedRelation: 'deals';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'ai_tool_orders_company_id_fkey';
            columns: ['company_id'];
            isOneToOne: false;
            referencedRelation: 'companies';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'ai_tool_orders_closer_id_fkey';
            columns: ['closer_id'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'ai_tool_orders_appointer_id_fkey';
            columns: ['appointer_id'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      sales_outsourcing_orders: {
        Row: {
          id: string;
          deal_id: string;
          company_id: string;
          service_type: string;
          monthly_fee: number;
          initial_fee: number;
          commission_rate: number;
          monthly_commission: number;
          initial_commission: number;
          contract_start_date: string | null;
          contract_end_date: string | null;
          contract_months: number | null;
          status: string;
          closer_id: string | null;
          appointer_id: string | null;
          notes: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          deal_id: string;
          company_id: string;
          service_type: string;
          monthly_fee: number;
          initial_fee?: number;
          commission_rate: number;
          monthly_commission: number;
          initial_commission?: number;
          contract_start_date?: string | null;
          contract_end_date?: string | null;
          contract_months?: number | null;
          status?: string;
          closer_id?: string | null;
          appointer_id?: string | null;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          deal_id?: string;
          company_id?: string;
          service_type?: string;
          monthly_fee?: number;
          initial_fee?: number;
          commission_rate?: number;
          monthly_commission?: number;
          initial_commission?: number;
          contract_start_date?: string | null;
          contract_end_date?: string | null;
          contract_months?: number | null;
          status?: string;
          closer_id?: string | null;
          appointer_id?: string | null;
          notes?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'sales_outsourcing_orders_deal_id_fkey';
            columns: ['deal_id'];
            isOneToOne: false;
            referencedRelation: 'deals';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'sales_outsourcing_orders_company_id_fkey';
            columns: ['company_id'];
            isOneToOne: false;
            referencedRelation: 'companies';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'sales_outsourcing_orders_closer_id_fkey';
            columns: ['closer_id'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'sales_outsourcing_orders_appointer_id_fkey';
            columns: ['appointer_id'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      monthly_revenue: {
        Row: {
          id: string;
          year_month: string;
          order_id: string;
          order_type: string;
          company_id: string;
          product: string;
          monthly_fee: number;
          margin_amount: number;
          is_active: boolean;
          created_at: string;
        };
        Insert: {
          id?: string;
          year_month: string;
          order_id: string;
          order_type: string;
          company_id: string;
          product: string;
          monthly_fee: number;
          margin_amount: number;
          is_active?: boolean;
          created_at?: string;
        };
        Update: {
          id?: string;
          year_month?: string;
          order_id?: string;
          order_type?: string;
          company_id?: string;
          product?: string;
          monthly_fee?: number;
          margin_amount?: number;
          is_active?: boolean;
          created_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'monthly_revenue_company_id_fkey';
            columns: ['company_id'];
            isOneToOne: false;
            referencedRelation: 'companies';
            referencedColumns: ['id'];
          },
        ];
      };

      sales_outsourcing_leads: {
        Row: {
          id: string;
          outsourcing_order_id: string;
          lead_date: string;
          company_name: string;
          contact_name: string | null;
          phone: string | null;
          email: string | null;
          status: string;
          notes: string | null;
          created_by: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          outsourcing_order_id: string;
          lead_date: string;
          company_name: string;
          contact_name?: string | null;
          phone?: string | null;
          email?: string | null;
          status?: string;
          notes?: string | null;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          outsourcing_order_id?: string;
          lead_date?: string;
          company_name?: string;
          contact_name?: string | null;
          phone?: string | null;
          email?: string | null;
          status?: string;
          notes?: string | null;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'sales_outsourcing_leads_outsourcing_order_id_fkey';
            columns: ['outsourcing_order_id'];
            isOneToOne: false;
            referencedRelation: 'sales_outsourcing_orders';
            referencedColumns: ['id'];
          },
          {
            foreignKeyName: 'sales_outsourcing_leads_created_by_fkey';
            columns: ['created_by'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      users: {
        Row: {
          id: string;
          email: string;
          display_name: string;
          role: string;
          avatar_url: string | null;
          is_active: boolean;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          email: string;
          display_name: string;
          role?: string;
          avatar_url?: string | null;
          is_active?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          email?: string;
          display_name?: string;
          role?: string;
          avatar_url?: string | null;
          is_active?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [];
      };

      lists: {
        Row: {
          id: string;
          list_name: string;
          description: string | null;
          source: string | null;
          total_count: number;
          is_active: boolean;
          created_by: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          list_name: string;
          description?: string | null;
          source?: string | null;
          total_count?: number;
          is_active?: boolean;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          list_name?: string;
          description?: string | null;
          source?: string | null;
          total_count?: number;
          is_active?: boolean;
          created_by?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'lists_created_by_fkey';
            columns: ['created_by'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };

      dropdown_options: {
        Row: {
          id: string;
          category: string;
          value: string;
          label: string;
          sort_order: number;
          is_active: boolean;
          created_at: string;
        };
        Insert: {
          id?: string;
          category: string;
          value: string;
          label: string;
          sort_order?: number;
          is_active?: boolean;
          created_at?: string;
        };
        Update: {
          id?: string;
          category?: string;
          value?: string;
          label?: string;
          sort_order?: number;
          is_active?: boolean;
          created_at?: string;
        };
        Relationships: [];
      };

      activity_logs: {
        Row: {
          id: string;
          entity_type: string;
          entity_id: string;
          action: string;
          changes: Json | null;
          performed_by: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          entity_type: string;
          entity_id: string;
          action: string;
          changes?: Json | null;
          performed_by?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          entity_type?: string;
          entity_id?: string;
          action?: string;
          changes?: Json | null;
          performed_by?: string | null;
          created_at?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'activity_logs_performed_by_fkey';
            columns: ['performed_by'];
            isOneToOne: false;
            referencedRelation: 'users';
            referencedColumns: ['id'];
          },
        ];
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      [_ in never]: never;
    };
    Enums: {
      [_ in never]: never;
    };
    CompositeTypes: {
      [_ in never]: never;
    };
  };
};

// ===== 便利な型エイリアス =====
export type Tables<T extends keyof Database['public']['Tables']> =
  Database['public']['Tables'][T]['Row'];

export type TablesInsert<T extends keyof Database['public']['Tables']> =
  Database['public']['Tables'][T]['Insert'];

export type TablesUpdate<T extends keyof Database['public']['Tables']> =
  Database['public']['Tables'][T]['Update'];
