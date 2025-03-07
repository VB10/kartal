import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('Test makeSafe property', () {
    final Iterable<int?> iterableList = [1, 2, 3, null, 5];
    final safeList = iterableList.exts.makeSafe();
    expect(safeList, equals([1, 2, 3, 5]));
  });

  test('Test makeSafeCustom property', () {
    final Iterable<int?> iterableList = [-2, -1, 1, 2, 3, null, 5];
    final safeList = iterableList.exts.makeSafeCustom(
      (item) => item != null && item > 0,
    );
    expect(safeList, equals([1, 2, 3, 5]));
  });
}
