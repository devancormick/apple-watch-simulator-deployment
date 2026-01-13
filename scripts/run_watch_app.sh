#!/bin/bash

# Run Watch App on Simulator
# Installs and launches a Watch app on the simulator

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

APP_PATH="$1"

if [ -z "$APP_PATH" ]; then
    echo "📱 Run Watch App on Simulator"
    echo "=============================="
    echo ""
    echo "Usage: $0 <path/to/WatchApp.app>"
    echo ""
    echo "Example:"
    echo "  $0 ~/Library/Developer/Xcode/DerivedData/YourApp-*/Build/Products/Debug-watchsimulator/WatchApp.app"
    echo ""
    exit 1
fi

if [ ! -d "$APP_PATH" ]; then
    echo "❌ Error: App not found at $APP_PATH"
    exit 1
fi

# Find Watch simulator
WATCH_UDID=$(xcrun simctl list devices available | grep -i "watch" | grep -v "unavailable" | head -n 1 | grep -oE '[A-F0-9-]{36}' | head -n 1)

if [ -z "$WATCH_UDID" ]; then
    echo "❌ No Watch simulator available"
    exit 1
fi

echo "📲 Installing app on simulator: $WATCH_UDID"
xcrun simctl install "$WATCH_UDID" "$APP_PATH"

if [ $? -eq 0 ]; then
    echo "✅ App installed successfully"
    
    # Get bundle identifier
    BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$APP_PATH/Info.plist" 2>/dev/null || echo "")
    
    if [ -n "$BUNDLE_ID" ]; then
        echo "🚀 Launching app: $BUNDLE_ID"
        xcrun simctl launch "$WATCH_UDID" "$BUNDLE_ID"
        echo "✅ App launched"
    else
        echo "⚠️  Could not determine bundle ID. Please launch manually from simulator."
    fi
else
    echo "❌ Failed to install app"
    exit 1
fi
