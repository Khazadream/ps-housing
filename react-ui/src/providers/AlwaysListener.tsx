import { useNuiEvent } from '@utils/useNuiEvent';
import { debugData } from '@utils/debugData';
import { useStore } from '@store/useStore';
import { useModelStore } from '@store/useModelStore';
import type { IFurnitures, ICartItem, IFurniture } from '@customTypes/types';

export default function AlwaysListener() {
  const setBrowserMode = useStore((s) => s.setBrowserMode);
  const setFurnitures = useStore((s) => s.setFurnitures);
  const setShowFurnitures = useStore((s) => s.setShowFurnitures);
  const addToCart = useStore((s) => s.addToCart);
  const removeFromCart = useStore((s) => s.removeFromCart);
  const clearCart = useStore((s) => s.clearCart);
  const setIsMenuMinimized = useStore((s) => s.setIsMenuMinimized);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setOwnedItems = useStore((s) => s.setOwnedItems);
  const removeOwnedItem = useStore((s) => s.removeOwnedItem);
  const setShow = useModelStore((s) => s.setShow);
  const setupModel = useModelStore((s) => s.setupModel);
  const updateCamera = useModelStore((s) => s.updateCamera);

  // Debug data for browser mode
  debugData([{ action: 'setVisible', data: true }]);
  debugData([{ action: 'setBrowserMode', data: true }]);

  useNuiEvent<boolean>('setBrowserMode', (data) => {
    setBrowserMode(data);
    if (data) {
      const handler = (e: KeyboardEvent) => {
        if (e.key === '=') {
          useStore.getState().setVisibility(true);
        }
      };
      window.addEventListener('keydown', handler);
    }
  });

  useNuiEvent('setupModel', (data: any) => {
    setShow(true);
    setupModel(data);
  });

  useNuiEvent('updateCamera', (data: any) => {
    updateCamera(data);
  });

  useNuiEvent('setFurnituresData', (data: IFurnitures[]) => {
    setFurnitures(data);
    setShowFurnitures(data[0]);
  });

  useNuiEvent('addToCart', (cartEntry: ICartItem) => {
    addToCart(cartEntry);
    setShow(false);
    setIsMenuMinimized(false);
  });

  useNuiEvent('removeFromCart', (data: any) => {
    removeFromCart(data.entity);
    setCurrentFurniture(null);
    setShow(false);
  });

  useNuiEvent('clearCart', () => {
    clearCart();
  });

  useNuiEvent('setOwnedItems', (data: IFurniture[]) => {
    setOwnedItems(data);
  });

  useNuiEvent('removeOwnedItem', (data: any) => {
    removeOwnedItem(data.id);
  });

  return null;
}
