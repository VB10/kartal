import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/src/constants/input_formatter_constants.dart';
import 'package:kartal/src/constants/regex_constants.dart';
import 'package:kartal/src/exception/generic_type_exception.dart';
import 'package:kartal/src/platform/custom_platform.dart';
import 'package:kartal/src/utility/maps_utility.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'private/mixin/string_extension_mixin.dart';

/// Extension methods for [String] to provide additional functionalities.
extension StringExtension on String? {
  /// Provides convenient access to additional functionalities for [String].
  _StringExtension get ext => _StringExtension(this);
}

/// Extension methods for [String] to provide additional functionalities.
extension StringDefaultExtension on String {
  /// Provides convenient access to additional functionalities for [String].
  _StringExtension get ext => _StringExtension(this);
}

final class _StringExtension with _StringExtensionMixin {
  _StringExtension(String? value) : _value = value;

  final String? _value;

  /// Returns the length of the string.
  int get lineLength => '\n'.allMatches(_value ?? '').length + 1;

  /// Returns the length of the string.
  Color get color => Color(int.parse('0xff$_value'));

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
    final value = _value;
    if (value == null) return null;
    if (checkListFormat(T.toString())) throw const ListTypeNotSupported();
    if (T == bool) return _getBoolFromString(value) as T?;
    if (T == int) return int.tryParse(value) as T?;
    if (T == double) return double.tryParse(value) as T?;
    if (T == String) return value as T?;
    return null;
  }

  /// Converts the first letter of the string to capital letter and returns the resulting string.
  /// If the string is null or empty, returns an empty string.
  String toCapitalized() {
    final condition = _value?.isNotEmpty ?? false;
    if (!condition) return '';
    final firstIndexUpperCased = _value![0].toUpperCase();
    final restOfTheString = _value.substring(1).toLowerCase();
    return condition ? firstIndexUpperCased + restOfTheString : '';
  }

  /// Converts all letters of the string to title case and returns the resulting string.
  /// If the string is null or empty, returns an empty string.
  String toTitleCase() => _value != null
      ? _value
          .replaceAll(
            RegExp(' +'),
            ' ',
          )
          .split(' ')
          .map((str) => str.ext.toCapitalized())
          .join(' ')
      : '';

  int? get colorCode => int.tryParse('0xFF$_value');

  Color get toColor => Color(colorCode ?? 0xFFFFFFFF);

  /// Returns true if this string is null or empty.
  bool get isNullOrEmpty => _value?.isEmpty ?? true;

  /// Returns true if this string is not null and not empty.
  bool get isNotNullOrNoEmpty => _value?.isNotEmpty ?? false;

  // Check if email is valid
  bool get isValidEmail {
    if (!isNotNullOrNoEmpty) return false;
    return RegExp(
      RegexConstants.instance().emailRegex,
    ).hasMatch(_value!);
  }

  /// Checks if the password is valid.
  ///
  /// A valid password is one that is at least 8 characters long and contains
  /// at least one uppercase letter, one lowercase letter, one number, and one
  /// symbol.
  ///
  /// Returns `true` if the password is valid, otherwise returns `false`.
  bool get isValidPassword {
    if (_value == null) return false;
    return RegExp(
      RegexConstants.instance().passwordRegex,
    ).hasMatch(_value);
  }

  /// Removes all diacritics from the string.
  ///
  /// For example, [removeDiacritics] would transform 'à' to 'a'.
  String? get withoutSpecialCharacters =>
      isNullOrEmpty ? _value : removeDiacritics(_value ?? '');

  /// Returns the _value of the phone number without the formatting characters.
  String get phoneFormatValue =>
      InputFormatter.instance.phoneFormatter.unmaskText(_value ?? '');

  /// Formats the _value of this [String] as a time.
  ///
  /// This assumes that the _value of this [String] is a time string, and
  /// returns a [String] representing the formatted version of the _value.
  String get timeFormatValue =>
      InputFormatter.instance.timeFormatter.unmaskText(_value ?? '');

  /// Unmasks the text for the time overline format.
  ///
  /// This format only allows numbers.
  String get timeOverlineFormatValue =>
      InputFormatter.instance.timeFormatterOverLine.unmaskText(_value ?? '');

  /// Random image -> picsum 200x300
  String get randomImage => 'https://picsum.photos/200/300';

  /// Random image -> picsum 200x200
  String get randomSquareImage => 'https://picsum.photos/200';

  /// Random image -> picsum 200x300
  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';

  /// Profile image from gravatar
  String get customHighProfileImage =>
      'https://www.gravatar.com/avatar/?d=mp&s=200';

  /// Returns the value of map with bearer token
  Map<String, dynamic> get bearer => {'Authorization': 'Bearer $_value'};

  ///
  /// The function will launch to relaeted maps for your in device
  /// When try to launch in apple it will open AppleMaps or Gogle maps web link if catch any problem.
  /// When try to launch in android it will open GoogleMaps or Gogle maps web link if catch any problem.
  ///
  Future<bool> launchMaps({
    LaunchUrlCallBack? callBack,
  }) async {
    final query = _value;
    if (query.ext.isNullOrEmpty) return false;

    final encodedQuery = Uri.encodeComponent(query!);

    var result = false;

    if (CustomPlatform.instance.isIOS) {
      result = await MapsUtility.openAppleMapsWithQuery(
        encodedQuery,
        callBack: callBack,
      );
    } else {
      result = await MapsUtility.openGoogleMapsWithQuery(
        encodedQuery,
        callBack: callBack,
      );
    }

    if (result) return true;
    return MapsUtility.openGoogleWebMapsWithQuery(encodedQuery);
  }

  /// Launches the email app with this email address.
  Future<bool> get launchEmail => launchUrlString('mailto:$_value');
  // Launch the phone application with the given number.
  Future<bool> get launchPhone => launchUrlString('tel:$_value');

  /// Returns whether or not the user can launch the website.
  Future<bool> get launchWebsite => launchUrlString(_value ?? '');

  /// Returns whether or not the user can launch the website.
  Future<bool> launchWebsiteCustom({
    bool enableJavaScript = false,
    bool enableDomStorage = false,
    Map<String, String> headers = const <String, String>{},
    String? webOnlyWindowName,
    LaunchMode mode = LaunchMode.platformDefault,
  }) =>
      launchUrlString(
        _value ?? '',
        webViewConfiguration: WebViewConfiguration(
          enableDomStorage: enableDomStorage,
          enableJavaScript: enableJavaScript,
          headers: headers,
        ),
        mode: mode,
        webOnlyWindowName: webOnlyWindowName,
      );

  /// Share your value with WhatsApp
  Future<void> shareWhatsApp() async =>
      CustomPlatform.instance.shareWhatsApp(_value);

  /// Share your value with Mail
  Future<void> shareMail(String title) async =>
      CustomPlatform.instance.shareMail(title, _value);

  /// Share your value  General
  Future<void> share() async => CustomPlatform.instance.share(_value);

  /// Application name from CustomPlatform
  String get appName => CustomPlatform.instance.appName;

  /// Application package name from CustomPlatform
  String get packageName => CustomPlatform.instance.version;

  /// Application version from CustomPlatform
  String get version => CustomPlatform.instance.version;

  /// Application build number from CustomPlatform
  String get buildNumber => CustomPlatform.instance.buildNumber;

  /// Application device id from CustomPlatform
  Future<String> get deviceId async =>
      (await CustomPlatform.instance.deviceId) ?? '';

  /// this method work with string value to convert json or any model
  Future<T?> safeJsonDecodeCompute<T>() async {
    if (_value.ext.isNullOrEmpty) return null;
    try {
      final response = await compute<String, dynamic>(
        jsonDecode,
        _value!,
      );

      if (response is T) {
        return response;
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
