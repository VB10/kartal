class RegexConstants {
  RegexConstants._init();
  static RegexConstants? _instance;
  static RegexConstants get instance {
    if (_instance != null) return _instance!;

    _instance = RegexConstants._init();
    return _instance!;
  }

  final String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final String passwordRegex = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
}
