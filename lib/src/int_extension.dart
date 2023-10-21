import 'dart:math';

part './private/integer_ext.dart';

extension IntegerExtension on int {
  IntegerExt get ext => IntegerExt(this);
}
