import { useEffect, useRef, useState, useCallback } from 'react';
import { Canvas, useThree } from '@react-three/fiber';
import { TransformControls } from '@react-three/drei';
import {
  BoxGeometry,
  MeshStandardMaterial,
  MathUtils,
  Euler,
  PerspectiveCamera as ThreePerspectiveCamera,
  Vector3,
} from 'three';
import type { Mesh as ThreeMesh } from 'three';
import { useModelStore } from '@store/useModelStore';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { useNuiEvent } from '@utils/useNuiEvent';
import {
  convertToGTACordSystem,
  convertToThreeCordSystem,
} from '@customTypes/types';
import { fr } from '@locales/fr';

const t = fr.modeler;
const boxGeo = new BoxGeometry(0, 0, 0);
const boxMat = new MeshStandardMaterial();

// ─── Sub-components ──────────────────────────────────────────

interface SectionProps {
  icon: string;
  title: string;
  children: React.ReactNode;
}

function PanelSection({ icon, title, children }: SectionProps) {
  return (
    <div className="flex flex-col gap-3">
      <div className="flex items-center gap-3 text-white/60 text-2xl uppercase tracking-wider">
        <i className={`fa-solid ${icon} text-xl`} />
        <span>{title}</span>
      </div>
      <div className="flex flex-col gap-4 pl-1">{children}</div>
    </div>
  );
}

interface CoordDisplayProps {
  label: string;
  value: number;
}

function CoordChip({ label, value }: CoordDisplayProps) {
  return (
    <div className="bg-[color:var(--color-secondary)] rounded-lg flex flex-col items-center min-w-[9rem] px-5 py-3">
      <span className="text-white/50 text-lg uppercase">{label}</span>
      <span className="text-white text-2xl font-mono">{value.toFixed(2)}</span>
    </div>
  );
}

interface SliderRowProps {
  icon: string;
  label: string;
  value: number;
  min: number;
  max: number;
  step: number;
  displayValue?: string;
  onChange: (val: number) => void;
}

function SliderRow({ icon, label, value, min, max, step, displayValue, onChange }: SliderRowProps) {
  return (
    <div className="flex flex-col gap-2">
      <div className="flex items-center justify-between text-xl text-white/50">
        <span className="flex items-center gap-2">
          <i className={`fa-solid ${icon} text-lg`} />
          {label}
        </span>
        <span className="font-mono text-xl bg-[color:var(--color-secondary)] rounded-lg px-4 py-1">
          {displayValue ?? value}
        </span>
      </div>
      <input
        type="range"
        min={min}
        max={max}
        step={step}
        value={value}
        onChange={(e) => onChange(parseFloat(e.target.value))}
        className="w-full h-3 accent-[color:var(--color-accent)]"
      />
    </div>
  );
}

interface ActionButtonProps {
  icon: string;
  label: string;
  onClick: () => void;
  variant?: 'default' | 'danger';
  fullWidth?: boolean;
}

function ActionButton({ icon, label, onClick, variant = 'default', fullWidth = false }: ActionButtonProps) {
  const base = 'flex items-center justify-center gap-3 rounded-lg px-6 py-4 text-2xl font-medium transition-all hover:brightness-125';
  const colors = variant === 'danger'
    ? 'bg-red-600/80 text-white'
    : 'bg-[color:var(--color-secondary)] text-white';
  return (
    <button className={`${base} ${colors} ${fullWidth ? 'w-full' : ''}`} onClick={onClick}>
      <i className={`fa-solid ${icon}`} />
      <span>{label}</span>
    </button>
  );
}

// ─── Three.js internals (unchanged logic) ────────────────────

function CameraSetup() {
  const { camera } = useThree();
  const cameraPosition = useModelStore((s) => s.cameraPosition);
  const cameraLookAt = useModelStore((s) => s.cameraLookAt);

  useEffect(() => {
    camera.position.set(cameraPosition.x, cameraPosition.y, cameraPosition.z);
    (camera as ThreePerspectiveCamera).lookAt(
      new Vector3(cameraLookAt.x, cameraLookAt.y, cameraLookAt.z)
    );
    camera.updateProjectionMatrix();
  }, [camera, cameraPosition, cameraLookAt]);

  return null;
}

