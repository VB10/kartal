import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:kartal/src/constants/app_constants.dart';
import 'package:kartal/src/constants/input_formatter_constants.dart';
import 'package:kartal/src/constants/regex_constants.dart';
import 'package:kartal/src/exception/package_info_exception.dart';
import 'package:kartal/src/utility/device_utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension StringCommonExtension on String? {
  int get lineLength => '\n'.allMatches(this ?? '').length + 1;
}

extension StringColorExtension on String {
  Color get color => Color(int.parse('0xff$this'));
}

extension StringConverterExtension on String? {
  String toCapitalized() {
    final condition = this != null && this!.isNotEmpty;
    final firstIndexUpperCased = this![0].toUpperCase();
    final restOfTheString = this!.substring(1).toLowerCase();
    return condition ? firstIndexUpperCased + restOfTheString : '';
  }

  String toTitleCase() {
    return this != null
        ? this!
            .replaceAll(
              RegExp(' +'),
              ' ',
            )
            .split(' ')
            .map((str) => str.toCapitalized())
            .join(' ')
        : '';
  }
}

extension StringValidatorExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrNoEmpty => this != null && this!.isNotEmpty;

  bool get isValidEmail {
    if (!isNotNullOrNoEmpty) return false;
    return RegExp(
      RegexConstants.instance().emailRegex,
    ).hasMatch(this!);
  }

  bool get isValidPassword {
    if (this == null) return false;
    return RegExp(
      RegexConstants.instance().passwordRegex,
    ).hasMatch(this!);
  }

  String? get withoutSpecialCharacters {
    return isNullOrEmpty ? this : removeDiacritics(this!);
  }
}

extension AuthorizationExtension on String {
  Map<String, dynamic> get bearer => {'Authorization': 'Bearer $this'};
}

extension LaunchExtension on String {
  Future<bool> get launchEmail => launchUrlString('mailto:$this');
  Future<bool> get launchPhone => launchUrlString('tel:$this');
  Future<bool> get launchWebsite => launchUrlString(this);

  Future<bool> launchWebsiteCustom({
    bool enableJavaScript = false,
    bool enableDomStorage = false,
    Map<String, String> headers = const <String, String>{},
    String? webOnlyWindowName,
    LaunchMode mode = LaunchMode.platformDefault,
  }) =>
      launchUrlString(
        this,
        webViewConfiguration: WebViewConfiguration(
          enableDomStorage: enableDomStorage,
          enableJavaScript: enableJavaScript,
          headers: headers,
        ),
        mode: mode,
        webOnlyWindowName: webOnlyWindowName,
      );
}

extension ShareText on String {
  Future<void> shareWhatsApp() async {
    try {
      final isLaunch = await launch(
        '${KartalAppConstants.WHATS_APP_PREFIX}$this',
      );
      if (!isLaunch) await share();
    } catch (e) {
      await share();
    }
  }

  Future<void> shareMail(String title) async {
    final value = DeviceUtility.instance.shareMailText(title, this);
    final isLaunch = await launchUrlString(Uri.encodeFull(value));
    if (!isLaunch) await value.share();
  }

  Future<void> share() async {
    if (Platform.isIOS) {
      final isAppIpad = await DeviceUtility.instance.isIpad();
      if (isAppIpad) {
        await Share.share(
          this,
          sharePositionOrigin: DeviceUtility.instance.ipadPaddingBottom,
        );
      }
    }

    await Share.share(this);
  }
}

extension FormatterExtension on String {
  String get phoneFormatValue {
    return InputFormatter.instance().phoneFormatter.unmaskText(this);
  }

  String get timeFormatValue {
    return InputFormatter.instance().timeFormatter.unmaskText(this);
  }

  String get timeOverlineFormatValue {
    return InputFormatter.instance().timeFormatterOverLine.unmaskText(this);
  }
}

extension PackageInfoExtension on String {
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
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.getUniqueDeviceId();
    }
  }
}

extension NetworkImageExtension on String {
  String get randomImage => 'https://picsum.photos/200/300';
  String get randomSquareImage => 'https://picsum.photos/200';

  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';
  String get customHighProfileImage =>
      'https://www.gravatar.com/avatar/?d=mp&s=200';
}

extension ColorPaletteExtension on String {
  int? get colorCode => int.tryParse('0xFF$this');
  Color get toColor => Color(colorCode ?? 0xFFFFFFFF);
}
