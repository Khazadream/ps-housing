import { fr } from '@locales/fr';

/** Brand mark at the top of the rail. */
export default function RailBrand() {
  return (
    <span className="block text-center font-kanit text-[19px] font-thin leading-none tracking-[0.22em] text-tacoma-paper">
      {fr.brand.name} <span className="text-green-500">{fr.brand.suffix}</span>
    </span>
  );
}
