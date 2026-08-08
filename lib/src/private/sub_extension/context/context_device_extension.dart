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

  /// Returns `true` if the screen is narrower than
  /// [ResponsibilityConstants.smallScreenSize].
  ///
  /// The range is defined as `0 <= width < 300`.
  bool get isSmallScreen => _width < _responsibilityConstants.smallScreenSize;

  /// Returns `true` if the screen width falls between
  /// [ResponsibilityConstants.smallScreenSize] and
  /// [ResponsibilityConstants.mediumScreenSize].
  ///
  /// The range is defined as `300 <= width < 600`.
  bool get isMediumScreen =>
      _width >= _responsibilityConstants.smallScreenSize &&
      _width < _responsibilityConstants.mediumScreenSize;

  /// Returns `true` if the screen width falls between
  /// [ResponsibilityConstants.mediumScreenSize] and
  /// [ResponsibilityConstants.largeScreenSize].
  ///
  /// The range is defined as `600 <= width < 900`. This band previously had
  /// no accessor at all, which left those widths unclassified.
  bool get isExpandedScreen =>
      _width >= _responsibilityConstants.mediumScreenSize &&
      _width < _responsibilityConstants.largeScreenSize;

  /// Returns `true` if the screen is at least
  /// [ResponsibilityConstants.largeScreenSize] wide.
  ///
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

  /// The band the current screen width falls into.
  ///
  /// Unlike the individual boolean getters this is exhaustive, so it can be
  /// switched over without a fallback branch.
  DeviceBreakpoint get breakpoint {
    if (isSmallScreen) return DeviceBreakpoint.small;
    if (isMediumScreen) return DeviceBreakpoint.medium;
    if (isExpandedScreen) return DeviceBreakpoint.expanded;

    return DeviceBreakpoint.large;
  }

  /// Picks a value for the current screen width.
  ///
  /// [small] is required and acts as the fallback, so a narrow layout is always
  /// defined. Wider bands fall back to the next narrower value that was
  /// supplied, which means supplying only [small] and [large] behaves the way
  /// you would expect.
  ///
  /// ```dart
  /// final columns = context.device.responsive(small: 1, medium: 2, large: 4);
  /// ```
  T responsive<T>({required T small, T? medium, T? expanded, T? large}) =>
      switch (breakpoint) {
        DeviceBreakpoint.small => small,
        DeviceBreakpoint.medium => medium ?? small,
        DeviceBreakpoint.expanded => expanded ?? medium ?? small,
        DeviceBreakpoint.large => large ?? expanded ?? medium ?? small,
      };
}

/// The screen width bands used by `context.device`.
///
/// Thresholds come from [ResponsibilityConstants], which can be reconfigured
/// through `KartalConfig.configure`.
enum DeviceBreakpoint {
  /// Narrower than the small threshold. Defaults to `< 300`.
  small,

  /// Between the small and medium thresholds. Defaults to `300..600`.
  medium,

  /// Between the medium and large thresholds. Defaults to `600..900`.
  expanded,

  /// At or above the large threshold. Defaults to `>= 900`.
  large
  ;

  /// Whether this is the narrowest band.
  bool get isSmall => this == DeviceBreakpoint.small;

  /// Whether this is the widest band.
  bool get isLarge => this == DeviceBreakpoint.large;
}
