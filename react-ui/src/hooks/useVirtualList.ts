import { useCallback, useEffect, useRef, useState } from 'react';

interface VirtualWindow {
  start: number;
  end: number;
  padTop: number;
  padBottom: number;
}

/**
 * Fixed-height windowing for the catalogue list.
 *
 * "Toutes catégories" is 886 rows; rendering them all is ~60 000 px of DOM and
 * CEF chokes on it. Rows are a known height, so a plain scroll offset window
 * beats pulling in a virtualisation dependency.
 */
export function useVirtualList(
  itemCount: number,
  rowHeight: number,
  overscan = 6
) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const [scrollTop, setScrollTop] = useState(0);
  const [viewportHeight, setViewportHeight] = useState(0);

  const measure = useCallback(() => {
    const node = scrollRef.current;
    if (node) setViewportHeight(node.clientHeight);
  }, []);

  useEffect(() => {
    measure();
    window.addEventListener('resize', measure);
    return () => window.removeEventListener('resize', measure);
  }, [measure]);

  const onScroll = useCallback((e: React.UIEvent<HTMLDivElement>) => {
    setScrollTop(e.currentTarget.scrollTop);
  }, []);

  // Reset to the top whenever the result set changes (new search / category).
  useEffect(() => {
    const node = scrollRef.current;
    if (node && node.scrollTop !== 0) node.scrollTop = 0;
    setScrollTop(0);
  }, [itemCount]);

  const visibleCount = Math.ceil((viewportHeight || rowHeight) / rowHeight);
  const start = Math.max(0, Math.floor(scrollTop / rowHeight) - overscan);
  const end = Math.min(itemCount, start + visibleCount + overscan * 2);

  const viewWindow: VirtualWindow = {
    start,
    end,
    padTop: start * rowHeight,
    padBottom: Math.max(0, (itemCount - end) * rowHeight),
  };

  return { scrollRef, onScroll, window: viewWindow };
}
