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
  /** Absent for a brand-new preview object, real handle for a cart/owned item. */
  entity?: number;
}

/** Emitted every frame while the freecam moves (modeler.lua:60). */
interface UpdateCameraMessage {
  cameraPosition: position;
  cameraLookAt: position;
}

export type GizmoMode = 'translate' | 'rotate';

/** Lua's own starting alpha (modeler.lua:101) — never override it on mount. */
export const DEFAULT_OBJECT_ALPHA = 200;

interface ModelState {
  show: boolean;
  cameraPosition: position;
  cameraLookAt: position;
  objectPosition: position;
  objectEuler: Euler;
  entity: number | null;

  // Gizmo settings — shared between the placement card and the Scene.
  mode: GizmoMode;
  translationSnap: number;
  rotationSnapDegrees: number;
  objectAlpha: number;

  setShow: (val: boolean) => void;
  setObjectPosition: (pos: position) => void;
  setObjectEuler: (euler: Euler) => void;
  setEntity: (entity: number | null) => void;
  setMode: (mode: GizmoMode) => void;
  toggleMode: () => void;
  setTranslationSnap: (snap: number) => void;
  setRotationSnapDegrees: (deg: number) => void;
  setObjectAlpha: (alpha: number) => void;
  applyObjectAlpha: (alpha: number) => void;
  setupModel: (data: SetupModelMessage) => void;
  updateCamera: (data: UpdateCameraMessage) => void;
  sendMovementUpdate: (pos: position) => void;
  sendRotationUpdate: (euler: position) => void;
}

export const useModelStore = create<ModelState>((set, get) => ({
  show: false,
  cameraPosition: { x: 0, y: 0, z: 1 },
  cameraLookAt: { x: 0, y: 0, z: 10 },
  objectPosition: { x: 0, y: 0, z: 10 },
  objectEuler: new Euler(0, 0, 0, 'ZXY'),
  entity: null,

  mode: 'translate',
  translationSnap: 0.01,
  rotationSnapDegrees: 15,
  objectAlpha: DEFAULT_OBJECT_ALPHA,

  setShow: (val) => set({ show: val }),
  setObjectPosition: (pos) => set({ objectPosition: pos }),
  setObjectEuler: (euler) => set({ objectEuler: euler }),
  setEntity: (entity) => set({ entity }),
  setMode: (mode) => set({ mode }),
  toggleMode: () =>
    set({ mode: get().mode === 'translate' ? 'rotate' : 'translate' }),
  setTranslationSnap: (translationSnap) => set({ translationSnap }),
  setRotationSnapDegrees: (rotationSnapDegrees) => set({ rotationSnapDegrees }),

  /** Mirrors Lua's value without echoing it back (inbound `setObjectAlpha`). */
  setObjectAlpha: (objectAlpha) => set({ objectAlpha }),

  /** User-driven change: update the slider and push it to the game. */
  applyObjectAlpha: (alpha) => {
    set({ objectAlpha: alpha });
    // Asymmetric on purpose: Lua emits a raw number but expects { alpha }.
    sendNUI('setObjectAlpha', { alpha }).catch(() => {});
  },

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
      entity: data.entity ?? null,
    }),

  updateCamera: (data) =>
    set({
      cameraPosition: convertToThreeCordSystem(data.cameraPosition),
      cameraLookAt: convertToThreeCordSystem(data.cameraLookAt),
    }),

  sendMovementUpdate: (pos) => {
    sendNUI('moveObject', pos).catch(() => {});
  },

  sendRotationUpdate: (euler) => {
    const gtaCoords = convertToGTACordSystem(euler);
    // Lua coerces these back to numbers via `+ 0.0` (modeler.lua:624).
    sendNUI('rotateObject', {
      x: MathUtils.radToDeg(gtaCoords.x).toFixed(2),
      y: MathUtils.radToDeg(gtaCoords.y).toFixed(2),
      z: MathUtils.radToDeg(gtaCoords.z).toFixed(2),
    }).catch(() => {});
  },
}));
