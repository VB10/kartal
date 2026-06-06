final class RegexConstants {
  factory RegexConstants.instance() => _instance ??= RegexConstants._init();
  RegexConstants._init();
  static RegexConstants? _instance;

  /// Regex for email validation
  final String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\w-]+\.[a-zA-Z]+";

  /// Regex for password
  final String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  /// Regex for list
  final String listRegex = r'^List(?:<(?:List<[^>]+>|[^<>])+>)?$';

  /// Regex for hex color
  final String hexColorRegex =
      r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$';
}
