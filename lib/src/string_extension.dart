import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants/app_constants.dart';
import 'constants/regex_constants.dart';
import 'utility/device_utility.dart';

extension StringExtension on String {
  String get tlMoney => "$this TL";
}

extension StringColorExtension on String {
  Color get color => Color(int.parse("0xff$this"));
}

extension StringValidatorExtension on String {
  bool get isNullOrEmpty => this == null || this.isEmpty;
  bool get isNotNullOrNoEmpty => !isNullOrEmpty;

  bool get isValidEmail => RegExp(RegexConstans.instance.emailRegex).hasMatch(this);
}

extension AuthorizationExtension on String {
  Map<String, dynamic> get beraer => {"Authorization": "Bearer ${this}"};
}

extension LaunchExtension on String {
  get launchEmail => launch("mailto:$this");
  get launchPhone => launch("tel:$this");
  get launchWebsite => launch("$this");
}

extension ShareText on String {
  Future<void> shareWhatsApp() async {
    try {
      final isLaunch = await launch("${KartalAppConstants.WHATS_APP_PREFIX}$this");
      if (!isLaunch) share();
    } catch (e) {
      share();
    }
  }

  ///

  Future<void> shareMail(String title) async {
    final value = DeviceUtility.instance.shareMailText(title, this);
    final isLaunch = await launch(Uri.encodeFull(value));
    if (!isLaunch) value.share();
  }

  Future<void> share() async {
    if (Platform.isIOS) {
      final isAppIpad = await DeviceUtility.instance.isIpad();
      if (isAppIpad) Share.share(this, sharePositionOrigin: DeviceUtility.instance.ipadPaddingBottom);
    }

    Share.share(this);
  }
}
