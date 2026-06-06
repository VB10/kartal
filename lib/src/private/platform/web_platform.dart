import 'package:kartal/kartal.dart';
import 'package:kartal/src/private/platform/custom_platform.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web/web.dart';

CustomPlatform get instance => WebPlatform();

final class WebPlatform implements CustomPlatform {
  @override
  bool get isIOS => false;

  @override
  String get appName => window.navigator.appName;

  @override
  String get buildNumber => window.navigator.appCodeName;

  @override
  Future<String> get deviceId async => window.navigator.userAgent;

  @override
  String get packageName => window.navigator.appCodeName;

  @override
  Future<void> share(String? value) async {
    if (value == null) return;
    window.navigator.clipboard.writeText(value);
  }

  @override
  Future<void> shareMail(String title, String? value) async {
    final mailBodyText = '$title\n${value ?? ''}';
    await launchUrlString(
      Uri.encodeFull('mailto:?body=${Uri.encodeComponent(mailBodyText)}'),
    );
  }

  @override
  Future<void> shareWhatsApp(String? value) async {
    if (value == null) return;
    await launchUrlString(
      'https://wa.me/?text=${Uri.encodeComponent(value)}',
    );
  }

  @override
  String get version => window.navigator.appVersion;

  @override
  bool get isAndroid =>
      window.navigator.userAgent.toLowerCase().contains('android');

  @override
  bool get isLinux => false;

  @override
  bool get isMacOS => false;

  @override
  bool get isWindows => false;
}
