#!/usr/bin/env python3
"""
Voice Interaction Tool - Cross-Platform Voice Assistant

Features:
- Local speech-to-text (Whisper.cpp or Web Speech API)
- Text-to-speech responses
- Simple CLI interface
- Cross-platform (macOS/Windows/Linux)

Setup Instructions:
1. Install Python 3.8+
2. pip install -r requirements.txt
3. For Whisper.cpp: Download from https://github.com/ggerganov/whisper.cpp
4. Run: python voice_chat_tool.py --help
"""

import argparse
import json
import os
import subprocess
import sys
import threading
import time
from pathlib import Path
from typing import Optional, Dict, Any

# Try to import optional dependencies
try:
    import pyttsx3
    HAS_TTS = True
except ImportError:
    HAS_TTS = False
    print("Warning: pyttsx3 not installed. TTS functionality will be disabled.")
    print("Install with: pip install pyttsx3")

try:
    import sounddevice as sd
    import soundfile as sf
    HAS_AUDIO = True
except ImportError:
    HAS_AUDIO = False
    print("Warning: sounddevice/soundfile not installed. Audio recording disabled.")
    print("Install with: pip install sounddevice soundfile")

try:
    import requests
    HAS_REQUESTS = True
except ImportError:
    HAS_REQUESTS = False


