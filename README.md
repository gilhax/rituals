# Rituals MVP

A daily ritual reminder app to help you build stable habits.

## Features (MVP)

- ✅ Create, edit, and delete rituals
- ✅ Local notifications at scheduled times
- ✅ Mark rituals as done
- ✅ Offline-first (local storage)
- ✅ Cross-platform: iOS, Web, macOS

## Tech Stack

- **Framework:** Flutter 3.24+
- **State Management:** Provider
- **Local Storage:** shared_preferences
- **Notifications:** flutter_local_notifications

## Getting Started

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Xcode 15+ (for iOS/macOS)
- Chrome (for Web)

### Quick Start (Using Makefile)

```bash
# Install dependencies
make install

# Run on your platform
make run-macos          # macOS
make run-web            # Web (Chrome)
make run-ios-device     # iOS (connected iPhone)
make run-ios-wireless   # iOS (wireless iPhone)

# Run tests
make test

# Validate before commit
make validate
```

### Manual Installation

```bash
# Get dependencies
flutter pub get

# Run on platforms
flutter run -d macos           # macOS
flutter run -d chrome          # Web
flutter run -d ios             # iOS simulator
flutter run -d <device-id>     # Physical iPhone
```

See [Makefile](Makefile) for all available commands.

### Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
├── repositories/                # Data access layer
├── services/                    # Business logic
├── providers/                   # State management
├── screens/                     # UI screens
├── widgets/                     # Reusable components
└── theme/                       # Design tokens
```

## Platform Setup

### iOS
**Quick Deploy:**
```bash
make run-ios-device     # USB or WiFi connected
# OR
./scripts/deploy_ios.sh # Interactive menu
```

**Detailed Guide:** See [docs/iOS_DEPLOYMENT.md](docs/iOS_DEPLOYMENT.md)

**Testing Checklist:** See [docs/iOS_TESTING_CHECKLIST.md](docs/iOS_TESTING_CHECKLIST.md)

### macOS
```bash
make run-macos
```
Notifications work out of the box. Grant permission when prompted.

### Web
```bash
make run-web
```
Browser notifications supported. Minimize tab to see notifications (browser behavior).

## Documentation

- 📖 [Quick Start](QUICK_START.md) - Get started in 5 minutes
- 🛠️ [Development Guide](docs/DEVELOPMENT.md) - Full developer docs
- 📱 [iOS Deployment](docs/iOS_DEPLOYMENT.md) - iPhone deployment guide
- ✅ [iOS Testing Checklist](docs/iOS_TESTING_CHECKLIST.md) - Comprehensive testing
- 🎯 [PRD](docs/PRD.md) - Product requirements
- 📝 [Contributing](CONTRIBUTING.md) - How to contribute
- 📋 [Changelog](CHANGELOG.md) - Version history

## License

See LICENSE file.
