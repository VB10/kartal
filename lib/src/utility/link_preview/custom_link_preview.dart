import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:kartal/src/string_extension.dart';
import 'package:kartal/src/utility/link_preview/custom_link_preview_data.dart';

/// A utility class that provides methods to fetch the title, description, and image of a given URL.
final class CustomLinkPreview {
  const CustomLinkPreview._();

  /// This method is used to validate the url
  static const _ok = 200;

  /// Whether [url] is a fetchable absolute http(s) URL.
  ///
  /// This used to test `Uri.hasAbsolutePath`, which asks whether the *path*
  /// component starts with a slash. That rejected perfectly valid inputs such
  /// as `https://example.com` (whose path is empty) while accepting a bare
  /// `/relative/path` that cannot be fetched at all.
  static bool _validateUrl(String url) => url.ext.isValidUrl;

  /// This method is used to get the link preview data
  /// Returns the [CustomLinkPreviewData] object containing the title, description, and image of the given URL.
  /// If the URL is invalid or the data cannot be fetched, returns `null`.
  ///
  /// Pass [client] to supply your own [Dio], which lets tests stub the
  /// response instead of making a real request.
  static Future<CustomLinkPreviewData?> getLinkPreviewData(
    String url, {
    @visibleForTesting Dio? client,
  }) async {
    if (!_validateUrl(url)) return null;
    Response<dynamic> response;
    try {
      response = await (client ?? Dio()).get<dynamic>(url);
    } on Exception catch (_) {
      return null;
    }
    if (response.statusCode == _ok) {
      final document = html_parser.parse(response.data);
      final title = _fetchTitleFromUrl(document);
      final description = _fetchDescriptionFromUrl(document);
      final image = _fetchImageFromUrl(document);

      return CustomLinkPreviewData(
        title: title,
        description: description,
        image: image,
      );
    } else {
      return null;
    }
  }

  static String _fetchTitleFromUrl(Document document) {
    final title =
        document
            .querySelector('meta[property="og:title"]')
            ?.attributes['content'] ??
        document
            .querySelector('meta[name="twitter:title"]')
            ?.attributes['content'] ??
        document.head?.querySelector('title')?.text ??
        '';
    return title;
  }

  static String _fetchDescriptionFromUrl(Document document) {
    final description =
        document
            .querySelector('meta[property="og:description"]')
            ?.attributes['content'] ??
        document
            .querySelector('meta[name="twitter:description"]')
            ?.attributes['content'] ??
        document
            .querySelector('meta[name="description"]')
            ?.attributes['content'] ??
        '';
    return description;
  }

  static String _fetchImageFromUrl(Document document) {
    final image =
        document
            .querySelector('meta[property="og:image"]')
            ?.attributes['content'] ??
        document
            .querySelector('meta[name="twitter:image"]')
            ?.attributes['content'] ??
        '';
    return image;
  }
}
