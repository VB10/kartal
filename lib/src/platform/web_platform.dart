import 'dart:html';

import 'package:kartal/src/platform/platform.dart';

Platform get instance => WebPlatform();

final class WebPlatform implements Platform {
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
}
