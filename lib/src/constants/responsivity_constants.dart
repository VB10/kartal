class ResponsivityConstants {
  static ResponsivityConstants? _instace;
  static ResponsivityConstants get instance {
    if (_instace != null) {
      return _instace!;
    }

    _instace = ResponsivityConstants._init();
    return _instace!;
  }

  ResponsivityConstants._init();

  final smallScreenSize = 300;
  final mediumScreenSize = 600;
  final largeScreenSize = 900;
}
