# Deployment Guide

## Quick Deployment

### Method 1: Using Deployment Script

```bash
./scripts/deploy_simulator.sh
```

This script will:
1. Find available Watch simulators
2. Boot the simulator if needed
3. Open Simulator app
4. Provide instructions for deploying your app

### Method 2: Using Xcode

1. Open your Xcode project
2. Select the Watch app scheme
3. Choose a Watch simulator from the device menu
4. Press **Cmd+R** to build and run

### Method 3: Command Line Build and Deploy

```bash
# Build the project
xcodebuild -scheme "WatchApp" \
  -sdk watchsimulator \
  -configuration Debug \
  -destination 'platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)' \
  build

# Find the built app
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "WatchApp.app" -path "*/Debug-watchsimulator/*" | head -n 1)

# Deploy to simulator
./scripts/run_watch_app.sh "$APP_PATH"
```

## Advanced Deployment

### Deploying to Specific Simulator

```bash
# List all simulators
xcrun simctl list devices

# Boot specific simulator
xcrun simctl boot "SIMULATOR_UDID"

# Install app
xcrun simctl install "SIMULATOR_UDID" "/path/to/app.app"

# Launch app
xcrun simctl launch "SIMULATOR_UDID" "com.example.bundleid"
```

### Batch Deployment

Deploy to multiple simulators:

```bash
for udid in $(xcrun simctl list devices available | grep -i watch | grep -oE '[A-F0-9-]{36}'); do
  echo "Deploying to $udid"
  xcrun simctl install "$udid" "/path/to/app.app"
done
```

## Configuration

Edit `config/simulator_config.json` to customize:
- Preferred simulator models
- WatchOS version
- Build configuration
- Code signing settings

## Monitoring

### View Simulator Logs

```bash
# Stream logs
xcrun simctl spawn booted log stream --predicate 'processImagePath contains "WatchApp"'

# View crash logs
xcrun simctl spawn booted log show --predicate 'eventMessage contains "WatchApp"'
```

### Simulator Status

```bash
# List running simulators
xcrun simctl list devices | grep Booted

# Get simulator info
xcrun simctl list devices "SIMULATOR_UDID"
```

## Best Practices

1. **Always test on multiple Watch sizes** (41mm, 45mm, 49mm)
2. **Test different WatchOS versions** when possible
3. **Monitor memory usage** - Watch apps have strict memory limits
4. **Test companion app interactions** if applicable
5. **Use automated testing** for consistent deployments

## Troubleshooting

See [Troubleshooting Guide](TROUBLESHOOTING.md) for common issues and solutions.
