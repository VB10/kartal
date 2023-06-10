import 'package:flutter/material.dart';
import 'package:kartal/src/sub_extension/context/index.dart';

class _ContextPaddingExtension {
  _ContextPaddingExtension(this.context);
  final BuildContext context;

  double get lowValue => context.sized.lowValue;
  double get normalValue => context.sized.normalValue;
  double get mediumValue => context.sized.mediumValue;
  double get highValue => context.sized.highValue;

  /// Returns an [EdgeInsets] object with equal padding on all sides, where the value is set to
  /// [lowValue].
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);

  /// Returns an [EdgeInsets] object with equal padding on all sides, where the value is set to
  /// [normalValue].
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);

  /// Returns an [EdgeInsets] object with equal padding on all sides, where the value is set to
  /// [mediumValue].
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);

  /// Returns an [EdgeInsets] object with equal padding on all sides, where the value is set to
  /// [highValue].
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  /// Returns an [EdgeInsets] object with horizontal padding only, where the horizontal padding
  /// value is set to [lowValue].
  EdgeInsets get horizontalPaddingLow =>
      EdgeInsets.symmetric(horizontal: lowValue);

  /// Returns an [EdgeInsets] object with horizontal padding only, where the horizontal padding
  /// value is set to [normalValue].
  EdgeInsets get horizontalPaddingNormal =>
      EdgeInsets.symmetric(horizontal: normalValue);

  /// Returns an [EdgeInsets] object with horizontal padding only, where the horizontal padding
  /// value is set to [mediumValue].
  EdgeInsets get horizontalPaddingMedium =>
      EdgeInsets.symmetric(horizontal: mediumValue);

  /// Returns an [EdgeInsets] object with horizontal padding only, where the horizontal padding
  /// value is set to [highValue].
  EdgeInsets get horizontalPaddingHigh =>
      EdgeInsets.symmetric(horizontal: highValue);

  /// Returns an [EdgeInsets] object with vertical padding only, where the vertical padding value
  /// is set to [lowValue].
  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);

  /// Returns an [EdgeInsets] object with vertical padding only, where the vertical padding value
  /// is set to [normalValue].
  EdgeInsets get verticalPaddingNormal =>
      EdgeInsets.symmetric(vertical: normalValue);

  /// Returns an [EdgeInsets] object with vertical padding only, where the vertical padding value
  /// is set to [mediumValue].
  EdgeInsets get verticalPaddingMedium =>
      EdgeInsets.symmetric(vertical: mediumValue);

  /// Returns an [EdgeInsets] object with vertical padding only, where the vertical padding value
  /// is set to [highValue].
  EdgeInsets get verticalPaddingHigh =>
      EdgeInsets.symmetric(vertical: highValue);

  /// Returns an [EdgeInsets] object with padding only on the left side, where the left padding
  /// value is set to [lowValue].
  EdgeInsets get onlyLeftPaddingLow => EdgeInsets.only(left: lowValue);

  /// Returns an [EdgeInsets] object with padding only on the left side, where the left padding
  /// value is set to [normalValue].
  EdgeInsets get onlyLeftPaddingNormal => EdgeInsets.only(left: normalValue);

  /// Returns an [EdgeInsets] object with padding only on the left side, where the left padding
  /// value is set to [mediumValue].
  EdgeInsets get onlyLeftPaddingMedium => EdgeInsets.only(left: mediumValue);

  /// Returns an [EdgeInsets] object with padding only on the left side, where the left padding
  /// value is set to [highValue].
  EdgeInsets get onlyLeftPaddingHigh => EdgeInsets.only(left: highValue);

  /// Returns an [EdgeInsets] object with padding only on the right side, where the right padding
  /// value is set to [lowValue].
  EdgeInsets get onlyRightPaddingLow => EdgeInsets.only(right: lowValue);

  /// Returns an [EdgeInsets] object with padding only on the right side, where the right padding
  /// value is set to [normalValue].
  EdgeInsets get onlyRightPaddingNormal => EdgeInsets.only(right: normalValue);

  /// Returns an [EdgeInsets] object with padding only on the right side, where the right padding
  /// value is set to [mediumValue].
  EdgeInsets get onlyRightPaddingMedium => EdgeInsets.only(right: mediumValue);

  /// Returns an [EdgeInsets] object with padding only on the right side, where the right padding
  /// value is set to [highValue].
  EdgeInsets get onlyRightPaddingHigh => EdgeInsets.only(right: highValue);

  /// Returns an [EdgeInsets] object with padding only on the bottom side, where the bottom padding
  /// value is set to [lowValue].
  EdgeInsets get onlyBottomPaddingLow => EdgeInsets.only(bottom: lowValue);

  /// Returns an [EdgeInsets] object with padding only on the bottom side, where the bottom padding
  /// value is set to [normalValue].
  EdgeInsets get onlyBottomPaddingNormal =>
      EdgeInsets.only(bottom: normalValue);

  /// Returns an [EdgeInsets] object with padding only on the bottom side, where the bottom padding
  /// value is set to [mediumValue].
  EdgeInsets get onlyBottomPaddingMedium =>
      EdgeInsets.only(bottom: mediumValue);

  /// Returns an [EdgeInsets] object with padding only on the bottom side, where the bottom padding
  /// value is set to [highValue].
  EdgeInsets get onlyBottomPaddingHigh => EdgeInsets.only(bottom: highValue);

  /// Returns an [EdgeInsets] object with padding only on the top side, where the top padding
  /// value is set to [lowValue].
  EdgeInsets get onlyTopPaddingLow => EdgeInsets.only(top: lowValue);

  /// Returns an [EdgeInsets] object with padding only on the top side, where the top padding
  /// value is set to [normalValue].
  EdgeInsets get onlyTopPaddingNormal => EdgeInsets.only(top: normalValue);

  /// Returns an [EdgeInsets] object with padding only on the top side, where the top padding
  /// value is set to [mediumValue].
  EdgeInsets get onlyTopPaddingMedium => EdgeInsets.only(top: mediumValue);

  /// Returns an [EdgeInsets] object with padding only on the top side, where the top padding
  /// value is set to [highValue].
  EdgeInsets get onlyTopPaddingHigh => EdgeInsets.only(top: highValue);
}

