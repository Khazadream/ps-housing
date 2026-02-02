import { useEffect, useState } from 'react';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { useNuiEvent } from '@utils/useNuiEvent';
import Header from './Header';
import ItemList from './ItemList';
import Cart from './Cart';
import OwnedItems from './OwnedItems';

export default function Menu() {
  const isMenuMinimized = useStore((s) => s.isMenuMinimized);
  const setIsMenuMinimized = useStore((s) => s.setIsMenuMinimized);
  const [isFreeCamMode, setIsFreeCamMode] = useState(false);
  const [hoverDistance, setHoverDistance] = useState(5.0);

  useNuiEvent<boolean>('freecamMode', (data) => {
    if (data === false) {
      setIsMenuMinimized(false);
      setIsFreeCamMode(false);
    }
  });

  useEffect(() => {
    function listenForKey(e: KeyboardEvent) {
      if (
        e.target instanceof HTMLInputElement ||
        e.target instanceof HTMLTextAreaElement
      )
        return;
      if (e.key === 'c') {
        sendNUI('freecamMode', true);
        setIsMenuMinimized(true);
        setIsFreeCamMode(true);
      }
    }

    window.addEventListener('keypress', listenForKey);
    sendNUI('freecamMode', false);
    sendNUI('setHoverDistance', hoverDistance);
    setIsMenuMinimized(false);
    setIsFreeCamMode(false);

    return () => window.removeEventListener('keypress', listenForKey);
  }, []);

  return (
    <div
      className={`w-[97%] h-fit flex flex-col absolute left-1/2 overflow-visible -translate-x-1/2 ${
        isMenuMinimized ? '-bottom-[24rem]' : 'bottom-[3rem]'
      } z-[1] transition-all`}
    >
      <Header />
      <ItemList />
      <Cart />
      <OwnedItems />

      {/* Freecam button */}
      <div
        style={{
          borderColor: isFreeCamMode ? 'white' : 'var(--color-tertiary)',
        }}
        className="absolute -top-[5rem] text-[2rem] right-0 w-[8rem] border-[0.3rem] h-[4rem] bg-[color:var(--color-primary)] flex flex-row gap-[1rem] items-center justify-center"
      >
        <i className="fa-solid fa-video text-[white]" />
        <p className="font-semibold">C</p>
      </div>

      {/* Hover distance slider */}
      <div className="flex flex-row gap-[1rem] items-center absolute left-0 -top-[5rem] w-[30rem] h-fit p-4 bg-[color:var(--color-primary)]">
        <i className="fa-solid fa-eye text-[white]" />
        <p className="font-semibold text-center w-[4rem]">
          {hoverDistance.toFixed(1)}
        </p>
        <input
          id="slider"
          type="range"
          min="1.0"
          max="12.5"
          step="0.5"
          value={hoverDistance}
          onChange={(e) => {
            const val = parseFloat(e.target.value);
            setHoverDistance(val);
            sendNUI('setHoverDistance', val);
          }}
          className="w-full"
        />
      </div>
    </div>
  );
}
