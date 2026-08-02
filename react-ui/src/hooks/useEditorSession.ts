import { useEffect, useState } from 'react';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { useNuiEvent } from '@utils/useNuiEvent';

export const DEFAULT_HOVER_DISTANCE = 5.0;

/**
 * Owns the two editor-wide session concerns that used to live in Menu.tsx:
 * the freecam toggle (key "C") and the hover preview distance.
 *
 * Lua drives the exit side: pressing C in-game emits `freecamMode:false`
 * (modeler.lua:221) so the rail comes back on its own.
 */
export function useEditorSession() {
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);
  const [isFreecam, setIsFreecam] = useState(false);
  const [hoverDistance, setHoverDistanceState] = useState(DEFAULT_HOVER_DISTANCE);

  useNuiEvent<boolean>('freecamMode', (active) => {
    if (active === false) {
      setIsFreecam(false);
      setIsRailCollapsed(false);
    }
  });

  useEffect(() => {
    function listenForKey(e: KeyboardEvent) {
      if (
        e.target instanceof HTMLInputElement ||
        e.target instanceof HTMLTextAreaElement
      )
        return;
      if (e.key === 'c' || e.key === 'C') {
        sendNUI('freecamMode', true);
        setIsFreecam(true);
        setIsRailCollapsed(true);
      }
    }

    window.addEventListener('keypress', listenForKey);

    sendNUI('freecamMode', false);
    sendNUI('setHoverDistance', DEFAULT_HOVER_DISTANCE);
    setIsFreecam(false);
    setIsRailCollapsed(false);

    return () => window.removeEventListener('keypress', listenForKey);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  function setHoverDistance(value: number) {
    setHoverDistanceState(value);
    sendNUI('setHoverDistance', value);
  }

  return { isFreecam, hoverDistance, setHoverDistance };
}
