#!/bin/bash

# Apple Watch Simulator Setup Script
# This script sets up the environment for Apple Watch simulator deployment

set -e

echo "🚀 Setting up Apple Watch Simulator Deployment..."

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode Command Line Tools not found"
    echo "Please install Xcode from the App Store and run: xcode-select --install"
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -n 1)"

# Check for WatchOS SDK
WATCHOS_SDK=$(xcodebuild -showsdks | grep -i watchos | head -n 1)
if [ -z "$WATCHOS_SDK" ]; then
    echo "⚠️  Warning: WatchOS SDK not found. Make sure Xcode is fully installed."
else
    echo "✅ WatchOS SDK found: $WATCHOS_SDK"
fi

# Create necessary directories
mkdir -p ../config
mkdir -p ../docs
mkdir -p ../examples

echo "✅ Directory structure created"

# Check simulator availability
echo "📱 Checking available simulators..."
xcrun simctl list devices available | grep -i watch || echo "⚠️  No Watch simulators found. You may need to install additional simulators in Xcode."

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Run ./scripts/deploy_simulator.sh to deploy to simulator"
echo "  2. Check docs/ for detailed documentation"
