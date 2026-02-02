import { useState } from 'react';
import { debugData } from '@utils/debugData';

const debugItems = [
  { label: 'Item 1', object: 'v_res_d_coffeetable', price: 100 },
  { label: 'Item 2', object: 'v_res_d_coffeetable', price: 100 },
  { label: 'Item 3', object: 'v_res_d_coffeetable', price: 100 },
  { label: 'Item 4', object: 'v_res_d_coffeetable', price: 100 },
  { label: 'Item 5', object: 'v_res_d_coffeetable', price: 100 },
];

const debugFurnitures = [
  { category: 'Category 1', items: debugItems },
  { category: 'Category 2', items: debugItems },
  { category: 'Category 3', items: debugItems },
  { category: 'Category 4', items: debugItems },
  { category: 'Category 5', items: debugItems },
];

const debugSetupModel = {
  objectPosition: { x: 0, y: 0, z: 0 },
  objectRotation: { x: 0, y: 0, z: 0 },
  cameraPosition: { x: 5, y: 5, z: 5 },
  cameraLookAt: { x: 0, y: 0, z: 0 },
  entity: null,
};

const options = [
  {
    component: 'Show',
    actions: [
      { name: 'show', action: 'setVisible', data: true },
      { name: 'hide', action: 'setVisible', data: false },
    ],
  },
  {
    component: 'Furniture',
    actions: [
      {
        name: 'Set Furniture Data',
        action: 'setFurnituresData',
        data: debugFurnitures,
      },
    ],
  },
  {
    component: 'Modeler',
    actions: [
      {
        name: 'Setup Model',
        action: 'setupModel',
        data: debugSetupModel,
      },
    ],
  },
];

export default function DebugBrowser() {
  const [show, setShow] = useState(false);

  return (
    <div className="absolute top-0 left-1/2 z-[1000]">
      <button
        className="bg-red-500 text-white p-2"
        onClick={() => setShow(!show)}
      >
        Show
      </button>
      {show && (
        <div className="w-fit h-fit bg-gray-600 p-2">
          {options.map((option, i) => (
            <div key={i} className="flex flex-row gap-2 items-center m-1">
              <p className="text-white">{option.component}</p>
              {option.actions.map((action, j) => (
                <button
                  key={j}
                  className="bg-blue-500 text-white p-2"
                  onClick={() => {
                    debugData([
                      { action: action.action, data: action.data },
                    ]);
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
