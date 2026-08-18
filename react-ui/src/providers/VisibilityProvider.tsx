import { useEffect, useState, type ReactNode } from 'react';
import { createPortal } from 'react-dom';
import { useNuiEvent } from '@utils/useNuiEvent';
import { sendNUI } from '@utils/sendNUI';
import { useStore } from '@store/useStore';
import { useModelStore } from '@store/useModelStore';
import { fr } from '@locales/fr';
import ConfirmDialog from '@components/ConfirmDialog';

interface Props {
  children: ReactNode;
}

export default function VisibilityProvider({ children }: Props) {
  const visibility = useStore((s) => s.visibility);
  const setVisibility = useStore((s) => s.setVisibility);
  const cart = useStore((s) => s.cart);
  const setCurrentFurniture = useStore((s) => s.setCurrentFurniture);
  const setIsRailCollapsed = useStore((s) => s.setIsRailCollapsed);
  const setShow = useModelStore((s) => s.setShow);

  const [showExitModal, setShowExitModal] = useState(false);

  useNuiEvent<boolean>('setVisible', (visible) => {
    setVisibility(visible);
    if (visible) {
      setIsRailCollapsed(false);
    } else {
      setShowExitModal(false);
    }
  });

  function closeEditor() {
    sendNUI('hoverOut').catch(() => {});
    sendNUI('hideUI').catch(() => {});
    setShowExitModal(false);
    setVisibility(false);
    setShow(false);
    setCurrentFurniture(null);
  }

  useEffect(() => {
    const keyHandler = (e: KeyboardEvent) => {
      if (!visibility || e.code !== 'Escape') return;
      if (cart.length > 0) {
        setShowExitModal(true);
      } else {
        closeEditor();
      }
    };

    window.addEventListener('keydown', keyHandler);
    return () => window.removeEventListener('keydown', keyHandler);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [visibility, cart]);

  return (
    <>
      {visibility && (
        <main className="absolute inset-0 z-[100] m-0 select-none p-0 font-sans">
          {children}
        </main>
      )}

      {showExitModal &&
        visibility &&
        createPortal(
          <ConfirmDialog
            title={fr.confirm.exitTitle}
            body={fr.confirm.exitBody}
            onCancel={() => setShowExitModal(false)}
            onConfirm={closeEditor}
          />,
          document.body
        )}
    </>
  );
}
