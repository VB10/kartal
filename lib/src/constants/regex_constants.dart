class RegexConstants {
  factory RegexConstants.instance() {
    return _instance ??= RegexConstants._init();
  }
  RegexConstants._init();
  static RegexConstants? _instance;

  final String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final String passwordRegex = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
}
