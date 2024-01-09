// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:kartal/src/private/sub_extension/context/index.dart';

extension BorderExtension on BuildContext {
  _ContextBorderExtension get border => _ContextBorderExtension(this);
}

/// Extension methods for [BuildContext] to create [BorderRadius] objects.
final class _ContextBorderExtension {
  _ContextBorderExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get _width => _context.sized.width;
  double get _lowValue => _context.sized.lowValue;
  double get _normalValue => _context.sized.normalValue;
  double get _highValue => _context.sized.highValue;
  double get _mediumValue => _context.sized.mediumValue;

  /// Returns a [Radius] object with a circular radius equal to [_width] multiplied by 0.02.
  Radius get lowRadius => Radius.circular(_width * 0.02);

  /// Returns a [Radius] object with a circular radius equal to [_width] multiplied by 0.05.
  Radius get normalRadius => Radius.circular(_width * 0.05);

  /// Returns a [Radius] object with a circular radius equal to [_width] multiplied by 0.1.
  Radius get highRadius => Radius.circular(_width * 0.1);

  /// Returns a [BorderRadius] object with all corners having a circular radius of [_width] multiplied by 0.05.
  BorderRadius get normalBorderRadius =>
      BorderRadius.all(Radius.circular(_width * 0.05));

  /// Returns a [BorderRadius] object with all corners having a circular radius of [_width] multiplied by 0.02.
  BorderRadius get lowBorderRadius =>
      BorderRadius.all(Radius.circular(_width * 0.02));

  /// Returns a [BorderRadius] object with all corners having a circular radius of [_width] multiplied by 0.1.
  BorderRadius get highBorderRadius =>
      BorderRadius.all(Radius.circular(_width * 0.1));

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [_lowValue].
  RoundedRectangleBorder get roundedRectangleBorderLow =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_lowValue)),
      );

  /// Returns a [RoundedRectangleBorder] object with all corners having a circular radius of [_normalValue].
  RoundedRectangleBorder get roundedRectangleAllBorderNormal =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_normalValue),
      );

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [_normalValue].
  RoundedRectangleBorder get roundedRectangleBorderNormal =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_normalValue)),
      );

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [_mediumValue].
  RoundedRectangleBorder get roundedRectangleBorderMedium =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_mediumValue)),
      );

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [_highValue].
  RoundedRectangleBorder get roundedRectangleBorderHigh =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_highValue)),
      );
}
