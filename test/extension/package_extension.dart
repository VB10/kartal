import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/package_info');
  late List<MethodCall> log;

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    log.add(methodCall);
    switch (methodCall.method) {
      case 'getAll':
        return <String, dynamic>{
          'appName': 'package_info_example',
          'buildNumber': '1',
          'packageName': 'io.flutter.plugins.packageinfoexample',
          'version': '1.0',
        };
      default:
        assert(false);
        return null;
    }
  });
  setUp(() async {
    log = <MethodCall>[];
    await DeviceUtility.instance.initPackageInfo();
  });

  test('Get Device Package', () {
    // var fifteenLiras = '15';

    expect(''.appName, isNotNull);
  });
}
