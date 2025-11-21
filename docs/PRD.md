
# Rituals MVP — Product Requirements Document (PRD)

## 1. Overview

- **Goal:** Help the user perform daily rituals (morning/evening etc.) without forgetting steps.
- **Core flow:** Device shows a notification about a ritual → user opens the ritual → reads what to do → performs it → taps **Done**.
- **User problems:**
  - Cannot remember all morning/evening tasks.
  - Wants to build a stable daily habit.

## 2. MVP Scope

### 2.1. Included

1. **Rituals**
   - Create ritual.
   - Edit / delete ritual.
   - Text description of what needs to be done.

2. **Notifications**
   - Local notifications on device based on ritual schedule.
   - Tapping notification opens the corresponding ritual screen.

3. **Completion**
   - Ritual detail screen with description.
   - **Done** button to mark the ritual as completed (at least for current moment/day).

4. **Data storage**
   - All data stored locally on device.

5. **UX constraints**
   - English-only interface.
   - Works offline.

6. **Platforms**
   - iOS  
   - Web  
   - macOS  

### 2.2. Not in MVP (Future)

- Sync between platforms/devices.
- History of completed rituals.
- Import/export all rituals via a single file.
- More detailed ritual configuration.
- More flexible notification settings.
- Sequential steps configuration inside a ritual.
- Multi-language interface.
- System that respects timezone changes.
- Push notifications using backend.
- Platform-adapted design for desktop and mobile.
- Backend (e.g. Go) for sync/history/etc.
- Voice + AI for configuration/creation/editing of rituals.

## 3. Core Scenarios

### 3.1. Receive notification and complete ritual

1. App schedules local notification for a ritual.
2. At the right time, notification fires.
3. User taps the notification.
4. Ritual detail screen opens with description.
5. User does what is written.
6. User taps **Done**.

### 3.2. Configure ritual

1. User opens the app.
2. Sees list of rituals.
3. Opens edit mode.
4. Creates a new ritual or edits an existing one.

### 3.3. View ritual

1. User opens the app manually.
2. Selects ritual from the list.
3. Sees detail screen with description.

## 4. Data

### 4.1. Entity

**Ritual (MVP):**

- `id`
- `title`
- `description`
- `time`

### 4.2. Storage

- Local storage on device (no backend).
- Local scheduling of notifications only.

## 5. UX / UI

- Style: minimalistic, with a feeling of a “pleasant ritual” that you want to come back to.
- Main screens:
  - ritual list;
  - ritual detail;
  - ritual create/edit.
- Focus: quickly perform the key action and close the app.

## 6. Technical

- **Frontend:** Flutter.
- **Platforms:** iOS, Web, macOS.
- **Backend:** none in MVP. Later a backend for sync between devices is possible.
- **Integrations in MVP:** only local notifications.

## 7. Success criteria

- You and friends can:
  - configure a ritual,
  - receive a notification,
  - open description,
  - tap **Done**,
  quickly and without crashes.
- App can be used daily, with no blocking bugs.
