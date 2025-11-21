import '../models/ritual.dart';

/// Abstract interface for notification services
abstract class INotificationService {
  Future<void> initialize();
  Future<bool> scheduleNotification(Ritual ritual);
  Future<bool> cancelNotification(String ritualId);
  Future<void> cancelAllNotifications();
  void setNotificationTapHandler(Function(String ritualId) handler);
  Future<void> scheduleImmediateNotification(String title, String description);
}
