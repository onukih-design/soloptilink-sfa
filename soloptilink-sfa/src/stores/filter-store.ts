/**
 * フィルタストア
 * Zustand を使用した案件一覧のフィルタ状態管理
 */

import { create } from 'zustand';
import type { YomiStatus } from '@/types/deals';

/** フィルタの状態 */
type FilterState = {
  yomiStatus: YomiStatus | null;
  closerId: string | null;
  appointerId: string | null;
  listId: string | null;
  month: string | null;
  keyword: string;
};

/** フィルタのアクション */
type FilterActions = {
  setYomiStatus: (status: YomiStatus | null) => void;
  setCloserId: (id: string | null) => void;
  setAppointerId: (id: string | null) => void;
  setListId: (id: string | null) => void;
  setMonth: (month: string | null) => void;
  setKeyword: (keyword: string) => void;
  resetFilters: () => void;
  hasActiveFilters: () => boolean;
};

type FilterStore = FilterState & FilterActions;

/** フィルタの初期値 */
const initialState: FilterState = {
  yomiStatus: null,
  closerId: null,
  appointerId: null,
  listId: null,
  month: null,
  keyword: '',
};

/**
 * 案件一覧のフィルタストア
 */
export const useFilterStore = create<FilterStore>((set, get) => ({
  ...initialState,

  setYomiStatus: (status) => set({ yomiStatus: status }),

  setCloserId: (id) => set({ closerId: id }),

  setAppointerId: (id) => set({ appointerId: id }),

  setListId: (id) => set({ listId: id }),

  setMonth: (month) => set({ month }),

  setKeyword: (keyword) => set({ keyword }),

  resetFilters: () => set(initialState),

  hasActiveFilters: () => {
    const state = get();
    return (
      state.yomiStatus !== null ||
      state.closerId !== null ||
      state.appointerId !== null ||
      state.listId !== null ||
      state.month !== null ||
      state.keyword !== ''
    );
  },
}));
