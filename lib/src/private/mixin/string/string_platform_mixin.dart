import 'package:kartal/kartal.dart';

/// It provides platform-specific functionalities for [String].
mixin StringPlatformMixin {
  String? get value;

  /// Application name from CustomPlatform
  String get appName => CustomPlatform.instance.appName;

  /// Application package name from CustomPlatform
  String get packageName => CustomPlatform.instance.packageName;

  /// Application version from CustomPlatform
  String get version => CustomPlatform.instance.version;

  /// Application build number from CustomPlatform
  String get buildNumber => CustomPlatform.instance.buildNumber;

  /// Application device id from CustomPlatform
  Future<String> get deviceId async =>
      (await CustomPlatform.instance.deviceId) ?? '';
}
