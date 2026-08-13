import { fr } from '@locales/fr';

interface Props {
  title: string;
  body?: string;
  onConfirm: () => void;
  onCancel: () => void;
}

export default function ConfirmDialog({
  title,
  body,
  onConfirm,
  onCancel,
}: Props) {
  return (
    <div className="absolute inset-0 z-[100] grid place-items-center bg-black/60 font-sans">
      <div className="flex w-[420px] flex-col gap-5 border border-tacoma-cardline bg-zinc-950 p-7 shadow-[0_30px_60px_rgba(0,0,0,0.6)]">
        <div className="flex flex-col gap-2">
          <span className="font-kanit text-[20px] text-tacoma-paper">
            {title}
          </span>
          {body && (
            <span className="text-[14px] leading-relaxed text-tacoma-mut1">
              {body}
            </span>
          )}
        </div>

        <div className="flex gap-3">
          <button
            onClick={onCancel}
            className="flex-1 border border-tacoma-slot py-[11px] text-[14px] text-tacoma-cream transition-colors hover:border-tacoma-mut1 hover:text-tacoma-paper"
          >
            {fr.confirm.no}
          </button>
          <button
            onClick={onConfirm}
            className="flex-1 bg-tacoma-gold py-[11px] text-[14px] font-bold text-tacoma-ink transition-all hover:brightness-110"
          >
            {fr.confirm.yes}
          </button>
        </div>
      </div>
    </div>
  );
}
