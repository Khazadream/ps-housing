import { useMemo } from 'react';
import { FaChevronLeft } from 'react-icons/fa';
import { useStore } from '@store/useStore';
import { ALL_CATEGORIES } from '@customTypes/types';
import { matchesSearch, totalItemCount } from '@utils/catalog';
import { fr } from '@locales/fr';
import RailBrand from './RailBrand';
import RailTabs from './RailTabs';
import RailSearch from './RailSearch';
import CatalogList from './CatalogList';
import OwnedPanel from './OwnedPanel';
import RailCollapsed from './RailCollapsed';

export default function Rail() {
  const furnitures = useStore((s) => s.furnitures);
  const searchTerm = useStore((s) => s.searchTerm);
  const selectedCategory = useStore((s) => s.selectedCategory);
  const railView = useStore((s) => s.railView);
  const isRailCollapsed = useStore((s) => s.isRailCollapsed);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);

  const objectCount = useMemo(() => totalItemCount(furnitures), [furnitures]);

  // Derived straight from the store — no round-trip through an effect.
  const shownItems = useMemo(() => {
    if (!furnitures) return [];
    const scope =
      selectedCategory === ALL_CATEGORIES
        ? furnitures.flatMap((group) => group.items ?? [])
        : (furnitures[selectedCategory]?.items ?? []);

    if (searchTerm.length === 0) return scope;
    return scope.filter((item) => matchesSearch(item.label, searchTerm));
  }, [furnitures, selectedCategory, searchTerm]);

  return (
    <div
      className={`absolute inset-y-0 left-0 z-20 flex flex-col border-r border-tacoma-cardline bg-zinc-950/[0.97] transition-[width] duration-300 ${
        isRailCollapsed ? 'w-[72px]' : 'w-[392px]'
      }`}
    >
      {isRailCollapsed ? (
        <RailCollapsed />
      ) : (
        <>
          <div className="relative flex-none px-5 pb-[14px] pt-[18px]">
            <RailBrand />
            <button
              title={fr.rail.collapse}
              onClick={() => setIsRailCollapsed(true)}
              className="absolute right-3 top-3 text-[13px] text-tacoma-mut3 transition-colors hover:text-tacoma-paper"
            >
              <FaChevronLeft />
            </button>
          </div>

          <RailTabs objectCount={objectCount} />

          {railView === 'catalog' ? (
            <>
              <div className="flex flex-none flex-col gap-3 border-b border-tacoma-cardline px-5 py-[14px]">
                <RailSearch resultCount={shownItems.length} />
              </div>
              <CatalogList items={shownItems} />
            </>
          ) : (
            <OwnedPanel />
          )}
        </>
      )}
    </div>
  );
}
