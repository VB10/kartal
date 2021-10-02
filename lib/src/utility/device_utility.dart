import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants/app_constants.dart';

class DeviceUtility {
  static DeviceUtility? _instace;
  static DeviceUtility get instance {
    if (_instace != null) {
      return _instace!;
    }
    _instace = DeviceUtility._init();
    return _instace!;
  }

  PackageInfo? packageInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  late IosDeviceInfo info;
  final Rect ipadPaddingBottom = const Rect.fromLTWH(30, 50, 30, 50);
  DeviceUtility._init();

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
