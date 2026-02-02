import { create } from 'zustand';
import type { IFurniture, IFurnitures, ICartItem } from '@customTypes/types';

interface StoreState {
  visibility: boolean;
  browserMode: boolean;
  resName: string;

  furnitures: IFurnitures[] | null;
  showFurnitures: IFurnitures | null;
  currentFurniture: IFurniture | null;

  isMenuMinimized: boolean;
  isCartOpen: boolean;
  isOwnedItemsOpen: boolean;

  cart: ICartItem[];
  ownedItems: IFurniture[];

  setVisibility: (visible: boolean) => void;
  setBrowserMode: (mode: boolean) => void;
  setResName: (name: string) => void;
  setFurnitures: (data: IFurnitures[]) => void;
  setShowFurnitures: (data: IFurnitures | null) => void;
  setCurrentFurniture: (data: IFurniture | null) => void;
  setIsMenuMinimized: (val: boolean) => void;
  setIsCartOpen: (val: boolean) => void;
  setIsOwnedItemsOpen: (val: boolean) => void;
  addToCart: (item: ICartItem) => void;
  removeFromCart: (entity: number) => void;
  clearCart: () => void;
  setCart: (cart: ICartItem[]) => void;
  setOwnedItems: (items: IFurniture[]) => void;
  removeOwnedItem: (id: string) => void;
}

export const useStore = create<StoreState>((set) => ({
  visibility: false,
  browserMode: false,
  resName: '',

  furnitures: null,
  showFurnitures: null,
  currentFurniture: null,

  isMenuMinimized: false,
  isCartOpen: false,
  isOwnedItemsOpen: false,

  cart: [],
  ownedItems: [],

  setVisibility: (visible) => set({ visibility: visible }),
  setBrowserMode: (mode) => set({ browserMode: mode }),
  setResName: (name) => set({ resName: name }),
  setFurnitures: (data) => set({ furnitures: data }),
  setShowFurnitures: (data) => set({ showFurnitures: data }),
  setCurrentFurniture: (data) => set({ currentFurniture: data }),
  setIsMenuMinimized: (val) => set({ isMenuMinimized: val }),
  setIsCartOpen: (val) => set({ isCartOpen: val }),
  setIsOwnedItemsOpen: (val) => set({ isOwnedItemsOpen: val }),
  addToCart: (item) => set((state) => ({ cart: [...state.cart, item] })),
  removeFromCart: (entity) =>
    set((state) => ({
      cart: state.cart.filter((entry) => entry.entity !== entity),
    })),
  clearCart: () => set({ cart: [] }),
  setCart: (cart) => set({ cart }),
  setOwnedItems: (items) => set({ ownedItems: items }),
  removeOwnedItem: (id) =>
    set((state) => ({
      ownedItems: state.ownedItems.filter(
        (entry: any) => entry.id !== id
      ),
    })),
}));
