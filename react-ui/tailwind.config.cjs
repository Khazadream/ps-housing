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
          paper: '#ffffff',
          ink: '#151210',
          ink2: '#1a1512',
          card: '#1a1815',
          cardline: '#2c2822',
          slot: '#3a352d',
          gold: '#c9a25f',
          goldmuted: '#b09a6e',
          // Text ramp — readability first: white body text, neutral greys below it.
          // Every step clears 4.5:1 on zinc-950 (mut3, the weakest, sits at 6:1).
          cream: '#f2f2f4',
          mut1: '#c8c6c2',
          mut2: '#a8a49e',
          mut3: '#8d8880',
          mut4: '#74706a',
          bg1: '#0d0c0e',
          bg2: '#0a090b',
          // ps-housing only: search field ground + furniture thumbnail stripes.
          field: '#0e0c0a',
          thumb1: '#232019',
          thumb2: '#1d1a16',
        },
      },
      fontFamily: {
        sans: ['Roboto', 'system-ui', 'sans-serif'],
        kanit: ['Kanit', 'sans-serif'],
        mono: ['"Space Mono"', 'monospace'],
        michroma: ['Michroma', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
