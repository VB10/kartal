import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:kartal/src/constants/app_constants.dart';
import 'package:kartal/src/constants/input_formatter_constants.dart';
import 'package:kartal/src/constants/regex_constants.dart';
import 'package:kartal/src/exception/package_info_exception.dart';
import 'package:kartal/src/utility/device_utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class _StringExtension {
  _StringExtension(String? value) : _value = value;

  final String? _value;

  int get lineLength => '\n'.allMatches(_value ?? '').length + 1;
  Color get color => Color(int.parse('0xff$_value'));

  /// Converts the first letter of the string to capital letter and returns the resulting string.
  /// If the string is null or empty, returns an empty string.
  String toCapitalized() {
    final condition = _value?.isNotEmpty ?? false;
    if (!condition) return '';
    final firstIndexUpperCased = _value![0].toUpperCase();
    final restOfTheString = _value!.substring(1).toLowerCase();
    return condition ? firstIndexUpperCased + restOfTheString : '';
  }

  /// Converts all letters of the string to title case and returns the resulting string.
  /// If the string is null or empty, returns an empty string.
  String toTitleCase() => _value != null
      ? _value!
          .replaceAll(
            RegExp(' +'),
            ' ',
          )
          .split(' ')
          .map((str) => str.toCapitalized())
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
    ).hasMatch(_value!);
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

  String get randomImage => 'https://picsum.photos/200/300';
  String get randomSquareImage => 'https://picsum.photos/200';

  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';
  String get customHighProfileImage =>
      'https://www.gravatar.com/avatar/?d=mp&s=200';

  Map<String, dynamic> get bearer => {'Authorization': 'Bearer $_value'};

  /// Launches the email app with this email address.
  Future<bool> get launchEmail => launchUrlString('mailto:$_value');
  // Launch the phone application with the given number.
  Future<bool> get launchPhone => launchUrlString('tel:$_value');

  /// Returns whether or not the user can launch the website.
  Future<bool> get launchWebsite => launchUrlString(_value ?? '');

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

  Future<void> shareWhatsApp() async {
    try {
      final isLaunch = await launchUrlString(
        '${KartalAppConstants.WHATS_APP_PREFIX}$this',
      );
      if (!isLaunch) await share();
    } catch (e) {
      await share();
    }
  }

  Future<void> shareMail(String title) async {
    final mailBodyText =
        DeviceUtility.instance.shareMailText(title, _value ?? '');
    final isLaunch = await launchUrlString(Uri.encodeFull(mailBodyText));
    if (!isLaunch) await _value?.share();
  }

  Future<void> share() async {
    if (Platform.isIOS) {
      final isAppIpad = await DeviceUtility.instance.isIpad();
      if (isAppIpad) {
        await Share.share(
          _value ?? '',
          sharePositionOrigin: DeviceUtility.instance.ipadPaddingBottom,
        );
      }
    }

    await Share.share(_value ?? '');
  }

  String get appName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.appName;
    }
  }

  String get packageName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.packageName;
    }
  }

  String get version {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.version;
    }
  }

  String get buildNumber {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.buildNumber;
    }
  }

  Future<String> get deviceId async {
    {
      if (DeviceUtility.instance.packageInfo == null) {
        throw PackageInfoNotFound();
      } else {
        return DeviceUtility.instance.getUniqueDeviceId();
      }
    }
  }
}

// Deprecated: Use ext.toVisible instead

extension StringExtension on String? {
  _StringExtension get ext => _StringExtension(this);

  @Deprecated('Use ext.lineLength instead')
  int get lineLength => '\n'.allMatches(this ?? '').length + 1;

  @Deprecated('Use ext.color instead')
  Color get color => Color(int.parse('0xff$this'));

  @Deprecated('Use ext.toCapitalized instead')
  String toCapitalized() {
    final condition = this != null && this!.isNotEmpty;
    if (!condition) return '';
    final firstIndexUpperCased = this![0].toUpperCase();
    final restOfTheString = this!.substring(1).toLowerCase();
    return condition ? firstIndexUpperCased + restOfTheString : '';
  }

  @Deprecated('Use ext.toTitleCase instead')
  String toTitleCase() => this != null
      ? this!
          .replaceAll(
            RegExp(' +'),
            ' ',
          )
          .split(' ')
          .map((str) => str.toCapitalized())
          .join(' ')
      : '';

  @Deprecated('Use ext.isNullOrEmpty instead')
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  @Deprecated('Use ext.isNotNullOrNoEmpty instead')
  bool get isNotNullOrNoEmpty => this != null && this!.isNotEmpty;

