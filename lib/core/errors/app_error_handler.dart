import 'dart:ui';

import 'package:flutter/material.dart';

/// this is the AppErrorHandler class for main error handling
class AppErrorHandler {
  /// this is the initialize method for error handling
  /// called from the main.dart
  static void initialize() {
    FlutterError.onError = _handleFlutterError;
    PlatformDispatcher.instance.onError = _handlePlatformError;
  }

  /// All errors caught by Flutter are routed to here
  /// Placing FlutterError.onError outside of runZonedGuarded
  /// is the generally recommended approach.
  /// This ensures that the global handler catches UI-related errors thrown by
  /// the Flutter framework itself, even if those errors occur outside
  /// of the zone created by runZonedGuarded.
  static void _handleFlutterError(FlutterErrorDetails details) {
    debugPrint('Caught UI error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  }

  /// If invokeMethod throws an error, it won't be forwarded
  /// to FlutterError.onError.
  /// Instead, it's forwarded to the PlatformDispatcher.
  static bool _handlePlatformError(Object error, StackTrace stack) {
    debugPrint('Caught error: $error');
    debugPrint('Stack trace: $stack');
    return true;
  }
}
