import 'package:timezone/timezone.dart' as tz;

/// Helper class for timezone detection and configuration
class TimezoneHelper {
  /// Get timezone name from UTC offset
  ///
  /// Maps common UTC offsets to their respective timezone locations.
  /// Falls back to 'UTC' if offset is not recognized.
  static String getTimezoneNameFromOffset(Duration offset) {
    final offsetHours = offset.inHours;

    // Map common UTC offsets to timezone locations
    switch (offsetHours) {
      case -8:
        return 'America/Los_Angeles'; // PST/PDT
      case -7:
        return 'America/Denver'; // MST/MDT
      case -6:
        return 'America/Chicago'; // CST/CDT
      case -5:
        return 'America/New_York'; // EST/EDT
      case 0:
        return 'Europe/London'; // GMT/BST
      case 1:
        return 'Europe/Paris'; // CET/CEST
      case 2:
        return 'Europe/Athens'; // EET/EEST
      case 3:
        return 'Europe/Moscow'; // MSK
      case 8:
        return 'Asia/Shanghai'; // CST
      case 9:
        return 'Asia/Tokyo'; // JST
      case 10:
        return 'Australia/Sydney'; // AEST/AEDT
      default:
        return 'UTC'; // Fallback
    }
  }

  /// Initialize and set local timezone from system offset
  ///
  /// Returns the timezone name that was set, or null if failed.
  static String? initializeLocalTimezone() {
    final now = DateTime.now();
    final localOffset = now.timeZoneOffset;
    final timezoneName = getTimezoneNameFromOffset(localOffset);

    try {
      final location = tz.getLocation(timezoneName);
      tz.setLocalLocation(location);
      return timezoneName;
    } catch (e) {
      // Fallback to UTC on error
      tz.setLocalLocation(tz.UTC);
      return null;
    }
  }
}
