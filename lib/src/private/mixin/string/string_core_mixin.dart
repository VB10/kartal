import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/exception/generic_type_exception.dart';

mixin StringCoreMixin {
  String? get value;

  /// Converts the generic value `T` to its primitive form.
  ///
  /// Returns the primitive value or null if the generic value is null.
  /// Throws a `ListTypeNotSupported` exception if the generic type is a list format.
  ///
  /// Type `T` is expected to be one of the supported primitive types: bool, int, double, String.
  ///
  /// Returns:
  ///   The primitive value of type `T` or null.
  T? toPrimitiveFromGeneric<T>() {
    if (value == null) return null;
    if (checkListFormat(T.toString())) throw const ListTypeNotSupported();
    if (T == bool) return _getBoolFromString(value!) as T?;
    if (T == int) return int.tryParse(value!) as T?;
    if (T == double) return double.tryParse(value!) as T?;
    if (T == String) return value as T?;
    return null;
  }

  /// Converts the first letter of the string to capital letter and returns the resulting string.
  /// If the string is null or empty, returns an empty string.
  String toCapitalized() {
    if (value == null) return '';
    final condition = value!.isNotEmpty;
    if (!condition) return '';
    final firstIndexUpperCased = value![0].toUpperCase();
    final restOfTheString = value!.substring(1).toLowerCase();
    return condition ? firstIndexUpperCased + restOfTheString : '';
  }

  /// Converts all letters of the string to title case and returns the resulting string.
  /// If the string is null or empty, returns an empty string.
  String toTitleCase() {
    if (value.ext.isNullOrEmpty) return '';
    return value!
        .replaceAll(
          RegExp(' +'),
          ' ',
        )
        .split(' ')
        .map((str) => str.ext.toCapitalized())
        .join(' ');
  }

  /// this method work with string value to convert json or any model
  Future<T?> safeJsonDecodeCompute<T>() async {
    if (value.ext.isNullOrEmpty) return null;
    try {
      final response = await compute<String, dynamic>(
        jsonDecode,
        value!,
      );

      if (response is T) {
        return response;
      }
    } catch (e) {
      return null;
    }

    return null;
  }

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
