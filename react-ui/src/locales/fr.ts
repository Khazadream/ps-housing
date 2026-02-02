export const fr = {
  modeler: {
    panelTitle: 'Placement d\'objet',
    // Mode
    modeTranslation: 'Translation',
    modeRotation: 'Rotation',
    switchToRotation: 'Mode Rotation',
    switchToTranslation: 'Mode Translation',
    // Position section
    positionTitle: 'Position',
    resetPosition: 'Réinitialiser',
    placeOnGround: 'Placer au sol',
    snapLabel: 'Précision',
    // Rotation section
    rotationTitle: 'Rotation',
    resetRotation: 'Réinitialiser',
    snapDegreesLabel: 'Degrés',
    // Appearance section
    appearanceTitle: 'Apparence',
    transparency: 'Transparence',
    // Actions
    cancelPlacement: 'Annuler le placement',
    addToCart: 'Ajouter au panier',
    maxItemError: (max: number) =>
      `Vous ne pouvez avoir que ${max} de ce type d'objet!`,
  },
} as const;
