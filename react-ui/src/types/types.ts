export interface position {
  x: number;
  y: number;
  z: number;
}

export interface quaternion {
  x: number;
  y: number;
  z: number;
  w: number;
}

export function convertToThreeCordSystem(pos: position): position {
  return { x: pos.x, y: pos.z, z: -pos.y };
}

export function convertToGTACordSystem(pos: position): position {
  return { x: pos.x, y: -pos.z, z: pos.y };
}

/** A catalogue entry, straight out of `Config.Furnitures` (shared/config.lua:1039). */
export interface IFurniture {
  label: string;
  object: string;
  price: number;
  /** Only "storage" | "clothing" | "door" exist — 32 of 886 entries carry one. */
  type?: string;
  /** Per-type quota. Only the two "Prérequis" entries declare it. */
  max?: number;
}

export interface IFurnitures {
  category: string;
  items: IFurniture[];
}

/**
 * A furniture object already placed and paid for, as built client-side in
 * cl_property.lua:626-639 and shipped through `setOwnedItems`.
 * Note it carries neither `price` nor `max` — use the catalogue index
 * (utils/catalog.ts) to recover those.
 */
export interface IOwnedFurniture {
  entity: number;
  id: string;
  propertyId?: number | string;
  label: string;
  object: string;
  position: position;
  rotation: position;
  type?: string;
}

/** A staged furniture object, awaiting payment. Built in modeler.lua:416-424. */
export interface ICartItem extends IFurniture {
  entity: number;
  position: position;
  rotation: position;
}

/** Which view the rail shows: the catalogue, or the player's placed furniture. */
export type RailView = 'catalog' | 'owned';

/** Sentinel for "Toutes catégories" in the category dropdown. */
export const ALL_CATEGORIES = -1;

/**
 * Lua serialises an empty table as `{}` (an object), not `[]` — see
 * modeler.lua:169 and :346. Every list coming off the NUI bridge goes through here.
 */
export function asArray<T>(value: unknown): T[] {
  return Array.isArray(value) ? (value as T[]) : [];
}
