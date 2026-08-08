import 'dart:math' as math;

/// Formatting and maths helpers shared by every numeric extension.
///
/// This is a mixin rather than plain members on a `num` extension because an
/// extension declared on `int` shadows one declared on `num` for `int`
/// receivers. Mixing it into both wrappers keeps `42.ext.compact()` and
/// `4.2.ext.compact()` resolving to the same implementation.
mixin NumCoreMixin {
  /// The number these helpers operate on.
  num get value;

  static const _compactUnits = <String>['', 'K', 'M', 'B', 'T'];
  static const _byteUnits = <String>['B', 'KB', 'MB', 'GB', 'TB', 'PB'];

  /// A short, human readable form of this number.
  ///
  /// ```dart
  /// 999.ext.compact();      // '999'
  /// 1500.ext.compact();     // '1.5K'
  /// 1234567.ext.compact();  // '1.2M'
  /// (-1500).ext.compact();  // '-1.5K'
  /// ```
  ///
  /// [decimals] controls the digits kept after the separator. A trailing
  /// `.0` is always dropped, so 2000 renders as `2K` rather than `2.0K`.
  String compact({int decimals = 1}) {
    final isNegative = value < 0;
    var remaining = value.abs().toDouble();
    var unit = 0;

    while (remaining >= 1000 && unit < _compactUnits.length - 1) {
      remaining /= 1000;
      unit++;
    }

    final formatted = unit == 0
        ? remaining.toStringAsFixed(0)
        : _trimTrailingZeros(remaining.toStringAsFixed(decimals));

    return '${isNegative ? '-' : ''}$formatted${_compactUnits[unit]}';
  }

  /// Treats this number as a byte count and renders it with a binary unit.
  ///
  /// ```dart
  /// 512.ext.readableFileSize;      // '512 B'
  /// 2048.ext.readableFileSize;     // '2 KB'
  /// 1536000.ext.readableFileSize;  // '1.5 MB'
  /// ```
  String get readableFileSize => readableFileSizeWith();

  /// Treats this number as a byte count and renders it with a binary unit.
  ///
  /// [decimals] controls the digits kept after the separator, and a trailing
  /// `.0` is dropped.
  String readableFileSizeWith({int decimals = 1}) {
    final isNegative = value < 0;
    var remaining = value.abs().toDouble();
    var unit = 0;

    while (remaining >= 1024 && unit < _byteUnits.length - 1) {
      remaining /= 1024;
      unit++;
    }

    final formatted = unit == 0
        ? remaining.toStringAsFixed(0)
        : _trimTrailingZeros(remaining.toStringAsFixed(decimals));

    return '${isNegative ? '-' : ''}$formatted ${_byteUnits[unit]}';
  }

  /// Renders this number as a currency amount with grouped thousands.
  ///
  /// ```dart
  /// 1234.5.ext.currency();              // '1,234.50'
  /// 1234.5.ext.currency(symbol: r'$');  // r'$1,234.50'
  /// 1234.5.ext.currency(
  ///   symbol: '₺',
  ///   symbolOnLeft: false,
  ///   thousandSeparator: '.',
  ///   decimalSeparator: ',',
  /// );                                  // '1.234,50 ₺'
  /// ```
  String currency({
    String symbol = '',
    int decimals = 2,
    String thousandSeparator = ',',
    String decimalSeparator = '.',
    bool symbolOnLeft = true,
  }) {
    final isNegative = value < 0;
    final fixed = value.abs().toStringAsFixed(decimals);
    final parts = fixed.split('.');

    final grouped = _groupThousands(parts.first, thousandSeparator);
    final number = parts.length > 1
        ? '$grouped$decimalSeparator${parts[1]}'
        : grouped;

    final signed = '${isNegative ? '-' : ''}$number';
    if (symbol.isEmpty) return signed;

    return symbolOnLeft ? '$symbol$signed' : '$signed $symbol';
  }

  /// Renders this number as a percentage.
  ///
  /// The receiver is treated as an already-scaled percentage value, so
  /// `85.ext.percent()` is `'85%'`. Use [fraction] when the receiver is a
  /// ratio in `[0, 1]`.
  String percent({int decimals = 0}) =>
      '${_trimTrailingZeros(value.toStringAsFixed(decimals))}%';

  /// Renders this number as a percentage, treating it as a `[0, 1]` ratio.
  ///
  /// ```dart
  /// 0.85.ext.fraction();  // '85%'
  /// ```
  String fraction({int decimals = 0}) =>
      '${_trimTrailingZeros((value * 100).toStringAsFixed(decimals))}%';

  /// Clamps this number into the inclusive range `[min, max]`.
  ///
  /// Unlike [num.clamp] this returns a [num] rather than a `Comparable`,
  /// which keeps it usable in arithmetic without a cast.
  num clampRange(num min, num max) => value.clamp(min, max);

  /// Converts this number from degrees to radians.
  double get toRadians => value * math.pi / 180;

  /// Converts this number from radians to degrees.
  double get toDegrees => value * 180 / math.pi;

  /// Whether this number is between [min] and [max].
  ///
  /// The bounds are inclusive unless [inclusive] is `false`.
  bool isBetween(num min, num max, {bool inclusive = true}) =>
      inclusive ? value >= min && value <= max : value > min && value < max;

  /// Drops trailing zeros after the separator, so that `2.50` renders as
  /// `2.5` and `2.00` as `2`.
  static String _trimTrailingZeros(String value) {
    if (!value.contains('.')) return value;

    return value
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  /// Inserts [separator] every three digits from the right.
  static String _groupThousands(String digits, String separator) {
    if (separator.isEmpty || digits.length <= 3) return digits;

    final buffer = StringBuffer();
    for (var index = 0; index < digits.length; index++) {
      final remaining = digits.length - index;
      buffer.write(digits[index]);
      if (remaining > 1 && remaining % 3 == 1) buffer.write(separator);
    }

    return buffer.toString();
  }
}
