import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Records the URL a launch was attempted with, and controls the outcome.
final class _LaunchRecorder {
  _LaunchRecorder({this.succeeds = true, this.throws = false});

  final bool succeeds;
  final bool throws;
  final List<String> launched = <String>[];

  Future<bool> call(
    String urlString, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) {
    launched.add(urlString);
    if (throws) throw Exception('launch failed');

    return Future.value(succeeds);
  }
}

void main() {
  group('openAppleMapsWithQuery', () {
    test('builds the Apple Maps deep link', () async {
      final recorder = _LaunchRecorder();

      final result = await MapsUtility.openAppleMapsWithQuery(
        'Kartal%20Istanbul',
        callBack: recorder.call,
      );

      expect(result, isTrue);
      expect(recorder.launched.single, 'maps://?q=Kartal%20Istanbul');
      expect(
        recorder.launched.single,
        startsWith(KartalAppConstants.APPLE_MAPS_DEEP_URL),
      );
    });

    test('reports failure when the launch is refused', () async {
      final recorder = _LaunchRecorder(succeeds: false);

      expect(
        await MapsUtility.openAppleMapsWithQuery(
          'somewhere',
          callBack: recorder.call,
        ),
        isFalse,
      );
    });

    test('returns false rather than throwing when launching throws', () async {
      final recorder = _LaunchRecorder(throws: true);

      expect(
        await MapsUtility.openAppleMapsWithQuery(
          'somewhere',
          callBack: recorder.call,
        ),
        isFalse,
      );
    });
  });

  group('openGoogleMapsWithQuery', () {
    test('builds the Google Maps geo link', () async {
      final recorder = _LaunchRecorder();

      final result = await MapsUtility.openGoogleMapsWithQuery(
        'Kartal%20Istanbul',
        callBack: recorder.call,
      );

      expect(result, isTrue);
      expect(recorder.launched.single, 'geo:0,0?q=Kartal%20Istanbul');
      expect(
        recorder.launched.single,
        startsWith(KartalAppConstants.GOOGLE_MAPS_DEEP_URL),
      );
    });

    test('reports failure when the launch is refused', () async {
      final recorder = _LaunchRecorder(succeeds: false);

      expect(
        await MapsUtility.openGoogleMapsWithQuery(
          'somewhere',
          callBack: recorder.call,
        ),
        isFalse,
      );
    });

    test('returns false rather than throwing when launching throws', () async {
      final recorder = _LaunchRecorder(throws: true);

      expect(
        await MapsUtility.openGoogleMapsWithQuery(
          'somewhere',
          callBack: recorder.call,
        ),
        isFalse,
      );
    });
  });

  group('constants', () {
    test('the deep link prefixes are the documented ones', () {
      expect(KartalAppConstants.APPLE_MAPS_DEEP_URL, 'maps://?q=');
      expect(KartalAppConstants.GOOGLE_MAPS_DEEP_URL, 'geo:0,0?q=');
      expect(
        KartalAppConstants.GOOGLE_MAPS_WEB_LINK,
        'https://www.google.com/maps/search/?api=1&query=',
      );
      expect(KartalAppConstants.WHATS_APP_PREFIX, 'whatsapp://send?text=');
      expect(KartalAppConstants.IPAD_TYPE, 'ipad');
    });
  });
}
