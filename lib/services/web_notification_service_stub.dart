import 'dart:async';
import '../models/ritual.dart';
import 'notification_service_interface.dart';

/// Stub for non-web platforms (should never be used)
class WebNotificationService implements INotificationService {
  @override
  Future<void> initialize() async {
    throw UnsupportedError('WebNotificationService is only for web');
  }

  @override
  Future<bool> scheduleNotification(Ritual ritual) async {
    throw UnsupportedError('WebNotificationService is only for web');
  }

  @override
  Future<bool> cancelNotification(String ritualId) async {
    throw UnsupportedError('WebNotificationService is only for web');
  }

  @override
  Future<void> cancelAllNotifications() async {
    throw UnsupportedError('WebNotificationService is only for web');
  }

  @override
  void setNotificationTapHandler(Function(String ritualId) handler) {
    throw UnsupportedError('WebNotificationService is only for web');
  }

  @override
  Future<void> scheduleImmediateNotification(
      String title, String description) async {
    throw UnsupportedError('WebNotificationService is only for web');
  }
}
