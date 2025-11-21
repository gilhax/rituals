# iOS Deployment Guide - Rituals MVP

Quick guide for deploying Rituals app to iPhone devices.

---

## 🚀 Quick Start

### Option 1: Using Makefile (Easiest)
```bash
# Run on connected iPhone (USB or WiFi)
make run-ios-device

# Run on wireless iPhone specifically
make run-ios-wireless

# Build and install release version
make build-ios-release
make install-ios-device
```

### Option 2: Using Deployment Script
```bash
# Interactive deployment with menu
./scripts/deploy_ios.sh
```

### Option 3: Direct Flutter Commands
```bash
# List devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Build release
flutter build ios --release
```

---

## 📱 Device Setup

### First Time Setup

1. **Connect iPhone via USB**
   - Unlock iPhone
   - Trust this computer when prompted
   - Enter iPhone passcode

2. **Enable Developer Mode** (iOS 16+)
   - Settings > Privacy & Security > Developer Mode
   - Toggle ON
   - Restart iPhone

3. **Verify Connection**
   ```bash
   flutter devices
   ```
   Should show your iPhone

### Wireless Connection (Optional)

1. **Connect iPhone via USB first**

2. **Open Xcode**
   - Window > Devices and Simulators
   - Select your iPhone
   - Check "Connect via network"

3. **Disconnect USB**
   - iPhone should remain in `flutter devices` with "(wireless)" tag

4. **Deploy Wirelessly**
   ```bash
   make run-ios-wireless
   ```

---

## 🔨 Build Modes

### Debug Build (Development)
```bash
# Fast build, includes debugging symbols
make run-ios-device
```
**Use for:** Development, testing, debugging

### Release Build (Performance Testing)
```bash
# Optimized build, no debugging
flutter run -d <device-id> --release
```
**Use for:** Performance testing, pre-release validation

### Release Archive (App Store)
```bash
# Creates IPA file for distribution
make build-ios-archive
```
**Use for:** App Store submission, TestFlight

---

## 📦 Distribution

### TestFlight (Beta Testing)

1. **Build IPA**
   ```bash
   make build-ios-archive
   ```

2. **Upload to App Store Connect**
   - Use Xcode Organizer OR
   - Use Transporter app
   - Select `build/ios/ipa/rituals.ipa`

3. **Configure TestFlight**
   - App Store Connect > TestFlight
   - Add testers
   - Submit for review

### App Store (Production)

1. **Prepare App Store Connect**
   - Create app listing
   - Add screenshots
   - Write description
   - Set privacy policy

2. **Build and Upload**
   ```bash
   make build-ios-archive
   ```

3. **Submit for Review**
   - App Store Connect
   - Submit app
   - Wait for approval (1-3 days typically)

---

## 🧪 Testing on Device

### Quick Test (5 minutes)
```bash
# 1. Install app
make run-ios-device

# 2. On iPhone:
# - Create a ritual
# - Grant notification permission
# - Wait 1-2 minutes for notification
# - Tap notification
# - Verify app opens to ritual detail

# ✅ If all works: iOS support confirmed
```

### Full Test
See [iOS_TESTING_CHECKLIST.md](iOS_TESTING_CHECKLIST.md) for comprehensive testing.

---

## ⚠️ Common Issues

### Issue: Device not appearing
**Solution:**
```bash
# Check connection
flutter devices

# Restart Flutter
flutter doctor

# Unplug and replug iPhone
```

### Issue: "Unable to install"
**Solution:**
- Free up space on iPhone (need ~100MB)
- Delete old version of app
- Restart iPhone

### Issue: "Code signing error"
**Solution:**
- Open `ios/Runner.xcworkspace` in Xcode
- Select your development team
- Xcode will fix provisioning automatically

### Issue: Wireless connection fails
**Solution:**
- Ensure iPhone and Mac on same WiFi
- Disable VPN
- Re-enable "Connect via network" in Xcode

### Issue: Notifications not working
**Solution:**
- Settings > Rituals > Notifications > Enable
- Check iOS notification settings
- Grant permission when prompted

---

## 📊 Device Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| iOS Version | 13.0+ | 15.0+ |
| Storage | 50MB | 100MB |
| Network | None (offline app) | - |
| Permissions | Notifications | Notifications |

---

## 🔐 Code Signing

### Development (Testing)
- Automatic signing in Xcode
- Uses your Apple ID
- Free, no paid developer account needed
- Apps expire after 7 days

### Distribution (App Store)
- Requires Apple Developer Program ($99/year)
- Xcode manages certificates
- No expiration

---

## 🛠️ Advanced

### Custom Device Selection
```bash
# Find your device ID
flutter devices | grep ios

# Run on specific device
flutter run -d 00008110-001C10E11460201E
```

### Build with Custom Scheme
```bash
# Debug with custom flavor
flutter run --flavor development

# Release with specific target
flutter build ios --release --target=lib/main_production.dart
```

### Clean Build
```bash
# If build fails, try clean
flutter clean
flutter pub get
make run-ios-device
```

---

## 📱 Multi-Device Testing

### Test on Different Screen Sizes
```bash
# iPhone SE (small)
flutter run -d <se-device-id>

# iPhone 14 Pro Max (large)
flutter run -d <pro-max-device-id>
```

### Test on Different iOS Versions
- iOS 13: Minimum supported
- iOS 15: Recommended baseline
- iOS 18: Latest features

---

## 🚦 Pre-Release Checklist

Before submitting to App Store:

- [ ] Tested on physical device
- [ ] Notifications working
- [ ] All features functional
- [ ] No crashes
- [ ] App icon set
- [ ] Launch screen configured
- [ ] Privacy policy ready
- [ ] Screenshots prepared
- [ ] App Store listing complete

---

## 📞 Support

**Deployment Issues:**
- Check [iOS_TESTING_CHECKLIST.md](iOS_TESTING_CHECKLIST.md)
- Run `flutter doctor` for diagnostics
- Check Xcode console for errors

**App Issues:**
- See main [README.md](../README.md)
- Check [DEVELOPMENT.md](DEVELOPMENT.md)

---

## 🎯 Quick Commands Reference

```bash
# Check devices
flutter devices

# Run debug
make run-ios-device

# Run release (performance testing)
flutter run -d <device-id> --release

# Build for App Store
make build-ios-archive

# Install pre-built version
make install-ios-device

# Interactive deployment
./scripts/deploy_ios.sh
```

---

*Your iPhone "Alex" is ready to test!*  
*Device ID: 00008110-001C10E11460201E*  
*iOS Version: 18.3*

