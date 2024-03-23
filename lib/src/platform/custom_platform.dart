import 'package:kartal/src/platform/app_platform.dart'
    if (dart.library.html) 'package:kartal/src/platform/web_platform.dart'
    as platform;

abstract class CustomPlatform {
  Future<String>? get deviceId;
  String get buildNumber;
  String get version;
  String get packageName;
  String get appName;

  bool get isIOS;
  bool get isAndroid;
  bool get isWindows;
  bool get isLinux;
  bool get isMacOS;

  Future<void> share(String? value);
  Future<void> shareMail(String title, String? value);
  Future<void> shareWhatsApp(String? value);

  static CustomPlatform get instance => platform.instance;
}
