export const fr = {
  brand: {
    name: 'TACOMA',
    suffix: 'RP',
  },

  rail: {
    title: 'MOBILIER',
    objectCount: (n: number) => `${n} objet${n > 1 ? 's' : ''}`,
    expand: 'Déployer le catalogue',
    collapse: 'Replier le catalogue',
  },

  catalog: {
    tab: 'Mobilier',
    searchPlaceholder: 'Rechercher un meuble',
    allCategories: 'Toutes catégories',
    place: 'placer',
    preview: 'Aperçu dans la pièce',
    quotaReached: 'Quota atteint',
    empty: 'Aucun meuble ne correspond',
    emptyHint: 'Modifiez la recherche ou changez de catégorie.',
  },

  cart: {
    title: 'VOTRE PANIER',
    buy: 'ACHETER',
    remove: 'Retirer du panier',
    select: 'Repositionner cet article',
  },

  owned: {
    title: 'Mes meubles',
    empty: 'Aucun meuble posé',
    emptyHint: 'Les meubles achetés apparaîtront ici.',
    move: 'déplacer',
    remove: 'Supprimer ce meuble',
  },

  hud: {
    preview: 'APERÇU',
    freecam: 'Caméra libre',
    freecamKey: 'C',
    distanceUnit: 'm',
  },

  placement: {
    badge: 'PLACEMENT EN COURS',
    // Mode
    modeTitle: 'MODE',
    modeTranslation: 'Translation',
    modeRotation: 'Rotation',
    // Position
    positionTitle: 'POSITION',
    moveStepTitle: 'PAS DE DÉPLACEMENT',
    // Rotation
    rotationTitle: 'ROTATION',
    rotationStepTitle: 'PAS DE ROTATION',
    resetRotation: 'Remettre la rotation à zéro',
    // Appearance
    transparencyTitle: 'TRANSPARENCE',
    // Actions
    placeOnGround: 'Poser au sol',
    recenter: 'Recentrer',
    addToCart: 'AJOUTER AU PANIER',
    done: 'TERMINER',
    cancel: 'Annuler',
    maxItemError: (max: number) =>
      `Vous ne pouvez avoir que ${max} de ce type d'objet !`,
    maxStashError: (max: number) =>
      max === 0
        ? 'Cette propriété n’accepte aucun meuble de stockage.'
        : `Cette propriété n’accepte que ${max} meuble(s) de stockage.`,
  },

  confirm: {
    exitTitle: 'Quitter l’éditeur ?',
    exitBody: 'Votre panier contient des articles non payés. Ils seront perdus.',
    switchTitle: 'Changer d’objet ?',
    switchBody: 'Le placement en cours sera abandonné.',
    yes: 'Oui',
    no: 'Non',
  },
} as const;
