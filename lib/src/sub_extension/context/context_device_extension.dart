import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kartal/src/constants/index.dart';
import 'package:kartal/src/sub_extension/context/index.dart';

/// Provides convenient access to commonly used properties related to screen sizes and device platforms.
class _ContextDeviceExtension {
  _ContextDeviceExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  double get width => _context.sized.width;

  /// Returns `true` if the width of the screen is within the range of small screens,
  /// based on the values defined in [ResponsibilityConstants].
  bool get isSmallScreen =>
      width >= ResponsibilityConstants.instance().smallScreenSize &&
      width < ResponsibilityConstants.instance().mediumScreenSize;

  /// Returns `true` if the width of the screen is within the range of medium screens,
  /// based on the values defined in [ResponsibilityConstants].
  bool get isMediumScreen =>
      width >= ResponsibilityConstants.instance().mediumScreenSize &&
      width < ResponsibilityConstants.instance().largeScreenSize;

  /// Returns `true` if the width of the screen is within the range of large screens,
  /// based on the values defined in [ResponsibilityConstants].
  bool get isLargeScreen =>
      width >= ResponsibilityConstants.instance().largeScreenSize;

  /// Returns `true` if the current device is running on Android.
  bool get isAndroidDevice => Platform.isAndroid;

  /// Returns `true` if the current device is running on iOS.
  bool get isIOSDevice => Platform.isIOS;

  /// Returns `true` if the current device is running on Windows.
  bool get isWindowsDevice => Platform.isWindows;

  /// Returns `true` if the current device is running on Linux.
  bool get isLinuxDevice => Platform.isLinux;

  /// Returns `true` if the current device is running on macOS.
  bool get isMacOSDevice => Platform.isMacOS;
}

extension ContextDeviceTypeExtension on BuildContext {
  _ContextDeviceExtension get device => _ContextDeviceExtension(this);

  @Deprecated('Use device.isAndroidDevice instead')
  bool get isAndroidDevice => Platform.isAndroid;
  @Deprecated('Use device.isIOSDevice instead')
  bool get isIOSDevice => Platform.isIOS;
  @Deprecated('Use device.isWindowsDevice instead')
  bool get isWindowsDevice => Platform.isWindows;
  @Deprecated('Use device.isLinuxDevice instead')
  bool get isLinuxDevice => Platform.isLinux;
  @Deprecated('Use device.isMacOSDevice instead')
  bool get isMacOSDevice => Platform.isMacOS;

  @Deprecated('Use device.isSmallScreen instead')
  bool get isSmallScreen =>
      width >= ResponsibilityConstants.instance().smallScreenSize &&
      width < ResponsibilityConstants.instance().mediumScreenSize;
  @Deprecated('Use device.isMediumScreen instead')
  bool get isMediumScreen =>
      width >= ResponsibilityConstants.instance().mediumScreenSize &&
      width < ResponsibilityConstants.instance().largeScreenSize;
  @Deprecated('Use device.isLargeScreen instead')
  bool get isLargeScreen =>
      width >= ResponsibilityConstants.instance().largeScreenSize;
}
