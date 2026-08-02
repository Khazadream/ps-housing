import { useMemo } from 'react';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { buildObjectIndex, lookupOwned, quotaFor } from '@utils/catalog';
import type { IOwnedFurniture } from '@customTypes/types';
import { fr } from '@locales/fr';

export default function OwnedPanel() {
  const ownedItems = useStore((s) => s.ownedItems);
  const cart = useStore((s) => s.cart);
  const maxStash = useStore((s) => s.maxStash);
  const furnitures = useStore((s) => s.furnitures);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);

  // Owned items ship without price/category (cl_property.lua:626) — recover them.
  const objectIndex = useMemo(() => buildObjectIndex(furnitures), [furnitures]);

  function metaFor(item: IOwnedFurniture): string {
    const entry = lookupOwned(objectIndex, item);
    const category = entry?.category ?? '';
    const quota = entry && quotaFor(entry, ownedItems, cart, maxStash);
    if (quota) {
      return `${category.toUpperCase()} · ${quota.used}/${quota.max}`;
    }
    return category.toUpperCase();
  }

  return (
    <div className="flex min-h-0 flex-1 flex-col">
      {ownedItems.length === 0 ? (
        <div className="flex flex-1 flex-col items-center justify-center gap-2 px-8 text-center">
          <span className="font-mono text-[11px] uppercase tracking-[0.16em] text-tacoma-mut2">
            {fr.owned.empty}
          </span>
          <span className="text-[13px] text-tacoma-mut3">
            {fr.owned.emptyHint}
          </span>
        </div>
      ) : (
        <div className="tacoma-scroll flex min-h-0 flex-1 flex-col gap-2 overflow-y-auto px-5 py-[14px]">
          {ownedItems.map((item) => (
            <div
              key={item.id}
              className="flex items-center gap-3 border border-tacoma-cardline border-l-[3px] border-l-tacoma-gold bg-zinc-900 px-[13px] py-[11px]"
            >
              <div className="flex min-w-0 flex-1 flex-col gap-[2px]">
                <span className="truncate text-[14px] text-tacoma-paper">
                  {item.label}
                </span>
                <span className="truncate font-mono text-[10px] tracking-[0.1em] text-tacoma-mut3">
                  {metaFor(item)}
                </span>
              </div>

              <button
                onClick={() => {
                  // Re-attaches the gizmo; stopPlacement then persists the move.
                  sendNUI('selectOwnedItem', item).catch(() => {});
                  setCurrentFurniture(null);
                  setIsRailCollapsed(true);
                }}
                className="shrink-0 border border-tacoma-slot px-[10px] py-1 text-[12px] text-tacoma-cream transition-colors hover:border-tacoma-gold hover:text-tacoma-paper"
              >
                {fr.owned.move}
              </button>

              <button
                title={fr.owned.remove}
                onClick={() => {
                  sendNUI('removeOwnedItem', item).catch(() => {});
                }}
                className="shrink-0 px-1 text-[13px] leading-none text-tacoma-mut2 transition-colors hover:text-tacoma-red"
              >
                ✕
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
