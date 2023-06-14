import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    PackageInfo.setMockInitialValues(
      appName: 'vb10',
      packageName: 'io.flutter.plugins.mockpackageinfoexample',
      version: '1.1',
      buildNumber: '2',
      buildSignature: 'deadbeef',
    );
    await DeviceUtility.instance.initPackageInfo();
  });

  test('Get Device Package', () {
    expect(''.ext.appName, 'vb10');
  });
}
