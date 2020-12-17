import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class DeviceUtility {
  static DeviceUtility _instace;
  static DeviceUtility get instance {
    if (_instace == null) _instace = DeviceUtility._init();
    return _instace;
  }

  final Rect ipadPaddingBottom = Rect.fromLTWH(30, 50, 30, 50);
  DeviceUtility._init();

  Future<bool> isIpad() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    return info.name.toLowerCase().contains(KartalAppConstants.IPAD_TYPE);
  }

  String shareMailText(String title, String body) {
    return "mailto:?subject='$title'&body=$body ";
  }
}
