import 'dart:html';

import 'package:kartal/src/utility/device_utility.dart';

DeviceUtils get instance => DeviceUtilsWeb();

final class DeviceUtilsWeb extends DeviceUtils {
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
