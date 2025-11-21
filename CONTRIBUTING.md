# Contributing to Rituals

Thank you for your interest in contributing to Rituals! This document provides guidelines and instructions for contributing.

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [How to Contribute](#how-to-contribute)
4. [Development Process](#development-process)
5. [Code Standards](#code-standards)
6. [Pull Request Process](#pull-request-process)
7. [Issue Guidelines](#issue-guidelines)

---

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all.

### Standards

**Positive behavior:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community

**Unacceptable behavior:**
- Harassment or discriminatory language
- Trolling or insulting comments
- Public or private harassment
- Publishing others' private information

### Enforcement

Report unacceptable behavior to conduct@rituals.app. All complaints will be reviewed and investigated.

---

## Getting Started

### Prerequisites

- Flutter SDK 3.24.0+
- Dart 3.5.0+
- Git
- Xcode (for iOS/macOS)
- Chrome (for Web)

### Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork:

git clone https://github.com/YOUR-USERNAME/rituals.git
cd rituals
```

### Setup

```bash
# Install dependencies
flutter pub get

# Verify setup
flutter doctor

# Run tests
flutter test

# Run app
flutter run -d "iPhone 15 Pro"
```

---

## How to Contribute

### Types of Contributions

**Bug Fixes**
- Fix existing issues
- Add test coverage
- Update documentation

**Features** (discuss first!)
- Check if feature aligns with product vision
- Open an issue to discuss before coding
- Keep changes focused and minimal

**Documentation**
- Fix typos
- Improve clarity
- Add examples
- Translate (future)

**Tests**
- Increase test coverage
- Add missing test cases
- Improve test quality

---

## Development Process

### 1. Pick an Issue

- Browse [open issues](https://github.com/yourorg/rituals/issues)
- Look for `good-first-issue` or `help-wanted` labels
- Comment "I'd like to work on this"
- Wait for assignment (prevents duplicate work)

### 2. Create a Branch

```bash
# Update main
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/issue-number-description
```

### 3. Make Changes

- Write code following our standards
- Add tests for new functionality
- Update documentation
- Keep commits small and focused

### 4. Test

```bash
# Run all tests
flutter test

# Check formatting
dart format --set-exit-if-changed .

# Check for errors
flutter analyze

# Run on device
flutter run -d "iPhone 15 Pro"
```

### 5. Commit

```bash
# Stage changes
git add .

# Commit with descriptive message
git commit -m "feat: add ritual completion animation"
```

**Commit message format:**

```
<type>: <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding/updating tests
- `chore`: Maintenance tasks

**Examples:**

```
feat: add dark mode support

fix: resolve notification timing issue on iOS 17

docs: update README with new installation steps

test: add unit tests for RitualProvider
```

### 6. Push

```bash
git push origin feature/your-feature-name
```

### 7. Open Pull Request

- Go to GitHub
- Click "New Pull Request"
- Fill out PR template
- Wait for review

---

## Code Standards

### Dart Style

Follow [Effective Dart](https://dart.dev/guides/language/effective-dart):

```dart
// Good
class RitualCard extends StatelessWidget {
  final Ritual ritual;
  final VoidCallback onTap;
  
  const RitualCard({
    super.key,
    required this.ritual,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(ritual.title),
        onTap: onTap,
      ),
    );
  }
}
```

### File Organization

```dart
// 1. Imports (grouped and sorted)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ritual.dart';
import '../theme/app_theme.dart';

// 2. Class/functions

// 3. Private helpers at bottom
```

### Documentation

```dart
/// Creates a new ritual and schedules notification.
///
/// Throws [Exception] if save fails.
Future<void> createRitual({
  required String title,
  required String description,
  required TimeOfDay time,
}) async {
  // Implementation
}
```

### Testing

Every new feature needs tests:

```dart
// test/feature_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Feature', () {
    test('should do something', () {
      // Arrange
      final input = 'test';
      
      // Act
      final result = doSomething(input);
      
      // Assert
      expect(result, expectedValue);
    });
  });
}
```

---

## Pull Request Process

### Before Submitting

- [ ] Tests pass: `flutter test`
- [ ] No linter errors: `flutter analyze`
- [ ] Code formatted: `dart format .`
- [ ] Documentation updated
- [ ] CHANGELOG.md updated (for significant changes)

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How was this tested?

## Screenshots
If applicable

## Checklist
- [ ] Tests pass
- [ ] Linter passes
- [ ] Documentation updated
```

### Review Process

1. **Automated checks:** CI runs tests
2. **Code review:** Maintainer reviews code
3. **Feedback:** Address comments
4. **Approval:** Once approved, maintainer merges

### Review Timeline

- Initial review: Within 48 hours
- Follow-up: Within 24 hours
- Merge: When all checks pass

---

## Issue Guidelines

### Bug Reports

Use the bug template:

```markdown
**Describe the bug**
Clear description

**To Reproduce**
1. Step one
2. Step two
3. See error

**Expected behavior**
What should happen

**Platform**
- iOS 17
- Device: iPhone 15
- App version: 1.0.0

**Screenshots**
If applicable
```

### Feature Requests

```markdown
**Is your feature request related to a problem?**
Description of problem

**Describe the solution**
What would you like to happen?

**Describe alternatives**
Alternative solutions considered

**Additional context**
Any other info
```

### Questions

- Check FAQ first
- Search existing issues
- Use discussion board (not issues) for questions

---

## Development Tips

### Hot Reload

While running:
- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit

### Debugging

```dart
// Use debugPrint (not print)
debugPrint('Ritual created: ${ritual.id}');

// Add breakpoints in IDE
// Step through code
```

### Performance

```dart
// Use performance monitor
import 'package:rituals/utils/performance_monitor.dart';

await performanceMonitor.time('operation', () async {
  // Code to measure
});
```

---

## Common Tasks

### Adding a Screen

1. Create file in `lib/screens/`
2. Follow naming: `feature_screen.dart`
3. Use AppTheme constants
4. Add navigation
5. Write widget test

### Adding a Widget

1. Create file in `lib/widgets/`
2. Make reusable and configurable
3. Add to theme if needed
4. Document parameters
5. Write widget test

### Updating a Model

1. Modify model class
2. Update `toJson()` and `fromJson()`
3. Bump schema version if breaking
4. Add migration if needed
5. Update tests

---

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Thanked on social media (if desired)

---

## Questions?

- **Documentation:** Check docs/ folder
- **Chat:** [Discord/Slack link if available]
- **Email:** dev@rituals.app

---

**Thank you for contributing to Rituals!** 🌅

---

*Contributing Guidelines Version 1.0*  
*Last Updated: November 20, 2025*


