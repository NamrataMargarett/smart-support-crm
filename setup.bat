@echo off
REM SmartSupport CRM - Quick setup script for VS Code (Windows)
REM Run this to set up everything automatically

echo ===== SmartSupport CRM Setup =====
echo.

REM Step 1: Check Python
echo Step 1: Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo Python not found. Install from python.org
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('python --version') do echo ✓ %%i
echo.

REM Step 2: Create virtual environment
echo Step 2: Creating Python virtual environment...
cd ai-service
python -m venv .venv
echo ✓ Virtual environment created
echo.

REM Step 3: Activate and install
echo Step 3: Installing dependencies...
call .venv\Scripts\activate.bat
pip install -r requirements.txt
echo ✓ Dependencies installed
echo.

echo ===== Setup Complete =====
echo.
echo To run AI service anytime:
echo   cd ai-service
echo   .venv\Scripts\activate.bat
echo   uvicorn app:app --reload
echo.
echo To test in another terminal:
echo   powershell -Command "$body = @{description='My laptop battery is not charging'} | ConvertTo-Json; Invoke-WebRequest -Uri 'http://127.0.0.1:8000/predict' -Method POST -ContentType 'application/json' -Body $body"
echo.
pause
