import 'dart:math';

part './private/integer_ext.dart';

extension IntegerExtension on int {
  @Deprecated('Use ext instead since: 1.0.0')
  int get randomColorValue => Random().nextInt(this);

  String get toTimerFormat => toString().padLeft(2, '0');

  IntegerExt get ext => IntegerExt(this);
}
