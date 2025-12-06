@TestOn('browser')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/src/private/platform/web_platform.dart';
import 'package:web/web.dart';

void main() {
  group('WebPlatform', () {
    late WebPlatform webPlatform;

    setUp(() {
      webPlatform = WebPlatform();
    });

    test('isIOS returns false', () {
      expect(webPlatform.isIOS, isFalse);
    });

    test('isAndroid returns false', () {
      expect(webPlatform.isAndroid, isFalse);
    });

    test('isLinux returns false', () {
      expect(webPlatform.isLinux, isFalse);
    });

    test('isMacOS returns false', () {
      expect(webPlatform.isMacOS, isFalse);
    });

    test('isWindows returns false', () {
      expect(webPlatform.isWindows, isFalse);
    });

    test('appName returns navigator.appName', () {
      expect(webPlatform.appName, window.navigator.appName);
    });

    test('buildNumber returns navigator.appCodeName', () {
      expect(webPlatform.buildNumber, window.navigator.appCodeName);
    });

    test('deviceId returns navigator.userAgent', () async {
      expect(await webPlatform.deviceId, window.navigator.userAgent);
    });

    test('packageName returns navigator.appCodeName', () {
      expect(webPlatform.packageName, window.navigator.appCodeName);
    });

    test('version returns navigator.appVersion', () {
      expect(webPlatform.version, window.navigator.appVersion);
    });
  });
}
