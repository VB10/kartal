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
  String toCapitalized() => (this != null && this!.isNotEmpty)
      ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
      : '';
  String toTitleCase() => this != null
      ? this!
          .replaceAll(RegExp(' +'), ' ')
          .split(' ')
          .map((str) => str.toCapitalized())
          .join(' ')
      : '';
}

extension StringValidatorExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrNoEmpty => this != null && this!.isNotEmpty;

  // ignore: avoid_bool_literals_in_conditional_expressions
  bool get isValidEmail => isNotNullOrNoEmpty
      ? RegExp(RegexConstants.instance.emailRegex).hasMatch(this!)
      : false;

  // ignore: avoid_bool_literals_in_conditional_expressions
  bool get isValidPassword => isNotNullOrNoEmpty
      ? RegExp(RegexConstants.instance.passwordRegex).hasMatch(this!)
      : false;

  String? get withoutSpecialCharacters {
    return isNullOrEmpty ? this : removeDiacritics(this!);
  }
}

extension AuthorizationExtension on String {
  Map<String, dynamic> get bearer => {'Authorization': 'Bearer ${this}'};
}

extension LaunchExtension on String {
  Future<bool> get launchEmail => launchUrlString('mailto:$this');
  Future<bool> get launchPhone => launchUrlString('tel:$this');
  Future<bool> get launchWebsite => launchUrlString(this);

  Future<bool> launchWebsiteCustom({
    bool? forceSafariVC,
    bool forceWebView = false,
    bool enableJavaScript = false,
    bool enableDomStorage = false,
    bool universalLinksOnly = false,
    Map<String, String> headers = const <String, String>{},
    Brightness? statusBarBrightness,
    String? webOnlyWindowName,
  }) =>
      launch(
        this,
        forceSafariVC: forceSafariVC,
        forceWebView: forceWebView,
        enableDomStorage: enableDomStorage,
        enableJavaScript: enableJavaScript,
        universalLinksOnly: universalLinksOnly,
        headers: headers,
        statusBarBrightness: statusBarBrightness,
        webOnlyWindowName: webOnlyWindowName,
      );
}

extension ShareText on String {
  Future<void> shareWhatsApp() async {
    try {
      final isLaunch =
          await launchUrlString('${KartalAppConstants.WHATS_APP_PREFIX}$this');
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
  String get phoneFormatValue =>
      InputFormatter.instance.phoneFormatter.unmaskText(this);
  String get timeFormatValue =>
      InputFormatter.instance.timeFormatter.unmaskText(this);
  String get timeOverlineFormatValue =>
      InputFormatter.instance.timeFormatterOverLine.unmaskText(this);
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

extension NumberParsing on String {
  int get parseInt => int.parse(this);

  int? get tryParseInt => int.tryParse(this);

  double get parseDouble => double.parse(this);

  double? get tryParseDouble => double.tryParse(this);
}

extension StringExtensions on String {
  String get firstWord {
    final wordList = split('');
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }
}
