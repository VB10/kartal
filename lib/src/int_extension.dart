import 'dart:math';
import 'dart:ui';

import 'package:kartal/src/utility/http_result.dart';

/// Extension methods for [int] to provide additional functionalities.
extension IntegerExtension on int {
  /// Provides convenient access to additional functionalities for [int].
  _IntegerExt get ext => _IntegerExt(this);
}

final class _IntegerExt {
  _IntegerExt(int value) : _value = value;

  final int _value;

  /// Returns a random color value between 0 and 255.
  int get randomColorValue => Random(_value).nextInt(256);

  /// Returns a [HttpResult] based on the status code.
  HttpResult get httpStatus => HttpResult.fromStatusCode(_value);

  /// Returns a [Color] based on the status code.
  Color get httpStatusColor => httpStatus.color;
}
