class RegexConstants {
  RegexConstants._init();
  static RegexConstants? _instance;
  static RegexConstants get instance {
    if (_instance != null) return _instance!;

    _instance = RegexConstants._init();
    return _instance!;
  }

  final String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\w-]+\.[a-zA-Z]+";
  final String passwordRegex = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
}
