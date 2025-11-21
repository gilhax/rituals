#!/bin/bash

# Quick Install iOS App (Debug Mode - Faster)
# Usage: ./scripts/quick_install_ios.sh

set -e

echo "⚡ Quick iOS Install (Debug Mode)"
echo "================================="
echo ""

# Find iOS device
DEVICE_ID=$(flutter devices 2>&1 | grep "ios" | grep -v "Simulator" | head -1 | awk '{print $4}')

if [ -z "$DEVICE_ID" ]; then
    echo "❌ No iPhone found!"
    echo "Connect your iPhone and try again."
    exit 1
fi

echo "📱 Installing on device: $DEVICE_ID"
echo ""
echo "⏳ This takes ~2-3 minutes on first build..."
echo ""

# Run in debug mode (faster, includes hot reload)
flutter run -d "$DEVICE_ID"

