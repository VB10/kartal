import 'dart:math';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  _ColorExtension get ext => _ColorExtension(this);
}

final class _ColorExtension {
  _ColorExtension(Color color) : _color = color;

  final Color _color;

  /// Returns a random [MaterialColor] from the predefined list of primary colors.
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  /// Returns with opacity
  Color withOpacity(double opacity) => _color.withValues(alpha: opacity);
}
