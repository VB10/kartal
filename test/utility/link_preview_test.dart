import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

/// A [Dio] whose adapter returns canned responses.
///
/// These tests previously issued real HTTP requests to a third party site,
/// which made the suite slow and able to fail for reasons unrelated to the
/// code. Stubbing the adapter keeps the parsing logic under test without a
/// network.
Dio _stubDio({
  required String body,
  int statusCode = 200,
  DioException? throws,
}) {
  final dio = Dio()
    ..httpClientAdapter = _StubAdapter(
      body: body,
      statusCode: statusCode,
      throws: throws,
    );

  return dio;
}

final class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({required this.body, required this.statusCode, this.throws});

  final String body;
  final int statusCode;
  final DioException? throws;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final failure = throws;
    if (failure != null) throw failure;

    return ResponseBody.fromString(body, statusCode);
  }

  @override
  void close({bool force = false}) {}
}

const _fullPage = '''
<html>
  <head>
    <title>Fallback title</title>
    <meta property="og:title" content="Open Graph Title" />
    <meta property="og:description" content="Open Graph Description" />
    <meta property="og:image" content="https://example.com/og.png" />
  </head>
  <body>Body text</body>
</html>
''';

void main() {
  group('url validation', () {
    test('returns null without a request for an invalid url', () async {
      // No client is supplied: if validation did not short circuit, this
      // would attempt a real request.
      expect(await CustomLinkPreview.getLinkPreviewData('xssxs'), isNull);
      expect(await CustomLinkPreview.getLinkPreviewData(''), isNull);
      expect(await CustomLinkPreview.getLinkPreviewData('not a url'), isNull);
    });

    test('accepts a host with no path', () async {
      // Regression guard: validation used to test Uri.hasAbsolutePath, which
      // asks whether the path starts with a slash. A bare host has an empty
      // path, so every URL without a trailing path was silently rejected.
      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(body: _fullPage),
      );

      expect(result, isNotNull);
      expect(result!.title, 'Open Graph Title');
    });

    test('rejects a relative path that cannot be fetched', () async {
      // The mirror image of the bug above: /relative/path satisfies
      // hasAbsolutePath but is not a fetchable URL.
      expect(
        await CustomLinkPreview.getLinkPreviewData('/relative/path'),
        isNull,
      );
    });
  });

  group('metadata extraction', () {
    test('prefers Open Graph tags', () async {
      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(body: _fullPage),
      );

      expect(result, isNotNull);
      expect(result!.title, 'Open Graph Title');
      expect(result.description, 'Open Graph Description');
      expect(result.image, 'https://example.com/og.png');
    });

    test('falls back to Twitter tags when Open Graph is absent', () async {
      const page = '''
      <html><head>
        <meta name="twitter:title" content="Twitter Title" />
        <meta name="twitter:description" content="Twitter Description" />
        <meta name="twitter:image" content="https://example.com/tw.png" />
      </head></html>
      ''';

      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(body: page),
      );

      expect(result!.title, 'Twitter Title');
      expect(result.description, 'Twitter Description');
      expect(result.image, 'https://example.com/tw.png');
    });

    test('falls back to the title element and meta description', () async {
      const page = '''
      <html><head>
        <title>Plain Title</title>
        <meta name="description" content="Plain Description" />
      </head></html>
      ''';

      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(body: page),
      );

      expect(result!.title, 'Plain Title');
      expect(result.description, 'Plain Description');
      // No image tag at all, so the image is empty rather than null.
      expect(result.image, isEmpty);
    });

    test('returns empty strings when the page has no metadata', () async {
      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(body: '<html><body>nothing</body></html>'),
      );

      expect(result, isNotNull);
      expect(result!.title, isEmpty);
      expect(result.description, isEmpty);
      expect(result.image, isEmpty);
    });
  });

  group('failure handling', () {
    test('returns null for a non-200 response', () async {
      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(body: _fullPage, statusCode: 404),
      );

      expect(result, isNull);
    });

    test('returns null rather than throwing when the request fails', () async {
      final result = await CustomLinkPreview.getLinkPreviewData(
        'https://example.com',
        client: _stubDio(
          body: '',
          throws: DioException.connectionError(
            requestOptions: RequestOptions(path: 'https://example.com'),
            reason: 'offline',
          ),
        ),
      );

      expect(result, isNull);
    });
  });
}
