// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:kartal/src/constants/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A utility class for device-related operations and information.
final class DeviceUtility {
  DeviceUtility._init();

  static DeviceUtility? _instance;

  /// Returns the singleton instance of [DeviceUtility].
  static DeviceUtility get instance {
    _instance ??= DeviceUtility._init();
    return _instance!;
  }

  PackageInfo? packageInfo;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  late IosDeviceInfo info;

  /// The padding bottom area for iPad devices.
  final Rect ipadPaddingBottom = const Rect.fromLTWH(30, 50, 30, 50);

  /// Checks if the current device is an iPad.
  Future<bool> isIpad() async {
    info = await deviceInfo.iosInfo;
    return info.name.toLowerCase().contains(KartalAppConstants.IPAD_TYPE);
  }

  /// Generates a mailto link with the given [title] and [body] for sharing via email.
  String shareMailText(String title, String body) =>
      "mailto:?subject='$title'&body=$body ";

  /// Initializes the package information.
  Future<void> initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  /// Retrieves the unique device ID for the current device.
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
