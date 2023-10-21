import 'package:flutter/material.dart';
import 'package:kartal/src/private/sub_extension/context/index.dart';

/// Contains extension methods on the [BuildContext] class to simplify the creation of
/// [EdgeInsets] objects for padding in Flutter.
extension PaddingExtension on BuildContext {
  _ContextExtension get padding => _ContextExtension(this);
}

final class _ContextExtension {
  _ContextExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  /// Returns a value representing a low dimension, calculated as 0.01 times the current widget's height.
  double get _lowValue => _context.sized.lowValue;

  /// Returns a value representing a normal dimension, calculated as 0.02 times the current widget's height.
  double get _normalValue => _context.sized.normalValue;

  /// Returns a value representing a medium dimension, calculated as 0.04 times the current widget's height.
  double get _mediumValue => _context.sized.mediumValue;

  /// Returns a value representing a high dimension, calculated as 0.1 times the current widget's height.
  double get _highValue => _context.sized.highValue;

  /// Returns an [EdgeInsets] object with equal  on all sides, where the value is set to
  /// [_lowValue].
  EdgeInsets get low => EdgeInsets.all(_lowValue);

  /// Returns an [EdgeInsets] object with equal  on all sides, where the value is set to
  /// [_normalValue].
  EdgeInsets get normal => EdgeInsets.all(_normalValue);

  /// Returns an [EdgeInsets] object with equal  on all sides, where the value is set to
  /// [_mediumValue].
  EdgeInsets get medium => EdgeInsets.all(_mediumValue);

  /// Returns an [EdgeInsets] object with equal  on all sides, where the value is set to
  /// [_highValue].
  EdgeInsets get high => EdgeInsets.all(_highValue);

  /// Returns an [EdgeInsets] object with horizontal  only, where the horizontal
  /// value is set to [_lowValue].
  EdgeInsets get horizontalLow => EdgeInsets.symmetric(horizontal: _lowValue);

  /// Returns an [EdgeInsets] object with horizontal  only, where the horizontal
  /// value is set to [_normalValue].
  EdgeInsets get horizontalNormal =>
      EdgeInsets.symmetric(horizontal: _normalValue);

  /// Returns an [EdgeInsets] object with horizontal  only, where the horizontal
  /// value is set to [_mediumValue].
  EdgeInsets get horizontalMedium =>
      EdgeInsets.symmetric(horizontal: _mediumValue);

  /// Returns an [EdgeInsets] object with horizontal  only, where the horizontal
  /// value is set to [_highValue].
  EdgeInsets get horizontalHigh => EdgeInsets.symmetric(horizontal: _highValue);

  /// Returns an [EdgeInsets] object with vertical  only, where the vertical  value
  /// is set to [_lowValue].
  EdgeInsets get verticalLow => EdgeInsets.symmetric(vertical: _lowValue);

  /// Returns an [EdgeInsets] object with vertical  only, where the vertical  value
  /// is set to [_normalValue].
  EdgeInsets get verticalNormal => EdgeInsets.symmetric(vertical: _normalValue);

  /// Returns an [EdgeInsets] object with vertical  only, where the vertical  value
  /// is set to [_mediumValue].
  EdgeInsets get verticalMedium => EdgeInsets.symmetric(vertical: _mediumValue);

  /// Returns an [EdgeInsets] object with vertical  only, where the vertical  value
  /// is set to [_highValue].
  EdgeInsets get verticalHigh => EdgeInsets.symmetric(vertical: _highValue);

  /// Returns an [EdgeInsets] object with  only on the left side, where the left
  /// value is set to [_lowValue].
  EdgeInsets get onlyLeftLow => EdgeInsets.only(left: _lowValue);

  /// Returns an [EdgeInsets] object with  only on the left side, where the left
  /// value is set to [_normalValue].
  EdgeInsets get onlyLeftNormal => EdgeInsets.only(left: _normalValue);

  /// Returns an [EdgeInsets] object with  only on the left side, where the left
  /// value is set to [_mediumValue].
  EdgeInsets get onlyLeftMedium => EdgeInsets.only(left: _mediumValue);

  /// Returns an [EdgeInsets] object with  only on the left side, where the left
  /// value is set to [_highValue].
  EdgeInsets get onlyLeftHigh => EdgeInsets.only(left: _highValue);

  /// Returns an [EdgeInsets] object with  only on the right side, where the right
  /// value is set to [_lowValue].
  EdgeInsets get onlyRightLow => EdgeInsets.only(right: _lowValue);

  /// Returns an [EdgeInsets] object with  only on the right side, where the right
  /// value is set to [_normalValue].
  EdgeInsets get onlyRightNormal => EdgeInsets.only(right: _normalValue);

  /// Returns an [EdgeInsets] object with  only on the right side, where the right
  /// value is set to [_mediumValue].
  EdgeInsets get onlyRightMedium => EdgeInsets.only(right: _mediumValue);

  /// Returns an [EdgeInsets] object with  only on the right side, where the right
  /// value is set to [_highValue].
  EdgeInsets get onlyRightHigh => EdgeInsets.only(right: _highValue);

  /// Returns an [EdgeInsets] object with  only on the bottom side, where the bottom
  /// value is set to [_lowValue].
  EdgeInsets get onlyBottomLow => EdgeInsets.only(bottom: _lowValue);

  /// Returns an [EdgeInsets] object with  only on the bottom side, where the bottom
  /// value is set to [_normalValue].
  EdgeInsets get onlyBottomNormal => EdgeInsets.only(bottom: _normalValue);

  /// Returns an [EdgeInsets] object with  only on the bottom side, where the bottom
  /// value is set to [_mediumValue].
  EdgeInsets get onlyBottomMedium => EdgeInsets.only(bottom: _mediumValue);

  /// Returns an [EdgeInsets] object with  only on the bottom side, where the bottom
  /// value is set to [_highValue].
  EdgeInsets get onlyBottomHigh => EdgeInsets.only(bottom: _highValue);

  /// Returns an [EdgeInsets] object with  only on the top side, where the top
  /// value is set to [_lowValue].
  EdgeInsets get onlyTopLow => EdgeInsets.only(top: _lowValue);

  /// Returns an [EdgeInsets] object with  only on the top side, where the top
  /// value is set to [_normalValue].
  EdgeInsets get onlyTopNormal => EdgeInsets.only(top: _normalValue);

  /// Returns an [EdgeInsets] object with  only on the top side, where the top
  /// value is set to [_mediumValue].
  EdgeInsets get onlyTopMedium => EdgeInsets.only(top: _mediumValue);

  /// Returns an [EdgeInsets] object with  only on the top side, where the top
  /// value is set to [_highValue].
  EdgeInsets get onlyTopHigh => EdgeInsets.only(top: _highValue);
}
