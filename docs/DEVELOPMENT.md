# Development Guide

Quick guide for developing the Rituals MVP.

## Prerequisites

- Flutter SDK (stable channel)
- Xcode (for macOS/iOS)
- Chrome (for web)

## Getting Started

```bash
# Install dependencies
make install

# Run on macOS
make run-macos

# Run on web
make run-web

# Run tests
make test

# Lint & format
make lint
```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/                # Data models
├── providers/             # State management
├── repositories/          # Data access layer
├── screens/               # UI screens
├── services/              # Business logic services
├── theme/                 # Design tokens
├── utils/                 # Utilities
└── widgets/               # Reusable widgets
```

## Architecture

**3-Layer Architecture:**
- **UI Layer**: Screens & widgets
- **Business Logic**: Providers & services
- **Data Layer**: Repositories & models

**State Management**: Provider (ChangeNotifier)  
**Local Storage**: SharedPreferences  
**Notifications**: Platform-specific (flutter_local_notifications + Web Notification API)

## Testing

```bash
# Run all tests
make test

# Run with coverage
make test-coverage

# Run specific test
flutter test test/models/ritual_test.dart
```

## Building

```bash
# Debug build
make build-macos-debug
make build-web-debug

# Release build
make build-macos-release
make build-web-release
```

## Code Quality

- Follow Dart style guide
- Run `make lint` before committing
- Maintain test coverage >70%
- Update tests when adding features

## Debugging

### Notifications (macOS)
1. Check System Settings > Notifications
2. Enable notifications for Rituals app
3. View logs in console

### Notifications (Web)
1. Check browser notification permissions
2. Minimize tab to see notifications
3. Open DevTools > Console for logs

## Common Issues

**Notifications not appearing:**
- macOS: Check System Settings permissions
- Web: Minimize browser tab (notifications don't show when tab is active)

**Build fails:**
```bash
make clean
make install
```

**Tests fail:**
```bash
flutter clean
flutter pub get
make test
```

## Contributing

1. Create feature branch from `dev`
2. Make changes
3. Run `make lint` and `make test`
4. Create PR to `dev` branch
5. Wait for review

See `CONTRIBUTING.md` for details.

