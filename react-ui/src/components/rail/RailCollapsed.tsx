import { FaSearch } from 'react-icons/fa';
import { useStore } from '@store/useStore';
import { fr } from '@locales/fr';

/** The 72px icon strip shown while placing an object or flying the freecam. */
export default function RailCollapsed() {
  const cart = useStore((s) => s.cart);
  const ownedItems = useStore((s) => s.ownedItems);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);
  const setRailView = useStore((s) => s.setRailView);

  function expand(view: 'catalog' | 'owned') {
    setRailView(view);
    setIsRailCollapsed(false);
  }

  return (
    <div className="flex h-full flex-col items-center gap-[14px] py-[18px]">
      <button
        title={fr.rail.expand}
        onClick={() => setIsRailCollapsed(false)}
        className="font-mono text-[15px] text-tacoma-gold transition-all hover:brightness-125"
      >
        ▶
      </button>

      <button
        title={fr.catalog.tab}
        onClick={() => expand('catalog')}
        className="grid h-9 w-9 place-items-center border border-tacoma-slot text-tacoma-mut1 transition-colors hover:border-tacoma-gold hover:text-tacoma-paper"
      >
        <FaSearch className="text-[13px]" />
      </button>

      {/* Read-only: the cart itself is the floating card, always on screen. */}
      <div
        title={fr.cart.title}
        className="grid h-9 w-9 place-items-center border border-dashed border-green-500 font-mono text-[12px] text-green-400"
      >
        {cart.length}
      </div>

      <button
        title={fr.owned.title}
        onClick={() => expand('owned')}
        className="grid h-9 w-9 place-items-center border border-tacoma-gold font-mono text-[12px] text-tacoma-gold transition-all hover:brightness-125"
      >
        {ownedItems.length}
      </button>
    </div>
  );
}
