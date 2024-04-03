import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Extension methods for [BuildContext] to access device-related properties.
extension ContextDeviceTypeExtension on BuildContext {
  /// Provides convenient access to commonly used properties related to screen sizes and device platforms.
  _ContextDeviceExtension get device => _ContextDeviceExtension(this);
}

/// Provides convenient access to commonly used properties related to screen sizes and device platforms.
final class _ContextDeviceExtension {
  _ContextDeviceExtension(BuildContext context) : _context = context;
  final BuildContext _context;
  ResponsibilityConstants get _responsibilityConstants =>
      ResponsibilityConstants.instance();
  double get _width => _context.sized.width;

  /// Returns `true` if the width of the screen is within the range of small screens,
  /// based on the values defined in [ResponsibilityConstants].
  /// The range is defined as `0 <= width < 300`.
  bool get isSmallScreen =>
      _width >= _responsibilityConstants.smallScreenSize &&
      _width < _responsibilityConstants.mediumScreenSize;

  /// Returns `true` if the width of the screen is within the range of medium screens,
  /// based on the values defined in [ResponsibilityConstants].
  /// The range is defined as `300 <= width < 600`.
  bool get isMediumScreen =>
      _width >= _responsibilityConstants.mediumScreenSize &&
      _width < _responsibilityConstants.largeScreenSize;

  /// Returns `true` if the width of the screen is within the range of large screens,
  /// based on the values defined in [ResponsibilityConstants].
  /// The range is defined as `900 <= width`.
  bool get isLargeScreen => _width >= _responsibilityConstants.largeScreenSize;

  /// Returns `true` if the current device is running on Android.
  bool get isAndroidDevice => CustomPlatform.instance.isAndroid;

  /// Returns `true` if the current device is running on iOS.
  bool get isIOSDevice => CustomPlatform.instance.isIOS;

  /// Returns `true` if the current device is running on Windows.
  bool get isWindowsDevice => CustomPlatform.instance.isWindows;

  /// Returns `true` if the current device is running on Linux.
  bool get isLinuxDevice => CustomPlatform.instance.isLinux;

  /// Returns `true` if the current device is running on macOS.
  bool get isMacOSDevice => CustomPlatform.instance.isMacOS;
}
