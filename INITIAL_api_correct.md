# Feature Request – Weather App (Updated to Historical View)

---

##  The Goal

Update the existing "Aesthetic Weather App" to use the [Open-Meteo API](https://open-meteo.com/en/docs) instead of any previous real-time or commercial weather APIs.

This new version will no longer provide live updates. Instead, it should show **hourly weather history** for up to the last **10 days**, including:

- ️ Temperature  
-  Wind speed  
-  Relative humidity

Users should be able to:
- Pick a date from the past 10 days
- See an hourly breakdown of that day's weather (as cards or charts)
- View the interface on both mobile and desktop

---

##  Inspiration & Examples

- - **File:** `examples/components/WeatherCard.jsx`  
  **Reason:** Shows a minimalist hourly card UI with pastel themes and emojis.

- **File:** `examples/hooks/useWeatherData.js`  
  **Reason:** Demonstrates how to fetch Open-Meteo API and cache results per date using localStorage.

- **File:** `examples/utils/formatDate.js`  
  **Reason:** Contains utility for formatting ISO date strings into hour labels for display.

---

##  Required Knowledge

- [Open-Meteo API Documentation](https://open-meteo.com/en/docs)
  - Use `forecast` endpoint with:
    - `latitude`, `longitude`
    - `hourly=temperature_2m,relative_humidity_2m,wind_speed_10m`

  Example:
  ```bash
  curl "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"


---

⚠️ Potential Pitfalls & Gotchas

❗ This is not live weather data — make sure UI and wording reflect "history" instead of "now"

 API data for the current day may be incomplete until the day ends

 Don’t trust the current field — focus only on the hourly block

 Avoid excessive API calls by caching results per-date using localStorage

 Some users will access from low-end phones — animations should be minimal and performance friendly