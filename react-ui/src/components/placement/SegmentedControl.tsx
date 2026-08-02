interface Option<T> {
  value: T;
  label: string;
}

interface Props<T> {
  options: Option<T>[];
  value: T;
  onChange: (value: T) => void;
}

/** Gold-outlined segmented picker used for mode, move step and rotation step. */
export default function SegmentedControl<T extends string | number>({
  options,
  value,
  onChange,
}: Props<T>) {
  return (
    <div className="flex gap-[6px]">
      {options.map((option) => {
        const active = option.value === value;
        return (
          <button
            key={String(option.value)}
            onClick={() => onChange(option.value)}
            className={`flex-1 border py-2 text-center text-[13px] transition-colors ${
              active
                ? 'border-tacoma-gold bg-tacoma-gold/[0.12] text-tacoma-paper'
                : 'border-tacoma-cardline text-tacoma-mut1 hover:border-tacoma-slot hover:text-tacoma-cream'
            }`}
          >
            {option.label}
          </button>
        );
      })}
    </div>
  );
}
