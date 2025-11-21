import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/ritual.dart';
import 'notification_service_interface.dart';

/// Service for managing local notifications (Native: iOS/Android/macOS)
class NotificationService implements INotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  Function(String ritualId)? _notificationTapHandler;

  NotificationService(this._plugin);

  /// Initialize notification permissions and channels
  @override
  Future<void> initialize() async {
    if (kIsWeb) {
      // Web notifications not supported in MVP
      return;
    }

    // Android initialization
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS/macOS initialization
    final darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        if (payload != null && _notificationTapHandler != null) {
          _notificationTapHandler!(payload);
        }
      },
    );

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null && _notificationTapHandler != null) {
          _notificationTapHandler!(details.payload!);
        }
      },
    );

    // Request permissions for iOS/macOS
    if (Platform.isIOS || Platform.isMacOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      await _plugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  /// Schedule daily notification for ritual
  @override
  Future<bool> scheduleNotification(Ritual ritual) async {
    if (kIsWeb) {
      debugPrint('⚠️ Notifications not supported on Web');
      return false;
    }

    try {
      final scheduledTime = _nextInstanceOfTime(ritual.time.hour, ritual.time.minute);
      final notificationId = ritual.id.hashCode;
      
      debugPrint('📅 Scheduling notification for "${ritual.title}" at ${ritual.time.hour}:${ritual.time.minute}');
      
      await _plugin.zonedSchedule(
        notificationId,
        ritual.title,
        'Time for your ritual',
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'rituals_channel',
            'Daily Rituals',
            channelDescription: 'Notifications for scheduled rituals',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          macOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: ritual.id,
      );
      
      debugPrint('✅ Notification scheduled successfully');
      return true;
    } catch (e) {
      debugPrint('❌ Failed to schedule notification: $e');
      return false;
    }
  }
  
  /// Show immediate test notification
  Future<void> showTestNotification() async {
    if (kIsWeb) {
      debugPrint('⚠️ Test notifications not supported on Web');
      return;
    }

    try {
      debugPrint('🧪 Showing test notification...');
      
      await _plugin.show(
        999999, // Test notification ID
        'Test Notification',
        'This is a test notification from Rituals',
        const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          macOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
      
      debugPrint('✅ Test notification sent');
    } catch (e) {
      debugPrint('❌ Test notification failed: $e');
    }
  }

  /// Cancel notification for ritual
  @override
  Future<bool> cancelNotification(String ritualId) async {
    if (kIsWeb) return false;
    
    try {
      await _plugin.cancel(ritualId.hashCode);
      debugPrint('🚫 Cancelled notification for ritual: $ritualId');
      return true;
    } catch (e) {
      debugPrint('Failed to cancel notification: $e');
      return false;
    }
  }

  /// Cancel all notifications
  @override
  Future<void> cancelAllNotifications() async {
    if (kIsWeb) return;
    
    try {
      await _plugin.cancelAll();
      debugPrint('🚫 Cancelled all notifications');
    } catch (e) {
      debugPrint('Failed to cancel all notifications: $e');
    }
  }

  /// Schedule an immediate test notification (for debugging)
  @override
  Future<void> scheduleImmediateNotification(String title, String description) async {
    if (kIsWeb) return;
    
    try {
      await _plugin.show(
        999999, // Test ID
        title,
        description,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'rituals_channel',
            'Daily Rituals',
            channelDescription: 'Notifications for scheduled rituals',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          macOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
      
      debugPrint('✅ Immediate test notification shown');
    } catch (e) {
      debugPrint('❌ Test notification failed: $e');
    }
  }

  /// Set handler for notification taps
  @override
  void setNotificationTapHandler(Function(String ritualId) handler) {
    _notificationTapHandler = handler;
  }

  /// Calculate next occurrence of specified time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    // Get current time in device timezone
    final nowDevice = DateTime.now().toLocal();
    
    // Convert to TZDateTime
    final now = tz.TZDateTime.from(nowDevice, tz.local);
    
    // Create target time for today in local timezone
    var scheduledDate = tz.TZDateTime(
      tz.local,
      nowDevice.year,
      nowDevice.month, 
      nowDevice.day,
      hour,
      minute,
    );
    
    // If time has passed, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    return scheduledDate;
  }
}

