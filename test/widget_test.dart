import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rituals/main.dart';
import 'package:rituals/repositories/ritual_repository.dart';
import 'package:rituals/services/notification_service.dart';

void main() {
  testWidgets('App initializes with Rituals title',
      (WidgetTester tester) async {
    // Setup
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repository = RitualRepository(prefs);
    final notificationPlugin = FlutterLocalNotificationsPlugin();
    final notificationService = NotificationService(notificationPlugin);

    // Build our app
    await tester.pumpWidget(MyApp(
      repository: repository,
      notificationService: notificationService,
    ));

    // Verify that the app bar title is 'Rituals'
    expect(find.text('Rituals'), findsOneWidget);
  });
}
