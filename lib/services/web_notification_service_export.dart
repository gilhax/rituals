// Conditional export to avoid dart:html on non-web platforms
export 'web_notification_service_stub.dart'
    if (dart.library.html) 'web_notification_service.dart';
