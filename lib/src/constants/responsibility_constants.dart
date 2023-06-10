class ResponsibilityConstants {
  factory ResponsibilityConstants.instance() =>
      _instance ??= ResponsibilityConstants._init();
  ResponsibilityConstants._init();
  static ResponsibilityConstants? _instance;

  final double smallScreenSize = 300;
  final double mediumScreenSize = 600;
  final double largeScreenSize = 900;
}
