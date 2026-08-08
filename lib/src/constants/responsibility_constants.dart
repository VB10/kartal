import 'package:kartal/src/kartal_config.dart';

/// This class is used to define the screen sizes for different devices.
///
/// Each value is the upper bound of a band, so [smallScreenSize] is the width
/// at which a screen stops being small. Override them globally through
/// [KartalConfig.configure] rather than mutating this class directly.
final class ResponsibilityConstants {
  factory ResponsibilityConstants.instance() =>
      _instance ??= ResponsibilityConstants._init();
  ResponsibilityConstants._init();
  static ResponsibilityConstants? _instance;

  /// The thresholds currently in force.
  ///
  /// Assigned by [KartalConfig.configure]; prefer that over setting this
  /// directly so the rest of the configuration stays consistent.
  KartalBreakpoints breakpoints = const KartalBreakpoints();

  /// The width at which a screen stops being small. Defaults to 300.
  double get smallScreenSize => breakpoints.small;

  /// The width at which a screen stops being medium. Defaults to 600.
  double get mediumScreenSize => breakpoints.medium;

  /// The width at which a screen becomes large. Defaults to 900.
  double get largeScreenSize => breakpoints.large;
}
