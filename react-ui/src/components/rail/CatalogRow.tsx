import { useState } from 'react';
import { FaEye } from 'react-icons/fa';
import { sendNUI } from '@utils/sendNUI';
import type { IFurniture } from '@customTypes/types';
import type { Quota } from '@utils/catalog';
import { fr } from '@locales/fr';

export const CATALOG_ROW_HEIGHT = 76; // 68px row + 8px gap

interface Props {
  furniture: IFurniture;
  quota: Quota | null;
  onPlace: (furniture: IFurniture) => void;
}

export default function CatalogRow({ furniture, quota, onPlace }: Props) {
  const blocked = quota?.full ?? false;
  const [isPreviewing, setIsPreviewing] = useState(false);

  function startPreview() {
    setIsPreviewing(true);
    // hoverIn blocks Lua-side until hoverOut (modeler.lua:679) — never await it.
    sendNUI('hoverIn', furniture).catch(() => {});
  }

  function stopPreview() {
    setIsPreviewing(false);
    sendNUI('hoverOut').catch(() => {});
  }

  return (
    <div
      className="flex h-[68px] items-center gap-[13px] border border-tacoma-cardline bg-zinc-900 p-[9px] transition-colors hover:border-zinc-500"
      // Defensive: the tile's own mouseleave occasionally misses on fast scroll.
      onMouseLeave={() => isPreviewing && stopPreview()}
    >
      {/*
        GTA props ship no thumbnails — Config.Furnitures only carries a model
        name. The in-world ghost preview stands in for the missing image.
      */}
      <button
        title={fr.catalog.preview}
        onMouseEnter={startPreview}
        onMouseLeave={stopPreview}
        onClick={() => onPlace(furniture)}
        disabled={blocked}
        className={`furniture-thumb relative grid h-[50px] w-16 shrink-0 place-items-center border transition-colors ${
          isPreviewing
            ? 'border-tacoma-gold'
            : 'border-transparent hover:border-tacoma-gold'
        } ${blocked ? 'cursor-not-allowed' : 'cursor-pointer'}`}
      >
        <span
          className={`absolute inset-0 transition-colors ${
            isPreviewing ? 'bg-tacoma-gold/20' : 'bg-black/40'
          }`}
        />
        <FaEye
          className={`relative text-[15px] transition-colors ${
            isPreviewing ? 'text-tacoma-gold' : 'text-tacoma-mut1'
          }`}
        />
      </button>

      <div className="flex min-w-0 flex-1 flex-col gap-[3px]">
        <span className="truncate text-[14px] text-tacoma-paper">
          {furniture.label}
        </span>
        <span className="font-mono text-[12px] text-tacoma-gold">
          ${furniture.price}
        </span>
      </div>

      {quota && (
        <span
          className={`shrink-0 border px-2 py-[3px] font-mono text-[11px] ${
            quota.full
              ? 'border-tacoma-gold text-tacoma-gold'
              : 'border-tacoma-cardline text-tacoma-mut2'
          }`}
          title={quota.full ? fr.catalog.quotaReached : undefined}
        >
          {quota.used}/{quota.max}
        </span>
      )}

      <button
        disabled={blocked}
        onClick={() => onPlace(furniture)}
        className={`shrink-0 border px-[10px] py-[5px] text-[12px] transition-colors ${
          blocked
            ? 'cursor-not-allowed border-tacoma-cardline text-tacoma-mut3'
            : 'border-tacoma-slot text-tacoma-mut1 hover:border-tacoma-gold hover:text-tacoma-paper'
        }`}
      >
        {fr.catalog.place}
      </button>
    </div>
  );
}
