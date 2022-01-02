import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('adds one to input values', () {
    var fifteenLiras = '15';

    expect(fifteenLiras.isNotNullOrNoEmpty, true);
  });

  test('Remove special characters - çamur', () {
    var correctText = 'çamur'.withoutSpecialCharacters;
    expect(correctText, 'camur');
  });
}
