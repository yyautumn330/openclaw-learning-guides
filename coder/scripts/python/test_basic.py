#!/usr/bin/env python3
"""
Basic test script to verify voice chat tool components work.
"""

import sys
import os

def test_imports():
    """Test that required imports work."""
    try:
        import threading
        import json
        import subprocess
        import platform
        print("✓ Basic Python modules imported successfully")
    except ImportError as e:
        print(f"✗ Basic import failed: {e}")
        return False
    
    try:
        import pyttsx3
        print("✓ pyttsx3 imported successfully")
    except ImportError as e:
        print(f"⚠ pyttsx3 not available: {e}")
    
    try:
        import sounddevice as sd
        import soundfile as sf
        print("✓ Audio recording modules imported successfully")
    except ImportError as e:
        print(f"⚠ Audio recording modules not available: {e}")
    
    return True

def test_platform_detection():
    """Test platform detection."""
    system = platform.system().lower()
    if system in ['darwin', 'windows', 'linux']:
        print(f"✓ Platform detected: {system}")
        return True
    else:
        print(f"✗ Unknown platform: {system}")
        return False

def main():
    print("Testing Voice Chat Tool Components...\n")
    
    success = True
    success &= test_imports()
    success &= test_platform_detection()
    
    if success:
        print("\n✓ All basic tests passed!")
        print("You can now proceed with full setup using:")
        print("- ./setup_voice_tool.sh (macOS/Linux)")
        print("- setup_voice_tool.bat (Windows)")
    else:
        print("\n✗ Some tests failed. Check the error messages above.")
    
    return 0 if success else 1

if __name__ == "__main__":
    sys.exit(main())