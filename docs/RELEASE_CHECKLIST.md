# Rituals MVP — Release Checklist

Complete this checklist before releasing to production.

---

## Pre-Release Testing

### ✅ Functional Testing

#### Create Ritual Flow
- [ ] Tap + button opens form
- [ ] Title field validation works (required, 2-60 chars)
- [ ] Description field accepts 0-500 chars
- [ ] Time picker opens and saves selection
- [ ] Save button creates ritual
- [ ] Returns to list after save
- [ ] New ritual appears in list
- [ ] Notification is scheduled

#### View Ritual Flow
- [ ] List shows all rituals sorted by time
- [ ] Empty state shows when no rituals
- [ ] Tap card opens detail screen
- [ ] Detail shows title, time, description
- [ ] Done button shows checkmark animation
- [ ] Returns to list after Done

#### Edit Ritual Flow
- [ ] Tap edit icon opens form
- [ ] Form pre-fills with current data
- [ ] Can modify all fields
- [ ] Save updates ritual
- [ ] Notification is rescheduled
- [ ] Cancel discards changes

#### Delete Ritual Flow
- [ ] Swipe left shows delete option
- [ ] Confirmation dialog appears
- [ ] Confirm removes ritual from list
- [ ] Notification is cancelled
- [ ] Delete button in form also works

#### Notification Flow
- [ ] Notification fires at correct time
- [ ] Notification shows ritual title
- [ ] Tap notification opens app
- [ ] Opens correct ritual detail screen
- [ ] Can mark as done from notification tap

---

### ✅ Platform-Specific Testing

#### iOS (Required)
- [ ] Builds without errors
- [ ] Runs on iOS 13+ devices
- [ ] Notification permission requested
- [ ] Notifications fire correctly
- [ ] All screens render properly
- [ ] No crashes during 30-min session
- [ ] Works on iPhone SE, iPhone 15, iPad

#### macOS (Required)
- [ ] Builds without errors
- [ ] Runs on macOS 11+
- [ ] Notification permission requested
- [ ] Native macOS notifications work
- [ ] Keyboard shortcuts work (Cmd+W, etc.)
- [ ] Window resizing works
- [ ] No crashes

#### Web (Required)
- [ ] Builds without errors
- [ ] Loads in Chrome, Safari, Firefox
- [ ] Shows "no notifications" message
- [ ] All CRUD operations work
- [ ] Responsive on mobile viewport
- [ ] No console errors

---

### ✅ Edge Cases

- [ ] Create ritual with same time as existing
- [ ] Create ritual with past time (should schedule tomorrow)
- [ ] Edit ritual to change time
- [ ] Delete ritual while on detail screen
- [ ] Rapid tapping Save button (should disable)
- [ ] App restart preserves data
- [ ] 50+ rituals in list (performance)
- [ ] Empty title shows validation error
- [ ] Maximum length inputs (title 60, description 500)

---

### ✅ Error Handling

- [ ] Network unavailable (should work offline)
- [ ] Storage full (error message shown)
- [ ] Permission denied (graceful message)
- [ ] Corrupted data (doesn't crash)
- [ ] Missing ritual ID (shows not found)

---

## Code Quality

### ✅ Analysis

- [ ] `flutter analyze` returns zero errors
- [ ] No warnings in Xcode build
- [ ] No console errors in web build
- [ ] `dart format .` applied

### ✅ Testing

- [ ] All unit tests pass: `flutter test`
- [ ] Test coverage >70%
- [ ] No flaky tests

### ✅ Performance

- [ ] App launches in <2 seconds
- [ ] List scrolls at 60fps
- [ ] No memory leaks (profiled)
- [ ] Build size <50MB

---

## Documentation

### ✅ User-Facing

- [ ] USER_GUIDE.md complete
- [ ] Screenshots added
- [ ] App Store description written
- [ ] Privacy policy URL ready

### ✅ Developer-Facing

- [ ] README.md updated
- [ ] DEVELOPER_GUIDE.md complete
- [ ] Code comments added
- [ ] Architecture documented

---

## App Store Preparation

### ✅ iOS App Store

#### Metadata
- [ ] App name: "Rituals"
- [ ] Subtitle: "Daily Ritual Reminders"
- [ ] Description (4000 chars max)
- [ ] Keywords selected
- [ ] Category: Productivity
- [ ] Age rating: 4+

#### Media
- [ ] App icon (1024x1024)
- [ ] Screenshots (6.7", 6.5", 5.5" devices)
- [ ] Preview video (optional)

#### Build
- [ ] Archive uploaded to App Store Connect
- [ ] Build passed automated review
- [ ] TestFlight tested by 5+ beta users
- [ ] Version: 1.0.0
- [ ] Build number: 1

#### Legal
- [ ] Privacy policy URL added
- [ ] Support URL added
- [ ] Terms of service (if needed)
- [ ] EULA (if custom)

### ✅ macOS App Store

#### Metadata
- [ ] Same as iOS, adjusted for macOS
- [ ] Category: Productivity
- [ ] macOS 11+ requirement listed

#### Media
- [ ] App icon
- [ ] Screenshots (various screen sizes)

#### Build
- [ ] Archive created
- [ ] Code signed and notarized
- [ ] Uploaded to App Store Connect

### ✅ Web Deployment

- [ ] Domain purchased (e.g., rituals.app)
- [ ] Hosting configured (Firebase, Netlify, etc.)
- [ ] SSL certificate active
- [ ] PWA manifest configured
- [ ] Analytics added (if desired)

---

## Security & Privacy

### ✅ Security Review

- [ ] No hardcoded secrets
- [ ] No external API calls
- [ ] Input validation on all fields
- [ ] No XSS vulnerabilities (web)
- [ ] App sandbox enabled (macOS)

### ✅ Privacy Compliance

- [ ] No personal data collected
- [ ] No analytics without consent
- [ ] Privacy policy accurate
- [ ] GDPR compliant (if EU users)
- [ ] No third-party trackers

---

## Launch

### ✅ Pre-Launch

- [ ] Beta testing complete (10+ users)
- [ ] All critical bugs fixed
- [ ] Support email setup
- [ ] Social media accounts ready
- [ ] Landing page live

### ✅ Launch Day

- [ ] iOS app submitted for review
- [ ] macOS app submitted for review
- [ ] Web app deployed
- [ ] Announcement post published
- [ ] Support team ready

### ✅ Post-Launch (Week 1)

- [ ] Monitor crash reports
- [ ] Respond to user reviews
- [ ] Track adoption metrics
- [ ] Address urgent bugs
- [ ] Plan version 1.1

---

## Rollback Plan

If critical issues discovered:

### iOS/macOS
1. Reject binary in App Store Connect (if not released)
2. Remove from sale (if released)
3. Fix issues
4. Re-submit

### Web
1. Deploy previous version
2. Fix issues
3. Redeploy

---

## Success Metrics (Week 1)

- [ ] 0 crashes per session
- [ ] <5% uninstall rate
- [ ] >4.0 rating (iOS App Store)
- [ ] 50+ downloads
- [ ] 3+ positive reviews

---

## Sign-Off

**Product Owner:** __________ Date: __________  
**Tech Lead:** __________ Date: __________  
**QA Lead:** __________ Date: __________  
**Designer:** __________ Date: __________  

---

**Ready for Release:** ☐ YES ☐ NO

**If NO, blockers:**

1. _______________________________________
2. _______________________________________
3. _______________________________________

---

*Version 1.0 — Updated November 20, 2025*


