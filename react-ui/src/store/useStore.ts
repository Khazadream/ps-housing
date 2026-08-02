import { create } from 'zustand';
import type {
  ICartItem,
  IFurniture,
  IFurnitures,
  IOwnedFurniture,
  RailView,
} from '@customTypes/types';
import { ALL_CATEGORIES, asArray } from '@customTypes/types';

interface StoreState {
  visibility: boolean;
  browserMode: boolean;
  resName: string;

  furnitures: IFurnitures[] | null;
  currentFurniture: IFurniture | null;

  /** Rail folded down to the 72px icon strip (placement or freecam). */
  isRailCollapsed: boolean;
  /** Which view the rail body shows. */
  railView: RailView;
  searchTerm: string;
  /** Index into `furnitures`, or ALL_CATEGORIES. */
  selectedCategory: number;

  cart: ICartItem[];
  ownedItems: IOwnedFurniture[];
  /** How many "storage" props this property accepts (per-door on evange-housing). */
  maxStash: number;

  setVisibility: (visible: boolean) => void;
  setMaxStash: (max: number) => void;
  setBrowserMode: (mode: boolean) => void;
  setResName: (name: string) => void;
  setFurnitures: (data: unknown) => void;
  setCurrentFurniture: (data: IFurniture | null) => void;
  setIsRailCollapsed: (val: boolean) => void;
  setRailView: (view: RailView) => void;
  setSearchTerm: (term: string) => void;
  setSelectedCategory: (index: number) => void;
  addToCart: (item: ICartItem) => void;
  removeFromCart: (entity: number) => void;
  clearCart: () => void;
  setCart: (cart: ICartItem[]) => void;
  setOwnedItems: (items: unknown) => void;
  removeOwnedItem: (id: string) => void;
}

export const useStore = create<StoreState>((set) => ({
  visibility: false,
  browserMode: false,
  resName: '',

  furnitures: null,
  currentFurniture: null,

  isRailCollapsed: false,
  railView: 'catalog',
  searchTerm: '',
  selectedCategory: ALL_CATEGORIES,

  cart: [],
  ownedItems: [],
  maxStash: 2,

  setVisibility: (visible) => set({ visibility: visible }),
  setMaxStash: (max) => set({ maxStash: max }),
  setBrowserMode: (mode) => set({ browserMode: mode }),
  setResName: (name) => set({ resName: name }),
  setFurnitures: (data) => set({ furnitures: asArray<IFurnitures>(data) }),
  setCurrentFurniture: (data) => set({ currentFurniture: data }),
  setIsRailCollapsed: (val) => set({ isRailCollapsed: val }),
  setRailView: (view) => set({ railView: view }),
  setSearchTerm: (term) => set({ searchTerm: term }),
  setSelectedCategory: (index) => set({ selectedCategory: index }),
  addToCart: (item) => set((state) => ({ cart: [...state.cart, item] })),
  removeFromCart: (entity) =>
    set((state) => ({
      cart: state.cart.filter((entry) => entry.entity !== entity),
    })),
  clearCart: () => set({ cart: [] }),
  setCart: (cart) => set({ cart }),
  // Lua sends `{}` (not `[]`) for an empty list — see modeler.lua:169.
  setOwnedItems: (items) => set({ ownedItems: asArray<IOwnedFurniture>(items) }),
  removeOwnedItem: (id) =>
    set((state) => ({
      ownedItems: state.ownedItems.filter((entry) => entry.id !== id),
    })),
}));