  @Deprecated('Use ext.isValidEmail instead')
  bool get isValidEmail {
    if (!isNotNullOrNoEmpty) return false;
    return RegExp(
      RegexConstants.instance().emailRegex,
    ).hasMatch(this!);
  }

  @Deprecated('Use ext.isValidPassword instead')
  bool get isValidPassword {
    if (this == null) return false;
    return RegExp(
      RegexConstants.instance().passwordRegex,
    ).hasMatch(this!);
  }

  @Deprecated('Use ext.withoutSpecialCharacters instead')
  String? get withoutSpecialCharacters =>
      isNullOrEmpty ? this : removeDiacritics(this!);

  @Deprecated('Use ext.bearer instead')
  Map<String, dynamic> get bearer => {'Authorization': 'Bearer $this'};

  @Deprecated('Use ext.phoneFormat_value instead')
  String get phoneFormat_value =>
      InputFormatter.instance.phoneFormatter.unmaskText(this ?? '');

  @Deprecated('Use ext.timeFormat_value instead')
  String get timeFormat_value =>
      InputFormatter.instance.timeFormatter.unmaskText(this ?? '');

  @Deprecated('Use ext.timeOverlineFormat_value instead')
  String get timeOverlineFormat_value =>
      InputFormatter.instance.timeFormatterOverLine.unmaskText(this ?? '');

  @Deprecated('Use ext.randomImage instead')
  String get randomImage => 'https://picsum.photos/200/300';
  @Deprecated('Use ext.randomSquareImage instead')
  String get randomSquareImage => 'https://picsum.photos/200';
  @Deprecated('Use ext.customProfileImage instead')
  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';
  @Deprecated('Use ext.customHighProfileImage instead')
  String get customHighProfileImage =>
      'https://www.gravatar.com/avatar/?d=mp&s=200';
  @Deprecated('Use ext.colorCode instead')
  int? get colorCode => int.tryParse('0xFF$this');

  @Deprecated('Use ext.toColor instead')
  Color get toColor => Color(colorCode ?? 0xFFFFFFFF);

  @Deprecated('Use ext.launchEmail instead')
  Future<bool> get launchEmail => launchUrlString('mailto:$this');

  @Deprecated('Use ext.launchPhone instead')
  Future<bool> get launchPhone => launchUrlString('tel:$this');

  @Deprecated('Use ext.launchWebsite instead')
  Future<bool> get launchWebsite => launchUrlString(this ?? '');

  @Deprecated('Use ext.launchWebsiteCustom instead')
  Future<bool> launchWebsiteCustom({
    bool enableJavaScript = false,
    bool enableDomStorage = false,
    Map<String, String> headers = const <String, String>{},
    String? webOnlyWindowName,
    LaunchMode mode = LaunchMode.platformDefault,
  }) =>
      launchUrlString(
        this ?? '',
        webViewConfiguration: WebViewConfiguration(
          enableDomStorage: enableDomStorage,
          enableJavaScript: enableJavaScript,
          headers: headers,
        ),
        mode: mode,
        webOnlyWindowName: webOnlyWindowName,
      );

  @Deprecated('Use ext.shareWhatsApp instead')
  Future<void> shareWhatsApp() async {
    try {
      final isLaunch = await launchUrlString(
        '${KartalAppConstants.WHATS_APP_PREFIX}$this',
      );
      if (!isLaunch) await share();
    } catch (e) {
      await share();
    }
  }

  @Deprecated('Use ext.shareMail instead')
  Future<void> shareMail(String title) async {
    final value = DeviceUtility.instance.shareMailText(title, this ?? '');
    final isLaunch = await launchUrlString(Uri.encodeFull(value));
    if (!isLaunch) await value.share();
  }

  @Deprecated('Use ext.share instead')
  Future<void> share() async {
    if (Platform.isIOS) {
      final isAppIpad = await DeviceUtility.instance.isIpad();
      if (isAppIpad) {
        await Share.share(
          this ?? '',
          sharePositionOrigin: DeviceUtility.instance.ipadPaddingBottom,
        );
      }
    }

    await Share.share(this ?? '');
  }

  @Deprecated('Use ext.appName instead')
  String get appName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.appName;
    }
  }

  @Deprecated('Use ext.phoneFormatValue instead')
  String get phoneFormatValue =>
      InputFormatter.instance.phoneFormatter.unmaskText(this ?? '');

  @Deprecated('Use ext.packageName instead')
  String get packageName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.packageName;
    }
  }

  @Deprecated('Use ext.version instead')
  String get version {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.version;
    }
  }

  @Deprecated('Use ext.buildNumber instead')
  String get buildNumber {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.buildNumber;
    }
  }

  @Deprecated('Use ext.deviceId instead')
  Future<String> get deviceId async {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.getUniqueDeviceId();
    }
  }
}
