import 'package:flutter/material.dart';
import 'package:kartal/src/sub_extension/context/index.dart';
import 'package:kartal/src/widget/sized_box/space_sized_height_box.dart';
import 'package:kartal/src/widget/sized_box/space_sized_width_box.dart';

class _ContextSizeExtension {
  _ContextSizeExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  /// Returns an empty [SpaceSizedWidthBox] widget with a low width size of 0.01 times the height.
  Widget get emptySizedWidthBoxLow => const SpaceSizedWidthBox(width: 0.01);

  /// Returns an empty [SpaceSizedWidthBox] widget with a low width size of 0.03 times the height.
  Widget get emptySizedWidthBoxLow3x => const SpaceSizedWidthBox(width: 0.03);

  /// Returns an empty [SpaceSizedWidthBox] widget with a normal width size of 0.05 times the height.
  Widget get emptySizedWidthBoxNormal => const SpaceSizedWidthBox(width: 0.05);

  /// Returns an empty [SpaceSizedWidthBox] widget with a high width size of 0.1 times the height.
  Widget get emptySizedWidthBoxHigh => const SpaceSizedWidthBox(width: 0.1);

  /// Returns an empty [SpaceSizedHeightBox] widget with a low height size of 0.01 times the height.
  Widget get emptySizedHeightBoxLow => const SpaceSizedHeightBox(height: 0.01);

  /// Returns an empty [SpaceSizedHeightBox] widget with a low height size of 0.03 times the height.
  Widget get emptySizedHeightBoxLow3x =>
      const SpaceSizedHeightBox(height: 0.03);

  /// Returns an empty [SpaceSizedHeightBox] widget with a normal height size of 0.05 times the height.
  Widget get emptySizedHeightBoxNormal =>
      const SpaceSizedHeightBox(height: 0.05);

  /// Returns an empty [SpaceSizedHeightBox] widget with a high height size of 0.1 times the height.
  Widget get emptySizedHeightBoxHigh => const SpaceSizedHeightBox(height: 0.1);

  /// Returns the height of the current widget's [MediaQuery].
  double get height => _context.general.mediaSize.height;

  /// Returns the width of the current widget's [MediaQuery].
  double get width => _context.general.mediaSize.width;

  /// Returns a value representing a low dimension, calculated as 0.01 times the current widget's height.
  double get lowValue => height * 0.01;

  /// Returns a value representing a normal dimension, calculated as 0.02 times the current widget's height.
  double get normalValue => height * 0.02;

  /// Returns a value representing a medium dimension, calculated as 0.04 times the current widget's height.
  double get mediumValue => height * 0.04;

  /// Returns a value representing a high dimension, calculated as 0.1 times the current widget's height.
  double get highValue => height * 0.1;

  /// Calculates and returns a dynamic width value based on the provided [val] and the current widget's width.
  double dynamicWidth(double val) => width * val;

  /// Calculates and returns a dynamic height value based on the provided [val] and the current widget's height.
  double dynamicHeight(double val) => height * val;
}

// Deprecated extension methods for [BuildContext] to create [Radius] objects.
extension SizedBoxExtension on BuildContext {
  _ContextSizeExtension get sized => _ContextSizeExtension(this);

  @Deprecated('Use sized.emptySizedWidthBoxLow instead')
  Widget get emptySizedWidthBoxLow => const SpaceSizedWidthBox(width: 0.01);

  @Deprecated('Use sized.emptySizedWidthBoxLow3x instead')
  Widget get emptySizedWidthBoxLow3x => const SpaceSizedWidthBox(width: 0.03);
  @Deprecated('Use sized.emptySizedWidthBoxNormal instead')
  Widget get emptySizedWidthBoxNormal => const SpaceSizedWidthBox(width: 0.05);
  @Deprecated('Use sized.emptySizedWidthBoxHigh instead')
  Widget get emptySizedWidthBoxHigh => const SpaceSizedWidthBox(width: 0.1);
  @Deprecated('Use sized.emptySizedHeightBoxLow instead')
  Widget get emptySizedHeightBoxLow => const SpaceSizedHeightBox(height: 0.01);
  @Deprecated('Use sized.emptySizedHeightBoxLow3x instead')
  Widget get emptySizedHeightBoxLow3x =>
      const SpaceSizedHeightBox(height: 0.03);
  @Deprecated('Use sized.emptySizedHeightBoxNormal instead')
  Widget get emptySizedHeightBoxNormal =>
      const SpaceSizedHeightBox(height: 0.05);
  @Deprecated('Use sized.emptySizedHeightBoxHigh instead')
  Widget get emptySizedHeightBoxHigh => const SpaceSizedHeightBox(height: 0.1);

  @Deprecated('Use sized.height instead')
  double get height => mediaQuery.size.height;
  @Deprecated('Use sized.width instead')
  double get width => mediaQuery.size.width;

  @Deprecated(
    'Use size.lowValue instead. ',
  )
  double get lowValue => height * 0.01;
  @Deprecated('Use sized.normalValue instead')
  double get normalValue => height * 0.02;
  @Deprecated('Use sized.mediumValue instead')
  double get mediumValue => height * 0.04;
  @Deprecated('Use sized.highValue instead')
  double get highValue => height * 0.1;

  @Deprecated('Use sized.dynamicWidth instead')
  double dynamicWidth(double val) => width * val;
  @Deprecated('Use sized.dynamicHeight instead')
  double dynamicHeight(double val) => height * val;
}
