import { useEffect, useRef, useState } from 'react';
import { useStore } from '@store/useStore';

export default function Header() {
  const furnitures = useStore((s) => s.furnitures);
  const setShowFurnitures = useStore((s) => s.setShowFurnitures);
  const isMenuMinimized = useStore((s) => s.isMenuMinimized);
  const setIsMenuMinimized = useStore((s) => s.setIsMenuMinimized);
  const cart = useStore((s) => s.cart);
  const ownedItems = useStore((s) => s.ownedItems);
  const isCartOpen = useStore((s) => s.isCartOpen);
  const setIsCartOpen = useStore((s) => s.setIsCartOpen);
  const isOwnedItemsOpen = useStore((s) => s.isOwnedItemsOpen);
  const setIsOwnedItemsOpen = useStore((s) => s.setIsOwnedItemsOpen);

  const [selected, setSelected] = useState(-1);
  const [showSearch, setShowSearch] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const scrollableRef = useRef<HTMLDivElement>(null);

  function scrollHorizontally(e: React.WheelEvent) {
    if (scrollableRef.current) {
      const delta = Math.max(-1, Math.min(1, (e as any).wheelDelta || -e.deltaY));
      scrollableRef.current.scrollLeft -= delta * 50;
      e.preventDefault();
    }
  }

  // Update shown furnitures when search or selection changes
  useEffect(() => {
    if (!furnitures) return;

    if (searchTerm.length > 0) {
      let allItems;
      if (selected === -1) {
        allItems = furnitures.flatMap((f) => f.items);
      } else {
        allItems = furnitures[selected].items;
      }
      const filtered = allItems.filter((f) =>
        f.label.toLowerCase().includes(searchTerm.toLowerCase())
      );
      setShowFurnitures({ category: 'Search Results', items: filtered });
    } else {
      if (selected === -1) {
        const allItems = furnitures.flatMap((f) => f.items);
        setShowFurnitures({ category: 'All Objects', items: allItems });
      } else {
        setShowFurnitures(furnitures[selected]);
      }
    }
  }, [searchTerm, selected, furnitures, setShowFurnitures]);

  return (
    <div className="w-full h-full overflow-y-visible flex flex-row gap-2 items-end flex-nowrap">
      {/* Search */}
      <button
        className={`h-[4.5rem] ${
          showSearch ? 'w-fit' : 'w-[5rem] aspect-square'
        } bg-[color:var(--color-secondary)] flex flex-row gap-2 items-center`}
      >
        <button
          className="h-[4.5rem] w-[4.5rem] aspect-square bg-[color:var(--color-secondary)] flex flex-row gap-2 items-center justify-center"
          onClick={() => {
            setShowSearch(!showSearch);
            if (isMenuMinimized) setIsMenuMinimized(false);
          }}
        >
          <i className="fas fa-magnifying-glass text-[1.6rem]" />
        </button>

        {showSearch && (
          <input
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            autoFocus
            className="min-w-[10rem] h-[4.5rem] px-[1rem] text-[1.6rem] bg-[color:var(--color-tertiary)]"
            type="text"
            placeholder="Search"
          />
        )}
      </button>

      {/* Category tabs */}
      <div
        onWheel={scrollHorizontally}
        ref={scrollableRef}
        className="w-full h-[5rem] items-end flex flex-row gap-2 overflow-y-visible overflow-x-scroll categories"
        style={{ scrollbarWidth: 'none' }}
      >
        <button
          className={`whitespace-nowrap w-fit px-10 h-[4.5rem] text-[1.6rem] bg-[color:var(--color-secondary)] grid place-items-center transition-all duration-200 ease-in-out ${
            selected === -1
              ? 'scale-110 origin-bottom bg-[color:var(--color-primary)] mx-2'
              : ''
          }`}
          onClick={() => {
            setSelected(-1);
            if (furnitures) {
              const allItems = furnitures.flatMap((f) => f.items);
              setShowFurnitures({ category: 'All Objects', items: allItems });
            }
            if (isMenuMinimized) setIsMenuMinimized(false);
          }}
        >
          React Tous les objets
        </button>
        {furnitures?.map((category, i) => (
          <button
            key={i}
            className={`whitespace-nowrap w-fit px-10 h-[4.5rem] text-[1.6rem] bg-[color:var(--color-secondary)] grid place-items-center transition-all duration-200 ease-in-out ${
              selected === i
                ? 'scale-110 origin-bottom bg-[color:var(--color-primary)] mx-2'
                : ''
            }`}
            onClick={() => {
              setSelected(i);
              setShowFurnitures(furnitures[i]);
              if (isMenuMinimized) setIsMenuMinimized(false);
            }}
          >
            {category.category}
          </button>
        ))}
      </div>

      {/* Right buttons */}
      <div className="overflow-y-visible flex flex-row gap-2 ml-auto">
        <button
          className="w-fit px-[2rem] items-center justify-center break h-[4.5rem] text-[1.6rem] bg-[color:var(--color-secondary)] flex flex-row gap-4 transition-all duration-200 ease-in-out"
          onClick={() => {
            setIsCartOpen(false);
            setIsOwnedItemsOpen(!isOwnedItemsOpen);
          }}
        >
          <p className="w-fit whitespace-nowrap">Meubles achetés</p>
          <span className="h-fit px-[1rem] bg-[color:var(--color-tertiary)]">
            {ownedItems.length}
          </span>
        </button>
        <button
          className="h-[4.5rem] w-fit px-[2rem] text-[1.6rem] bg-[color:var(--color-secondary)] flex flex-row gap-4 items-center justify-center transition-all duration-200 ease-in-out"
          onClick={() => {
            setIsOwnedItemsOpen(false);
            setIsCartOpen(!isCartOpen);
          }}
        >
          <i className="fas fa-shopping-cart" />
          <span className="h-fit px-[1rem] bg-[color:var(--color-tertiary)]">
            {cart.length}
          </span>
        </button>
        <button
          className="h-[4.5rem] w-fit aspect-square text-[1.6rem] bg-[color:var(--color-secondary)] flex flex-row gap-4 items-center justify-center transition-all duration-200 ease-in-out"
          onClick={() => setIsMenuMinimized(!isMenuMinimized)}
        >
          <i
            className={`fas fa-chevron-${isMenuMinimized ? 'up' : 'down'}`}
          />
        </button>
      </div>
    </div>
  );
}
