import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:kartal/src/utility/link_preview/custom_link_preview_data.dart';

final class CustomLinkPreview {
  const CustomLinkPreview._();

  static bool _validateUrl(String url) =>
      Uri.tryParse(url)?.hasAbsolutePath ?? false;

  static Future<CustomLinkPreviewData?> getLinkPreviewData(String url) async {
    if (!_validateUrl(url)) return null;
    Response<dynamic> response;
    try {
      response = await Dio().get<dynamic>(url);
    } catch (_) {
      return null;
    }
    if (response.statusCode == HttpStatus.ok) {
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
    final title = document
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
    final description = document
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
    final image = document
            .querySelector('meta[property="og:image"]')
            ?.attributes['content'] ??
        document
            .querySelector('meta[name="twitter:image"]')
            ?.attributes['content'] ??
        '';
    return image;
  }
}
