import 'package:kartal/kartal.dart';
import 'package:kartal/src/utility/maps_utility.dart';
import 'package:url_launcher/url_launcher_string.dart';

mixin StringShareMixin {
  String? get value;

  ///
  /// The function will launch to relaeted maps for your in device
  /// When try to launch in apple it will open AppleMaps or Gogle maps web link if catch any problem.
  /// When try to launch in android it will open GoogleMaps or Gogle maps web link if catch any problem.
  ///
  Future<bool> launchMaps({
    LaunchUrlCallBack? callBack,
  }) async {
    if (value == null) return false;
    final query = value!;
    if (query.ext.isNullOrEmpty) return false;

    final encodedQuery = Uri.encodeComponent(query);

    var result = false;

    if (CustomPlatform.instance.isIOS) {
      result = await MapsUtility.openAppleMapsWithQuery(
        encodedQuery,
        callBack: callBack,
      );
    } else {
      result = await MapsUtility.openGoogleMapsWithQuery(
        encodedQuery,
        callBack: callBack,
      );
    }

    if (result) return true;
    return MapsUtility.openGoogleWebMapsWithQuery(encodedQuery);
  }

  /// Launches the email app with this email address.
  Future<bool> get launchEmail => launchUrlString('mailto:$value');
  // Launch the phone application with the given number.
  Future<bool> get launchPhone => launchUrlString('tel:$value');

  /// Returns whether or not the user can launch the website.
  Future<bool> get launchWebsite {
    if (value == null) return Future.value(false);
    return launchUrlString(value!);
  }

  /// Returns whether or not the user can launch the website.
  Future<bool> launchWebsiteCustom({
    bool enableJavaScript = false,
    bool enableDomStorage = false,
    Map<String, String> headers = const <String, String>{},
    String? webOnlyWindowName,
    LaunchMode mode = LaunchMode.platformDefault,
  }) {
    if (value == null) return Future.value(false);
    return launchUrlString(
      value!,
      webViewConfiguration: WebViewConfiguration(
        enableDomStorage: enableDomStorage,
        enableJavaScript: enableJavaScript,
        headers: headers,
      ),
      mode: mode,
      webOnlyWindowName: webOnlyWindowName,
    );
  }

  /// Share your value with WhatsApp
  Future<void> shareWhatsApp() async =>
      CustomPlatform.instance.shareWhatsApp(value);

  /// Share your value with Mail
  Future<void> shareMail(String title) async =>
      CustomPlatform.instance.shareMail(title, value);

  /// Share your value  General
  Future<void> share() async => CustomPlatform.instance.share(value);
}
