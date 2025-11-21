// Conditional export to avoid dart:html on non-web platforms
export 'web_notification_banner_stub.dart'
    if (dart.library.html) 'web_notification_banner_web.dart';
