// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:kartal/src/sub_extension/context/index.dart';

/// Extension methods for [BuildContext] to create [BorderRadius] objects.
class _ContextBorderExtension {
  _ContextBorderExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get width => _context.sized.width;
  double get lowValue => _context.sized.lowValue;
  double get normalValue => _context.sized.normalValue;
  double get highValue => _context.sized.highValue;
  double get mediumValue => _context.sized.mediumValue;

  /// Returns a [Radius] object with a circular radius equal to [width] multiplied by 0.02.
  Radius get lowRadius => Radius.circular(width * 0.02);

  /// Returns a [Radius] object with a circular radius equal to [width] multiplied by 0.05.
  Radius get normalRadius => Radius.circular(width * 0.05);

  /// Returns a [Radius] object with a circular radius equal to [width] multiplied by 0.1.
  Radius get highRadius => Radius.circular(width * 0.1);

  /// Returns a [BorderRadius] object with all corners having a circular radius of [width] multiplied by 0.05.
  BorderRadius get normalBorderRadius =>
      BorderRadius.all(Radius.circular(width * 0.05));

  /// Returns a [BorderRadius] object with all corners having a circular radius of [width] multiplied by 0.02.
  BorderRadius get lowBorderRadius =>
      BorderRadius.all(Radius.circular(width * 0.02));

  /// Returns a [BorderRadius] object with all corners having a circular radius of [width] multiplied by 0.1.
  BorderRadius get highBorderRadius =>
      BorderRadius.all(Radius.circular(width * 0.1));

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [lowValue].
  RoundedRectangleBorder get roundedRectangleBorderLow =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)),
      );

  /// Returns a [RoundedRectangleBorder] object with all corners having a circular radius of [normalValue].
  RoundedRectangleBorder get roundedRectangleAllBorderNormal =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(normalValue),
      );

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [normalValue].
  RoundedRectangleBorder get roundedRectangleBorderNormal =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(normalValue)),
      );

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [mediumValue].
  RoundedRectangleBorder get roundedRectangleBorderMedium =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(mediumValue)),
      );

  /// Returns a [RoundedRectangleBorder] object with the top corners having a circular radius of [highValue].
  RoundedRectangleBorder get roundedRectangleBorderHigh =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(highValue)),
      );
}

extension BorderExtension on BuildContext {
  _ContextBorderExtension get border => _ContextBorderExtension(this);

  @Deprecated('Use border.lowRadius instead')
  Radius get lowRadius => Radius.circular(width * 0.02);
  @Deprecated('Use border.normalRadius instead')
  Radius get normalRadius => Radius.circular(width * 0.05);
  @Deprecated('Use border.highRadius instead')
  Radius get highRadius => Radius.circular(width * 0.1);

  @Deprecated('Use border.normalBorderRadius instead')
  BorderRadius get normalBorderRadius =>
      BorderRadius.all(Radius.circular(width * 0.05));
  @Deprecated('Use border.lowBorderRadius instead')
  BorderRadius get lowBorderRadius =>
      BorderRadius.all(Radius.circular(width * 0.02));
  @Deprecated('Use border.highBorderRadius instead')
  BorderRadius get highBorderRadius =>
      BorderRadius.all(Radius.circular(width * 0.1));
  @Deprecated('Use border.roundedRectangleBorderLow instead')
  RoundedRectangleBorder get roundedRectangleBorderLow =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)),
      );
  @Deprecated('Use border.roundedRectangleAllBorderNormal instead')
  RoundedRectangleBorder get roundedRectangleAllBorderNormal =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(normalValue),
      );
  @Deprecated('Use border.roundedRectangleBorderNormal instead')
  RoundedRectangleBorder get roundedRectangleBorderNormal =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(normalValue)),
      );

  @Deprecated('Use border.roundedRectangleBorderMedium instead')
  RoundedRectangleBorder get roundedRectangleBorderMedium =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(mediumValue)),
      );

  @Deprecated('Use border.roundedRectangleBorderHigh instead')
  RoundedRectangleBorder get roundedRectangleBorderHigh =>
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(highValue)),
      );
}
