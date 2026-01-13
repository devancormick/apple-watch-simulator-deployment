# Installing Xcode

## Current Status

Your system currently has:
- ✅ Command Line Tools installed at `/Library/Developer/CommandLineTools`
- ❌ Full Xcode application (required for Watch simulator)

## Installation Methods

### Method 1: Mac App Store (Recommended)

1. **Open Mac App Store**
   - Click the App Store icon in your Dock
   - Or press `Cmd + Space` and search "App Store"
   - Or run: `open "macappstore://apps.apple.com/app/xcode/id497799835"`

2. **Search for Xcode**
   - Type "Xcode" in the search bar
   - Click on Xcode from Apple

3. **Download and Install**
   - Click "Get" or "Download" button
   - Sign in with your Apple ID if prompted
   - Wait for download to complete (Xcode is ~15GB)
   - Installation will begin automatically

4. **Accept License Agreement**
   ```bash
   sudo xcodebuild -license accept
   ```

5. **Set Xcode as Active Developer Directory**
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   ```

### Method 2: Apple Developer Downloads

1. Visit: https://developer.apple.com/download/all/?q=Xcode
2. Sign in with your Apple ID
3. Download the `.xip` file for your macOS version
4. Extract the `.xip` file (double-click)
5. Move Xcode.app to `/Applications`
6. Accept license and set active directory (see Method 1, steps 4-5)

### Method 3: Using Xcodes.app (Third-party Tool)

1. Download Xcodes.app from: https://github.com/XcodesOrg/XcodesApp/releases
2. Install Xcodes.app to Applications
3. Launch Xcodes.app
4. Sign in with Apple ID
5. Select and install desired Xcode version

## Verification

After installation, verify Xcode is properly installed:

```bash
# Check Xcode version
xcodebuild -version

# Check active developer directory
xcode-select -p
# Should show: /Applications/Xcode.app/Contents/Developer

# Check available SDKs
xcodebuild -showsdks

# Check for WatchOS SDK
xcodebuild -showsdks | grep watchos
```

## Post-Installation Steps

1. **Install Additional Components**
   - Open Xcode
   - Go to Xcode > Settings > Platforms (or Components)
   - Download Watch simulators for your target WatchOS version

2. **Install Command Line Tools** (if needed)
   ```bash
   xcode-select --install
   ```

3. **Verify Simulator Availability**
   ```bash
   xcrun simctl list devices available | grep -i watch
   ```

## System Requirements

- **macOS**: Version 12.0 (Monterey) or later (check compatibility for specific Xcode version)
- **Storage**: At least 20GB free space (Xcode is ~15GB, plus simulators)
- **RAM**: 8GB minimum, 16GB recommended
- **Apple ID**: Required for download

## Troubleshooting

### Xcode won't open
- Check macOS compatibility
- Verify you have enough disk space
- Try: `sudo xcode-select --reset`

### Simulators not available
- Open Xcode > Settings > Platforms
- Download required simulator runtimes
- Or use: `xcrun simctl runtime download watchos-10.0`

### License agreement issues
```bash
sudo xcodebuild -license accept
```

### Command Line Tools conflicts
```bash
# Remove Command Line Tools
sudo rm -rf /Library/Developer/CommandLineTools

# Set Xcode as active
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

## Next Steps

After Xcode is installed:
1. Run `./scripts/setup.sh` again to verify installation
2. Download Watch simulators in Xcode
3. Test deployment with `./scripts/deploy_simulator.sh`
