# Troubleshooting Guide

## Common Issues and Solutions

### Issue: No Watch Simulators Available

**Symptoms:**
- `xcrun simctl list devices` shows no Watch devices
- Deployment script fails with "No Watch simulators available"

**Solutions:**
1. Install Watch simulators in Xcode:
   - Xcode > Settings > Platforms
   - Download Watch simulators
2. Check available runtimes:
   ```bash
   xcrun simctl runtime list
   ```
3. Download specific runtime:
   ```bash
   xcrun simctl runtime download watchos-10.0
   ```

### Issue: Simulator Won't Boot

**Symptoms:**
- Simulator stays on black screen
- Boot command hangs
- "Unable to boot simulator" error

**Solutions:**
1. Check system resources:
   ```bash
   # Check disk space
   df -h
   
   # Check memory
   vm_stat
   ```
2. Reset simulator:
   ```bash
   xcrun simctl erase "SIMULATOR_UDID"
   ```
3. Restart CoreSimulator service:
   ```bash
   sudo killall -9 com.apple.CoreSimulator.CoreSimulatorService
   ```
4. Delete and recreate simulator if needed

### Issue: App Won't Install

**Symptoms:**
- Installation fails silently
- "Could not install application" error

**Solutions:**
1. Check app bundle structure:
   ```bash
   # Verify Info.plist exists
   ls -la "App.app/Info.plist"
   
   # Check bundle identifier
   /usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "App.app/Info.plist"
   ```
2. Verify simulator is booted:
   ```bash
   xcrun simctl list devices | grep Booted
   ```
3. Check for code signing issues:
   - Ensure development team is set in Xcode
   - Verify provisioning profile if needed
4. Try manual installation:
   ```bash
   xcrun simctl install booted "/path/to/app.app"
   ```

### Issue: App Crashes on Launch

**Symptoms:**
- App installs but crashes immediately
- No visible error message

**Solutions:**
1. Check crash logs:
   ```bash
   xcrun simctl spawn booted log show --predicate 'processImagePath contains "YourApp"' --last 5m
   ```
2. Verify WatchOS version compatibility
3. Check for missing resources or dependencies
4. Test with a minimal app first

### Issue: Build Errors

**Symptoms:**
- Xcode build fails
- "No such module" errors
- SDK not found errors

**Solutions:**
1. Verify WatchOS SDK:
   ```bash
   xcodebuild -showsdks | grep watchos
   ```
2. Clean build folder:
   ```bash
   xcodebuild clean
   rm -rf ~/Library/Developer/Xcode/DerivedData
   ```
3. Check project settings:
   - Target platform: watchOS
   - Base SDK: Latest watchOS
   - Deployment target: Compatible version
4. Verify Swift/Objective-C compatibility

### Issue: Simulator Performance Issues

**Symptoms:**
- Simulator is slow or unresponsive
- High CPU/memory usage

**Solutions:**
1. Close unnecessary simulators
2. Reduce simulator window size
3. Disable unnecessary features:
   ```bash
   # Disable animations
   defaults write com.apple.iphonesimulator ReduceMotionEnabled -bool true
   ```
4. Allocate more resources if using virtualization
5. Restart Simulator app

### Issue: Script Permission Errors

**Symptoms:**
- "Permission denied" when running scripts
- Scripts won't execute

**Solutions:**
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Or specific script
chmod +x scripts/deploy_simulator.sh
```

## Getting Help

### Debug Information

Collect debug information:
```bash
# System information
system_profiler SPSoftwareDataType

# Xcode version
xcodebuild -version

# Available simulators
xcrun simctl list devices

# Simulator runtimes
xcrun simctl runtime list
```

### Logs

Important log locations:
- Simulator logs: `~/Library/Logs/CoreSimulator/`
- Xcode logs: `~/Library/Developer/Xcode/DerivedData/`
- System logs: Console.app

### Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/watchkit)
- [Xcode Release Notes](https://developer.apple.com/documentation/xcode-release-notes)
- [Simulator Help](https://help.apple.com/simulator/)

## Still Having Issues?

1. Verify all prerequisites are met
2. Check for Xcode updates
3. Review Apple Developer Forums
4. File a bug report with Apple if it's a tooling issue
