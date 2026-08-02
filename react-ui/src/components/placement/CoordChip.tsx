interface Props {
  label: string;
  value: number;
  suffix?: string;
}

/** Live read-out of one axis. Restored from the legacy modeler panel. */
export default function CoordChip({ label, value, suffix }: Props) {
  return (
    <div className="flex flex-1 flex-col items-center bg-zinc-900 px-2 py-[6px]">
      <span className="text-[10px] uppercase leading-none text-tacoma-mut2">
        {label}
      </span>
      <span className="mt-[3px] font-mono text-[13px] leading-none text-tacoma-paper">
        {value.toFixed(2)}
        {suffix}
      </span>
    </div>
  );
}
