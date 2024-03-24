import 'package:kartal/src/utility/device/device_utils_io.dart'
    if (dart.library.html) 'package:kartal/src/utility/device/device_utils_web.dart'
    as device_utils;

abstract class DeviceUtils {
  Future<String> getUniqueDeviceId();
  Future<void> initPackageInfo();
  Future<bool> isIpad();
  String shareMailText(String title, String body);
}

/// A utility class for device-related operations and information.
final class DeviceUtility {
  DeviceUtility._init();

  static DeviceUtility? _instance;

  /// Returns the singleton instance of [DeviceUtility].
  static DeviceUtility get instance {
    _instance ??= DeviceUtility._init();
    return _instance!;
  }

  /// There is device general utils for each platform
  DeviceUtils get deviceUtils => device_utils.instance;

  /// Checks if the current device is an iPad.
  Future<bool> isIpad() => device_utils.instance.isIpad();

  /// Generates a mailto link with the given [title] and [body] for sharing via email.
  String shareMailText(String title, String body) =>
      device_utils.instance.shareMailText(title, body);

  /// Initializes the package information.
  Future<void> initPackageInfo() => device_utils.instance.initPackageInfo();

  /// Retrieves the unique device ID for the current device.
  Future<String> getUniqueDeviceId() =>
      device_utils.instance.getUniqueDeviceId();
}
