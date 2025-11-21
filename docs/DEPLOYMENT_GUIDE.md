# Deployment Guide

Complete guide for deploying Rituals to all platforms.

---

## Table of Contents

1. [Pre-Deployment](#pre-deployment)
2. [iOS Deployment](#ios-deployment)
3. [macOS Deployment](#macos-deployment)
4. [Web Deployment](#web-deployment)
5. [Post-Deployment](#post-deployment)
6. [Rollback Procedures](#rollback-procedures)
7. [Monitoring](#monitoring)

---

## Pre-Deployment

### Checklist

- [ ] All tests passing
- [ ] Zero linter errors
- [ ] Release checklist complete
- [ ] CHANGELOG.md updated
- [ ] Version bumped in pubspec.yaml
- [ ] App Store metadata ready
- [ ] Screenshots prepared
- [ ] Privacy policy live
- [ ] Support email active

### Version Numbering

Follow [Semantic Versioning](https://semver.org/):

```
MAJOR.MINOR.PATCH+BUILD

Example: 1.0.0+1
- 1 = Major version
- 0 = Minor version
- 0 = Patch version
- 1 = Build number
```

**When to increment:**
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes
- BUILD: Every App Store submission

### Update Version

```yaml
# pubspec.yaml
version: 1.0.0+1
```

---

## iOS Deployment

### Prerequisites

- Xcode 15+
- Active Apple Developer account ($99/year)
- App Store Connect access
- Certificates and provisioning profiles configured

### Step 1: Configure Signing

```bash
open ios/Runner.xcworkspace
```

In Xcode:
1. Select Runner target
2. Signing & Capabilities tab
3. Team → Select your team
4. Bundle Identifier → com.yourcompany.rituals
5. Signing Certificate → Apple Distribution

### Step 2: Build Archive

```bash
# Clean build folder
flutter clean
flutter pub get

# Build release
flutter build ios --release

# Or build archive directly in Xcode
# Product → Archive
```

### Step 3: Upload to App Store Connect

In Xcode:
1. Window → Organizer
2. Select latest archive
3. Distribute App
4. App Store Connect
5. Upload
6. Wait for processing (10-30 min)

### Step 4: Create App Store Listing

In [App Store Connect](https://appstoreconnect.apple.com):

1. **App Information**
   - Name: Rituals
   - Subtitle: Daily Ritual Reminders
   - Bundle ID: com.yourcompany.rituals
   - SKU: rituals-ios-1
   - Primary Language: English (U.S.)

2. **Pricing**
   - Price: Free
   - Availability: All countries

3. **App Privacy**
   - Data Collection: None
   - Privacy Policy URL: https://rituals.app/privacy

4. **Category**
   - Primary: Productivity
   - Secondary: Lifestyle

5. **Version Information**
   - Version: 1.0.0
   - Copyright: © 2025 Your Company
   - Age Rating: 4+

6. **Build**
   - Select uploaded build
   - Export Compliance: No encryption (or select if using)

7. **Screenshots** (see APP_STORE_METADATA.md)
   - 6.7" (iPhone 15 Pro Max)
   - 6.5" (iPhone 11 Pro Max)
   - 5.5" (iPhone 8 Plus)

8. **Description**
   - Copy from APP_STORE_METADATA.md

9. **Keywords**
   - ritual,habit,routine,reminder,meditation,journal,daily

10. **Support URL**
    - https://rituals.app/support

11. **Marketing URL**
    - https://rituals.app

### Step 5: Submit for Review

1. Click "Add for Review"
2. Answer app review questions:
   - Demo Account: Not required
   - Contact Info: Your email
   - Notes: "See USER_GUIDE.md for testing instructions"
3. Submit

### Step 6: Wait for Approval

- **Timeline:** 24-48 hours typically
- **Status:** Track in App Store Connect
- **If rejected:** Address feedback and resubmit

### Step 7: Release

Once approved:
1. Automatic release (or manual if configured)
2. App appears in App Store within hours
3. Users can download

---

## macOS Deployment

### Prerequisites

- Xcode 15+
- Apple Developer account
- Developer ID Application certificate
- Notarization setup

### Step 1: Configure Signing

```bash
open macos/Runner.xcworkspace
```

Configure like iOS, but also:
1. Enable App Sandbox
2. Enable Notifications capability
3. Set minimum macOS version: 11.0

### Step 2: Build Release

```bash
flutter build macos --release
```

Output: `build/macos/Build/Products/Release/rituals.app`

### Step 3: Code Sign

```bash
# Sign the app
codesign --deep --force --verify --verbose \
  --sign "Developer ID Application: Your Name (TEAM_ID)" \
  --options runtime \
  build/macos/Build/Products/Release/rituals.app
```

### Step 4: Notarize

```bash
# Create DMG
hdiutil create -volname Rituals -srcfolder \
  build/macos/Build/Products/Release/rituals.app \
  -ov -format UDZO rituals.dmg

# Upload for notarization
xcrun notarytool submit rituals.dmg \
  --apple-id your@email.com \
  --team-id TEAM_ID \
  --password app-specific-password \
  --wait

# Staple notarization
xcrun stapler staple rituals.dmg
```

### Step 5: Upload to App Store

Similar to iOS:
1. Create macOS app in App Store Connect
2. Upload via Xcode Organizer
3. Fill metadata
4. Submit for review

---

## Web Deployment

### Option 1: Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Build
flutter build web --release

# Deploy
firebase deploy --only hosting
```

**URL:** https://your-project.web.app

### Option 2: Netlify

```bash
# Build
flutter build web --release

# Deploy via Netlify CLI
npm install -g netlify-cli
netlify login
netlify deploy --prod --dir=build/web
```

Or connect GitHub repo for automatic deploys.

### Option 3: GitHub Pages

Uses `.github/workflows/build-web.yml`:

1. Push to main branch
2. Action builds and deploys automatically
3. Available at: https://yourusername.github.io/rituals

### Custom Domain

1. Purchase domain (e.g., rituals.app)
2. Configure DNS:
   ```
   CNAME  www  your-hosting.com
   A      @    your-ip-address
   ```
3. Enable SSL certificate
4. Update `web/index.html` base href if needed

---

## Post-Deployment

### Immediate Checks (First Hour)

- [ ] App appears in store
- [ ] Download and install
- [ ] Test core flow (create → notify → complete)
- [ ] Check crash reports
- [ ] Monitor reviews

### First Week Monitoring

- [ ] Daily crash rate <0.1%
- [ ] App Store rating >4.0
- [ ] User reviews sentiment
- [ ] Download numbers
- [ ] Any critical bugs reported

### Metrics to Track

| Metric | Source | Target |
|--------|--------|--------|
| Downloads | App Store Connect | 100+ week 1 |
| Crashes | App Store Connect | <0.1% |
| Rating | App Store | >4.0 |
| Reviews | App Store | Read all |
| Support emails | Inbox | Respond <24h |

---

## Rollback Procedures

### iOS/macOS

**If critical bug found:**

1. **Immediate:**
   - Remove from sale in App Store Connect
   - Post update in release notes

2. **Fix:**
   - Create hotfix branch
   - Fix bug
   - Test thoroughly
   - Bump version (e.g., 1.0.0 → 1.0.1)

3. **Redeploy:**
   - Submit new version
   - Request expedited review (if critical)

**Cannot rollback** to previous version in App Store.

### Web

**Easy rollback:**

```bash
# Firebase
firebase hosting:rollback

# Netlify
netlify rollback

# GitHub Pages
git revert <commit>
git push origin main
```

---

## Monitoring

### App Store Connect

**Metrics to check daily:**
- Crashes (should be 0)
- App Store rating trend
- Review sentiment
- Download numbers

### Crash Reporting

**MVP:** Monitor via App Store Connect

**Future:** Integrate Sentry/Crashlytics

```dart
// Future integration example
void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'your-dsn';
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

### User Feedback

**Channels:**
- App Store reviews → Read daily
- Support email → Respond within 24h
- Social media → Monitor mentions

**Response templates:** See APP_STORE_METADATA.md

---

## Continuous Deployment

### Automated Pipeline (Future)

```yaml
# .github/workflows/deploy-ios.yml
on:
  push:
    tags:
      - 'v*'

jobs:
  deploy:
    runs-on: macos-latest
    steps:
      - Build
      - Test
      - Upload to TestFlight
      - Notify team
```

---

## Hotfix Process

**For critical bugs:**

1. Create hotfix branch from main
2. Fix bug
3. Test fix
4. Bump patch version
5. Deploy immediately
6. Merge back to main and dev

**Timeline target:** <4 hours from discovery to deployment

---

## Deployment Checklist Template

```markdown
## Deployment: Version X.Y.Z

**Date:** YYYY-MM-DD
**Deployer:** [Name]

### Pre-Deployment
- [ ] Tests passing
- [ ] Version bumped
- [ ] CHANGELOG updated
- [ ] Metadata ready

### iOS
- [ ] Archive created
- [ ] Uploaded to App Store Connect
- [ ] Metadata filled
- [ ] Submitted for review
- [ ] Approved
- [ ] Released

### macOS
- [ ] Build created
- [ ] Signed and notarized
- [ ] Uploaded
- [ ] Released

### Web
- [ ] Built
- [ ] Deployed
- [ ] Live

### Post-Deployment
- [ ] Tested in production
- [ ] No crashes
- [ ] Monitoring active
- [ ] Team notified

**Status:** ✅ Complete / ⚠️ Issues / ❌ Rolled back

**Notes:** [Any issues or observations]
```

---

## Support Runbook

### User Reports "App Crashes"

1. Ask for:
   - Platform (iOS/macOS/Web)
   - Version
   - Steps to reproduce
   - When it started

2. Check App Store Connect crash reports

3. If reproducible:
   - File bug
   - Fix in hotfix
   - Notify user when fixed

### User Reports "Notification Not Working"

1. Ask for:
   - Platform
   - Permission status
   - Time set vs current time

2. Common causes:
   - Permissions denied → Guide to settings
   - Time already passed → Explain daily schedule
   - Web platform → Explain not supported

---

*Deployment Guide Version 1.0*  
*Last Updated: November 20, 2025*


