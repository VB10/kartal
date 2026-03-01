import 'package:web/web.dart' as web;

import 'package:kartal/src/private/platform/custom_platform.dart';

CustomPlatform get instance => WebPlatform();

final class WebPlatform implements CustomPlatform {
  @override
  bool get isIOS => false;

  @override
  String get appName => web.window.navigator.appName;

  @override
  String get buildNumber => web.window.navigator.appCodeName;

  @override
  Future<String> get deviceId async => web.window.navigator.userAgent;

  @override
  String get packageName => web.window.navigator.appCodeName;

  @override
  Future<void> share(String? value) => throw UnimplementedError();

  @override
  Future<void> shareMail(String title, String? value) =>
      throw UnimplementedError();

  @override
  Future<void> shareWhatsApp(String? value) => throw UnimplementedError();

  @override
  String get version => web.window.navigator.appVersion;

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
