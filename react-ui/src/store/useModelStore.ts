import { create } from 'zustand';
import { Euler, MathUtils } from 'three';
import { sendNUI } from '@utils/sendNUI';
import type { position } from '@customTypes/types';
import { convertToThreeCordSystem, convertToGTACordSystem } from '@customTypes/types';

interface SetupModelMessage {
  objectPosition: position;
  objectRotation: position;
  cameraPosition: position;
  cameraLookAt: position;
  entity: number;
}

interface UpdateCameraMessage {
  cameraPosition: position;
  cameraLookAt: position;
  objectPosition: position;
}

interface ModelState {
  show: boolean;
  cameraPosition: position;
  cameraLookAt: position;
  objectPosition: position;
  objectEuler: Euler;
  entity: number | null;

  setShow: (val: boolean) => void;
  setObjectPosition: (pos: position) => void;
  setObjectEuler: (euler: Euler) => void;
  setEntity: (entity: number | null) => void;
  setupModel: (data: SetupModelMessage) => void;
  updateCamera: (data: UpdateCameraMessage) => void;
  sendMovementUpdate: (pos: position) => void;
  sendRotationUpdate: (euler: position) => void;
}

export const useModelStore = create<ModelState>((set) => ({
  show: false,
  cameraPosition: { x: 0, y: 0, z: 1 },
  cameraLookAt: { x: 0, y: 0, z: 10 },
  objectPosition: { x: 0, y: 0, z: 10 },
  objectEuler: new Euler(0, 0, 0, 'ZXY'),
  entity: null,

  setShow: (val) => set({ show: val }),
  setObjectPosition: (pos) => set({ objectPosition: pos }),
  setObjectEuler: (euler) => set({ objectEuler: euler }),
  setEntity: (entity) => set({ entity }),

  setupModel: (data) =>
    set({
      cameraPosition: convertToThreeCordSystem(data.cameraPosition),
      cameraLookAt: convertToThreeCordSystem(data.cameraLookAt),
      objectPosition: convertToThreeCordSystem(data.objectPosition),
      objectEuler: new Euler(
        MathUtils.degToRad(data.objectRotation.x),
        MathUtils.degToRad(data.objectRotation.z),
        MathUtils.degToRad(data.objectRotation.y),
        'YZX'
      ),
      show: true,
      entity: data.entity,
    }),

  updateCamera: (data) =>
    set({
      cameraPosition: convertToThreeCordSystem(data.cameraPosition),
      cameraLookAt: convertToThreeCordSystem(data.cameraLookAt),
    }),

  sendMovementUpdate: (pos) => {
    sendNUI('moveObject', pos);
  },

  sendRotationUpdate: (euler) => {
    const gtaCoords = convertToGTACordSystem(euler);
    sendNUI('rotateObject', {
      x: MathUtils.radToDeg(gtaCoords.x).toFixed(2),
      y: MathUtils.radToDeg(gtaCoords.y).toFixed(2),
      z: MathUtils.radToDeg(gtaCoords.z).toFixed(2),
    });
  },
}));
