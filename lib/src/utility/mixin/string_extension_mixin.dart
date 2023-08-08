part of '../../string_extension.dart';

mixin _StringExtensionMixin {
  /// The function `_getBoolFromString` converts a string value to a boolean value if it matches the
  /// true or false constants, otherwise it returns null.
  ///
  /// Args:
  ///   value (String): The `value` parameter is a string that represents a boolean value.
  ///
  /// Returns:
  ///   The method `_getBoolFromString` returns a `bool?` value.
  bool? _getBoolFromString(String value) {
    final valueLowerCased = value.toLowerCase().trim();
    final isEqualTrueString = valueLowerCased == StringConstants.trueConstant;
    final isEqualFalseString = valueLowerCased == StringConstants.falseConstant;
    if (isEqualTrueString || isEqualFalseString) return isEqualTrueString;
    return null;
  }
}
