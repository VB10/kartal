import 'dart:io' as io;

import 'package:kartal/kartal.dart';
import 'package:kartal/src/exception/package_info_exception.dart';
import 'package:kartal/src/utility/device/device_utils_io.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// The `AppPlatform` class is used to provide platform-specific implementations of the [CustomPlatform] interface.
CustomPlatform get instance => AppPlatform();

/// Represents the platform-specific implementation of the [CustomPlatform] interface.
final class AppPlatform implements CustomPlatform {
  @override
  bool get isIOS => io.Platform.isIOS;

  DeviceUtilsIO get _deviceUtils =>
      DeviceUtility.instance.deviceUtils as DeviceUtilsIO;

  PackageInfo get _packageInfo {
    if (_deviceUtils.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return _deviceUtils.packageInfo!;
    }
  }

  @override
  String get appName => _packageInfo.appName;

  @override
  String get packageName => _packageInfo.packageName;

  @override
  String get version => _packageInfo.version;

  @override
  String get buildNumber => _packageInfo.buildNumber;

  @override
  Future<String> get deviceId async => _deviceUtils.getUniqueDeviceId();

  @override
  Future<void> shareWhatsApp(String? value) async {
    try {
      final isLaunch = await launchUrlString(
        '${KartalAppConstants.WHATS_APP_PREFIX}$value',
      );
      if (!isLaunch) await share(value);
    } on Exception {
      await share(value);
    }
  }

  @override
  Future<void> shareMail(String title, String? value) async {
    final mailBodyText =
        DeviceUtility.instance.shareMailText(title, value ?? '');
    final isLaunch = await launchUrlString(Uri.encodeFull(mailBodyText));
    if (!isLaunch) await value?.ext.share();
  }

  @override
  Future<void> share(String? value) async {
    if (io.Platform.isIOS) {
      final isAppIpad = await _deviceUtils.isIpad();
      if (isAppIpad) {
        await Share.share(
          value ?? '',
          sharePositionOrigin: _deviceUtils.ipadPaddingBottom,
        );
      }
    }

    await Share.share(value ?? '');
  }

  @override
  bool get isAndroid => io.Platform.isAndroid;

  @override
  bool get isLinux => io.Platform.isLinux;

  @override
  bool get isMacOS => io.Platform.isMacOS;

  @override
  bool get isWindows => io.Platform.isWindows;
}
