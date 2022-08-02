// ignore_for_file: prefer_constructors_over_static_methods

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:kartal/src/constants/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtility {
  DeviceUtility._init();
  static DeviceUtility? _instance;
  static DeviceUtility get instance {
    if (_instance != null) {
      return _instance!;
    }
    _instance = DeviceUtility._init();
    return _instance!;
  }

  PackageInfo? packageInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  late IosDeviceInfo info;
  final Rect ipadPaddingBottom = const Rect.fromLTWH(30, 50, 30, 50);

  Future<bool> isIpad() async {
    info = await deviceInfo.iosInfo;
    return info.name.toLowerCase().contains(KartalAppConstants.IPAD_TYPE);
  }

  String shareMailText(String title, String body) {
    return "mailto:?subject='$title'&body=$body ";
  }

  Future<void> initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
