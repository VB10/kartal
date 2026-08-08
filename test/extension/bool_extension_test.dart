import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('BoolExtension', () {
    test('isSuccess is true only for true', () {
      const bool? nullValue = null;

      expect(true.ext.isSuccess, isTrue);
      expect(false.ext.isSuccess, isFalse);
      expect(nullValue.ext.isSuccess, isFalse);
    });

    test('isFail treats null as a failure', () {
      const bool? nullValue = null;

      expect(false.ext.isFail, isTrue);
      expect(nullValue.ext.isFail, isTrue);
      expect(true.ext.isFail, isFalse);
    });

    test('isSuccess and isFail are always opposites', () {
      const values = <bool?>[true, false, null];

      for (final value in values) {
        expect(
          value.ext.isSuccess,
          isNot(value.ext.isFail),
          reason: 'inconsistent for $value',
        );
      }
    });
  });
}
