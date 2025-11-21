#!/bin/bash

# iOS Deployment Script for Rituals MVP
# Supports: USB connected, Wireless, and TestFlight deployment

set -e

echo "📱 Rituals MVP - iOS Deployment Tool"
echo "===================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter not found. Please install Flutter first."
    exit 1
fi

print_success "Flutter found"

# Detect connected iOS devices
print_status "Detecting iOS devices..."
echo ""

DEVICES_OUTPUT=$(flutter devices 2>&1)

# Check for physical devices
PHYSICAL_DEVICES=$(echo "$DEVICES_OUTPUT" | grep "ios" | grep -v "Simulator" | grep -v "Checking" || true)
WIRELESS_DEVICES=$(echo "$DEVICES_OUTPUT" | grep "wireless" || true)

if [ -z "$PHYSICAL_DEVICES" ]; then
    print_warning "No iOS devices found"
    echo ""
    echo "To connect your iPhone:"
    echo "  1. Connect via USB cable"
    echo "  2. Unlock your iPhone"
    echo "  3. Trust this computer when prompted"
    echo ""
    echo "For wireless connection:"
    echo "  1. Connect iPhone via USB first"
    echo "  2. Open Xcode > Window > Devices and Simulators"
    echo "  3. Select your device"
    echo "  4. Check 'Connect via network'"
    echo ""
    exit 1
fi

echo "Found iOS devices:"
echo "$PHYSICAL_DEVICES"
echo ""

if [ -n "$WIRELESS_DEVICES" ]; then
    print_success "Wireless device detected!"
    echo "$WIRELESS_DEVICES"
    echo ""
fi

# Extract device ID
DEVICE_ID=$(echo "$PHYSICAL_DEVICES" | head -1 | awk '{print $4}')

print_status "Selected device: $DEVICE_ID"
echo ""

# Menu
echo "Select deployment mode:"
echo "  1) Debug build (development & testing)"
echo "  2) Release build (performance testing)"
echo "  3) Build IPA for TestFlight/App Store"
echo "  4) Just build (no install)"
echo ""
read -p "Enter choice [1-4]: " choice

case $choice in
    1)
        print_status "Building and installing DEBUG version..."
        flutter run -d $DEVICE_ID --debug
        ;;
    2)
        print_status "Building and installing RELEASE version..."
        flutter run -d $DEVICE_ID --release
        ;;
    3)
        print_status "Building IPA for distribution..."
        flutter build ipa --release
        
        print_success "IPA built successfully!"
        echo ""
        echo "📦 IPA location: build/ios/ipa/rituals.ipa"
        echo ""
        echo "Next steps for App Store:"
        echo "  1. Open Xcode"
        echo "  2. Window > Organizer"
        echo "  3. Distribute App"
        echo "  4. Upload to App Store Connect"
        echo ""
        echo "Or use Transporter app to upload the IPA directly"
        ;;
    4)
        print_status "Building iOS release..."
        flutter build ios --release
        
        print_success "Build complete!"
        echo ""
        echo "📦 App location: build/ios/iphoneos/Runner.app"
        echo ""
        echo "To install manually:"
        echo "  make install-ios-device"
        ;;
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

echo ""
print_success "Deployment complete!"
echo ""
echo "📱 Check your iPhone for the Rituals app"
echo ""
echo "🧪 Test Checklist:"
echo "  ✓ Create a ritual"
echo "  ✓ Edit a ritual"
echo "  ✓ Delete a ritual"
echo "  ✓ Enable notifications in Settings"
echo "  ✓ Wait for notification to appear"
echo "  ✓ Tap notification to open ritual"
echo "  ✓ Tap Done button"
echo ""

