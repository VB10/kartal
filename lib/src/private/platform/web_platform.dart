import 'package:kartal/src/private/platform/custom_platform.dart';
import 'package:kartal/src/private/platform/user_agent_parser.dart';
import 'package:web/web.dart' as web;

CustomPlatform get instance => WebPlatform();

final class WebPlatform implements CustomPlatform {
  UserAgentPlatform get _platform =>
      UserAgentPlatform.from(web.window.navigator.userAgent);

  @override
  bool get isIOS => _platform == UserAgentPlatform.ios;

  @override
  String get appName => web.window.navigator.appName;

  @override
  String get buildNumber => web.window.navigator.appCodeName;

  @override
  Future<String> get deviceId async => web.window.navigator.userAgent;

  @override
  String get packageName => web.window.navigator.appCodeName;

  @override
  Future<void> share(String? value) => throw UnimplementedError();

  @override
  Future<void> shareMail(String title, String? value) =>
      throw UnimplementedError();

  @override
  Future<void> shareWhatsApp(String? value) => throw UnimplementedError();

  @override
  String get version => web.window.navigator.appVersion;

  @override
  bool get isAndroid => _platform == UserAgentPlatform.android;

  @override
  bool get isLinux => _platform == UserAgentPlatform.linux;

  @override
  bool get isMacOS => _platform == UserAgentPlatform.macOS;

  @override
  bool get isWindows => _platform == UserAgentPlatform.windows;
}
