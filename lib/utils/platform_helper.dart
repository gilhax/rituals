import 'platform_io.dart' if (dart.library.html) 'platform_stub.dart';

/// Cross-platform helpers for determining the current platform without
/// importing `dart:io` in web builds.
bool get isIOS => platformIsIOS;
bool get isMacOS => platformIsMacOS;
