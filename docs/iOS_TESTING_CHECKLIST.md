# iOS Testing Checklist - Rituals MVP

**Device:** iPhone (iOS 13+)  
**Build:** v1.0.0  
**Date:** November 21, 2025

---

## Pre-Testing Setup

### ✅ Device Connection
- [ ] iPhone connected (USB or wireless)
- [ ] Device appears in `flutter devices`
- [ ] Device trusted in Settings
- [ ] Developer mode enabled (iOS 16+)

### ✅ Build Installation
- [ ] App installed successfully
- [ ] App icon appears on home screen
- [ ] App launches without crashes

---

## Core Functionality Tests

### 1. ✅ Ritual Management

#### Create Ritual
- [ ] Tap FAB (+ button)
- [ ] Enter title: "Morning Meditation"
- [ ] Enter description: "10 minutes of quiet meditation"
- [ ] Select time: 8:00 AM
- [ ] Tap "Save"
- [ ] **Expected:** Ritual appears in list
- [ ] **Expected:** Success feedback shown

#### Edit Ritual
- [ ] Tap on existing ritual
- [ ] Tap "Edit" button
- [ ] Change title to "Morning Meditation Updated"
- [ ] Change time to 8:30 AM
- [ ] Tap "Save"
- [ ] **Expected:** Changes reflected in list
- [ ] **Expected:** Time updated

#### Delete Ritual
- [ ] Swipe left on ritual
- [ ] Tap "Delete"
- [ ] **Expected:** Confirmation dialog appears
- [ ] Tap "Delete" again
- [ ] **Expected:** Ritual removed from list

**Alternative Delete:**
- [ ] Tap on ritual
- [ ] Tap delete icon (if present)
- [ ] **Expected:** Same confirmation flow

---

### 2. ✅ Notifications (CRITICAL FOR iOS)

#### Permission Request
- [ ] First launch shows notification permission alert
- [ ] Tap "Allow"
- [ ] **Expected:** Permission granted
- [ ] Verify in Settings > Rituals > Notifications

#### Schedule Notification
- [ ] Create ritual with time 1-2 minutes from now
- [ ] Wait for scheduled time
- [ ] **Expected:** Notification appears on lock screen
- [ ] **Expected:** Notification appears in notification center
- [ ] **Expected:** Sound plays (if not silent mode)

#### Notification Tap
- [ ] Tap on notification
- [ ] **Expected:** App opens
- [ ] **Expected:** Ritual detail screen shown
- [ ] **Expected:** Correct ritual displayed

#### Notification Permission Denied (Edge Case)
- [ ] Go to Settings > Rituals > Notifications
- [ ] Turn off notifications
- [ ] Create new ritual
- [ ] **Expected:** No crash
- [ ] **Expected:** Graceful handling

---

### 3. ✅ Data Persistence

#### App Restart
- [ ] Create 2-3 rituals
- [ ] Force quit app (swipe up from app switcher)
- [ ] Reopen app
- [ ] **Expected:** All rituals still present
- [ ] **Expected:** Notifications still scheduled

#### Device Restart
- [ ] Create ritual
- [ ] Restart iPhone
- [ ] Open app
- [ ] **Expected:** Ritual still present
- [ ] **Expected:** Notification still works

---

### 4. ✅ UI/UX Tests

#### List Screen
- [ ] Empty state shows when no rituals
- [ ] **Expected:** Friendly empty state message
- [ ] **Expected:** Icon/illustration visible
- [ ] Add rituals
- [ ] **Expected:** Sorted by time (earliest first)

#### Detail Screen
- [ ] Tap on ritual
- [ ] **Expected:** Title, description, time visible
- [ ] **Expected:** "Done" button present
- [ ] Tap "Done" button
- [ ] **Expected:** Visual feedback

#### Form Screen
- [ ] Test with empty title
- [ ] **Expected:** Validation error shown
- [ ] Test with very long title (>100 chars)
- [ ] **Expected:** Validation error or truncation
- [ ] Test with very long description
- [ ] **Expected:** Handled gracefully

#### Navigation
- [ ] Back button works from all screens
- [ ] Navigation bar displays correctly
- [ ] No navigation glitches

---

### 5. ✅ Performance Tests

#### Startup
- [ ] App launches in < 3 seconds
- [ ] No splash screen hang
- [ ] Smooth transition to main screen

#### List Scrolling
- [ ] Create 10+ rituals
- [ ] Scroll through list
- [ ] **Expected:** Smooth 60fps scrolling
- [ ] No stuttering or lag

#### Form Input
- [ ] Type in title field
- [ ] **Expected:** No input lag
- [ ] Switch between fields
- [ ] **Expected:** Keyboard responds instantly

---

### 6. ✅ Edge Cases & Error Handling

#### Multiple Rituals Same Time
- [ ] Create 2 rituals for same time
- [ ] **Expected:** Both notifications schedule
- [ ] **Expected:** Both fire at correct time

