import 'dart:math';

extension IntagerExtension on int {
  int get randomColorValue => Random().nextInt(17);
}
