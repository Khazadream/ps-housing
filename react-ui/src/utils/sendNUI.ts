import { useStore } from '@store/useStore';

export async function sendNUI<T = any>(
  eventName: string,
  data: unknown = {},
  debugReturn?: T
): Promise<T> {
  const { browserMode, resName } = useStore.getState();

  if (browserMode && debugReturn) {
    return Promise.resolve(debugReturn || ({} as T));
  }

  const options = {
    method: 'post',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(data),
  };

  const resourceName = (window as any).GetParentResourceName
    ? (window as any).GetParentResourceName()
    : resName;

  const resp: Response = await fetch(
    `https://${resourceName}/${eventName}`,
    options
  );
  return await resp.json();
}
