import { useMemo, useState } from 'react';
import { createPortal } from 'react-dom';
import { useStore } from '@store/useStore';
import { useModelStore } from '@store/useModelStore';
import { useVirtualList } from '@hooks/useVirtualList';
import { sendNUI } from '@utils/sendNUI';
import { quotaFor, quotaKey } from '@utils/catalog';
import type { IFurniture } from '@customTypes/types';
import { fr } from '@locales/fr';
import CatalogRow, { CATALOG_ROW_HEIGHT } from './CatalogRow';
import ConfirmDialog from '../ConfirmDialog';

interface Props {
  items: IFurniture[];
}

export default function CatalogList({ items }: Props) {
  const ownedItems = useStore((s) => s.ownedItems);
  const cart = useStore((s) => s.cart);
  const maxStash = useStore((s) => s.maxStash);
  const currentFurniture = useStore((s) => s.currentFurniture);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);
  const isPlacing = useModelStore((s) => s.show);

  const [pendingSwitch, setPendingSwitch] = useState<IFurniture | null>(null);
  const { scrollRef, onScroll, window } = useVirtualList(
    items.length,
    CATALOG_ROW_HEIGHT
  );

  // Keyed by object *and* type: a decorative twin shares its model name with the
  // functional prop but carries no type, so it must not inherit its quota.
  const quotas = useMemo(() => {
    const map = new Map<string, ReturnType<typeof quotaFor>>();
    for (const item of items) {
      const key = quotaKey(item);
      if (item.type && !map.has(key)) {
        map.set(key, quotaFor(item, ownedItems, cart, maxStash));
      }
    }
    return map;
  }, [items, ownedItems, cart, maxStash]);

  function startPlacement(furniture: IFurniture) {
    sendNUI('previewFurniture', furniture).catch(() => {});
    setCurrentFurniture(furniture);
    setIsRailCollapsed(true);
  }

  function handlePlace(furniture: IFurniture) {
    sendNUI('hoverOut').catch(() => {});

    // Something is already on the gizmo — confirm before dropping it.
    if (isPlacing || currentFurniture) {
      setPendingSwitch(furniture);
      return;
    }
    startPlacement(furniture);
  }

  if (items.length === 0) {
    return (
      <div className="flex flex-1 flex-col items-center justify-center gap-2 px-8 text-center">
        <span className="font-mono text-[11px] uppercase tracking-[0.16em] text-tacoma-mut2">
          {fr.catalog.empty}
        </span>
        <span className="text-[13px] text-tacoma-mut3">
          {fr.catalog.emptyHint}
        </span>
      </div>
    );
  }

  return (
    <>
      <div
        ref={scrollRef}
        onScroll={onScroll}
        className="tacoma-scroll min-h-0 flex-1 overflow-y-auto px-5 py-[14px]"
      >
        <div style={{ height: window.padTop }} />
        {/* Each slot is exactly CATALOG_ROW_HEIGHT so the padding math stays exact. */}
        {items.slice(window.start, window.end).map((furniture, i) => (
          <div
            key={`${furniture.object}-${window.start + i}`}
            className="pb-2"
            style={{ height: CATALOG_ROW_HEIGHT }}
          >
            <CatalogRow
              furniture={furniture}
              quota={quotas.get(quotaKey(furniture)) ?? null}
              onPlace={handlePlace}
            />
          </div>
        ))}
        <div style={{ height: window.padBottom }} />
      </div>

      {pendingSwitch &&
        createPortal(
          <ConfirmDialog
            title={fr.confirm.switchTitle}
            body={fr.confirm.switchBody}
            onCancel={() => setPendingSwitch(null)}
            onConfirm={() => {
              startPlacement(pendingSwitch);
              setPendingSwitch(null);
            }}
          />,
          document.body
        )}
    </>
  );
}
