#!/bin/bash

# Create Example Watch App Project Structure
# Generates a basic Xcode project structure for Watch app development

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "📦 Creating Watch App Project Structure"
echo "========================================"
echo ""

PROJECT_NAME="WatchApp"
WATCH_APP_NAME="${PROJECT_NAME} Watch App"

# Create directory structure
mkdir -p "$PROJECT_DIR/$PROJECT_NAME"
mkdir -p "$PROJECT_DIR/$PROJECT_NAME/$PROJECT_NAME"
mkdir -p "$PROJECT_DIR/$PROJECT_NAME/$WATCH_APP_NAME"
mkdir -p "$PROJECT_DIR/$PROJECT_NAME/$WATCH_APP_NAME/Resources"

echo "✅ Created directory structure"

# Create basic Swift files
cat > "$PROJECT_DIR/$PROJECT_NAME/$PROJECT_NAME/AppDelegate.swift" << 'EOF'
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
EOF

cat > "$PROJECT_DIR/$PROJECT_NAME/$WATCH_APP_NAME/App.swift" << 'EOF'
import SwiftUI

@main
struct WatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
EOF

cat > "$PROJECT_DIR/$PROJECT_NAME/$WATCH_APP_NAME/ContentView.swift" << 'EOF'
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "applewatch")
                .imageScale(.large)
                .foregroundColor(.blue)
            Text("Hello, Watch!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
EOF

# Create Info.plist for Watch app
cat > "$PROJECT_DIR/$PROJECT_NAME/$WATCH_APP_NAME/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleDisplayName</key>
    <string>Watch App</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
    </array>
    <key>WKApplication</key>
    <true/>
    <key>WKCompanionAppBundleIdentifier</key>
    <string>com.example.WatchApp</string>
</dict>
</plist>
EOF

echo "✅ Created Swift source files"
echo "✅ Created Info.plist"

# Create README for the project
cat > "$PROJECT_DIR/$PROJECT_NAME/README.md" << EOF
# $PROJECT_NAME

A WatchOS application created with the Apple Watch Simulator Deployment tools.

## Project Structure

- \`$PROJECT_NAME/\` - iOS companion app (if needed)
- \`$WATCH_APP_NAME/\` - WatchOS app source code

## Building

1. Open the project in Xcode
2. Select the Watch app target
3. Choose a Watch simulator
4. Build and run (Cmd+R)

## Notes

This is a basic project structure. You'll need to:
1. Create an Xcode project and add these files
2. Configure build settings for WatchOS
3. Set up proper bundle identifiers
4. Add any additional dependencies

For automated deployment, use the scripts in the parent directory.
EOF

echo ""
echo "✅ Project structure created in: $PROJECT_DIR/$PROJECT_NAME"
echo ""
echo "Next steps:"
echo "  1. Open Xcode"
echo "  2. Create a new project or add these files to an existing project"
echo "  3. Configure for WatchOS target"
echo "  4. Use ./deploy_simulator.sh to deploy"
