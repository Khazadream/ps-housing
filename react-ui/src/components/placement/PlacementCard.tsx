import { useEffect } from 'react';
import { Euler, MathUtils } from 'three';
import { FaUndo } from 'react-icons/fa';
import { useModelStore } from '@store/useModelStore';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { quotaFor } from '@utils/catalog';
import { convertToThreeCordSystem } from '@customTypes/types';
import type { position } from '@customTypes/types';
import { fr } from '@locales/fr';
import SegmentedControl from './SegmentedControl';
import CoordChip from './CoordChip';

const t = fr.placement;

const MOVE_STEPS = [
  { value: 0.01, label: '1 cm' },
  { value: 0.1, label: '10 cm' },
  { value: 1, label: '1 m' },
];

const ROTATION_STEPS = [
  { value: 1, label: '1°' },
  { value: 15, label: '15°' },
  { value: 90, label: '90°' },
];

const MODES = [
  { value: 'translate' as const, label: t.modeTranslation },
  { value: 'rotate' as const, label: t.modeRotation },
];

export default function PlacementCard() {
  const show = useModelStore((s) => s.show);
  const setShow = useModelStore((s) => s.setShow);
  const entity = useModelStore((s) => s.entity);
  const objectPosition = useModelStore((s) => s.objectPosition);
  const objectEuler = useModelStore((s) => s.objectEuler);
  const cameraLookAt = useModelStore((s) => s.cameraLookAt);
  const setObjectPosition = useModelStore((s) => s.setObjectPosition);
  const setObjectEuler = useModelStore((s) => s.setObjectEuler);
  const mode = useModelStore((s) => s.mode);
  const setMode = useModelStore((s) => s.setMode);
  const toggleMode = useModelStore((s) => s.toggleMode);
  const translationSnap = useModelStore((s) => s.translationSnap);
  const setTranslationSnap = useModelStore((s) => s.setTranslationSnap);
  const rotationSnapDegrees = useModelStore((s) => s.rotationSnapDegrees);
  const setRotationSnapDegrees = useModelStore((s) => s.setRotationSnapDegrees);
  const objectAlpha = useModelStore((s) => s.objectAlpha);
  const applyObjectAlpha = useModelStore((s) => s.applyObjectAlpha);

  const currentFurniture = useStore((s) => s.currentFurniture);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);
  const ownedItems = useStore((s) => s.ownedItems);
  const cart = useStore((s) => s.cart);
  const maxStash = useStore((s) => s.maxStash);

  // Right-click keeps toggling the gizmo mode, as it always has.
  useEffect(() => {
    if (!show) return;
    function changeMode(e: MouseEvent) {
      if (e.button === 2) toggleMode();
    }
    document.addEventListener('contextmenu', changeMode);
    return () => document.removeEventListener('contextmenu', changeMode);
  }, [show, toggleMode]);

  if (!show) return null;

  /** Repositioning an existing cart/owned object rather than staging a new one. */
  const isRepositioning = entity != null;

  // When repositioning, currentFurniture is null — recover the name from the
  // cart or the placed objects so the card header is never blank.
  const placedLabel =
    currentFurniture?.label ??
    cart.find((item) => item.entity === entity)?.label ??
    ownedItems.find((item) => item.entity === entity)?.label ??
    '';

  function finishPlacement() {
    sendNUI('stopPlacement').catch(() => {});
    setShow(false);
    setCurrentFurniture(null);
    setIsRailCollapsed(false);
  }

  function handleAddToCart() {
    if (!currentFurniture) return;

    const quota = quotaFor(currentFurniture, ownedItems, cart, maxStash);
    if (quota?.full) {
      sendNUI('showNotification', {
        type: 'error',
        message:
          currentFurniture.type === 'storage'
            ? t.maxStashError(quota.max)
            : t.maxItemError(quota.max),
      }).catch(() => {});
      return;
    }

    sendNUI('addToCart', currentFurniture).catch(() => {});
    setCurrentFurniture(null);
    setIsRailCollapsed(false);
  }

  return (
    <div className="tacoma-scroll absolute right-6 top-6 z-20 flex max-h-[calc(var(--vh)*100-48px)] w-[330px] flex-col overflow-y-auto border border-tacoma-cream bg-zinc-950/[0.96] font-sans">
      {/* Header */}
      <div className="flex flex-col gap-[3px] border-b border-tacoma-cardline px-[18px] py-4">
        <span className="font-mono text-[10px] tracking-[0.16em] text-tacoma-cream">
          {t.badge}
        </span>
        <span className="truncate font-kanit text-[18px] text-tacoma-paper">
          {placedLabel}
        </span>
      </div>

      <div className="flex flex-col gap-[14px] px-[18px] py-4">
        <Section title={t.modeTitle}>
          <SegmentedControl options={MODES} value={mode} onChange={setMode} />
        </Section>

        <Section title={t.positionTitle}>
          {/* three.js -> GTA axes: X = x, Y = -z, Z = y */}
          <div className="flex gap-[6px]">
            <CoordChip label="X" value={objectPosition.x} />
            <CoordChip label="Y" value={-objectPosition.z} />
            <CoordChip label="Z" value={objectPosition.y} />
          </div>
        </Section>

        <Section title={t.moveStepTitle}>
          <SegmentedControl
            options={MOVE_STEPS}
            value={translationSnap}
            onChange={setTranslationSnap}
          />
        </Section>

        <Section
          title={t.rotationTitle}
          action={
            <button
              title={t.resetRotation}
              onClick={() => setObjectEuler(new Euler(0, 0, 0, objectEuler.order))}
              className="text-[11px] text-tacoma-mut2 transition-colors hover:text-tacoma-paper"
            >
              <FaUndo />
            </button>
          }
        >
          <div className="flex gap-[6px]">
            <CoordChip label="X" value={MathUtils.radToDeg(objectEuler.x)} suffix="°" />
            <CoordChip label="Y" value={MathUtils.radToDeg(objectEuler.y)} suffix="°" />
            <CoordChip label="Z" value={MathUtils.radToDeg(objectEuler.z)} suffix="°" />
          </div>
        </Section>

        <Section title={t.rotationStepTitle}>
          <SegmentedControl
            options={ROTATION_STEPS}
            value={rotationSnapDegrees}
            onChange={setRotationSnapDegrees}
          />
        </Section>

        <Section
          title={t.transparencyTitle}
          action={
            <span className="font-mono text-[11px] text-tacoma-paper">
              {Math.round((objectAlpha / 255) * 100)}%
            </span>
          }
        >
          <input
            type="range"
            min={1}
            max={255}
            step={10}
            value={objectAlpha}
            onChange={(e) => applyObjectAlpha(Math.round(parseFloat(e.target.value)))}
            className="tacoma-range w-full"
          />
        </Section>

        <div className="flex gap-[6px]">
          <SecondaryButton
            label={t.placeOnGround}
            onClick={() => {
              sendNUI<position>('placeOnGround')
                .then((data) => {
                  if (data) setObjectPosition(convertToThreeCordSystem(data));
                })
                .catch(() => {});
            }}
          />
          <SecondaryButton
            label={t.recenter}
            onClick={() => setObjectPosition({ ...cameraLookAt })}
          />
        </div>
      </div>

      <div className="flex flex-col gap-2 px-[18px] pb-[18px]">
        {isRepositioning ? (
          <button
            onClick={finishPlacement}
            className="bg-tacoma-gold py-[13px] text-center text-[14px] font-bold text-tacoma-ink transition-all hover:brightness-110"
          >
            {t.done}
          </button>
        ) : (
          <>
            <button
              onClick={handleAddToCart}
              className="bg-green-500 py-[13px] text-center text-[14px] font-bold text-tacoma-ink transition-all hover:brightness-110"
            >
              {t.addToCart} — ${currentFurniture?.price ?? 0}
            </button>
            <button
              onClick={finishPlacement}
              className="border border-tacoma-slot py-[11px] text-center text-[13px] text-tacoma-mut1 transition-colors hover:border-tacoma-red hover:text-tacoma-paper"
            >
              {t.cancel}
            </button>
          </>
        )}
      </div>
    </div>
  );
}

interface SectionProps {
  title: string;
  action?: React.ReactNode;
  children: React.ReactNode;
}

function Section({ title, action, children }: SectionProps) {
  return (
    <div className="flex flex-col gap-[7px]">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[10px] tracking-[0.14em] text-tacoma-mut2">
          {title}
        </span>
        {action}
      </div>
      {children}
    </div>
  );
}

function SecondaryButton({
  label,
  onClick,
}: {
  label: string;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className="flex-1 border border-tacoma-slot py-[10px] text-center text-[13px] text-tacoma-cream transition-colors hover:border-tacoma-gold hover:text-tacoma-paper"
    >
      {label}
    </button>
  );
}
