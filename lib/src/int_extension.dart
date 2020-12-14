import 'dart:math';

extension IntagerExtension on int {
  int get randomValue => Random().nextInt(17);
}