class VoiceAssistant:
    """Main voice assistant class handling STT, processing, and TTS."""
    
    def __init__(self, stt_method: str = "web", tts_enabled: bool = True, 
                 whisper_path: str = None, model_size: str = "base"):
        self.stt_method = stt_method
        self.tts_enabled = tts_enabled and HAS_TTS
        self.whisper_path = whisper_path or "./whisper.cpp"
        self.model_size = model_size
        self.is_listening = False
        self.audio_thread = None
        
        # Initialize TTS engine if available
        if self.tts_enabled:
            self.tts_engine = pyttsx3.init()
            # Configure TTS properties
            voices = self.tts_engine.getProperty('voices')
            if voices:
                self.tts_engine.setProperty('voice', voices[0].id)
            self.tts_engine.setProperty('rate', 150)
            self.tts_engine.setProperty('volume', 0.9)
        
        # Check Whisper.cpp availability
        self.whisper_available = self._check_whisper_availability()
        
    def _check_whisper_availability(self) -> bool:
        """Check if Whisper.cpp is available and properly set up."""
        if not os.path.exists(self.whisper_path):
            return False
        
        # Check if main executable exists
        whisper_main = os.path.join(self.whisper_path, "main")
        if not os.path.exists(whisper_main):
            # Try Windows executable
            whisper_main = os.path.join(self.whisper_path, "main.exe")
            if not os.path.exists(whisper_main):
                return False
        
        # Check if model exists
        model_path = os.path.join(self.whisper_path, f"models/ggml-{self.model_size}.bin")
        if not os.path.exists(model_path):
            print(f"Warning: Whisper model {model_path} not found.")
            print("Download models from: https://github.com/ggerganov/whisper.cpp#models")
            return False
            
        return True
    
    def speak(self, text: str):
        """Speak the given text using TTS."""
        if not self.tts_enabled:
            print(f"Assistant: {text}")
            return
        
        print(f"Assistant: {text}")
        try:
            self.tts_engine.say(text)
            self.tts_engine.runAndWait()
        except Exception as e:
            print(f"TTS Error: {e}")
            print(f"Assistant: {text}")  # Fallback to text
    
    def process_request(self, user_input: str) -> str:
        """
        Process user request and return response.
        This is where you'd integrate with your actual assistant system.
        For now, it's a simple echo with some basic commands.
        """
        if not user_input.strip():
            return "I didn't catch that. Could you repeat?"
        
        # Basic command handling
        user_input_lower = user_input.lower()
        
        if any(word in user_input_lower for word in ['hello', 'hi', 'hey']):
            return "Hello! How can I help you today?"
        elif 'time' in user_input_lower:
            return f"The current time is {time.strftime('%H:%M')}."
        elif 'date' in user_input_lower:
            return f"Today is {time.strftime('%A, %B %d, %Y')}."
        elif 'thank' in user_input_lower:
            return "You're welcome!"
        elif 'bye' in user_input_lower or 'goodbye' in user_input_lower:
            return "Goodbye! Have a great day!"
        else:
            # This is where you'd integrate with your actual assistant
            # For example, call an API or use local LLM
            return f"I heard you say: '{user_input}'. I'm still learning!"
    
    def transcribe_with_whisper(self, audio_file: str) -> str:
        """Transcribe audio using Whisper.cpp."""
        if not self.whisper_available:
            return "Whisper.cpp not available"
        
        whisper_main = os.path.join(self.whisper_path, "main")
        if not os.path.exists(whisper_main):
            whisper_main = os.path.join(self.whisper_path, "main.exe")
        
        model_path = os.path.join(self.whisper_path, f"models/ggml-{self.model_size}.bin")
        
        try:
            cmd = [
                whisper_main,
                "-m", model_path,
                "-f", audio_file,
                "--output-txt"
            ]
            
            result = subprocess.run(cmd, capture_output=True, text=True, cwd=self.whisper_path)
            
            if result.returncode == 0:
                # Read the output file
                output_file = audio_file + ".txt"
                if os.path.exists(output_file):
                    with open(output_file, 'r') as f:
                        transcription = f.read().strip()
                    # Clean up output file
                    os.remove(output_file)
                    return transcription
                else:
                    return "Transcription failed"
            else:
                return f"Whisper error: {result.stderr}"
                
        except Exception as e:
            return f"Whisper exception: {str(e)}"
    
    def record_audio(self, duration: int = 5, sample_rate: int = 16000) -> str:
        """Record audio from microphone and save to temporary file."""
        if not HAS_AUDIO:
            return None
        
        print("Recording... (press Ctrl+C to stop early)")
        try:
            audio_data = sd.rec(int(duration * sample_rate), 
                              samplerate=sample_rate, channels=1, dtype='float32')
            sd.wait()  # Wait until recording is finished
            
            # Save to temporary file
            temp_file = f"temp_recording_{int(time.time())}.wav"
            sf.write(temp_file, audio_data, sample_rate)
            return temp_file
            
        except KeyboardInterrupt:
            print("\nRecording stopped early.")
            # Handle partial recording if needed
            return None
        except Exception as e:
            print(f"Recording error: {e}")
            return None
    
    def start_listening(self):
        """Start the voice interaction loop."""
        if self.is_listening:
            print("Already listening!")
            return
        
        self.is_listening = True
        print("Voice assistant started. Say 'stop' or 'goodbye' to exit.")
        
        while self.is_listening:
            try:
                if self.stt_method == "whisper":
                    # Record audio
                    audio_file = self.record_audio(duration=5)
                    if not audio_file:
                        continue
                    
                    # Transcribe with Whisper
                    user_input = self.transcribe_with_whisper(audio_file)
                    
                    # Clean up temp file
                    if os.path.exists(audio_file):
                        os.remove(audio_file)
                        
                elif self.stt_method == "web":
                    # For web method, we'll simulate input for now
                    # In a real implementation, this would open a browser
                    # with Web Speech API
                    user_input = input("Enter your voice input (simulated): ").strip()
                    
                else:
                    print("Unknown STT method")
                    break
                
                if user_input and user_input.strip():
                    print(f"You said: {user_input}")
                    
                    # Process the request
                    response = self.process_request(user_input)
                    self.speak(response)
                    
                    # Check for exit commands
                    if any(word in user_input.lower() for word in ['stop', 'goodbye', 'exit']):
                        self.is_listening = False
                        print("Goodbye!")
                        break
                        
            except KeyboardInterrupt:
                print("\nStopping...")
                self.is_listening = False
                break
            except Exception as e:
                print(f"Error: {e}")
                continue
    
    def stop_listening(self):
        """Stop the voice interaction loop."""
        self.is_listening = False
        print("Stopped listening.")


