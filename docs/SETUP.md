# Setup Guide

## Prerequisites

### Required Software

1. **macOS**: Version 12.0 (Monterey) or later
2. **Xcode**: Version 14.0 or later
   - Download from Mac App Store
   - Includes WatchOS SDK
3. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

### Verify Installation

```bash
# Check Xcode version
xcodebuild -version

# Check available SDKs
xcodebuild -showsdks | grep watchos

# Check simulator availability
xcrun simctl list devices available | grep -i watch
```

## Installation Steps

1. **Clone or navigate to the project directory**
   ```bash
   cd apple-watch-simulator-deployment
   ```

2. **Make scripts executable**
   ```bash
   chmod +x scripts/*.sh
   ```

3. **Run setup script**
   ```bash
   ./scripts/setup.sh
   ```

4. **Verify setup**
   ```bash
   ./scripts/deploy_simulator.sh
   ```

## Installing Watch Simulators

If no Watch simulators are available:

1. Open Xcode
2. Go to **Xcode > Settings > Platforms** (or **Components** in older versions)
3. Download Watch simulators for the desired WatchOS versions
4. Wait for download and installation to complete

Alternatively, use command line:
```bash
xcrun simctl runtime list
xcrun simctl runtime download watchos-10.0
```

## Troubleshooting

### No Watch Simulators Found

- Ensure Xcode is fully installed (not just Command Line Tools)
- Download Watch simulators from Xcode Settings
- Check available runtimes: `xcrun simctl runtime list`

### Simulator Won't Boot

- Check system resources (memory, disk space)
- Restart Xcode and Simulator
- Reset simulators: `xcrun simctl erase all`

### Build Errors

- Ensure WatchOS SDK is installed
- Check Xcode project settings for correct target
- Verify bundle identifiers are properly configured

## Next Steps

After setup, proceed to:
- [Deployment Guide](DEPLOYMENT.md)
- [Troubleshooting Guide](TROUBLESHOOTING.md)
