import { useEffect } from 'react';
import VisibilityProvider from '@providers/VisibilityProvider';
import AlwaysListener from '@providers/AlwaysListener';
import Editor from '@components/Editor';
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
      <VisibilityProvider>{furnitures && <Editor />}</VisibilityProvider>

      <AlwaysListener />
      {browserMode && (
        <>
          <DebugBrowser />
          {/* Stand-in for the game world when iterating in a browser. */}
          <div className="browser-backdrop fixed inset-0 -z-10" />
        </>
      )}
    </>
  );
}
