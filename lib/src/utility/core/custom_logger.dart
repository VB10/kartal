import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

mixin CustomLogger {
  static void error<T>(Object object) {
    if (!kDebugMode) return;
    Logger().e('$T $object');
  }
}
