import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { fr } from '@locales/fr';

/**
 * Floating "pending payment" tray, bottom-right of the viewport.
 * Only shown when something is staged — an empty tray would be pure noise.
 */
export default function CartCard() {
  const cart = useStore((s) => s.cart);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);

  if (cart.length === 0) return null;

  const subtotal = cart.reduce((acc, item) => acc + item.price, 0);

  return (
    <div className="absolute bottom-6 right-6 z-20 flex max-h-[calc(var(--vh)*45)] w-[360px] flex-col border border-green-500/50 bg-zinc-950/[0.96] font-sans shadow-[0_20px_40px_rgba(0,0,0,0.55)]">
      <div className="flex flex-none items-center justify-between border-b border-tacoma-cardline px-[18px] py-3">
        <span className="font-mono text-[10px] tracking-[0.16em] text-green-400">
          {fr.cart.title}
        </span>
        <span className="font-mono text-[11px] text-tacoma-mut2">
          {cart.length}
        </span>
      </div>

      <div className="tacoma-scroll flex min-h-0 flex-1 flex-col gap-2 overflow-y-auto px-[18px] py-[14px]">
        {cart.map((item) => (
          <div
            key={item.entity}
            role="button"
            title={fr.cart.select}
            onClick={() => {
              // Re-attaches the gizmo to the existing entity (modeler.lua:654).
              sendNUI('selectCartItem', item).catch(() => {});
              setCurrentFurniture(null);
              setIsRailCollapsed(true);
            }}
            className="flex cursor-pointer items-center gap-[10px] border border-dashed border-green-500 bg-green-500/[0.07] px-[11px] py-2 transition-colors hover:bg-green-500/[0.14]"
          >
            <span className="min-w-0 flex-1 truncate text-[14px] text-tacoma-paper">
              {item.label}
            </span>
            <span className="shrink-0 font-mono text-[12px] text-tacoma-mut1">
              ${item.price}
            </span>
            <button
              title={fr.cart.remove}
              onClick={(e) => {
                e.stopPropagation();
                sendNUI('removeCartItem', item).catch(() => {});
              }}
              className="shrink-0 px-1 text-[13px] leading-none text-tacoma-mut2 transition-colors hover:text-tacoma-red"
            >
              ✕
            </button>
          </div>
        ))}
      </div>

      <div className="flex flex-none items-center gap-3 border-t border-tacoma-cardline px-[18px] py-[14px]">
        <span className="font-mono text-[20px] text-tacoma-paper">
          ${subtotal}
        </span>
        <button
          onClick={() => {
            setCurrentFurniture(null);
            sendNUI('buyCartItems').catch(() => {});
          }}
          className="flex-1 bg-green-500 py-[13px] text-center text-[14px] font-bold text-tacoma-ink transition-all hover:brightness-110"
        >
          {fr.cart.buy}
        </button>
      </div>
    </div>
  );
}
