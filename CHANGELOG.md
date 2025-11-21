# Changelog

All notable changes to the Rituals MVP will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned Features
- Sync between devices
- Completion history tracking
- Import/export functionality
- Sequential steps within rituals
- Custom notification sounds
- Timezone support
- Backend for sync
- Multi-language support

---

## [1.0.0] - 2025-11-21

### Added
- **Core Ritual Management**
  - Create new rituals with title, description, and time
  - Edit existing rituals
  - Delete rituals (swipe or button with confirmation)
  - View all rituals in sorted list by time

- **Local Notifications**
  - Daily reminders at scheduled times (macOS, iOS)
  - Web notifications via browser Notification API
  - Tap notification to open ritual detail (deep linking)
  - Auto-schedule on create/edit
  - Auto-cancel on delete
  - Timezone-aware scheduling

- **User Interface**
  - Minimalistic design with calm purple theme
  - Ritual list screen with FAB
  - Ritual detail screen with animated Done button
  - Create/edit form with validation
  - Empty state with illustration
  - Card-based layout with shadows

- **Data Storage**
  - Local persistence via shared_preferences
  - JSON serialization
  - Offline-first architecture

- **Platform Support**
  - iOS 13+ support (native notifications)
  - macOS 11+ support (native notifications)
  - Web support (browser notifications with user guidance)
  - Cross-platform notification abstraction

- **Testing**
  - Unit tests for models
  - Unit tests for repository
  - Unit tests for provider
  - Unit tests for validators
  - Test coverage reports

- **Documentation**
  - User guide
  - Developer guide
  - Release checklist
  - MVP completion report
  - README with quick start

### Technical Details
- Flutter 3.24.0
- Dart 3.5.0
- Provider state management
- Material Design 3
- Zero linter errors
- Clean architecture pattern

---

## [0.1.0] - 2025-11-20 (Internal Alpha)

### Added
- Initial project setup
- Basic architecture
- Core data models
- Prototype UI

---

[Unreleased]: https://github.com/yourorg/rituals/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourorg/rituals/releases/tag/v1.0.0
[0.1.0]: https://github.com/yourorg/rituals/releases/tag/v0.1.0


