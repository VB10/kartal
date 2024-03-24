import 'package:kartal/src/platform/app_platform.dart'
    if (dart.library.html) 'package:kartal/src/platform/web_platform.dart'
    as platform;

/// Represents the platform-specific implementation of the [CustomPlatform] interface.
abstract class CustomPlatform {
  /// Returns the unique device ID.
  Future<String>? get deviceId;

  /// Returns the build number of the application.
  String get buildNumber;

  /// Returns the version of the application.
  String get version;

  /// Returns the package name of the application.
  String get packageName;

  /// Returns the name of the application.
  String get appName;

  /// Returns `true` if the platform is iOS.
  bool get isIOS;

  /// Returns `true` if the platform is Android.
  bool get isAndroid;

  /// Returns `true` if the platform is Windows.
  bool get isWindows;

  /// Returns `true` if the platform is Linux.
  bool get isLinux;

  /// Returns `true` if the platform is macOS.
  bool get isMacOS;

  /// Shares the given value.
  Future<void> share(String? value);

  /// Shares the given value via email.
  Future<void> shareMail(String title, String? value);

  /// Shares the given value via WhatsApp.
  Future<void> shareWhatsApp(String? value);

  /// Returns the instance of the platform.
  static CustomPlatform get instance => platform.instance;
}
