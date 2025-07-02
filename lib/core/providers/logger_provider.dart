import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loggerProvider = Provider((ref) => Logger());

class Logger {
  void log(String message) {
    // Integrar com Firebase Crashlytics, Sentry, etc.
    debugPrint('[LOG]: $message');
  }
}
