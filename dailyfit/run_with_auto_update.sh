#!/bin/bash

echo "========================================"
echo "DailyFit - Auto-Update Runner"
echo "========================================"
echo ""

# Set Flutter path
export PATH="$PATH:/workspace/flutter/bin"

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Please ensure Flutter is installed."
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"
echo ""

# Kill and restart ADB server
echo "🔄 Restarting ADB server..."
adb kill-server
adb start-server

# Try to connect to phone
echo "📱 Connecting to phone..."
adb connect 192.168.18.9:5555

# Check device connection
echo ""
echo "📋 Connected devices:"
adb devices

echo ""
echo "🚀 Starting DailyFit with auto-update features..."
echo ""
echo "Features enabled:"
echo "• Hot reload (press 'r' for reload)"
echo "• Hot restart (press 'R' for restart)"
echo "• Auto-update checking"
echo "• Workout tracking"
echo "• Progress monitoring"
echo ""

# Run the app with hot reload enabled
flutter run \
  --hot \
  --debug \
  --verbose \
  --device-id=192.168.18.9:5555

echo ""
echo "✅ DailyFit is running with auto-update features!"
echo ""
echo "Controls:"
echo "• Press 'r' for hot reload (updates code changes)"
echo "• Press 'R' for hot restart (full app restart)"
echo "• Press 'q' to quit"
echo ""
echo "The app will automatically detect changes and reload when needed."