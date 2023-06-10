part of '../int_extension.dart';

class IntegerExt {
  IntegerExt(this.value);

  final int value;
  int get randomColorValue => Random(value).nextInt(256);
}
