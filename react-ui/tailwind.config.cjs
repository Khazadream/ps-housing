/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // TACOMA "classified dossier" palette (shared with qb-garages / qb-multicharacter).
        tacoma: {
          red: '#e63535',
          redhover: '#ff6a6a',
          paper: '#f4ede0',
          ink: '#151210',
          ink2: '#1a1512',
          card: '#1a1815',
          cardline: '#2c2822',
          slot: '#3a352d',
          gold: '#c9a25f',
          goldmuted: '#8a7d5f',
          cream: '#cfc4b2',
          mut1: '#9a8f81',
          mut2: '#7a6f66',
          mut3: '#6b6157',
          mut4: '#5c554c',
          bg1: '#0d0c0e',
          bg2: '#0a090b',
          // ps-housing only: search field ground + furniture thumbnail stripes.
          field: '#0e0c0a',
          thumb1: '#232019',
          thumb2: '#1d1a16',
        },
      },
      fontFamily: {
        chakra: ['"Chakra Petch"', 'sans-serif'],
        kanit: ['Kanit', 'sans-serif'],
        mono: ['"Space Mono"', 'monospace'],
        michroma: ['Michroma', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
