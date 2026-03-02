"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  LayoutDashboard,
  Briefcase,
  Building2,
  Bot,
  Users,
  Package,
  TrendingUp,
  BarChart3,
  Filter,
  Settings,
  Crown,
} from "lucide-react";
import { cn } from "@/lib/utils";

interface NavItem {
  label: string;
  href: string;
  icon: React.ComponentType<{ className?: string }>;
}

const navItems: NavItem[] = [
  {
    label: "ダッシュボード",
    href: "/dashboard",
    icon: LayoutDashboard,
  },
  {
    label: "経営ダッシュボード",
    href: "/executive",
    icon: Crown,
  },
  {
    label: "会社管理",
    href: "/companies",
    icon: Building2,
  },
  {
    label: "案件一覧",
    href: "/deals",
    icon: Briefcase,
  },
  {
    label: "AIツール受注",
    href: "/orders/ai-tools",
    icon: Bot,
  },
  {
    label: "営業代行受注",
    href: "/orders/outsourcing",
    icon: Users,
  },
  {
    label: "統合受注管理",
    href: "/orders/all",
    icon: Package,
  },
  {
    label: "売上ダッシュボード",
    href: "/revenue",
    icon: TrendingUp,
  },
  {
    label: "分析レポート",
    href: "/analytics",
    icon: BarChart3,
  },
  {
    label: "営業代行管理",
    href: "/leads/outsourcing",
    icon: Filter,
  },
  {
    label: "マスタ管理",
    href: "/settings",
    icon: Settings,
  },
];

export function Sidebar() {
  const pathname = usePathname();

  return (
    <aside
      className={cn(
        "fixed inset-y-0 left-0 z-40 flex flex-col border-r bg-white",
        "w-16 md:w-16 lg:w-60"
      )}
    >
      {/* Logo */}
      <div className="flex h-16 items-center border-b px-4">
        <Link href="/dashboard" className="flex items-center gap-2">
          <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-primary text-primary-foreground font-bold text-sm">
            SL
          </div>
          <span className="hidden lg:block text-lg font-bold text-gray-900">
            SoloptiLink
          </span>
        </Link>
      </div>

      {/* Navigation */}
      <nav className="flex-1 overflow-y-auto py-4">
        <ul className="space-y-1 px-2">
          {navItems.map((item) => {
            const isActive =
              pathname === item.href || pathname.startsWith(`${item.href}/`);
            const Icon = item.icon;

            return (
              <li key={item.href}>
                <Link
                  href={item.href}
                  className={cn(
                    "flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors",
                    "hover:bg-gray-100 hover:text-gray-900",
                    isActive
                      ? "bg-primary/10 text-primary"
                      : "text-gray-600"
                  )}
                  title={item.label}
                >
                  <Icon className="h-5 w-5 shrink-0" />
                  <span className="hidden lg:block truncate">
                    {item.label}
                  </span>
                </Link>
              </li>
            );
          })}
        </ul>
      </nav>
    </aside>
  );
}
