#!/bin/bash

# Setup script for Voice Chat Tool
# Works on macOS, Linux, and Windows (with WSL or Git Bash)

set -e

echo "🚀 Setting up Voice Chat Tool..."

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Darwin*)    
        OS_TYPE="macos"
        ;;
    Linux*)
        OS_TYPE="linux"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        OS_TYPE="windows"
        ;;
    *)
        OS_TYPE="unknown"
        ;;
esac

echo "Detected OS: $OS_TYPE"

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv voice_env
source voice_env/bin/activate

# Install Python dependencies
echo "Installing Python dependencies..."
pip install --upgrade pip
pip install pyaudio==0.2.14 \
            speechrecognition==3.10.4 \
            pyttsx3==2.90 \
            requests==2.31.0 \
            websockets==12.0 \
            flask==3.0.0 \
            numpy==1.24.3

# Handle platform-specific audio dependencies
if [ "$OS_TYPE" = "macos" ]; then
    echo "macOS detected - installing portaudio..."
    if command -v brew &> /dev/null; then
        brew install portaudio
    else
        echo "Warning: Homebrew not found. Please install portaudio manually:"
        echo "Visit: https://brew.sh to install Homebrew, then run 'brew install portaudio'"
    fi
elif [ "$OS_TYPE" = "linux" ]; then
    echo "Linux detected - installing portaudio..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y portaudio19-dev python3-pyaudio
    elif command -v yum &> /dev/null; then
        sudo yum install -y portaudio-devel python3-pyaudio
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm portaudio python-pyaudio
    else
        echo "Warning: Package manager not detected. Please install portaudio19-dev manually."
    fi
elif [ "$OS_TYPE" = "windows" ]; then
    echo "Windows detected - PyAudio should work with pre-compiled wheels."
    echo "If you encounter issues, try: pip install pipwin && pipwin install pyaudio"
fi

# Download Whisper.cpp (optional but recommended for offline use)
echo ""
echo "Would you like to download Whisper.cpp for offline speech recognition? (y/n)"
read -r WHISPER_CHOICE

if [[ $WHISPER_CHOICE =~ ^[Yy]$ ]]; then
    echo "Downloading Whisper.cpp..."
    if [ ! -d "whisper.cpp" ]; then
        git clone https://github.com/ggerganov/whisper.cpp.git
    fi
    
    cd whisper.cpp
    echo "Building Whisper.cpp... (this may take a few minutes)"
    make
    
    echo "Downloading base model (144MB)..."
    ./models/download-ggml-model.sh base
    
    cd ..
    echo "Whisper.cpp setup complete!"
else
    echo "Skipping Whisper.cpp installation. You can add it later by running this script again."
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "To activate the virtual environment and run the tool:"
echo "  source voice_env/bin/activate  # On Windows: voice_env\\Scripts\\activate"
echo "  python voice_chat_tool.py"
echo ""
echo "For browser-based Web Speech API mode:"
echo "  python voice_chat_tool.py --mode web"
echo ""
echo "Documentation is available in README.md"