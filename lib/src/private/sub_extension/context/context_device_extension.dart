import 'package:flutter/material.dart';
import 'package:kartal/src/constants/index.dart';
import 'package:kartal/src/platform/custom_platform.dart';
import 'package:kartal/src/private/sub_extension/context/index.dart';

/// Extension methods for [BuildContext] to access device-related properties.
extension ContextDeviceTypeExtension on BuildContext {
  /// Provides convenient access to commonly used properties related to screen sizes and device platforms.
  _ContextDeviceExtension get device => _ContextDeviceExtension(this);
}

/// Provides convenient access to commonly used properties related to screen sizes and device platforms.
final class _ContextDeviceExtension {
  _ContextDeviceExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get _width => _context.sized.width;

  /// Returns `true` if the width of the screen is within the range of small screens,
  /// based on the values defined in [ResponsibilityConstants].
  bool get isSmallScreen =>
      _width >= ResponsibilityConstants.instance().smallScreenSize &&
      _width < ResponsibilityConstants.instance().mediumScreenSize;

  /// Returns `true` if the width of the screen is within the range of medium screens,
  /// based on the values defined in [ResponsibilityConstants].
  bool get isMediumScreen =>
      _width >= ResponsibilityConstants.instance().mediumScreenSize &&
      _width < ResponsibilityConstants.instance().largeScreenSize;

  /// Returns `true` if the width of the screen is within the range of large screens,
  /// based on the values defined in [ResponsibilityConstants].
  bool get isLargeScreen =>
      _width >= ResponsibilityConstants.instance().largeScreenSize;

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
