import { useStore } from '@store/useStore';
import type { RailView } from '@customTypes/types';
import { fr } from '@locales/fr';

interface Props {
  /** Total catalogue size, shown next to the "Mobilier" tab. */
  objectCount: number;
}

/** Primary rail navigation: browse the catalogue, or manage what is placed. */
export default function RailTabs({ objectCount }: Props) {
  const railView = useStore((s) => s.railView);
  const setRailView = useStore((s) => s.setRailView);
  const ownedItems = useStore((s) => s.ownedItems);

  return (
    <div className="flex flex-none">
      <Tab
        view="catalog"
        active={railView === 'catalog'}
        label={fr.catalog.tab}
        count={objectCount}
        onClick={setRailView}
      />
      <Tab
        view="owned"
        active={railView === 'owned'}
        label={fr.owned.title}
        count={ownedItems.length}
        onClick={setRailView}
      />
    </div>
  );
}

interface TabProps {
  view: RailView;
  active: boolean;
  label: string;
  count: number;
  onClick: (view: RailView) => void;
}

function Tab({ view, active, label, count, onClick }: TabProps) {
  return (
    <button
      onClick={() => onClick(view)}
      className={`flex-1 py-3 text-center text-[13px] uppercase transition-colors ${
        active
          ? 'bg-tacoma-gold font-bold text-tacoma-ink'
          : 'border-b border-tacoma-cardline text-tacoma-mut1 hover:text-tacoma-paper'
      }`}
    >
      {label} · {count}
    </button>
  );
}
