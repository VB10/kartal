import 'dart:math';

import 'package:flutter/material.dart';

/// Provides convenient access to commonly used properties from [Color].
extension ColorExtension on Color {
  /// Provides convenient access to commonly used properties from [Color].
  _ColorExtension get ext => _ColorExtension(this);
}

/// Receiver-independent [Color] helpers.
final class KartalColor {
  const KartalColor._();

  /// Returns a random [MaterialColor] from [Colors.primaries].
  ///
  /// Pass a [seed] to make the choice deterministic, which is what you want
  /// in tests and in golden files.
  static MaterialColor random({int? seed}) =>
      Colors.primaries[Random(seed).nextInt(Colors.primaries.length)];

  /// Parses a hex colour string into a [Color], or returns `null` when the
  /// input is not a valid hex colour.
  ///
  /// Accepts an optional leading `#` and either 6 (RGB) or 8 (ARGB) digits.
  /// A 6 digit value is treated as fully opaque.
  static Color? tryParse(String? value) {
    if (value == null) return null;

    final normalized = value.replaceFirst('#', '').trim();
    if (normalized.length != 6 && normalized.length != 8) return null;

    final withAlpha = normalized.length == 6 ? 'ff$normalized' : normalized;
    final parsed = int.tryParse(withAlpha, radix: 16);

    return parsed == null ? null : Color(parsed);
  }
}

final class _ColorExtension {
  _ColorExtension(Color color) : _color = color;

  final Color _color;

  /// Returns a random [MaterialColor] from [Colors.primaries].
  ///
  /// The receiver is ignored. Use [KartalColor.random] when you need a
  /// deterministic, seeded result.
  MaterialColor get randomColor => KartalColor.random();

  /// Returns a copy of this colour with the given [opacity] in `[0, 1]`.
  ///
  /// Unlike the deprecated `Color.withOpacity`, this is implemented on top of
  /// `Color.withValues` and so is safe to keep using.
  Color withOpacity(double opacity) => _color.withValues(alpha: opacity);

  /// Returns the hex representation of this colour, prefixed with `#`.
  ///
  /// Alpha is included only when [includeAlpha] is `true`, in which case the
  /// result is in `#AARRGGBB` order.
  String toHex({bool includeAlpha = false, bool uppercase = false}) {
    String channel(double value) =>
        (value * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');

    final hex = <String>[
      if (includeAlpha) channel(_color.a),
      channel(_color.r),
      channel(_color.g),
      channel(_color.b),
    ].join();

    return '#${uppercase ? hex.toUpperCase() : hex}';
  }

  /// The relative luminance of this colour per the WCAG 2.x definition.
  ///
  /// Ranges from 0 (black) to 1 (white).
  double get luminance => _color.computeLuminance();

  /// Whether this colour reads as dark.
  ///
  /// Uses the WCAG relative luminance rather than a naive RGB average, so
  /// perceptually bright hues such as yellow are correctly reported as light.
  bool get isDark => luminance < 0.5;

  /// Whether this colour reads as light. The inverse of [isDark].
  bool get isLight => !isDark;

  /// A foreground colour that contrasts with this colour.
  ///
  /// Returns [light] over dark backgrounds and [dark] over light ones,
  /// defaulting to white and black respectively.
  Color contrastText({Color light = Colors.white, Color dark = Colors.black}) =>
      isDark ? light : dark;

  /// Returns a lighter shade of this colour.
  ///
  /// [amount] is clamped to `[0, 1]`, where 1 returns white.
  Color lighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(_color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Returns a darker shade of this colour.
  ///
  /// [amount] is clamped to `[0, 1]`, where 1 returns black.
  Color darken([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(_color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Mixes this colour with [other].
  ///
  /// [t] is the weight of [other]: 0 returns this colour unchanged and 1
  /// returns [other].
  Color blend(Color other, [double t = 0.5]) =>
      Color.lerp(_color, other, t.clamp(0.0, 1.0)) ?? _color;

  /// Builds a full [MaterialColor] swatch from this colour as the 500 shade.
  ///
  /// Useful for feeding a single brand colour into `ThemeData.primarySwatch`.
  MaterialColor toMaterialColor() {
    const strengths = <int, double>{
      50: 0.5,
      100: 0.4,
      200: 0.3,
      300: 0.2,
      400: 0.1,
      500: 0,
      600: 0.1,
      700: 0.2,
      800: 0.3,
      900: 0.4,
    };

    final swatch = strengths.map(
      (shade, amount) => MapEntry(
        shade,
        shade < 500 ? lighten(amount) : darken(amount),
      ),
    );

    return MaterialColor(_color.toARGB32(), swatch);
  }
}
