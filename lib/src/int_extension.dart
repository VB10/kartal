import 'dart:math';

extension IntegerExtension on int {
  int get randomColorValue => Random().nextInt(this);
}
