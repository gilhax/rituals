# Accessibility Guide

Rituals is designed to be accessible to all users, including those using assistive technologies.

---

## Supported Features

### Screen Readers

**iOS: VoiceOver**
- All interactive elements properly labeled
- Screen announcements for actions (ritual created, deleted, completed)
- Logical navigation order
- Grouped elements for better context

**macOS: VoiceOver**
- Full keyboard navigation
- All buttons and fields accessible
- Proper heading hierarchy

**Web: NVDA / JAWS**
- Semantic HTML structure
- ARIA labels where needed
- Keyboard navigation

---

## Keyboard Navigation (macOS/Web)

### Global Shortcuts

- `Tab` — Move to next element
- `Shift + Tab` — Move to previous element
- `Enter` — Activate button/link
- `Escape` — Close dialog/cancel

### Screen-Specific

**Ritual List:**
- `Cmd/Ctrl + N` — Create new ritual
- `Arrow Keys` — Navigate list
- `Enter` — Open selected ritual
- `Delete/Backspace` — Delete selected ritual (with confirmation)

**Create/Edit Form:**
- `Tab` — Move between fields
- `Cmd/Ctrl + S` — Save
- `Escape` — Cancel

**Detail Screen:**
- `Space` — Mark as done
- `Escape` — Go back

---

## Visual Accessibility

### Text Scaling

Rituals supports Dynamic Type (iOS) and system text scaling.

**Testing:**
- iOS: Settings → Accessibility → Display & Text Size → Larger Text
- macOS: System Settings → Accessibility → Display → Text Size
- Web: Browser zoom (Cmd/Ctrl + +/-)

All text scales from 100% to 200% without breaking layout.

### Color Contrast

All text meets WCAG AA standards:

| Element | Contrast Ratio | Standard |
|---------|---------------|----------|
| Body text on background | 11.8:1 | AAA |
| Button text on primary | 5.2:1 | AA |
| Secondary text | 4.8:1 | AA |
| Error text | 6.1:1 | AA |

**Color blindness support:**
- Red/green: Error states use icons + text
- Blue/yellow: No reliance on blue/yellow alone

### High Contrast Mode

- Automatically adapts to system high contrast settings
- Increases border thickness
- Uses system accent colors

---

## Motor Accessibility

### Touch Targets

All interactive elements meet minimum touch target size:
- **Buttons:** 56x56 pt (exceeds 44x44 minimum)
- **List items:** Full card width, 72 pt height
- **Icons:** 48x48 pt touch area

### Timing

- No time-based actions required
- Done button animation doesn't require precise timing
- Notifications persist until dismissed

### Alternative Inputs

- Full keyboard support (macOS/Web)
- Switch control compatible (iOS/macOS)
- Voice control supported

---

## Cognitive Accessibility

### Simple Language

- Clear, direct instructions
- No jargon or technical terms
- Short sentences

### Visual Clarity

- Minimalistic design reduces cognitive load
- One primary action per screen
- Consistent layout and navigation

### Error Prevention

- Confirmation dialogs for destructive actions
- Validation messages in plain language
- Undo not needed (confirmation prevents mistakes)

---

## Hearing Accessibility

- No audio-only content
- Visual notification indicators
- All information available visually

---

## Testing Checklist

### VoiceOver Testing (iOS)

- [ ] Enable VoiceOver: Settings → Accessibility → VoiceOver
- [ ] Navigate ritual list (swipe right/left)
- [ ] Create ritual (all fields announced)
- [ ] Edit ritual (values announced)
- [ ] Delete ritual (confirmation announced)
- [ ] Mark ritual as done (success announced)
- [ ] Test with screen curtain (triple-tap with 3 fingers)

### Keyboard Testing (macOS)

- [ ] Enable Full Keyboard Access: System Settings → Keyboard → Keyboard Navigation
- [ ] Tab through all elements
- [ ] Activate buttons with Enter/Space
- [ ] Close dialogs with Escape
- [ ] Test focus indicators visible

### Screen Reader Testing (Web)

- [ ] Test with Chrome + ChromeVox
- [ ] Test with Firefox + NVDA (Windows)
- [ ] Verify ARIA labels present
- [ ] Check reading order logical

### Visual Testing

- [ ] Test with largest text size
- [ ] Test with 200% browser zoom
- [ ] Enable high contrast mode
- [ ] Use color blindness simulator

### Motor Testing

- [ ] Test with keyboard only (no mouse)
- [ ] Verify touch targets sufficiently large
- [ ] Test with slow pointer speed

---

## Known Limitations

### MVP Version

- **Notification sounds:** Cannot customize (system default)
- **Voice input:** Not yet supported for creating rituals
- **Braille display:** Works via VoiceOver but not directly tested

### Future Improvements

- Custom notification sounds (v1.1)
- Voice-to-text for descriptions (v1.2)
- Simplified mode for cognitive accessibility (v1.3)
- More granular screen reader announcements (v1.1)

---

## Reporting Accessibility Issues

If you encounter any accessibility barriers:

1. Email: accessibility@rituals.app
2. Include:
   - Device/browser
   - Assistive technology used
   - What you were trying to do
   - What happened vs. what you expected

We aim to respond within 48 hours and fix issues in the next release.

---

## Accessibility Statement

Rituals is committed to ensuring digital accessibility for people with disabilities. We continually improve the user experience for everyone and apply relevant accessibility standards.

**Conformance Status:**
- WCAG 2.1 Level AA: Partial conformance
- Target: Full conformance by version 1.2

**Date:** November 20, 2025
**Last Reviewed:** November 20, 2025

---

## Resources

- [Apple Accessibility](https://www.apple.com/accessibility/)
- [Web Content Accessibility Guidelines (WCAG)](https://www.w3.org/WAI/WCAG21/quickref/)
- [Flutter Accessibility](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)

---

*Version 1.0 — Updated November 20, 2025*


