import { useCallback, useEffect, useRef, useState } from 'react';
import { Canvas, useThree } from '@react-three/fiber';
import { TransformControls } from '@react-three/drei';
import {
  BoxGeometry,
  MeshStandardMaterial,
  MathUtils,
  PerspectiveCamera as ThreePerspectiveCamera,
  Vector3,
} from 'three';
import type { Mesh as ThreeMesh } from 'three';
import { useModelStore } from '@store/useModelStore';
import { useStore } from '@store/useStore';
import { sendNUI } from '@utils/sendNUI';
import { convertToGTACordSystem } from '@customTypes/types';

// Invisible proxy: the real prop is rendered by the game, this only drives the gizmo.
const boxGeo = new BoxGeometry(0, 0, 0);
const boxMat = new MeshStandardMaterial();

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

function Scene() {
  const meshRef = useRef<ThreeMesh>(null!);
  const transformRef = useRef<any>(null);
  const [meshReady, setMeshReady] = useState(false);

  const objectPosition = useModelStore((s) => s.objectPosition);
  const objectEuler = useModelStore((s) => s.objectEuler);
  const entity = useModelStore((s) => s.entity);
  const mode = useModelStore((s) => s.mode);
  const translationSnap = useModelStore((s) => s.translationSnap);
  const rotationSnapDegrees = useModelStore((s) => s.rotationSnapDegrees);
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
      meshRef.current.rotation.set(
        objectEuler.x,
        objectEuler.y,
        objectEuler.z,
        objectEuler.order
      );
    }
  }, [objectPosition, objectEuler]);

  // On drag end, persist the new transform of a staged cart item.
  useEffect(() => {
    const controls = transformRef.current;
    if (!controls) return;

    const onDraggingChanged = (event: any) => {
      const isDragging = event.value;
      if (!isDragging && entity != null && meshRef.current) {
        const item = cart.find((i) => i.entity === entity);
        if (!item) return;
        const mesh = meshRef.current;
        const gtaPos = convertToGTACordSystem({
          x: mesh.position.x,
          y: mesh.position.y,
          z: mesh.position.z,
        });
        const gtaRot = convertToGTACordSystem({
          x: mesh.rotation.x,
          y: mesh.rotation.y,
          z: mesh.rotation.z,
        });
        item.position = gtaPos;
        item.rotation = gtaRot;
        setCart([...cart]);
        sendNUI('updateCartItem', item).catch(() => {});
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

    if (
      mesh.rotation.x !== storeEuler.x ||
      mesh.rotation.y !== storeEuler.y ||
      mesh.rotation.z !== storeEuler.z
    ) {
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

/** Full-screen gizmo layer. Sits under the rail and the placement card. */
export default function Modeler() {
  const show = useModelStore((s) => s.show);

  if (!show) return null;

  return (
    <div className="absolute inset-0 z-0">
      <Canvas camera={{ fov: 45 }}>
        <Scene />
      </Canvas>
    </div>
  );
}