interface SceneProps {
  mode: 'translate' | 'rotate';
  translationSnap: number;
  rotationSnapDegrees: number;
}

function Scene({ mode, translationSnap, rotationSnapDegrees }: SceneProps) {
  const meshRef = useRef<ThreeMesh>(null!);
  const transformRef = useRef<any>(null);
  const [meshReady, setMeshReady] = useState(false);

  const objectPosition = useModelStore((s) => s.objectPosition);
  const objectEuler = useModelStore((s) => s.objectEuler);
  const entity = useModelStore((s) => s.entity);
  const setObjectPosition = useModelStore((s) => s.setObjectPosition);
  const setObjectEuler = useModelStore((s) => s.setObjectEuler);
  const sendMovementUpdate = useModelStore((s) => s.sendMovementUpdate);
  const sendRotationUpdate = useModelStore((s) => s.sendRotationUpdate);

  const cart = useStore((s) => s.cart);
  const setCart = useStore((s) => s.setCart);

  const meshCallback = useCallback((node: ThreeMesh | null) => {
    (meshRef as any).current = node;
    setMeshReady(!!node);
  }, []);

  useEffect(() => {
    if (meshRef.current) {
      meshRef.current.position.set(objectPosition.x, objectPosition.y, objectPosition.z);
      meshRef.current.rotation.set(objectEuler.x, objectEuler.y, objectEuler.z, objectEuler.order);
    }
  }, [objectPosition, objectEuler]);

  useEffect(() => {
    const controls = transformRef.current;
    if (!controls) return;

    const onDraggingChanged = (event: any) => {
      const isDragging = event.value;
      if (!isDragging && entity != null && meshRef.current) {
        const item = cart.find((i) => i.entity === entity);
        if (!item) return;
        const mesh = meshRef.current;
        const gtaPos = convertToGTACordSystem({ x: mesh.position.x, y: mesh.position.y, z: mesh.position.z });
        const gtaRot = convertToGTACordSystem({ x: mesh.rotation.x, y: mesh.rotation.y, z: mesh.rotation.z });
        item.position = gtaPos;
        item.rotation = gtaRot;
        setCart([...cart]);
        sendNUI('updateCartItem', item);
      }
    };

    controls.addEventListener('dragging-changed', onDraggingChanged);
    return () => controls.removeEventListener('dragging-changed', onDraggingChanged);
  }, [meshReady, entity, cart, setCart]);

  const handleObjectChange = useCallback(() => {
    if (!meshRef.current) return;
    const mesh = meshRef.current;

    const newPos = { x: mesh.position.x, y: mesh.position.y, z: mesh.position.z };
    const storePos = useModelStore.getState().objectPosition;
    const storeEuler = useModelStore.getState().objectEuler;

    if (newPos.x !== storePos.x || newPos.y !== storePos.y || newPos.z !== storePos.z) {
      setObjectPosition(newPos);
      sendMovementUpdate(convertToGTACordSystem(newPos));
    }

    if (mesh.rotation.x !== storeEuler.x || mesh.rotation.y !== storeEuler.y || mesh.rotation.z !== storeEuler.z) {
      const eulerPos = { x: mesh.rotation.x, y: mesh.rotation.y, z: mesh.rotation.z };
      setObjectEuler(mesh.rotation.clone());
      sendRotationUpdate(eulerPos);
    }
  }, [setObjectPosition, setObjectEuler, sendMovementUpdate, sendRotationUpdate]);

  return (
    <>
      <CameraSetup />
      <mesh
        ref={meshCallback}
        position={[objectPosition.x, objectPosition.y, objectPosition.z]}
        rotation={[objectEuler.x, objectEuler.y, objectEuler.z, objectEuler.order]}
        geometry={boxGeo}
        material={boxMat}
      />
      {meshReady && meshRef.current && (
        <TransformControls
          ref={transformRef}
          object={meshRef.current}
          mode={mode}
          translationSnap={translationSnap}
          rotationSnap={MathUtils.degToRad(rotationSnapDegrees)}
          size={0.5}
          space="local"
          onChange={handleObjectChange}
        />
      )}
    </>
  );
}

