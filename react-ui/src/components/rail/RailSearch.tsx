import { useEffect, useRef, useState } from 'react';
import { FaSearch } from 'react-icons/fa';
import { useStore } from '@store/useStore';
import { ALL_CATEGORIES } from '@customTypes/types';
import { fr } from '@locales/fr';

interface Props {
  /** Number of catalogue entries currently matching. */
  resultCount: number;
}

export default function RailSearch({ resultCount }: Props) {
  const furnitures = useStore((s) => s.furnitures);
  const searchTerm = useStore((s) => s.searchTerm);
  const setSearchTerm = useStore((s) => s.setSearchTerm);
  const selectedCategory = useStore((s) => s.selectedCategory);
  const setSelectedCategory = useStore((s) => s.setSelectedCategory);

  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!isOpen) return;
    function onPointerDown(e: MouseEvent) {
      if (!dropdownRef.current?.contains(e.target as Node)) setIsOpen(false);
    }
    document.addEventListener('mousedown', onPointerDown);
    return () => document.removeEventListener('mousedown', onPointerDown);
  }, [isOpen]);

  const isSearching = searchTerm.length > 0;
  const activeLabel =
    selectedCategory === ALL_CATEGORIES
      ? fr.catalog.allCategories
      : (furnitures?.[selectedCategory]?.category ?? fr.catalog.allCategories);

  return (
    <>
      {/* Search field — gold border once it holds a query, per the wireframe */}
      <div
        className={`flex h-10 items-center gap-[10px] bg-tacoma-field px-3 transition-colors ${
          isSearching ? 'border border-tacoma-gold' : 'border border-tacoma-slot'
        }`}
      >
        <FaSearch className="shrink-0 text-[13px] text-tacoma-gold" />
        <input
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          placeholder={fr.catalog.searchPlaceholder}
          className="min-w-0 flex-1 bg-transparent text-[15px] text-tacoma-paper placeholder:text-tacoma-mut3"
          type="text"
        />
        {isSearching && (
          <span className="shrink-0 font-mono text-[11px] text-tacoma-mut2">
            {resultCount}
          </span>
        )}
      </div>

      {/* Category dropdown */}
      <div ref={dropdownRef} className="relative">
        <button
          onClick={() => setIsOpen((open) => !open)}
          className={`flex w-full items-center justify-between px-3 py-[9px] text-left text-[14px] transition-colors ${
            selectedCategory === ALL_CATEGORIES
              ? 'border border-tacoma-slot text-tacoma-cream'
              : 'border border-tacoma-gold text-tacoma-paper'
          }`}
        >
          <span className="truncate">{activeLabel}</span>
          <span className="ml-2 shrink-0 text-tacoma-mut2">
            {isOpen ? '▴' : '▾'}
          </span>
        </button>

        {isOpen && (
          <div className="tacoma-scroll absolute left-0 right-0 top-full z-30 max-h-[320px] overflow-y-auto border border-tacoma-slot bg-zinc-950">
            <CategoryOption
              label={fr.catalog.allCategories}
              count={null}
              active={selectedCategory === ALL_CATEGORIES}
              onClick={() => {
                setSelectedCategory(ALL_CATEGORIES);
                setIsOpen(false);
              }}
            />
            {furnitures?.map((group, i) => (
              <CategoryOption
                key={group.category}
                label={group.category}
                count={group.items?.length ?? 0}
                active={selectedCategory === i}
                onClick={() => {
                  setSelectedCategory(i);
                  setIsOpen(false);
                }}
              />
            ))}
          </div>
        )}
      </div>
    </>
  );
}

interface OptionProps {
  label: string;
  count: number | null;
  active: boolean;
  onClick: () => void;
}

function CategoryOption({ label, count, active, onClick }: OptionProps) {
  return (
    <button
      onClick={onClick}
      className={`flex w-full items-center justify-between px-3 py-[9px] text-left text-[14px] transition-colors hover:bg-zinc-900 ${
        active ? 'bg-zinc-900 text-tacoma-gold' : 'text-tacoma-cream'
      }`}
    >
      <span className="truncate">{label}</span>
      {count !== null && (
        <span className="ml-2 shrink-0 font-mono text-[11px] text-tacoma-mut2">
          {count}
        </span>
      )}
    </button>
  );
}
