part of '../int_extension.dart';

class IntegerExt {
  IntegerExt(int value) : _value = value;

  final int _value;
  int get randomColorValue => Random(_value).nextInt(256);
}
