#!/bin/bash

# Apple Watch Simulator Deployment Script
# Deploys Watch app to the iOS Simulator

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "📱 Apple Watch Simulator Deployment"
echo "===================================="
echo ""

# Check if Xcode project exists
if [ ! -f "$PROJECT_DIR/WatchApp.xcodeproj/project.pbxproj" ] && [ ! -f "$PROJECT_DIR/WatchApp.xcworkspace/contents.xcworkspacedata" ]; then
    echo "⚠️  No Xcode project found. Creating example project structure..."
    echo "   Run ./scripts/create_project.sh first to create a project"
    exit 1
fi

# Get available Watch simulators
echo "🔍 Finding available Watch simulators..."
WATCH_SIMULATORS=$(xcrun simctl list devices available | grep -i "watch" | grep -v "unavailable" | head -n 5)

if [ -z "$WATCH_SIMULATORS" ]; then
    echo "❌ No Watch simulators available"
    echo "   Please install Watch simulators in Xcode:"
    echo "   Xcode > Settings > Platforms > Download simulators"
    exit 1
fi

echo "Available Watch simulators:"
echo "$WATCH_SIMULATORS"
echo ""

# Get the first available Watch simulator
WATCH_UDID=$(xcrun simctl list devices available | grep -i "watch" | grep -v "unavailable" | head -n 1 | grep -oE '[A-F0-9-]{36}' | head -n 1)

if [ -z "$WATCH_UDID" ]; then
    echo "❌ Could not find Watch simulator UDID"
    exit 1
fi

echo "📲 Selected simulator: $WATCH_UDID"
echo ""

# Boot the simulator if not already booted
BOOT_STATUS=$(xcrun simctl list devices | grep "$WATCH_UDID" | grep -oE "(Booted|Shutdown)")
if [ "$BOOT_STATUS" != "Booted" ]; then
    echo "🚀 Booting simulator..."
    xcrun simctl boot "$WATCH_UDID" 2>/dev/null || echo "   Simulator already booting or booted"
fi

# Wait for simulator to be ready
echo "⏳ Waiting for simulator to be ready..."
sleep 3

# Open Simulator app
open -a Simulator

echo ""
echo "✅ Simulator is ready!"
echo ""
echo "To deploy your Watch app:"
echo "  1. Open your Xcode project"
echo "  2. Select the Watch target"
echo "  3. Choose the simulator from the device menu"
echo "  4. Press Cmd+R to build and run"
echo ""
echo "Or use: ./scripts/run_watch_app.sh [path/to/app.app]"
