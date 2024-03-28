import 'dart:html';

import 'package:kartal/src/utility/device_utility.dart';

DeviceUtils get instance => DeviceUtilsWeb._instance;

final class DeviceUtilsWeb extends DeviceUtils {
  DeviceUtilsWeb._init();

  static final DeviceUtilsWeb _instance = DeviceUtilsWeb._init();
  @override
  Future<String> getUniqueDeviceId() =>
      Future.value(window.navigator.appCodeName);

  @override
  Future<void> initPackageInfo() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isIpad() => Future.value(false);

  @override
  String shareMailText(String title, String body) {
    throw UnimplementedError('This method is not implemented for web.');
  }
}