#### Time in Past
- [ ] Create ritual with time earlier today
- [ ] **Expected:** Schedules for tomorrow
- [ ] **Expected:** Correct "next occurrence" shown

#### App in Background
- [ ] Create ritual
- [ ] Put app in background
- [ ] Wait for notification time
- [ ] **Expected:** Notification still fires

#### Low Memory
- [ ] Open many other apps
- [ ] Return to Rituals app
- [ ] **Expected:** App state preserved
- [ ] **Expected:** No crash

---

### 7. ✅ Accessibility Tests

#### VoiceOver
- [ ] Enable VoiceOver in Settings
- [ ] Navigate through app
- [ ] **Expected:** All elements labeled
- [ ] **Expected:** Logical navigation order
- [ ] Create/edit ritual with VoiceOver
- [ ] **Expected:** Fully functional

#### Dynamic Type
- [ ] Settings > Display & Brightness > Text Size
- [ ] Increase text size to maximum
- [ ] **Expected:** Text scales appropriately
- [ ] **Expected:** No text cutoff
- [ ] **Expected:** Layout adapts

#### Dark Mode
- [ ] Enable Dark Mode
- [ ] **Expected:** App uses dark theme
- [ ] **Expected:** Text readable
- [ ] **Expected:** No contrast issues

---

### 8. ✅ Orientation Tests

#### Portrait Mode
- [ ] App works in portrait
- [ ] **Expected:** Layout correct

#### Landscape Mode (if supported)
- [ ] Rotate device to landscape
- [ ] **Expected:** Layout adapts OR locked to portrait
- [ ] **Expected:** No broken layout

---

### 9. ✅ iOS-Specific Features

#### App Switcher
- [ ] Double-click home button / swipe up
- [ ] **Expected:** App preview shows correctly
- [ ] **Expected:** No sensitive data visible

#### Spotlight Search
- [ ] Open Spotlight (swipe down on home screen)
- [ ] Search for "Rituals"
- [ ] **Expected:** App appears in results

#### Share Sheet (if applicable)
- [ ] Long press on ritual (if implemented)
- [ ] **Expected:** Share options OR not implemented

---

## iOS-Specific Checks

### ✅ iOS Version Compatibility
- [ ] Test on iOS 13 (minimum)
- [ ] Test on iOS 18 (latest)
- [ ] **Expected:** Works on both

### ✅ Device Compatibility
- [ ] Test on iPhone SE (small screen)
- [ ] Test on iPhone Pro Max (large screen)
- [ ] **Expected:** Adapts to screen sizes

### ✅ Notification Settings
- [ ] Settings > Rituals > Notifications
- [ ] **Expected:** Banner, Sound, Badge options
- [ ] Toggle settings
- [ ] **Expected:** App respects settings

---

## Regression Tests

### After Each Code Change
- [ ] Run all critical tests above
- [ ] Focus on notifications (most iOS-specific)
- [ ] Check no new crashes introduced

---

## Performance Benchmarks

| Test | Target | Actual | Pass |
|------|--------|--------|------|
| Cold Start | <3s | ___s | [ ] |
| Notification Delivery | 100% | ___% | [ ] |
| Memory Usage | <100MB | ___MB | [ ] |
| Battery Impact | Minimal | ___ | [ ] |
| List Scroll FPS | 60fps | ___fps | [ ] |

---

## Known iOS Limitations

### By Design
1. **Notifications require permission** - System prompt, cannot bypass
2. **Background limits** - iOS may delay notifications if battery low
3. **Notification grouping** - iOS groups multiple rituals

### Technical
1. **Timezone handling** - Should work, needs verification
2. **Notification sound** - Uses system sound

---

## Sign-Off

### Tester Information
- **Name:** _____________
- **Device:** iPhone _____ (iOS ___)
- **Date:** _____________

### Test Results
- **Total Tests:** 50+
- **Passed:** ___
- **Failed:** ___
- **Blocked:** ___

### Verdict
- [ ] ✅ **PASS** - Ready for App Store
- [ ] ⚠️ **PASS WITH NOTES** - Minor issues, ready for release
- [ ] ❌ **FAIL** - Critical issues, needs fixes

### Notes
```
_____________________________________________
_____________________________________________
_____________________________________________
```

### Critical Issues Found
```
1. _____________________________________________
2. _____________________________________________
3. _____________________________________________
```

### Recommendations
```
_____________________________________________
_____________________________________________
_____________________________________________
```

---

## Quick Test (5 Minutes)

If time is limited, test these critical items:

1. **✅ Launch app** - No crash
2. **✅ Create ritual** - Works
3. **✅ Notification permission** - Granted
4. **✅ Wait for notification** - Appears
5. **✅ Tap notification** - Opens correct ritual
6. **✅ Delete ritual** - Works with confirmation
7. **✅ App restart** - Data persists

**If all 7 pass: iOS support is functional** ✅

---

*Use this checklist to systematically verify iOS compatibility*  
*Update with actual test results*  
*Report any issues found*

