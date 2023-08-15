part of '../../string_extension.dart';

mixin _StringExtensionMixin {
  /// The function `_getBoolFromString` converts a string value to a boolean value if it matches the
  /// string representation of `true` or `false`, otherwise it returns `null`.
  ///
  /// Args:
  ///   value (String): The `value` parameter is a string that represents a boolean value.
  ///
  /// Returns:
  ///   The method is returning a boolean value or null.
  bool? _getBoolFromString(String value) {
    final valueLowerCased = value.toLowerCase().trim();
    final isEqualTrueString = valueLowerCased == true.toString();
    final isEqualFalseString = valueLowerCased == false.toString();
    if (isEqualTrueString || isEqualFalseString) return isEqualTrueString;
    return null;
  }

  /// Checks if the provided data type string follows a valid list format in Dart,
  /// supporting up to two levels of nested List types.
  ///
  /// Parameters:
  ///   - type (String): A string representing a data type.
  ///
  /// Returns:
  ///   A boolean value indicating whether the type follows the valid list format.
  bool checkListFormat(String type) {
    final listRegex = RegExp(RegexConstants.instance().listRegex);
    return listRegex.hasMatch(type);
  }
}
