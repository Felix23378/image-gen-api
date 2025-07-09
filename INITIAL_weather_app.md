# ️ Feature Request – Aesthetic Weather App

---

##  The Goal

Build a minimalist, aesthetic weather app using a free weather API (like OpenWeatherMap).  
Users should be able to:

- Enter a city name  
- View current weather (temperature, condition, emoji/icon)  
- Enjoy smooth UI transitions, pastel backgrounds, and responsive layout  
- View errors and logs using **Eruda** debug console (mobile-compatible)

️ **All source code must be placed inside the `/src` folder.**  
 **Deployment to Vercel will be handled manually — do not configure deployment logic.**

---

##  Inspiration & Examples

- **File:** `examples/components/WeatherCard.jsx`  
  **Reason:** Shows component structure using Tailwind + conditionally styled content

- **File:** `examples/api/fetchWeather.js`  
  **Reason:** Demonstrates async fetch + fallback UI logic

---

##  Required Knowledge

- [OpenWeatherMap API Docs](https://openweathermap.org/current)  
  Use: `https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY`

- [TailwindCSS v3.4.1](https://tailwindcss.com/docs/installation)  
  Stick to v3.4.1 (Termux-friendly)

- [Framer Motion](https://www.framer.com/motion/)  
  Light use for transitions and motion effects

- [Eruda Debug Console](https://github.com/liriliri/eruda)  
  A mobile-compatible browser console — must be included in development mode

---

## ⚠️ Potential Pitfalls & Gotchas

- ❗ Free APIs like OpenWeatherMap have **rate limits** — throttle requests  
- ❗ Always use **Eruda** for logs — no native browser console on Termux  
- ❗ Tailwind v4 is incompatible — use 3.4.1 only  
- ❗ Don't hardcode the API key — use `.env` or local fallback  
- ❗ Keep all UI components and logic under `/src/`  
- ❗ Weather icons may be low-res — use emojis or SVGs for a better look  
- ❗ Background gradients should be performance-friendly for mobile devices  

---

##  Notes from Dev Standards

- Design must be minimalist and responsive (mobile + desktop)  
- Pastel theme (e.g., purple, pink, blue gradients)  
- Use emojis/icons over large image assets  
- Tailwind utility classes only — no external CSS files  
- Use GitHub for versioning  
- Vercel deploy must be done manually (`vite build`, output: `/dist`)