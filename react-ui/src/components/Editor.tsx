import { useEditorSession } from '@hooks/useEditorSession';
import { useModelStore } from '@store/useModelStore';
import Rail from './rail/Rail';
import ViewportHud from './hud/ViewportHud';
import PlacementCard from './placement/PlacementCard';
import CartCard from './cart/CartCard';
import Modeler from './Modeler';

/**
 * The furniture editor shell: gizmo layer at the bottom, then the left rail,
 * the top-right HUD and the placement card on top of it.
 */
export default function Editor() {
  const { isFreecam, hoverDistance, setHoverDistance } = useEditorSession();
  const isPlacing = useModelStore((s) => s.show);

  return (
    <>
      <Modeler />
      <Rail />
      {/* HUD and placement card share the top-right corner — never both at once.
          The tall placement card also reaches the cart's corner, so it yields too. */}
      {isPlacing ? (
        <PlacementCard />
      ) : (
        <>
          <ViewportHud
            isFreecam={isFreecam}
            hoverDistance={hoverDistance}
            onHoverDistanceChange={setHoverDistance}
          />
          <CartCard />
        </>
      )}
    </>
  );
}
