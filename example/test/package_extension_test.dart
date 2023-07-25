import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/package_info');
  late List<MethodCall> log;

  setUp(() async {
    log = <MethodCall>[];
    await DeviceUtility.instance.initPackageInfo();
    const iosUtsnameMap = <String, dynamic>{
      'release': 'release',
      'version': 'version',
      'machine': 'machine',
      'sysname': 'sysname',
      'nodename': 'nodename',
    };
    const iosDeviceInfoMap = <String, dynamic>{
      'name': 'name',
      'model': 'model',
      'utsname': iosUtsnameMap,
      'systemName': 'systemName',
      'isPhysicalDevice': 'true',
      'systemVersion': 'systemVersion',
      'localizedModel': 'localizedModel',
      'identifierForVendor': 'identifierForVendor',
    };
  });

  test('Get Device Package', () {
    // final iosDeviceInfo = IosDeviceInfo.fromMap(iosDeviceInfoMap);

    expect(''.appName, isNotNull);
    expect(''.packageName, isNotNull);
    expect(''.version, isNotNull);
    expect(''.buildNumber, isNotNull);
  });
}
