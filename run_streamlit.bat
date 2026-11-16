@echo off
setlocal
echo ====================================================================
echo    BHARAT TRANSIT AI - STREAMLIT LAUNCHER
echo ====================================================================
echo.

where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python was not found in your system PATH.
    echo.
    echo To run Streamlit locally on Windows:
    echo  1. Install Python from: https://www.python.org/downloads/
    echo     (Ensure you check "Add python.exe to PATH" during installation)
    echo  2. Open command prompt and run:
    echo        pip install -r requirements.txt
    echo        streamlit run streamlit_app.py
    echo.
    echo To publish for free on Streamlit Cloud (no local Python needed):
    echo  1. Push this folder to a GitHub repository.
    echo  2. Go to https://share.streamlit.io and select your repo.
    echo  3. Choose "streamlit_app.py" as the main file and click "Deploy"!
    echo.
    pause
    exit /b 1
)

echo Checking and installing requirements...
pip install -r requirements.txt
echo.
echo Launching Streamlit web application...
streamlit run streamlit_app.py
pause
