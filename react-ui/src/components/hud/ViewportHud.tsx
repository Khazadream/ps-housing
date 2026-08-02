import { fr } from '@locales/fr';

const MIN_DISTANCE = 1.0;
const MAX_DISTANCE = 12.5;

interface Props {
  isFreecam: boolean;
  hoverDistance: number;
  onHoverDistanceChange: (value: number) => void;
}

/** Top-right overlay: hover preview distance + freecam indicator. */
export default function ViewportHud({
  isFreecam,
  hoverDistance,
  onHoverDistanceChange,
}: Props) {
  return (
    <div className="pointer-events-none absolute right-6 top-6 z-20 flex flex-col items-end gap-2">
      <div className="pointer-events-auto flex items-center gap-3 border border-tacoma-cardline bg-zinc-950/[0.92] px-[14px] py-[9px]">
        <span className="font-mono text-[10px] tracking-[0.16em] text-tacoma-mut2">
          {fr.hud.preview}
        </span>
        <input
          type="range"
          min={MIN_DISTANCE}
          max={MAX_DISTANCE}
          step={0.5}
          value={hoverDistance}
          onChange={(e) => onHoverDistanceChange(parseFloat(e.target.value))}
          className="tacoma-range w-[120px]"
        />
        <span className="w-[46px] text-right font-mono text-[12px] text-tacoma-paper">
          {hoverDistance.toFixed(1)}
          {fr.hud.distanceUnit}
        </span>
      </div>

      <div
        className={`flex items-center gap-[10px] border bg-zinc-950/[0.92] px-[14px] py-2 transition-colors ${
          isFreecam ? 'border-tacoma-cream' : 'border-tacoma-cardline'
        }`}
      >
        <span
          className={`text-[13px] ${
            isFreecam ? 'text-tacoma-paper' : 'text-tacoma-mut1'
          }`}
        >
          {fr.hud.freecam}
        </span>
        <span
          className={`font-mono text-[11px] px-2 py-[2px] ${
            isFreecam
              ? 'bg-tacoma-gold text-tacoma-ink'
              : 'bg-tacoma-slot text-tacoma-paper'
          }`}
        >
          {fr.hud.freecamKey}
        </span>
      </div>
    </div>
  );
}
