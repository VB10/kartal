import 'dart:io' as io;

import 'package:kartal/kartal.dart';
import 'package:kartal/src/exception/package_info_exception.dart';
import 'package:kartal/src/platform/platform.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

Platform get instance => AppPlatform();

final class AppPlatform implements Platform {
  @override
  bool get isIOS => io.Platform.isIOS;

  @override
  String get appName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.appName;
    }
  }

  @override
  String get packageName {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.packageName;
    }
  }

  @override
  String get version {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.version;
    }
  }

  @override
  String get buildNumber {
    if (DeviceUtility.instance.packageInfo == null) {
      throw PackageInfoNotFound();
    } else {
      return DeviceUtility.instance.packageInfo!.buildNumber;
    }
  }

  @override
  Future<String> get deviceId async {
    {
      if (DeviceUtility.instance.packageInfo == null) {
        throw PackageInfoNotFound();
      } else {
        return DeviceUtility.instance.getUniqueDeviceId();
      }
    }
  }

  @override
  Future<void> shareWhatsApp(String? value) async {
    try {
      final isLaunch = await launchUrlString(
        '${KartalAppConstants.WHATS_APP_PREFIX}$value',
      );
      if (!isLaunch) await share(value);
    } catch (e) {
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
      final isAppIpad = await DeviceUtility.instance.isIpad();
      if (isAppIpad) {
        await Share.share(
          value ?? '',
          sharePositionOrigin: DeviceUtility.instance.ipadPaddingBottom,
        );
      }
    }

    await Share.share(value ?? '');
  }
}
