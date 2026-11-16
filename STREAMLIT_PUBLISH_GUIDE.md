# How to Publish Bharat Transit AI on Streamlit

This project is fully prepared for one-click deployment to **Streamlit Community Cloud** (free public URL accessible anywhere in the world) or running locally on your computer.

---

## Method 1: Publish to Streamlit Community Cloud (Recommended & Free)

Streamlit Community Cloud hosts your app online for free directly from GitHub. You don't need Python installed on your local computer to do this.

### Step 1: Push your code to GitHub
1. Create a free account at [GitHub.com](https://github.com) if you haven't already.
2. Create a new repository named `bharat-transit-ai` (or `bus-tracking-ai`).
3. Push your project files to the repository:
   ```bash
   git init
   git add .
   git commit -m "Deploy Bharat Transit AI Streamlit app"
   git branch -M main
   git remote add origin https://github.com/<YOUR_GITHUB_USERNAME>/bharat-transit-ai.git
   git push -u origin main
   ```

### Step 2: Deploy on Streamlit Cloud
1. Go to [share.streamlit.io](https://share.streamlit.io) and click **"Sign in with GitHub"**.
2. Click **"New app"**.
3. Fill in the deployment details:
   - **Repository:** `<YOUR_GITHUB_USERNAME>/bharat-transit-ai`
   - **Branch:** `main`
   - **Main file path:** `streamlit_app.py`
4. Click **"Deploy!"**.
5. Within 1–2 minutes, your app will be live with a permanent public URL, for example:
   `https://bharat-transit-ai.streamlit.app`

---

## Method 2: Run Streamlit Locally on Windows

If you want to run the Streamlit app locally on your machine:

### Step 1: Install Python (if not already installed)
1. Download Python from [python.org/downloads](https://www.python.org/downloads/) (Python 3.10, 3.11, or 3.12).
2. **Important:** Check the box **"Add python.exe to PATH"** before clicking "Install Now".

### Step 2: Run the App
Open Command Prompt in your project folder and run:

```cmd
.\run_streamlit.bat
```

Or manually:
```cmd
pip install -r requirements.txt
streamlit run streamlit_app.py
```

Your browser will automatically open to `http://localhost:8501` displaying the interactive Bharat Transit AI dashboard with live maps, AI chat, and fleet rosters.
