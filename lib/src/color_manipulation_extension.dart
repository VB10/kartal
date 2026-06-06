import 'package:flutter/material.dart';

extension ColorManipulationExtension on Color {
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final darkened =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkened.toColor();
  }

  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(this);
    final lightened =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightened.toColor();
  }

  Color contrast() {
    final luminance = computeLuminance();
    return luminance > 0.5 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }

  String toHex({bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${toHexWithAlpha()}';
    }
    return '#${toHexWithoutAlpha()}';
  }

  String toHexWithAlpha() => '${_toHexPart(alpha)}'
      '${_toHexPart(red)}'
      '${_toHexPart(green)}'
      '${_toHexPart(blue)}';

  String toHexWithoutAlpha() => '${_toHexPart(red)}'
      '${_toHexPart(green)}'
      '${_toHexPart(blue)}';

  String _toHexPart(int value) =>
      value.toRadixString(16).padLeft(2, '0').toUpperCase();

  Color invert() => Color.fromARGB(
        alpha,
        255 - red,
        255 - green,
        255 - blue,
      );

  bool get isLight => computeLuminance() > 0.5;

  bool get isDark => !isLight;

  Color withSaturation(double saturation) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withSaturation(saturation.clamp(0.0, 1.0)).toColor();
  }

  Color withHue(double hue) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withHue(hue % 360).toColor();
  }

  Color mix(Color other, [double amount = 0.5]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    return Color.lerp(this, other, amount)!;
  }

  MaterialColor toMaterialColor() => MaterialColor(toARGB32(), {
        50: lighten(0.9),
        100: lighten(0.8),
        200: lighten(0.6),
        300: lighten(0.4),
        400: lighten(0.2),
        500: this,
        600: darken(),
        700: darken(0.2),
        800: darken(0.3),
        900: darken(0.4),
      });
}
