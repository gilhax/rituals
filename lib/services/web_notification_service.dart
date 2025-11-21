import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import '../models/ritual.dart';
import 'notification_service_interface.dart';

/// Web-specific notification service using browser Notification API
class WebNotificationService implements INotificationService {
  final Map<String, Timer> _scheduledTimers = {};
  Function(String ritualId)? _notificationTapHandler;

  /// Initialize and request notification permission
  @override
  Future<void> initialize() async {
    if (!kIsWeb) return;

    debugPrint('🌐 Initializing web notifications...');

    // Check if Notifications API is supported
    if (html.Notification.supported) {
      debugPrint('✅ Notifications API is supported');

      // Request permission immediately on startup
      final permission = html.Notification.permission;
      debugPrint('📋 Current permission: $permission');

      if (permission == 'default') {
        debugPrint('🔔 Requesting notification permission...');
        try {
          final result = await html.Notification.requestPermission();
          debugPrint('📋 Permission result: $result');
          
          if (result == 'granted') {
            debugPrint('✅ Notification permission granted!');
            // Show a test notification
            _showTestNotification();
          } else {
            debugPrint('❌ Notification permission denied');
          }
        } catch (e) {
          debugPrint('⚠️ Error requesting permission: $e');
        }
      } else if (permission == 'granted') {
        debugPrint('✅ Notification permission already granted');
      } else {
        debugPrint('❌ Notification permission is denied');
      }
    } else {
      debugPrint('❌ Notifications API not supported in this browser');
    }
  }

  /// Show a test notification to confirm it works
  void _showTestNotification() {
    try {
      final notification = html.Notification(
        'Rituals App Ready! 🎉',
        body: 'Daily ritual notifications are now enabled.\nMinimize this tab to see notifications.',
        icon: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y="75" font-size="75">🔔</text></svg>',
      );
      
      notification.onClick.listen((_) {
        notification.close();
      });

      notification.onError.listen((e) {
        debugPrint('❌ Test notification error: $e');
      });

      // Auto-close after 8 seconds
      Timer(const Duration(seconds: 8), () {
        try {
          notification.close();
        } catch (e) {
          debugPrint('⚠️ Error closing notification: $e');
        }
      });
    } catch (e) {
      debugPrint('⚠️ Error showing test notification: $e');
    }
  }

  /// Schedule daily notification for ritual
  @override
  Future<bool> scheduleNotification(Ritual ritual) async {
    if (!kIsWeb) return false;

    if (html.Notification.permission != 'granted') {
      debugPrint('⚠️ Cannot schedule: permission not granted');
      return false;
    }

    try {
      // Cancel existing notification for this ritual
      await cancelNotification(ritual.id);

      // Calculate time until next occurrence
      final now = DateTime.now();
      var scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        ritual.time.hour,
        ritual.time.minute,
      );

      // If time has passed today, schedule for tomorrow
      if (scheduledTime.isBefore(now)) {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }

      final delay = scheduledTime.difference(now);
      debugPrint('📅 Scheduling web notification for "${ritual.title}" (fires in ${delay.inHours}h ${delay.inMinutes % 60}m)');

      // Schedule the notification
      final timer = Timer(delay, () {
        _showNotification(ritual);
        // Reschedule for tomorrow
        scheduleNotification(ritual);
      });

      _scheduledTimers[ritual.id] = timer;
      return true;
    } catch (e) {
      debugPrint('❌ Failed to schedule notification: $e');
      return false;
    }
  }

  /// Show notification immediately
  void _showNotification(Ritual ritual) {
    try {
      debugPrint('🔔 Showing notification for "${ritual.title}"');
      
      final notification = html.Notification(
        '⏰ ${ritual.title}',
        body: 'Time for your ritual! Tap to open.',
        icon: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y="75" font-size="75">⏰</text></svg>',
        tag: ritual.id, // Prevents duplicates
      );

      notification.onClick.listen((_) {
        _notificationTapHandler?.call(ritual.id);
        notification.close();
      });

      notification.onError.listen((e) {
        debugPrint('❌ Notification error: $e');
      });
    } catch (e) {
      debugPrint('❌ Failed to show notification: $e');
    }
  }

  /// Cancel notification for ritual
  @override
  Future<bool> cancelNotification(String ritualId) async {
    final timer = _scheduledTimers[ritualId];
    if (timer != null) {
      timer.cancel();
      _scheduledTimers.remove(ritualId);
      debugPrint('🚫 Cancelled web notification for ritual: $ritualId');
      return true;
    }
    return false;
  }

  /// Cancel all notifications
  @override
  Future<void> cancelAllNotifications() async {
    for (var timer in _scheduledTimers.values) {
      timer.cancel();
    }
    _scheduledTimers.clear();
    debugPrint('🚫 Cancelled all web notifications');
  }

  /// Set handler for notification taps
  @override
  void setNotificationTapHandler(Function(String ritualId) handler) {
    _notificationTapHandler = handler;
  }

  /// Schedule an immediate test notification
  @override
  Future<void> scheduleImmediateNotification(String title, String description) async {
    if (!kIsWeb) return;

    if (html.Notification.permission != 'granted') {
      debugPrint('⚠️ Cannot show notification: permission not granted');
      // Request permission
      await initialize();
      return;
    }

    try {
      final notification = html.Notification(
        '🧪 $title',
        body: description,
        icon: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y="75" font-size="75">🧪</text></svg>',
      );

      notification.onClick.listen((_) {
        notification.close();
      });

      notification.onError.listen((e) {
        debugPrint('❌ Test notification error: $e');
      });

      // Auto-close after 5 seconds
      Timer(const Duration(seconds: 5), () {
        try {
          notification.close();
        } catch (e) {
          debugPrint('⚠️ Error closing test notification: $e');
        }
      });
    } catch (e) {
      debugPrint('❌ Failed to show immediate notification: $e');
    }
  }
}

