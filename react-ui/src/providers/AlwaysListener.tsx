import { useNuiEvent } from '@utils/useNuiEvent';
import { debugData } from '@utils/debugData';
import { useStore } from '@store/useStore';
import { useModelStore } from '@store/useModelStore';
import type { ICartItem } from '@customTypes/types';

/**
 * Single place where every inbound NUI message is handled.
 * Payload shapes are Lua's, not JS's — see client/modeler.lua.
 */
export default function AlwaysListener() {
  const setBrowserMode = useStore((s) => s.setBrowserMode);
  const setFurnitures = useStore((s) => s.setFurnitures);
  const addToCart = useStore((s) => s.addToCart);
  const removeFromCart = useStore((s) => s.removeFromCart);
  const clearCart = useStore((s) => s.clearCart);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setOwnedItems = useStore((s) => s.setOwnedItems);
  const removeOwnedItem = useStore((s) => s.removeOwnedItem);
  const setMaxStash = useStore((s) => s.setMaxStash);
  const setShow = useModelStore((s) => s.setShow);
  const setupModel = useModelStore((s) => s.setupModel);
  const updateCamera = useModelStore((s) => s.updateCamera);
  const setObjectAlpha = useModelStore((s) => s.setObjectAlpha);

  // Browser-dev only: Lua never sends setBrowserMode.
  debugData([{ action: 'setVisible', data: true }]);
  debugData([{ action: 'setBrowserMode', data: true }]);

  useNuiEvent<boolean>('setBrowserMode', (data) => {
    setBrowserMode(data);
  });

  useNuiEvent('setupModel', (data: any) => {
    setShow(true);
    setupModel(data);
  });

  useNuiEvent('updateCamera', (data: any) => {
    updateCamera(data);
  });

  // Raw number, not an object — mirror it without echoing back to Lua.
  useNuiEvent<number>('setObjectAlpha', (data) => {
    if (typeof data === 'number') setObjectAlpha(data);
  });

  // Lua sends `{}` for an empty list; the store normalises it.
  useNuiEvent('setFurnituresData', (data: unknown) => {
    setFurnitures(data);
  });

  useNuiEvent('setOwnedItems', (data: unknown) => {
    setOwnedItems(data);
  });

  useNuiEvent<number>('setMaxStash', (data) => {
    if (typeof data === 'number') setMaxStash(data);
  });

  useNuiEvent('addToCart', (cartEntry: ICartItem) => {
    addToCart(cartEntry);
    setShow(false);
    setIsRailCollapsed(false);
  });

  useNuiEvent('removeFromCart', (data: any) => {
    removeFromCart(data.entity);
    setCurrentFurniture(null);
    setShow(false);
  });

  useNuiEvent('clearCart', () => {
    clearCart();
  });

  useNuiEvent('removeOwnedItem', (data: any) => {
    removeOwnedItem(data.id);
  });

  return null;
}
