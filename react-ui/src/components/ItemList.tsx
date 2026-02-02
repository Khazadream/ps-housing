import { useRef, useState } from 'react';
import { createPortal } from 'react-dom';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import type { IFurniture } from '@customTypes/types';

export default function ItemList() {
  const showFurnitures = useStore((s) => s.showFurnitures);
  const currentFurniture = useStore((s) => s.currentFurniture);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsMenuMinimized = useStore((s) => s.setIsMenuMinimized);
  const ownedItems = useStore((s) => s.ownedItems);

  const scrollableRef = useRef<HTMLDivElement>(null);
  const [showModal, setShowModal] = useState(false);
  const [switchToFurniture, setSwitchToFurniture] =
    useState<IFurniture | null>(null);

  function scrollHorizontally(e: React.WheelEvent) {
    if (scrollableRef.current) {
      const delta = Math.max(
        -1,
        Math.min(1, (e as any).wheelDelta || -e.deltaY)
      );
      scrollableRef.current.scrollLeft -= delta * 50;
      e.preventDefault();
    }
  }

  if (!showFurnitures) return null;

  return (
    <>
      <div className="w-full h-[24rem] bg-[color:var(--color-primary)] p-[2rem]">
        <div
          ref={scrollableRef}
          onWheel={scrollHorizontally}
          className="grid grid-rows-2 grid-flow-col-dense gap-[2rem] overflow-x-scroll overflow-y-hidden w-fit max-w-full h-full relative scroll-style scroll-style-horizontal"
        >
          {showFurnitures.items.map((furniture, i) => (
            <button
              key={i}
              className="h-full w-[30rem] bg-[color:var(--color-secondary)] flex flex-row items-center hover:cursor-pointer"
              onClick={() => {
                sendNUI('hoverOut');

                if (furniture.type) {
                  const itemsWithSameType = ownedItems.filter(
                    (item: any) => item.type === furniture.type
                  );
                  const furnitureTypeMax = furniture.max;
                  if (
                    furnitureTypeMax &&
                    itemsWithSameType.length >= furnitureTypeMax
                  ) {
                    sendNUI('showNotification', {
                      type: 'error',
                      message: `Vous ne pouvez avoir que ${furnitureTypeMax} de ce type d'objet!`,
                    });
                    return;
                  }
                }

                if (currentFurniture != null) {
                  setShowModal(true);
                  setSwitchToFurniture(furniture);
                } else {
                  sendNUI('previewFurniture', furniture);
                  setCurrentFurniture(furniture);
                  setIsMenuMinimized(true);
                }
              }}
              onMouseLeave={() => {
                sendNUI('hoverOut');
              }}
            >
              <div className="w-full h-full flex flex-col justify-center items-start ml-10">
                <p className="text-[color:var(--color-text)] text-[2rem] font-bold text-start">
                  {furniture.label}
                </p>
                <div className="flex">
                  <p className="text-[color:var(--color-text)] text-[1.2rem]">
                    Prix:
                  </p>
                  <p className="text-[color:var(--color-accent)] ml-2 font-bold text-[1.2rem]">
                    ${furniture.price}
                  </p>
                </div>
              </div>
              <div
                className="bg-[color:var(--color-tertiary)] aspect-square h-full grid place-items-center justify-center items-center"
                onMouseEnter={() => {
                  sendNUI('hoverIn', furniture);
                }}
                onMouseLeave={(e) => {
                  e.stopPropagation();
                  sendNUI('hoverOut');
                }}
              >
                <i className="fas fa-eye text-[color:var(--color-text)] text-[2.5rem]" />
              </div>
            </button>
          ))}
        </div>
      </div>

      {showModal &&
        createPortal(
          <div className="z-[100] bg-black bg-opacity-50 w-screen h-screen absolute top-0 left-0 grid place-items-center">
            <div className="bg-[color:var(--color-secondary)] absolute w-[50rem] h-fit p-[1vw] flex flex-col gap-[1vw] justify-center items-center">
              <p className="text-[color:var(--color-text)] text-[2rem] font-bold text-start">
                Êtes-vous sûr de vouloir arrêter le placement de cet objet?
              </p>
              <div className="flex flex-row justify-between w-full gap-[2vw]">
                <button
                  className="bg-[color:var(--color-tertiary)] text-[color:var(--color-text)] text-[2rem] px-[1rem] py-[0.5rem] w-full hover:cursor-pointer"
                  onClick={() => {
                    setShowModal(false);
                    setSwitchToFurniture(null);
                  }}
                >
                  Non
                </button>
                <button
                  className="bg-[color:var(--color-tertiary)] text-[color:var(--color-text)] text-[2rem] px-[1rem] py-[0.5rem] w-full hover:cursor-pointer"
                  onClick={() => {
                    sendNUI('previewFurniture', switchToFurniture);
                    setCurrentFurniture(switchToFurniture);
                    setIsMenuMinimized(true);
                    setShowModal(false);
                    setSwitchToFurniture(null);
                  }}
                >
                  Oui
                </button>
              </div>
            </div>
          </div>,
          document.body
        )}
    </>
  );
}
