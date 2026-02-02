import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';

export default function Cart() {
  const isCartOpen = useStore((s) => s.isCartOpen);
  const setIsCartOpen = useStore((s) => s.setIsCartOpen);
  const cart = useStore((s) => s.cart);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);

  if (!isCartOpen) return null;

  const subtotal = cart.reduce((acc, item) => acc + item.price, 0);

  return (
    <div className="w-[40rem] h-[60rem] bg-[color:var(--color-primary)] absolute right-0 -top-[65rem] flex flex-col gap-[1rem] p-12">
      <div className="font-medium">
        <p>VOTRE PANIER</p>
      </div>
      <div className="flex flex-col gap-2 overflow-scroll h-[73%] scroll-style scroll-style-vertical">
        {cart.map((item, i) => (
          <button
            key={i}
            className="flex flex-row gap-2 w-full min-h-[8rem] justify-between bg-[color:var(--color-secondary)] items-center"
            onClick={() => {
              sendNUI('selectCartItem', item);
            }}
          >
            <div className="flex flex-col gap-2 w-full text-start ml-10">
              <h1 className="text-[2rem]">{item.label}</h1>
              <div className="flex text-[1.5rem]">
                <h1>Prix:</h1>
                <h1 className="text-[color:var(--color-accent)] font-bold ml-2">
                  ${item.price}
                </h1>
              </div>
            </div>
            <button
              className="bg-[color:var(--color-tertiary)] text-[2rem] py-4 h-full text-center aspect-square"
              onClick={(e) => {
                e.stopPropagation();
                sendNUI('removeCartItem', item);
              }}
            >
              <i className="fa-solid fa-trash" />
            </button>
          </button>
        ))}
      </div>
      <div className="flex flex-col gap-2 items-center justify-center h-[5rem] mt-10">
        <div className="text-[1.6rem] w-full h-full flex items-center justify-between">
          <h1>SOUS-TOTAL:</h1>
          <h1>${subtotal}</h1>
        </div>
        <div className="flex w-full h-full justify-between">
          <button
            className="bg-[color:var(--color-secondary)] mt-2 font-medium h-full w-[20%] py-14 gap-4 whitespace-nowrap flex flex-row items-center justify-center px-8 text-center"
            onClick={() => setIsCartOpen(false)}
          >
            <i className="fa-solid fa-xmark" />
          </button>
          <button
            className="bg-[color:var(--color-accent)] text-[2rem] mt-2 font-medium h-full w-[79%] py-14 gap-4 whitespace-nowrap flex flex-row items-center justify-center px-8 text-center"
            onClick={() => {
              setCurrentFurniture(null);
              sendNUI('buyCartItems');
            }}
          >
            <p>Acheter</p>
          </button>
        </div>
      </div>
    </div>
  );
}
