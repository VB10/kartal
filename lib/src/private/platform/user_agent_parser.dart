/// Derives the host operating system from a browser user agent string.
///
/// This lives in a platform-agnostic file on purpose: it holds the only real
/// logic in the web platform implementation, and keeping it free of
/// `package:web` imports means it can be unit tested on the Dart VM.
enum UserAgentPlatform {
  /// iOS, iPadOS, or any other iPhone/iPad/iPod browser.
  ios,

  /// Android.
  android,

  /// macOS.
  macOS,

  /// Windows.
  windows,

  /// Linux, excluding Android.
  linux,

  /// Anything that did not match a known platform.
  unknown
  ;

  /// Classifies [userAgent].
  ///
  /// Order matters here because real user agents overlap:
  /// * Android reports `Linux` in its platform token, so Android is matched
  ///   before Linux.
  /// * iOS reports `like Mac OS X`, so iOS is matched before macOS.
  static UserAgentPlatform from(String? userAgent) {
    if (userAgent == null || userAgent.isEmpty) return unknown;

    final agent = userAgent.toLowerCase();

    if (agent.contains('iphone') ||
        agent.contains('ipad') ||
        agent.contains('ipod')) {
      return ios;
    }
    if (agent.contains('android')) return android;
    if (agent.contains('mac os') || agent.contains('macintosh')) return macOS;
    if (agent.contains('windows') || agent.contains('win32')) return windows;
    if (agent.contains('linux') || agent.contains('x11')) return linux;

    return unknown;
  }
}