def create_web_interface():
    """Create a simple HTML/JavaScript interface using Web Speech API."""
    html_content = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voice Assistant</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        button {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            margin: 10px;
        }
        button:hover {
            background: #45a049;
        }
        button:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }
        .status {
            margin: 20px 0;
            padding: 10px;
            background: #e8f5e8;
            border-radius: 5px;
        }
        .transcript {
            margin: 20px 0;
            padding: 15px;
            background: #f9f9f9;
            border-left: 4px solid #4CAF50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Voice Assistant</h1>
        
        <div>
            <button id="startBtn">Start Listening</button>
            <button id="stopBtn" disabled>Stop Listening</button>
        </div>
        
        <div class="status" id="status">Ready to listen</div>
        <div class="transcript" id="transcript">Transcript will appear here...</div>
        
        <div style="margin-top: 30px;">
            <h3>Instructions:</h3>
            <ul>
                <li>Click "Start Listening" to begin</li>
                <li>Speak clearly into your microphone</li>
                <li>The assistant will respond to your commands</li>
                <li>Works best in Chrome, Edge, or Safari</li>
            </ul>
        </div>
    </div>

    <script>
        let recognition;
        let isListening = false;
        
        // Check if Web Speech API is supported
        if (!('webkitSpeechRecognition' in window) && !('SpeechRecognition' in window)) {
            document.getElementById('status').textContent = 'Web Speech API not supported in this browser';
            document.getElementById('startBtn').disabled = true;
        } else {
            const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            recognition = new SpeechRecognition();
            recognition.continuous = false;
            recognition.interimResults = false;
            recognition.lang = 'en-US';
            
            recognition.onstart = function() {
                isListening = true;
                document.getElementById('status').textContent = 'Listening...';
                document.getElementById('startBtn').disabled = true;
                document.getElementById('stopBtn').disabled = false;
            };
            
            recognition.onresult = function(event) {
                const transcript = event.results[0][0].transcript;
                document.getElementById('transcript').textContent = 'You said: ' + transcript;
                
                // Process the transcript (this would normally send to your backend)
                processTranscript(transcript);
            };
            
            recognition.onerror = function(event) {
                document.getElementById('status').textContent = 'Error: ' + event.error;
                isListening = false;
                document.getElementById('startBtn').disabled = false;
                document.getElementById('stopBtn').disabled = true;
            };
            
            recognition.onend = function() {
                isListening = false;
                document.getElementById('status').textContent = 'Ready to listen';
                document.getElementById('startBtn').disabled = false;
                document.getElementById('stopBtn').disabled = true;
            };
        }
        
        function processTranscript(transcript) {
            // This is where you would send the transcript to your assistant backend
            // For demo purposes, we'll just show a simple response
            let response = '';
            
            const lowerTranscript = transcript.toLowerCase();
            if (lowerTranscript.includes('hello') || lowerTranscript.includes('hi')) {
                response = 'Hello! How can I help you?';
            } else if (lowerTranscript.includes('time')) {
                const now = new Date();
                response = 'The current time is ' + now.toLocaleTimeString();
            } else if (lowerTranscript.includes('date')) {
                const now = new Date();
                response = 'Today is ' + now.toLocaleDateString();
            } else if (lowerTranscript.includes('thank')) {
                response = 'You\'re welcome!';
            } else if (lowerTranscript.includes('bye') || lowerTranscript.includes('goodbye')) {
                response = 'Goodbye! Have a great day!';
            } else {
                response = 'I heard you say: "' + transcript + '". I\'m still learning!';
            }
            
            // Speak the response using Web Speech API
            if ('speechSynthesis' in window) {
                const utterance = new SpeechSynthesisUtterance(response);
                utterance.rate = 1.0;
                utterance.pitch = 1.0;
                utterance.volume = 1.0;
                speechSynthesis.speak(utterance);
            }
            
            // Display response
            document.getElementById('transcript').innerHTML += '<br><strong>Assistant:</strong> ' + response;
        }
        
        document.getElementById('startBtn').onclick = function() {
            if (recognition && !isListening) {
                recognition.start();
            }
        };
        
        document.getElementById('stopBtn').onclick = function() {
            if (recognition && isListening) {
                recognition.stop();
            }
        };
    </script>
</body>
</html>
'''
    
    with open("voice_assistant.html", "w") as f:
        f.write(html_content)
    print("Web interface created: voice_assistant.html")
    print("Open this file in your browser to use Web Speech API.")


def main():
    parser = argparse.ArgumentParser(description="Voice Interaction Tool")
    parser.add_argument("--stt", choices=["web", "whisper"], default="web",
                       help="Speech-to-text method (default: web)")
    parser.add_argument("--no-tts", action="store_true",
                       help="Disable text-to-speech")
    parser.add_argument("--whisper-path", 
                       help="Path to whisper.cpp directory")
    parser.add_argument("--model", default="base",
                       help="Whisper model size (tiny, base, small, medium, large)")
    parser.add_argument("--web-only", action="store_true",
                       help="Only create web interface, don't start CLI")
    parser.add_argument("--create-web", action="store_true",
                       help="Create web interface files")
    
    args = parser.parse_args()
    
    if args.create_web or args.web_only:
        create_web_interface()
        if args.web_only:
            return
    
    if args.web_only:
        return
    
    # Create and start voice assistant
    assistant = VoiceAssistant(
        stt_method=args.stt,
        tts_enabled=not args.no_tts,
        whisper_path=args.whisper_path,
        model_size=args.model
    )
    
    try:
        assistant.start_listening()
    except KeyboardInterrupt:
        print("\nShutting down...")
    finally:
        assistant.stop_listening()


if __name__ == "__main__":
    main()