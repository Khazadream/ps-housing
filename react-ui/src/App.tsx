import { useEffect } from 'react';
import VisibilityProvider from '@providers/VisibilityProvider';
import AlwaysListener from '@providers/AlwaysListener';
import Menu from '@components/Menu';
import Modeler from '@components/Modeler';
import DebugBrowser from '@components/DebugBrowser';
import { useStore } from '@store/useStore';

export default function App() {
  const setResName = useStore((s) => s.setResName);
  const browserMode = useStore((s) => s.browserMode);
  const furnitures = useStore((s) => s.furnitures);

  useEffect(() => {
    setResName('ps-housing');
  }, [setResName]);

  return (
    <>
      <VisibilityProvider>
        {furnitures && (
          <>
            <Menu />
            <Modeler />
          </>
        )}
      </VisibilityProvider>

      <AlwaysListener />
      {browserMode && (
        <>
          <DebugBrowser />
          <div
            style={{
              position: 'fixed',
              inset: 0,
              zIndex: -1,
              backgroundColor: '#404040',
            }}
          />
        </>
      )}
    </>
  );
}
