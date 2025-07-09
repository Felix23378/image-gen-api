#  Product Requirements Prompt (PRP)

---

## 1. Overview

- **Feature Name:** Weather App - Historical View

- **Objective:** Update the weather app to use the Open-Meteo API for displaying hourly weather history for any of the last 10 days.

- **Why:** To shift from a real-time, key-gated API to a free, open API that provides historical data, offering users a view into recent weather patterns.

---

## 2. Success Criteria

_This feature will be considered complete when the following conditions are met:_

- [ ] The code runs without errors.
- [ ] The application correctly fetches and displays historical weather data for a user-selected date.
- [ ] The UI clearly indicates that the data is historical, not live.
- [ ] The code adheres to the project standards defined in `GEMINI.md`.

---

## 3. Context & Resources

###  External Documentation

- **Resource:** [Open-Meteo API Documentation](https://open-meteo.com/en/docs)
  - **Purpose:** Essential for understanding how to structure the API call, specifically using the `forecast` endpoint with `latitude`, `longitude`, and the `hourly` parameters for temperature, humidity, and wind speed.

---

###  Internal Codebase Patterns

- **File:** `examples/components/WeatherCard.jsx`
  - **Reason:** Provides the UI blueprint for displaying a single hour's weather data.

- **File:** `examples/hooks/useWeatherData.js`
  - **Reason:** Demonstrates the core data fetching and caching logic using the Open-Meteo API and `localStorage`.

- **File:** `examples/utils/formatDate.js`
  - **Reason:** Contains the utility function for formatting date strings into a user-friendly hour format.

---

### ⚠️ Known Pitfalls

- The UI and all text must clearly reflect that the data is historical, not real-time.
- API calls should be cached per-date in `localStorage` to avoid redundant fetches.
- Animations and complex logic should be kept minimal to ensure performance on low-end mobile devices.

---

## 4. Implementation Blueprint

###  Proposed File Structure

```
src/
├── App.jsx               (modified)
├── api/
│   └── fetchWeather.js     (modified)
└── components/
    └── WeatherCard.jsx     (modified)
```

---

### ✅ Task Breakdown

**Task 1: Update API Fetching Logic**

- Modify `src/api/fetchWeather.js` to use the Open-Meteo API endpoint.
- The function should accept a `date` parameter.
- Implement the caching logic as seen in `examples/hooks/useWeatherData.js`.

**Task 2: Update UI Components**

- Modify `src/App.jsx` to include a date picker allowing users to select a date from the last 10 days.
- The selected date will be passed to the updated API fetcher.
- The main component will now map over the `hourly` data array returned by the API.

**Task 3: Update Weather Card**

- Adjust `src/components/WeatherCard.jsx` to accept props that match the Open-Meteo API response (`time`, `temperature_2m`, `relative_humidity_2m`, `wind_speed_10m`).

---

## 5. Validation Plan

### Unit Tests / Manual Validation

- **Test Date Picker:** Confirm that selecting a date triggers a new API call.
- **Test API Response:** Verify that the hourly data for the selected date is correctly fetched and displayed.
- **Test Caching:** After fetching data for a date, select a different date and then return to the first one. Verify the data loads instantly from `localStorage` without a network request.
- **Test UI:** Ensure the UI correctly labels the data as historical.

---

### ‍ Manual Test Command

Provide a simple command or interaction to verify visually or through the console.

```bash
# Run app
npm run dev
```

**Expected Output (UI):**
- The app should load showing weather for today.
- A date picker should be visible.
- Selecting a past date should update the hourly weather cards to reflect that day's data.
