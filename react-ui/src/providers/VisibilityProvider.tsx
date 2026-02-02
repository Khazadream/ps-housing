import { useEffect, useState, type ReactNode } from 'react';
import { createPortal } from 'react-dom';
import { useNuiEvent } from '@utils/useNuiEvent';
import { sendNUI } from '@utils/sendNUI';
import { useStore } from '@store/useStore';
import { useModelStore } from '@store/useModelStore';

interface Props {
  children: ReactNode;
}

export default function VisibilityProvider({ children }: Props) {
  const visibility = useStore((s) => s.visibility);
  const setVisibility = useStore((s) => s.setVisibility);
  const cart = useStore((s) => s.cart);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsMenuMinimized = useStore((s) => s.setIsMenuMinimized);
  const setShow = useModelStore((s) => s.setShow);

  const [showModal, setShowModal] = useState(false);

  useNuiEvent<boolean>('setVisible', (visible) => {
    setVisibility(visible);
    if (visible) {
      setIsMenuMinimized(false);
    }
  });

  useEffect(() => {
    const keyHandler = (e: KeyboardEvent) => {
      if (visibility && e.code === 'Escape') {
        if (cart.length > 0) {
          setShowModal(true);
        } else {
          sendNUI('hoverOut');
          sendNUI('hideUI');
          setShowModal(false);
          setVisibility(false);
          setShow(false);
          setCurrentFurniture(null);
        }
      }
    };

    window.addEventListener('keydown', keyHandler);
    return () => window.removeEventListener('keydown', keyHandler);
  }, [visibility, cart, setVisibility, setShow, setCurrentFurniture]);

  return (
    <>
      {visibility && (
        <main
          style={{
            position: 'absolute',
            left: 0,
            top: 0,
            zIndex: 100,
            userSelect: 'none',
            boxSizing: 'border-box',
            padding: 0,
            margin: 0,
            height: '100vh',
            width: '100vw',
          }}
        >
          {children}
        </main>
      )}

      {showModal &&
        visibility &&
        createPortal(
          <div className="z-[100] bg-black bg-opacity-50 w-screen h-screen absolute top-0 left-0 grid place-items-center">
            <div className="bg-[color:var(--color-secondary)] absolute w-[50rem] h-fit p-[1vw] flex flex-col gap-[1vw] justify-center items-center">
              <p className="text-[color:var(--color-text)] text-[2rem] font-bold text-start">
                Are you sure you want to exit? You have items in your cart.
              </p>
              <div className="flex flex-row justify-between w-full gap-[2vw]">
                <button
                  className="bg-[color:var(--color-tertiary)] text-[color:var(--color-text)] text-[2rem] px-[1rem] py-[0.5rem] w-full hover:cursor-pointer"
                  onClick={() => setShowModal(false)}
                >
                  No
                </button>
                <button
                  className="bg-[color:var(--color-tertiary)] text-[color:var(--color-text)] text-[2rem] px-[1rem] py-[0.5rem] w-full hover:cursor-pointer"
                  onClick={() => {
                    sendNUI('hideUI');
                    setShowModal(false);
                    setVisibility(false);
                    setShow(false);
                  }}
                >
                  Yes
                </button>
              </div>
            </div>
          </div>,
          document.body
        )}
    </>
  );
}
