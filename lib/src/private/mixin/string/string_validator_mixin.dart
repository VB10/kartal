import 'package:diacritic/diacritic.dart';
import 'package:kartal/kartal.dart';

/// It provides platform-specific functionalities for [String].
mixin StringValidatorMixin {
  String get value;

  /// Returns lowercase version with no special characters.
  String get searchable =>
      value.toLowerCase().ext.withoutSpecialCharacters ?? '';

  /// Returns true if this string is null or empty.
  bool get isNullOrEmpty => value.isEmpty;

  /// Returns true if this string is not null and not empty.
  bool get isNotNullOrNoEmpty => value.isNotEmpty;

  // Check if email is valid
  bool get isValidEmail {
    if (!isNotNullOrNoEmpty) return false;
    return RegExp(
      RegexConstants.instance().emailRegex,
    ).hasMatch(value);
  }

  /// Checks if the password is valid.
  ///
  /// A valid password is one that is at least 8 characters long and contains
  /// at least one uppercase letter, one lowercase letter, one number, and one
  /// symbol.
  ///
  /// Returns `true` if the password is valid, otherwise returns `false`.
  bool get isValidPassword => RegExp(
        RegexConstants.instance().passwordRegex,
      ).hasMatch(value);

  /// Removes all diacritics from the string.
  ///
  /// For example, [removeDiacritics] would transform 'à' to 'a'.
  String? get withoutSpecialCharacters =>
      isNullOrEmpty ? value : removeDiacritics(value);

  /// Returns the _value of the phone number without the formatting characters.
  String get phoneFormatValue =>
      InputFormatter.instance.phoneFormatter.unmaskText(value);

  /// Formats the _value of this [String] as a time.
  ///
  /// This assumes that the _value of this [String] is a time string, and
  /// returns a [String] representing the formatted version of the _value.
  String get timeFormatValue =>
      InputFormatter.instance.timeFormatter.unmaskText(value);

  /// Unmasks the text for the time overline format.
  ///
  /// This format only allows numbers.
  String get timeOverlineFormatValue =>
      InputFormatter.instance.timeFormatterOverLine.unmaskText(value);
}