// ─── Main Modeler component ──────────────────────────────────

export default function Modeler() {
  const show = useModelStore((s) => s.show);
  const setShow = useModelStore((s) => s.setShow);
  const entity = useModelStore((s) => s.entity);
  const objectPosition = useModelStore((s) => s.objectPosition);
  const objectEuler = useModelStore((s) => s.objectEuler);
  const cameraLookAt = useModelStore((s) => s.cameraLookAt);
  const setObjectPosition = useModelStore((s) => s.setObjectPosition);
  const setObjectEuler = useModelStore((s) => s.setObjectEuler);
  const browserMode = useStore((s) => s.browserMode);
  const currentFurniture = useStore((s) => s.currentFurniture);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const cart = useStore((s) => s.cart);

  const [isPanelOpen, setIsPanelOpen] = useState(false);
  const [objectAlpha, setObjectAlpha] = useState(255);
  const [mode, setMode] = useState<'translate' | 'rotate'>('translate');
  const [translationSnap, setTranslationSnap] = useState(0.01);
  const [rotationSnapDegrees, setRotationSnapDegrees] = useState(1);

  useNuiEvent<number>('setObjectAlpha', (data) => setObjectAlpha(data));

  useEffect(() => {
    sendNUI('setObjectAlpha', { alpha: objectAlpha });
  }, [objectAlpha]);

  useEffect(() => {
    if (!show) return;
    function changeMode(e: MouseEvent) {
      if (e.button === 2) {
        setMode((prev) => (prev === 'translate' ? 'rotate' : 'translate'));
      }
    }
    document.addEventListener('contextmenu', changeMode);
    return () => document.removeEventListener('contextmenu', changeMode);
  }, [show]);

  if (!show) return null;

  const isTranslate = mode === 'translate';

  return (
    <div className={`modeler z-[0] absolute h-screen w-screen ${browserMode ? 'bg-gray-800' : ''}`}>
      <Canvas camera={{ fov: 45 }}>
        <Scene mode={mode} translationSnap={translationSnap} rotationSnapDegrees={rotationSnapDegrees} />
      </Canvas>

      {/* ── Side Panel ── */}
      <div
        className={`absolute top-16 z-10 transition-all duration-300 ${
          isPanelOpen ? 'left-4' : '-left-[42rem]'
        }`}
      >
        <div className="flex flex-row">
          {/* Panel content */}
          <div className="w-[40rem] bg-[color:var(--color-primary)] rounded-l-lg shadow-2xl flex flex-col gap-7 p-8 max-h-[85vh] overflow-y-auto">
            {/* Header */}
            <div className="flex items-center gap-4 text-white text-4xl font-semibold border-b border-white/10 pb-5">
              <i className="fa-solid fa-cube text-3xl" />
              <span>{t.panelTitle}</span>
            </div>

            {/* Mode toggle */}
            <div className="flex gap-3">
              <button
                className={`flex-1 flex items-center justify-center gap-3 rounded-lg px-5 py-4 text-2xl font-medium transition-all ${
                  isTranslate ? 'bg-[color:var(--color-accent)] text-white' : 'bg-[color:var(--color-secondary)] text-white/60 hover:text-white'
                }`}
                onClick={() => setMode('translate')}
              >
                <i className="fa-solid fa-arrows-up-down-left-right text-xl" />
                {t.modeTranslation}
              </button>
              <button
                className={`flex-1 flex items-center justify-center gap-3 rounded-lg px-5 py-4 text-2xl font-medium transition-all ${
                  !isTranslate ? 'bg-[color:var(--color-accent)] text-white' : 'bg-[color:var(--color-secondary)] text-white/60 hover:text-white'
                }`}
                onClick={() => setMode('rotate')}
              >
                <i className="fa-solid fa-rotate text-xl" />
                {t.modeRotation}
              </button>
            </div>

            <div className="border-t border-white/10" />

            {/* Position section */}
            <PanelSection icon="fa-location-crosshairs" title={t.positionTitle}>
              <div className="flex gap-2">
                <CoordChip label="X" value={objectPosition.x} />
                <CoordChip label="Y" value={-objectPosition.z} />
                <CoordChip label="Z" value={objectPosition.y} />
              </div>
              <SliderRow
                icon="fa-crosshairs"
                label={t.snapLabel}
                value={translationSnap}
                min={0.01}
                max={1}
                step={0.01}
                onChange={setTranslationSnap}
              />
              <div className="flex gap-2">
                <ActionButton
                  icon="fa-location-dot"
                  label={t.resetPosition}
                  onClick={() => setObjectPosition({ ...cameraLookAt })}
                />
                <ActionButton
                  icon="fa-arrow-down"
                  label={t.placeOnGround}
                  onClick={() => {
                    sendNUI('placeOnGround').then((data: any) => {
                      const coords = convertToThreeCordSystem(data);
                      setObjectPosition(coords);
                    });
                  }}
                />
              </div>
            </PanelSection>

            <div className="border-t border-white/10" />

            {/* Rotation section */}
            <PanelSection icon="fa-rotate" title={t.rotationTitle}>
              <div className="flex gap-2">
                <CoordChip label="X" value={MathUtils.radToDeg(objectEuler.x)} />
                <CoordChip label="Y" value={MathUtils.radToDeg(objectEuler.y)} />
                <CoordChip label="Z" value={MathUtils.radToDeg(objectEuler.z)} />
              </div>
              <SliderRow
                icon="fa-compass-drafting"
                label={t.snapDegreesLabel}
                value={rotationSnapDegrees}
                min={1}
                max={90}
                step={1}
                displayValue={`${rotationSnapDegrees}°`}
                onChange={(v) => setRotationSnapDegrees(Math.round(v))}
              />
              <ActionButton
                icon="fa-arrow-rotate-left"
                label={t.resetRotation}
                onClick={() => setObjectEuler(new Euler(0, 0, 0, objectEuler.order))}
              />
            </PanelSection>

            <div className="border-t border-white/10" />

            {/* Appearance section */}
            <PanelSection icon="fa-eye" title={t.appearanceTitle}>
              <SliderRow
                icon="fa-droplet"
                label={t.transparency}
                value={objectAlpha}
                min={1}
                max={255}
                step={10}
                displayValue={`${Math.round((objectAlpha / 255) * 100)}%`}
                onChange={(v) => setObjectAlpha(Math.round(v))}
              />
            </PanelSection>

            <div className="border-t border-white/10" />

            {/* Cancel */}
            <ActionButton
              icon="fa-xmark"
              label={t.cancelPlacement}
              variant="danger"
              fullWidth
              onClick={() => {
                sendNUI('stopPlacement');
                setShow(false);
                setCurrentFurniture(null);
              }}
            />
          </div>

          {/* Toggle button */}
          <button
            className="w-16 h-28 self-start mt-6 bg-[color:var(--color-secondary)] rounded-r-lg grid place-items-center hover:brightness-125 transition-all"
            onClick={() => setIsPanelOpen(!isPanelOpen)}
          >
            <i className={`fa-solid text-2xl fa-chevron-${isPanelOpen ? 'left' : 'right'} text-white`} />
          </button>
        </div>
      </div>

      {/* ── Add To Cart button ── */}
      {entity == null && (
        <button
          className="absolute z-10 top-1/2 -translate-y-1/2 right-6 flex items-center gap-4 rounded-lg px-10 py-6 text-3xl font-semibold bg-[color:var(--color-secondary)] text-white shadow-2xl hover:brightness-125 transition-all"
          onClick={() => {
            if (!currentFurniture) return;
            if (currentFurniture.max) {
              const itemsWithSameType = cart.filter((item) => item.object === currentFurniture.object);
              if (itemsWithSameType.length >= currentFurniture.max) {
                sendNUI('showNotification', {
                  type: 'error',
                  message: t.maxItemError(currentFurniture.max),
                });
                return;
              }
            }
            sendNUI('addToCart', currentFurniture);
            setCurrentFurniture(null);
          }}
        >
          <i className="fa-solid fa-cart-plus" />
          <span>{t.addToCart}</span>
        </button>
      )}
    </div>
  );
}
