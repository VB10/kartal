class ResponsibilityConstants {
  ResponsibilityConstants._init();
  static ResponsibilityConstants? _instance;
  static ResponsibilityConstants get instance {
    if (_instance != null) {
      return _instance!;
    }

    _instance = ResponsibilityConstants._init();
    return _instance!;
  }

  final double smallScreenSize = 300;
  final double mediumScreenSize = 600;
  final double largeScreenSize = 900;
}
