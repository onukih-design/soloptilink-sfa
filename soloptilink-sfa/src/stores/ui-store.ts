/**
 * UI ストア
 * Zustand を使用したサイドバー開閉・モバイル判定の状態管理
 */

import { create } from 'zustand';

/** UI の状態 */
type UIState = {
  sidebarOpen: boolean;
  isMobile: boolean;
};

/** UI のアクション */
type UIActions = {
  setSidebarOpen: (open: boolean) => void;
  toggleSidebar: () => void;
  setIsMobile: (isMobile: boolean) => void;
};

type UIStore = UIState & UIActions;

/**
 * UI ストア
 * サイドバーの開閉状態とモバイル判定を管理
 */
export const useUIStore = create<UIStore>((set) => ({
  sidebarOpen: true,
  isMobile: false,

  setSidebarOpen: (open) => set({ sidebarOpen: open }),

  toggleSidebar: () =>
    set((state) => ({ sidebarOpen: !state.sidebarOpen })),

  setIsMobile: (isMobile) =>
    set({
      isMobile,
      // モバイルの場合はサイドバーを閉じる
      sidebarOpen: isMobile ? false : true,
    }),
}));
