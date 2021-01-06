import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final channel = MethodChannel('plugins.flutter.io/package_info');
  List<MethodCall> log;

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
    expect(''.appName, isNotNull);
    expect(''.packageName, isNotNull);
    expect(''.version, isNotNull);
    expect(''.buildNumber, isNotNull);
  });
}
