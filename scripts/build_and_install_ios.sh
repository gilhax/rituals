#!/bin/bash

# Build and Install iOS App on Physical Device
# Usage: ./scripts/build_and_install_ios.sh

set -e

echo "🚀 Rituals - iOS Build & Install Script"
echo "========================================"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}➜ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check Flutter
if ! command -v flutter &> /dev/null; then
    print_error "Flutter not found. Please install Flutter first."
    exit 1
fi

print_success "Flutter found"

# Check for connected devices
print_step "Checking for connected iPhone..."
DEVICES=$(flutter devices 2>&1)

# Find iOS device (not simulator)
IOS_DEVICE=$(echo "$DEVICES" | grep "ios" | grep -v "Simulator" | head -1)

if [ -z "$IOS_DEVICE" ]; then
    print_error "No iPhone found!"
    echo ""
    echo "Please:"
    echo "  1. Connect your iPhone via USB or WiFi"
    echo "  2. Unlock your iPhone"
    echo "  3. Trust this computer"
    echo ""
    exit 1
fi

# Extract device ID
DEVICE_ID=$(echo "$IOS_DEVICE" | awk '{print $4}')
DEVICE_NAME=$(echo "$IOS_DEVICE" | awk '{for(i=1;i<=NF-5;i++) printf $i" "; print ""}' | sed 's/ *$//')

print_success "Found iPhone: $DEVICE_NAME"
echo "Device ID: $DEVICE_ID"
echo ""

# Clean previous builds
print_step "Cleaning previous builds..."
flutter clean > /dev/null 2>&1
print_success "Clean complete"

# Get dependencies
print_step "Getting dependencies..."
flutter pub get > /dev/null 2>&1
print_success "Dependencies ready"

# Build and install
print_step "Building and installing app on your iPhone..."
echo ""
echo "This will take 2-3 minutes..."
echo ""

# Run flutter with proper device ID
flutter run -d "$DEVICE_ID" --release

print_success "Build and installation complete!"
echo ""
echo "📱 App installed on: $DEVICE_NAME"
echo ""
echo "🧪 Quick Test:"
echo "  1. Open Rituals app on your iPhone"
echo "  2. Allow notifications when prompted"
echo "  3. Create a test ritual (1-2 min from now)"
echo "  4. Wait for notification to appear"
echo "  5. Tap notification to test deep linking"
echo ""