// -- Deprecated

/// Contains extension methods on the [BuildContext] class to simplify the creation of
/// [EdgeInsets] objects for padding in Flutter.
extension PaddingExtension on BuildContext {
  _ContextPaddingExtension get padding => _ContextPaddingExtension(this);

  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get horizontalPaddingLow =>
      EdgeInsets.symmetric(horizontal: lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get horizontalPaddingNormal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get horizontalPaddingMedium =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get horizontalPaddingHigh =>
      EdgeInsets.symmetric(horizontal: highValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get verticalPaddingNormal =>
      EdgeInsets.symmetric(vertical: normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get verticalPaddingMedium =>
      EdgeInsets.symmetric(vertical: mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get verticalPaddingHigh =>
      EdgeInsets.symmetric(vertical: highValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyLeftPaddingLow => EdgeInsets.only(left: lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyLeftPaddingNormal => EdgeInsets.only(left: normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyLeftPaddingMedium => EdgeInsets.only(left: mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyLeftPaddingHigh => EdgeInsets.only(left: highValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyRightPaddingLow => EdgeInsets.only(right: lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyRightPaddingNormal => EdgeInsets.only(right: normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyRightPaddingMedium => EdgeInsets.only(right: mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyRightPaddingHigh => EdgeInsets.only(right: highValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyBottomPaddingLow => EdgeInsets.only(bottom: lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyBottomPaddingNormal =>
      EdgeInsets.only(bottom: normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyBottomPaddingMedium =>
      EdgeInsets.only(bottom: mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyBottomPaddingHigh => EdgeInsets.only(bottom: highValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyTopPaddingLow => EdgeInsets.only(top: lowValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyTopPaddingNormal => EdgeInsets.only(top: normalValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyTopPaddingMedium => EdgeInsets.only(top: mediumValue);
  @Deprecated('You should use the [ext] property instead')
  EdgeInsets get onlyTopPaddingHigh => EdgeInsets.only(top: highValue);
}
