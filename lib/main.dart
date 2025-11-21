import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'providers/ritual_provider.dart';
import 'repositories/ritual_repository.dart';
import 'screens/ritual_detail_screen.dart';
import 'screens/ritual_list_screen.dart';
import 'services/notification_service.dart';
import 'services/notification_service_interface.dart';
import 'services/web_notification_service_export.dart';
import 'theme/app_theme.dart';
import 'utils/timezone_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize timezone database
  tz.initializeTimeZones();
  
  // Configure local timezone for accurate notification scheduling
  TimezoneHelper.initializeLocalTimezone();
  
  // Initialize dependencies
  final prefs = await SharedPreferences.getInstance();
  
  // Create services
  final repository = RitualRepository(prefs);
  
  // Create platform-specific notification service
  final INotificationService notificationService;
  if (kIsWeb) {
    notificationService = WebNotificationService();
  } else {
    final notificationPlugin = FlutterLocalNotificationsPlugin();
    notificationService = NotificationService(notificationPlugin);
  }
  
  await notificationService.initialize();
  
  runApp(MyApp(
    repository: repository,
    notificationService: notificationService,
  ));
}

class MyApp extends StatefulWidget {
  final RitualRepository repository;
  final INotificationService notificationService;
  
  const MyApp({
    super.key,
    required this.repository,
    required this.notificationService,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // Handle notification taps to open ritual detail
    widget.notificationService.setNotificationTapHandler((ritualId) {
      navigatorKey.currentState?.pushNamed('/ritual/$ritualId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RitualProvider(widget.repository, widget.notificationService)..loadRituals(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Rituals',
        theme: AppTheme.lightTheme,
        home: const RitualListScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          // Handle /ritual/:id route from notification
          if (settings.name?.startsWith('/ritual/') == true) {
            final ritualId = settings.name!.split('/').last;
            return MaterialPageRoute(
              builder: (_) => RitualDetailScreen(ritualId: ritualId),
            );
          }
          return null;
        },
      ),
    );
  }
}

