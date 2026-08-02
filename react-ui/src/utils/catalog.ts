import type {
  ICartItem,
  IFurniture,
  IFurnitures,
  IOwnedFurniture,
} from '@customTypes/types';

export interface CatalogEntry {
  category: string;
  price: number;
  type?: string;
  max?: number;
}

/**
 * Owned furniture arrives without `price`, `max` or a category (cl_property.lua:626).
 * Index the catalogue so the "Mes meubles" rows can show real metadata.
 *
 * Entries are stored twice: under `object::type` — which distinguishes a
 * functional prop from its decorative twin, since both share a model name —
 * and under the bare `object` as a fallback for anything not found.
 * Labels are not usable as keys: they repeat inside a category.
 */
export function buildObjectIndex(
  furnitures: IFurnitures[] | null
): Map<string, CatalogEntry> {
  const index = new Map<string, CatalogEntry>();
  if (!furnitures) return index;

  for (const group of furnitures) {
    for (const item of group.items ?? []) {
      const entry: CatalogEntry = {
        category: group.category,
        price: item.price,
        type: item.type,
        max: item.max,
      };
      const key = quotaKey(item);
      if (!index.has(key)) index.set(key, entry);
      if (!index.has(item.object)) index.set(item.object, entry);
    }
  }
  return index;
}

/** Catalogue entry matching an owned prop, preferring the exact model+type pair. */
export function lookupOwned(
  index: Map<string, CatalogEntry>,
  owned: Pick<IOwnedFurniture, 'object' | 'type'>
): CatalogEntry | undefined {
  return index.get(quotaKey(owned)) ?? index.get(owned.object);
}

export function totalItemCount(furnitures: IFurnitures[] | null): number {
  if (!furnitures) return 0;
  return furnitures.reduce((acc, group) => acc + (group.items?.length ?? 0), 0);
}

export interface Quota {
  used: number;
  max: number;
  full: boolean;
}

/**
 * Cache key for a quota lookup. The model name alone is not enough: the
 * "Stockage déco" category reuses the models of "Stockage" without their type.
 */
export function quotaKey(furniture: Pick<IFurniture, 'object' | 'type'>): string {
  return `${furniture.object}::${furniture.type ?? ''}`;
}

/**
 * Single source of truth for the per-type quota.
 *
 * The previous UI checked it twice, inconsistently: ItemList counted *owned*
 * items by `type`, Modeler counted *cart* items by `object`, and the two were
 * never summed — so a player could own 2 storage units and stage 2 more.
 * Placed and staged objects both consume the quota here.
 *
 * Storage props answer to a second limit: how many containers the property
 * itself accepts (per-door on evange-housing). The stricter of the two wins,
 * and the server enforces the same rule in `buyFurniture`.
 */
export function quotaFor(
  furniture: Pick<IFurniture, 'type' | 'max'>,
  ownedItems: IOwnedFurniture[],
  cart: ICartItem[],
  maxStash?: number
): Quota | null {
  const { type } = furniture;
  if (!type) return null;

  const limits: number[] = [];
  if (furniture.max) limits.push(furniture.max);
  if (type === 'storage' && typeof maxStash === 'number') limits.push(maxStash);
  if (limits.length === 0) return null;

  const max = Math.min(...limits);
  const used =
    ownedItems.filter((item) => item.type === type).length +
    cart.filter((item) => item.type === type).length;

  return { used, max, full: used >= max };
}

// Unicode combining diacritical marks, built from an escaped string so the
// source file stays pure ASCII.
const COMBINING_MARKS = new RegExp('[\\u0300-\\u036f]', 'g');

/** Matches the catalogue search box: accent- and case-insensitive. */
function normalize(value: string): string {
  return value.toLowerCase().normalize('NFD').replace(COMBINING_MARKS, '');
}

export function matchesSearch(label: string, term: string): boolean {
  return normalize(label).includes(normalize(term));
}
