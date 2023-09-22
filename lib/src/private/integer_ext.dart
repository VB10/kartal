part of '../int_extension.dart';

class IntegerExt {
  IntegerExt(int value) : _value = value;

  final int _value;
  int get randomColorValue => Random(_value).nextInt(256);

  /// Displays minute:time in appropriate format.
  ///
  /// For example: 1:1 displays as 01:01.
  String get toTimerFormat => _value.toString().padLeft(2, '0');
}
