part of '../int_extension.dart';

final class IntegerExt {
  IntegerExt(int value) : _value = value;

  final int _value;

  /// Returns a random color value between 0 and 255.
  int get randomColorValue => Random(_value).nextInt(256);

  /// Returns a [HttpResult] based on the status code.
  HttpResult get httpStatus => HttpResult.fromStatusCode(_value);

  /// Returns a [Color] based on the status code.
  Color get httpStatusColor => httpStatus.color;
}
