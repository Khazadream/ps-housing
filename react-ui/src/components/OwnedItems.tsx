import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';

export default function OwnedItems() {
  const isOwnedItemsOpen = useStore((s) => s.isOwnedItemsOpen);
  const setIsOwnedItemsOpen = useStore((s) => s.setIsOwnedItemsOpen);
  const ownedItems = useStore((s) => s.ownedItems);

  if (!isOwnedItemsOpen) return null;

  return (
    <div className="w-[40rem] h-[60rem] bg-[color:var(--color-primary)] absolute right-0 -top-[65rem] flex flex-col gap-[1rem]">
      <div className="flex flex-row gap-2">
        <h1 className="bg-[color:var(--color-secondary)] text-[2rem] py-4 w-full h-fit text-center">
          Meubles achetés
        </h1>
        <button
          className="bg-[color:var(--color-secondary)] text-[2rem] py-4 h-full text-center aspect-square"
          onClick={() => setIsOwnedItemsOpen(false)}
        >
          <i className="fa-solid fa-xmark" />
        </button>
      </div>
      <div className="flex flex-col gap-2 px-4 overflow-scroll h-full scroll-style scroll-style-vertical">
        {ownedItems.map((item: any, i) => (
          <div
            key={i}
            className="flex flex-row gap-2 w-full justify-between bg-[color:var(--color-secondary)] p-4 items-center"
          >
            <button
              className="bg-[color:var(--color-tertiary)] text-[2rem] w-[4rem] h-[4rem] text-center aspect-square"
              onClick={() => {
                sendNUI('selectOwnedItem', item);
              }}
            >
              <i className="fa-solid fa-magnifying-glass" />
            </button>
            <div className="flex flex-col gap-2 w-full">
              <h1 className="text-[2rem]">{item.label}</h1>
            </div>
            <button
              className="bg-[color:var(--color-tertiary)] text-[2rem] py-4 h-full text-center aspect-square"
              onClick={() => {
                sendNUI('removeOwnedItem', item);
              }}
            >
              <i className="fa-solid fa-xmark" />
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
