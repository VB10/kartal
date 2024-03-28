import 'package:flutter/foundation.dart';
import 'package:logger/web.dart'
    if (dart.library.io) 'package:logger/logger.dart';

@immutable

/// Provides a custom logger for debugging purposes.
final class CustomLogger {
  const CustomLogger._();

  /// Logs the given [object] with the [T] type.
  /// If the [isShowDebugMode] is set to `true`, the log will be shown only in debug mode.
  static void showError<T>(Object object, {bool isShowDebugMode = true}) {
    if (!kDebugMode && isShowDebugMode) return;

    Logger().e('$T $object');
  }
}
