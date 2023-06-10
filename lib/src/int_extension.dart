import 'dart:math';

part './private/integer_ext.dart';

extension IntegerExtension on int {
  @Deprecated('Use ext instead since: 1.0.0')
  int get randomColorValue => Random().nextInt(this);

  IntegerExt get ext => IntegerExt(this);
}
