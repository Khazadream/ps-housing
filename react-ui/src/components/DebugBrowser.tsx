import { useState } from 'react';
import { debugData } from '@utils/debugData';

/**
 * Browser-only control panel. Injects the same messages client/modeler.lua
 * sends, so the three wireframe screens can be validated without the game.
 */

const item = (
  label: string,
  object: string,
  price: number,
  extra: Record<string, unknown> = {}
) => ({ label, object, price, ...extra });

// Mirrors the real Config.Furnitures shape and category names (shared/config.lua:1039).
const debugFurnitures = [
  {
    category: 'Prérequis',
    items: [
      item('Unité de stockage', 'v_res_tre_storagebox', 0, { type: 'storage', max: 2 }),
      item('Penderie', 'v_res_tre_wardrobe', 0, { type: 'clothing', max: 2 }),
    ],
  },
  {
    category: 'Meubles',
    items: [
      item('Vieux canapé', 'miss_rub_couch_01', 300),
      item('Canapé 3 places', 'prop_fib_3b_bench', 700),
      item('Vieille chaise', 'prop_ld_farm_chair01', 250),
      item('Vieux canapé rayé', 'prop_ld_farm_couch02', 300),
      item('Fauteuil jaune', 'v_res_d_armchair', 300),
      item("Canapé d'angle", 'v_res_fh_sofa', 3700),
    ],
  },
  {
    // Every prop of this category is a container (config.lua MapToStorage).
    category: 'Stockage',
    items: [
      item('Grande armoire', 'v_res_cabinet', 2500, { type: 'storage' }),
      item('Coiffeuse', 'v_res_d_dressingtable', 2500, { type: 'storage' }),
      item('Coffre-fort', 'prop_ld_int_safe_01', 1100, { type: 'storage' }),
    ],
  },
  {
    category: 'Stockage déco',
    items: [
      item('Grande armoire (déco)', 'v_res_cabinet', 2500),
      item('Coiffeuse (déco)', 'v_res_d_dressingtable', 2500),
      item('Coffre-fort (déco)', 'prop_ld_int_safe_01', 1100),
    ],
  },
  {
    category: 'Éclairage',
    items: [
      item('Lampe de bureau', 'prop_off_desk_lamp', 180),
      item('Lampadaire noir', 'prop_stand_lamp_01', 260),
      item('Lampe de chevet', 'v_res_bedlamp', 140),
    ],
  },
  {
    category: 'Tables',
    items: [
      item('Table basse', 'v_res_d_coffeetable', 180),
      item('Table à manger', 'v_res_tre_table', 400),
    ],
  },
  {
    category: 'Électronique',
    items: [item('TV 55"', 'prop_tv_flat_01', 900)],
  },
  {
    category: 'Plantes',
    items: [item('Plante verte', 'prop_plant_int_02a', 90)],
  },
];

const debugOwnedItems = [
  {
    entity: 101,
    id: '482913-1',
    label: 'Unité de stockage',
    object: 'v_res_tre_storagebox',
    position: { x: 0, y: 0, z: 0 },
    rotation: { x: 0, y: 0, z: 0 },
    type: 'storage',
  },
  {
    entity: 102,
    id: '482914-1',
    label: 'Penderie',
    object: 'v_res_tre_wardrobe',
    position: { x: 1, y: 0, z: 0 },
    rotation: { x: 0, y: 0, z: 0 },
    type: 'clothing',
  },
  {
    entity: 103,
    id: '482915-1',
    label: 'Canapé 3 places',
    object: 'prop_fib_3b_bench',
    position: { x: 2, y: 0, z: 0 },
    rotation: { x: 0, y: 0, z: 0 },
  },
  {
    entity: 104,
    id: '482916-1',
    label: 'TV 55"',
    object: 'prop_tv_flat_01',
    position: { x: 3, y: 0, z: 0 },
    rotation: { x: 0, y: 0, z: 0 },
  },
];

const debugSetupModel = {
  objectPosition: { x: 0, y: 0, z: 0 },
  objectRotation: { x: 0, y: 0, z: 0 },
  cameraPosition: { x: 5, y: 5, z: 5 },
  cameraLookAt: { x: 0, y: 0, z: 0 },
};

const debugCartItem = {
  label: 'Table basse',
  object: 'v_res_d_coffeetable',
  price: 180,
  entity: 201,
  position: { x: 0, y: 0, z: 0 },
  rotation: { x: 0, y: 0, z: 0 },
};

const options = [
  {
    component: 'Visibilité',
    actions: [
      { name: 'Afficher', action: 'setVisible', data: true },
      { name: 'Masquer', action: 'setVisible', data: false },
    ],
  },
  {
    component: 'Catalogue',
    actions: [
      { name: 'Charger', action: 'setFurnituresData', data: debugFurnitures },
      { name: 'Vider', action: 'setFurnituresData', data: {} },
    ],
  },
  {
    component: 'Posés',
    actions: [
      { name: 'Charger', action: 'setOwnedItems', data: debugOwnedItems },
      // Lua sends {} — exercises the Array.isArray guard.
      { name: 'Vider ({})', action: 'setOwnedItems', data: {} },
    ],
  },
  {
    component: 'Stock. max',
    actions: [
      { name: '0', action: 'setMaxStash', data: 0 },
      { name: '2', action: 'setMaxStash', data: 2 },
      { name: '6', action: 'setMaxStash', data: 6 },
    ],
  },
  {
    component: 'Panier',
    actions: [
      { name: 'Ajouter', action: 'addToCart', data: debugCartItem },
      { name: 'Vider', action: 'clearCart', data: undefined },
    ],
  },
  {
    component: 'Placement',
    actions: [
      { name: 'Nouvel objet', action: 'setupModel', data: debugSetupModel },
      {
        name: 'Repositionner',
        action: 'setupModel',
        data: { ...debugSetupModel, entity: 201 },
      },
      { name: 'Alpha 200', action: 'setObjectAlpha', data: 200 },
    ],
  },
];

export default function DebugBrowser() {
  const [show, setShow] = useState(false);

  return (
    <div className="absolute left-1/2 top-0 z-[1000] font-sans">
      <button
        className="bg-tacoma-red px-3 py-1 text-[12px] font-bold text-tacoma-paper"
        onClick={() => setShow(!show)}
      >
        DEBUG
      </button>

      {show && (
        <div className="flex w-fit flex-col gap-2 border border-tacoma-cardline bg-zinc-950 p-3">
          {options.map((option) => (
            <div key={option.component} className="flex items-center gap-2">
              <span className="w-[90px] shrink-0 font-mono text-[10px] uppercase tracking-[0.12em] text-tacoma-mut2">
                {option.component}
              </span>
              {option.actions.map((action) => (
                <button
                  key={action.name}
                  className="border border-tacoma-slot px-2 py-1 text-[12px] text-tacoma-cream hover:border-tacoma-gold hover:text-tacoma-paper"
                  onClick={() => {
                    debugData([{ action: action.action, data: action.data }]);
                  }}
                >
                  {action.name}
                </button>
              ))}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
