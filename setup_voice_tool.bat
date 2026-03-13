@echo off
REM Voice Chat Tool Setup Script for Windows
REM This script sets up the voice interaction tool on Windows systems

echo Setting up Voice Chat Tool for Windows...
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH.
    echo Please install Python 3.7+ from https://www.python.org/downloads/
    echo Then run this script again.
    pause
    exit /b 1
)

REM Create virtual environment
echo Creating virtual environment...
python -m venv voice_env
if %errorlevel% neq 0 (
    echo WARNING: Could not create virtual environment. Installing to system Python.
    goto install_packages
)

REM Activate virtual environment
echo Activating virtual environment...
call voice_env\Scripts\activate.bat

:install_packages
REM Install required packages
echo Installing required packages...
pip install --upgrade pip
pip install pyaudio pyttsx3 keyboard sounddevice numpy

REM Check if we can install faster-whisper (optional)
echo.
echo Attempting to install faster-whisper for offline speech recognition...
pip install faster-whisper

REM Create whisper models directory
if not exist "whisper_models" mkdir whisper_models

echo.
echo Setup complete!
echo.
echo To use the voice chat tool:
echo 1. Make sure your microphone is connected and working
echo 2. Run: python voice_chat_tool.py
echo.
echo For offline speech recognition with Whisper:
echo - Download a Whisper model from https://huggingface.co/guillaumekln/faster-whisper-large-v3
echo - Extract it to the 'whisper_models' folder
echo - Use the --offline flag when running the tool
echo.
echo Press any key to exit...
pause >nul