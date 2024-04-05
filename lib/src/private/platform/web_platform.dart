import 'dart:html';

import 'package:kartal/src/private/platform/custom_platform.dart';

CustomPlatform get instance => WebPlatform();

final class WebPlatform implements CustomPlatform {
  @override
  bool get isIOS => false;

  @override
  String get appName => window.navigator.appName;

  @override
  String get buildNumber => window.navigator.appCodeName;

  @override
  Future<String> get deviceId async => window.navigator.userAgent;

  @override
  String get packageName => window.navigator.appCodeName;

  @override
  Future<void> share(String? value) => throw UnimplementedError();

  @override
  Future<void> shareMail(String title, String? value) =>
      throw UnimplementedError();

  @override
  Future<void> shareWhatsApp(String? value) => throw UnimplementedError();

  @override
  String get version => window.navigator.appVersion;

  /// TODO: fix it for web platform by checking the user agent
  @override
  bool get isAndroid => false;

  @override
  bool get isLinux => false;

  @override
  bool get isMacOS => false;

  @override
  bool get isWindows => false;
}
