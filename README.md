# 🚌 Bharat Transit AI - All-India Live Bus Tracking

[![Streamlit App](https://static.streamlit.io/badges/streamlit_badge_black_white.svg)](https://share.streamlit.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An intelligent, real-time bus tracking and passenger assistant platform for public transit networks across India:
- **BMTC** (Bengaluru)
- **DTC / DIMTS** (Delhi)
- **BEST** (Mumbai)
- **MTC** (Chennai)
- **TSRTC** (Hyderabad)
- State Road Transport Undertakings (STUs)

---

## 🌟 Key Features

1. **Interactive Live GPS Tracking Map**:
   - Visualizes live bus positions and stop waypoints across major Indian cities using real-time GPS telemetry.
   - Shows live vehicle registration plates (e.g. `KA-01-F-2401`, `DL-1P-D-5341`, `MH-01-AP-0801`), vehicle speed, bearing, and route destination.
2. **Dynamic Live ETA & Grounding**:
   - Computes live arrival estimates dynamically using the Haversine formula based on actual real-time vehicle distances and traffic conditions.
   - Strictly grounded responses—never hallucinates unverified timetable departures as live GPS.
3. **Conversational AI Passenger Assistant**:
   - Understands natural language queries in English, Hindi, and Hinglish (*"Next 500D at Silk Board"*, *"DTC 534 AIIMS kab aayegi"*, *"Where is bus 2401?"*).
   - Ambiguity disambiguation (e.g., Northbound vs. Southbound boarding bays at Central & 3rd).
   - Indian ERSS **112** emergency protocol routing.
   - Guardrail enforcement prohibiting unauthorized driver-wait promises.
4. **All-India Fleet Roster**:
   - Live telemetry data table showing all buses operating across India, their speeds, nearest stops, and signal age.

---

## 🚀 Deploying to Streamlit Cloud

1. Fork or push this repository to your GitHub account.
2. Sign in to [share.streamlit.io](https://share.streamlit.io) with GitHub.
3. Select your repository, set the main file path to `streamlit_app.py`, and click **Deploy!**.

---

## 💻 Local Development

```bash
# Clone the repository
git clone https://github.com/<YOUR_USERNAME>/bharat-transit-ai.git
cd bharat-transit-ai

# Install dependencies
pip install -r requirements.txt

# Run the Streamlit app
streamlit run streamlit_app.py
```
