import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('compact', () {
    test('leaves values under a thousand alone', () {
      expect(0.ext.compact(), '0');
      expect(42.ext.compact(), '42');
      expect(999.ext.compact(), '999');
    });

    test('scales through K, M, B and T', () {
      expect(1000.ext.compact(), '1K');
      expect(1500.ext.compact(), '1.5K');
      expect(1234567.ext.compact(), '1.2M');
      expect(1500000000.ext.compact(), '1.5B');
      expect(2500000000000.ext.compact(), '2.5T');
    });

    test('drops a trailing .0 rather than padding it', () {
      expect(2000.ext.compact(), '2K');
      expect(3000000.ext.compact(), '3M');
    });

    test('honours the decimals argument', () {
      expect(1234567.ext.compact(decimals: 2), '1.23M');
      expect(1234567.ext.compact(decimals: 0), '1M');
    });

    test('preserves the sign', () {
      expect((-1500).ext.compact(), '-1.5K');
      expect((-42).ext.compact(), '-42');
    });

    test('saturates at the largest unit', () {
      expect(5000000000000000.ext.compact(), '5000T');
    });
  });

  group('readableFileSize', () {
    test('uses binary steps', () {
      expect(0.ext.readableFileSize, '0 B');
      expect(512.ext.readableFileSize, '512 B');
      expect(1024.ext.readableFileSize, '1 KB');
      expect(2048.ext.readableFileSize, '2 KB');
      expect(1048576.ext.readableFileSize, '1 MB');
      expect(1073741824.ext.readableFileSize, '1 GB');
    });

    test('keeps one decimal for partial units', () {
      expect(1536.ext.readableFileSize, '1.5 KB');
    });

    test('honours the decimals argument', () {
      expect(1536.ext.readableFileSizeWith(decimals: 2), '1.5 KB');
      expect(1590.ext.readableFileSizeWith(decimals: 2), '1.55 KB');
    });

    test('preserves the sign', () {
      expect((-2048).ext.readableFileSize, '-2 KB');
    });
  });

  group('currency', () {
    test('groups thousands and fixes the decimals', () {
      expect(1234.5.ext.currency(), '1,234.50');
      expect(999.ext.currency(), '999.00');
      expect(1000000.ext.currency(), '1,000,000.00');
    });

    test('groups correctly at every boundary', () {
      expect(1.ext.currency(decimals: 0), '1');
      expect(12.ext.currency(decimals: 0), '12');
      expect(123.ext.currency(decimals: 0), '123');
      expect(1234.ext.currency(decimals: 0), '1,234');
      expect(12345.ext.currency(decimals: 0), '12,345');
      expect(123456.ext.currency(decimals: 0), '123,456');
      expect(1234567.ext.currency(decimals: 0), '1,234,567');
    });

    test('places the symbol on either side', () {
      expect(1234.5.ext.currency(symbol: r'$'), r'$1,234.50');
      expect(
        1234.5.ext.currency(symbol: '₺', symbolOnLeft: false),
        '1,234.50 ₺',
      );
    });

    test('supports Turkish separators', () {
      expect(
        1234567.89.ext.currency(
          symbol: '₺',
          symbolOnLeft: false,
          thousandSeparator: '.',
          decimalSeparator: ',',
        ),
        '1.234.567,89 ₺',
      );
    });

    test('preserves the sign ahead of the symbol', () {
      expect((-1234.5).ext.currency(), '-1,234.50');
      expect((-1234.5).ext.currency(symbol: r'$'), r'$-1,234.50');
    });

    test('supports zero decimals', () {
      expect(1234.ext.currency(decimals: 0), '1,234');
    });
  });

  group('percent and fraction', () {
    test('percent treats the receiver as an already scaled value', () {
      expect(85.ext.percent(), '85%');
      expect(12.345.ext.percent(decimals: 1), '12.3%');
      expect(100.ext.percent(), '100%');
    });

    test('fraction treats the receiver as a ratio', () {
      expect(0.85.ext.fraction(), '85%');
      expect(1.ext.fraction(), '100%');
      expect(0.125.ext.fraction(decimals: 1), '12.5%');
    });
  });

  group('maths helpers', () {
    test('clampRange bounds the value and stays a num', () {
      expect(5.ext.clampRange(0, 10), 5);
      expect((-5).ext.clampRange(0, 10), 0);
      expect(15.ext.clampRange(0, 10), 10);

      // Returns num, so it is directly usable in arithmetic.
      expect(15.ext.clampRange(0, 10) + 1, 11);
    });

    test('toRadians and toDegrees round trip', () {
      expect(180.ext.toRadians, closeTo(math.pi, 1e-10));
      expect(math.pi.ext.toDegrees, closeTo(180, 1e-10));
      expect(90.ext.toRadians.ext.toDegrees, closeTo(90, 1e-10));
    });

    test('isBetween respects inclusivity', () {
      expect(5.ext.isBetween(1, 10), isTrue);
      expect(1.ext.isBetween(1, 10), isTrue);
      expect(10.ext.isBetween(1, 10), isTrue);
      expect(1.ext.isBetween(1, 10, inclusive: false), isFalse);
      expect(10.ext.isBetween(1, 10, inclusive: false), isFalse);
      expect(11.ext.isBetween(1, 10), isFalse);
    });
  });

  group('IntegerExtension additions', () {
    test('ordinal handles the teens exception', () {
      expect(1.ext.ordinal, '1st');
      expect(2.ext.ordinal, '2nd');
      expect(3.ext.ordinal, '3rd');
      expect(4.ext.ordinal, '4th');
      expect(11.ext.ordinal, '11th');
      expect(12.ext.ordinal, '12th');
      expect(13.ext.ordinal, '13th');
      expect(21.ext.ordinal, '21st');
      expect(22.ext.ordinal, '22nd');
      expect(23.ext.ordinal, '23rd');
      expect(101.ext.ordinal, '101st');
      expect(111.ext.ordinal, '111th');
      expect(112.ext.ordinal, '112th');
      expect(0.ext.ordinal, '0th');
    });

    test('duration builders produce the matching Duration', () {
      expect(500.ext.microseconds, const Duration(microseconds: 500));
      expect(300.ext.ms, const Duration(milliseconds: 300));
      expect(300.ext.milliseconds, const Duration(milliseconds: 300));
      expect(30.ext.seconds, const Duration(seconds: 30));
      expect(5.ext.minutes, const Duration(minutes: 5));
      expect(2.ext.hours, const Duration(hours: 2));
      expect(7.ext.days, const Duration(days: 7));
    });
  });
}
