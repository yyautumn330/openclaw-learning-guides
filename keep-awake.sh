#!/bin/bash
# Keep Mac awake to maintain network connection for OpenClaw gateway
# Run this in background to prevent sleep

echo "🦞 OpenClaw Keep-Awake Service Started"
echo "Preventing system sleep..."

# Use caffeinate to prevent sleep indefinitely
# -d: Prevent display sleep
# -i: Prevent idle sleep
# -s: Prevent sleep when lid is closed (if applicable)
# -u: Create user activity to avoid idle sleep
# -t 0: Run indefinitely

caffeinate -d -i -s -u
