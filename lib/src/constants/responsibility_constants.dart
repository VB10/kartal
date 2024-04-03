/// This class is used to define the screen sizes for different devices.
final class ResponsibilityConstants {
  factory ResponsibilityConstants.instance() =>
      _instance ??= ResponsibilityConstants._init();
  ResponsibilityConstants._init();
  static ResponsibilityConstants? _instance;

  final double smallScreenSize = 300;
  final double mediumScreenSize = 600;
  final double largeScreenSize = 900;
}
