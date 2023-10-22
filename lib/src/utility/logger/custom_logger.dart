import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

@immutable
final class CustomLogger {
  const CustomLogger._();

  static void showError<T>(Object object) {
    if (!kDebugMode) return;
    Logger().e('$T $object');
  }
}
