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

  /// Regex for http and https URLs.
  final String urlRegex =
      r'^https?:\/\/'
      r'(?:[\w-]+(?::[^@\/\s]*)?@)?'
      r'(?:localhost|(?:[\w-]+\.)+[a-zA-Z]{2,}|'
      r'(?:\d{1,3}\.){3}\d{1,3})'
      r'(?::\d{1,5})?'
      r'(?:[\/?#][^\s]*)?$';

  /// Regex for digits only, used to strip formatting from numeric input.
  final String digitsRegex = r'\D';

  /// Regex for Turkish mobile and landline numbers.
  ///
  /// Accepts an optional `+90`/`0090`/`0` country or trunk prefix followed by
  /// a 10 digit number whose area code cannot start with zero.
  final String phoneTrRegex = r'^(?:\+?90|0)?([1-9]\d{9})$';

  /// Regex for HTML tags, used by `removeHtmlTags`.
  final String htmlTagRegex = '<[^>]*>';

  /// Regex for characters that are not safe in a URL slug.
  final String slugUnsafeRegex = '[^a-z0-9]+';
}
