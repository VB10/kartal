import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('BoolExtension Tests', () {
    test('isSuccess returns true for true value', () {
      const value = true;
      expect(value.ext.isSuccess, isTrue);
    });

    test('isSuccess returns false for false value', () {
      const value = false;
      expect(value.ext.isSuccess, isFalse);
    });

    test('isSuccess returns false for null value', () {
      const bool? value = null;
      expect(value.ext.isSuccess, isFalse);
    });

    test('isFail returns false for true value', () {
      const value = true;
      expect(value.ext.isFail, isFalse);
    });

    test('isFail returns true for false value', () {
      const value = false;
      expect(value.ext.isFail, isTrue);
    });

    test('isFail returns true for null value', () {
      const bool? value = null;
      expect(value.ext.isFail, isTrue);
    });
  });
}
