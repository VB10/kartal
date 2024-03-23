import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:kartal/kartal.dart';
import 'package:package_info_plus/package_info_plus.dart';

DeviceUtils get instance => DeviceUtilsIO();

final class DeviceUtilsIO extends DeviceUtils {
  PackageInfo? packageInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  late IosDeviceInfo info;

  /// The padding bottom area for iPad devices.
  final Rect ipadPaddingBottom = const Rect.fromLTWH(30, 50, 30, 50);

  /// Checks if the current device is an iPad.
  @override
  Future<bool> isIpad() async {
    info = await deviceInfo.iosInfo;
    return info.name.toLowerCase().contains(KartalAppConstants.IPAD_TYPE);
  }

  /// Generates a mailto link with the given [title] and [body] for sharing via email.
  @override
  String shareMailText(String title, String body) =>
      "mailto:?subject='$title'&body=$body ";

  /// Initializes the package information.
  @override
  Future<void> initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  /// Retrieves the unique device ID for the current device.
  @override
  Future<String> getUniqueDeviceId() async {
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    } else {
      throw Exception('That platform is not supported.');
    }
  }
}
