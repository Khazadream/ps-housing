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

export interface IFurniture {
  label: string;
  object: string;
  price: number;
  type?: string;
  max?: number;
}

export interface IOwnedFurniture extends IFurniture {
  id: string;
}

export interface IFurnitures {
  category: string;
  items: IFurniture[];
}

export interface ICartItem extends IFurniture {
  entity: number;
  position: position;
  rotation: position;
}
