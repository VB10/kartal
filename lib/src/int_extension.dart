import 'dart:math';
import 'dart:ui';

import 'package:kartal/src/private/mixin/num/num_core_mixin.dart';
import 'package:kartal/src/utility/http_result.dart';

/// Extension methods for [int] to provide additional functionalities.
extension IntegerExtension on int {
  /// Provides convenient access to additional functionalities for [int].
  _IntegerExt get ext => _IntegerExt(this);
}

final class _IntegerExt with NumCoreMixin {
  _IntegerExt(int value) : _value = value;

  final int _value;

  @override
  num get value => _value;

  /// Returns a random color value between 0 and 255.
  int get randomColorValue => Random(_value).nextInt(256);

  /// Returns a [HttpResult] based on the status code.
  HttpResult get httpStatus => HttpResult.fromStatusCode(_value);

  /// Returns a [Color] based on the status code.
  Color get httpStatusColor => httpStatus.color;

  /// This number with its English ordinal suffix.
  ///
  /// ```dart
  /// 1.ext.ordinal;    // '1st'
  /// 2.ext.ordinal;    // '2nd'
  /// 3.ext.ordinal;    // '3rd'
  /// 11.ext.ordinal;   // '11th'
  /// 101.ext.ordinal;  // '101st'
  /// ```
  String get ordinal {
    final absolute = _value.abs();

    // 11, 12 and 13 take 'th' despite ending in 1, 2 and 3.
    if (absolute % 100 >= 11 && absolute % 100 <= 13) return '${_value}th';

    return switch (absolute % 10) {
      1 => '${_value}st',
      2 => '${_value}nd',
      3 => '${_value}rd',
      _ => '${_value}th',
    };
  }

  /// This number of microseconds as a [Duration].
  Duration get microseconds => Duration(microseconds: _value);

  /// This number of milliseconds as a [Duration].
  Duration get ms => Duration(milliseconds: _value);

  /// This number of milliseconds as a [Duration].
  Duration get milliseconds => ms;

  /// This number of seconds as a [Duration].
  Duration get seconds => Duration(seconds: _value);

  /// This number of minutes as a [Duration].
  Duration get minutes => Duration(minutes: _value);

  /// This number of hours as a [Duration].
  Duration get hours => Duration(hours: _value);

  /// This number of days as a [Duration].
  Duration get days => Duration(days: _value);
}
