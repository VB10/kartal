import 'package:flutter/foundation.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/utility/core/custom_logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

typedef LaunchUrlCallBack = Future<bool> Function(
  String urlString, {
  LaunchMode mode,
  WebViewConfiguration webViewConfiguration,
  String? webOnlyWindowName,
});

mixin MapsUtility {
  /// The function opens Apple Maps with a specified query.
  ///
  /// Args:
  ///   query (String): A string representing the location or address you want to search for in Apple Maps.
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
      CustomLogger.error<MapsUtility>(error);

      return false;
    }
  }

  /// The function opens Google Maps with a specified query.
  ///
  /// Args:
  ///   query (String): A string representing the search query to be used in Google Maps.
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
      CustomLogger.error<MapsUtility>(error);
      return false;
    }
  }

  /// The function opens Google Web Maps with a specified query.
  ///
  /// Args:
  ///   query (String): A string representing the search query to be used in Google Maps.
  static Future<bool> openGoogleWebMapsWithQuery(String query) async {
    final googleMapsWithQuery =
        '${KartalAppConstants.GOOGLE_MAPS_WEB_LINK}$query';

    try {
      return launchUrlString(googleMapsWithQuery);
    } catch (error) {
      CustomLogger.error<MapsUtility>(error);
      return false;
    }
  }
}
