import 'package:kartal/src/utility/device_utility.dart';
import 'package:web/web.dart';

DeviceUtils get instance => DeviceUtilsWeb._instance;

final class DeviceUtilsWeb extends DeviceUtils {
  DeviceUtilsWeb._init();

  static final DeviceUtilsWeb _instance = DeviceUtilsWeb._init();
  @override
  Future<String> getUniqueDeviceId() =>
      Future.value(window.navigator.userAgent);

  @override
  Future<void> initPackageInfo() async {}

  @override
  Future<bool> isIpad() => Future.value(false);

  @override
  String shareMailText(String title, String body) => '$title\n$body';
}
