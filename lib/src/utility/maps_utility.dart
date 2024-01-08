import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher_string.dart';

typedef LaunchUrlCallBack = Future<bool> Function(
  String urlString, {
  LaunchMode mode,
  WebViewConfiguration webViewConfiguration,
  String? webOnlyWindowName,
});

final class MapsUtility {
  const MapsUtility._();

  /// The function opens Apple Maps with a specified query.
  ///
  /// Args:
  ///   query (String): A string representing the location or
  ///   address you want to search for in Apple Maps.
  static Future<bool> openAppleMapsWithQuery(
    String query, {
    LaunchUrlCallBack? callBack,
  }) async {
    final appleMapsWithQuery =
        '${KartalAppConstants.APPLE_MAPS_DEEP_URL}$query';

    try {
      return callBack?.call(appleMapsWithQuery) ??
          launchUrlString(appleMapsWithQuery);
    } catch (error) {
      CustomLogger.showError<MapsUtility>(error);

      return false;
    }
  }

  /// The function opens Google Maps with a specified query.
  ///
  /// Args:
  ///   query (String): A string representing the search query
  /// to be used in Google Maps.
  static Future<bool> openGoogleMapsWithQuery(
    String query, {
    LaunchUrlCallBack? callBack,
  }) async {
    final googleMapsWithQuery =
        '${KartalAppConstants.GOOGLE_MAPS_DEEP_URL}$query';

    try {
      return callBack?.call(googleMapsWithQuery) ??
          launchUrlString(googleMapsWithQuery);
    } catch (error) {
      CustomLogger.showError<MapsUtility>(error);
      return false;
    }
  }

  /// The function opens Google Web Maps with a specified query.
  ///
  /// Args:
  ///   query (String): A string representing the search query to be used in
  /// Google Maps.
  static Future<bool> openGoogleWebMapsWithQuery(String query) async {
    final googleMapsWithQuery =
        '${KartalAppConstants.GOOGLE_MAPS_WEB_LINK}$query';

    try {
      return launchUrlString(googleMapsWithQuery);
    } catch (error) {
      CustomLogger.showError<MapsUtility>(error);
      return false;
    }
  }
}
