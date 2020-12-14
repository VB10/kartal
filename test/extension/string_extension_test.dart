import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('adds one to input values', () {
    var fifteenLiras = "15".tlMoney;

    expect(fifteenLiras.contains("TL"), true);
  });
}
