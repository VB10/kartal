import 'dart:convert';

import 'package:html/parser.dart' as html_parser;
import 'package:kartal/kartal.dart';

/// Formatting and shaping helpers for [String].
mixin StringFormatMixin {
  String? get value;

  /// Average adult reading speed, used by [readingTimeMinutes].
  static const _wordsPerMinute = 200;

  /// Masks the middle of this string, keeping [start] leading and [end]
  /// trailing characters visible.
  ///
  /// ```dart
  /// '4242424242424242'.ext.mask();               // '4242********4242'
  /// '4242424242424242'.ext.mask(start: 0, end: 4); // '************4242'
  /// ```
  ///
  /// If the string is too short to keep both ends visible it is masked in
  /// full, so this never leaks more than requested.
  String mask({int start = 4, int end = 4, String char = '*'}) {
    final source = value;
    if (source == null || source.isEmpty) return '';
    if (start < 0 || end < 0) return source;

    if (source.length <= start + end) return char * source.length;

    final head = source.substring(0, start);
    final tail = source.substring(source.length - end);

    return '$head${char * (source.length - start - end)}$tail';
  }

  /// Masks the local part of an email address, keeping the domain intact.
  ///
  /// ```dart
  /// 'veli@kartal.dev'.ext.maskEmail;  // 've**@kartal.dev'
  /// ```
  ///
  /// Returns the input unchanged when it is not an email address.
  String get maskEmail {
    final source = value;
    if (source == null || source.isEmpty) return '';

    final atIndex = source.indexOf('@');
    if (atIndex <= 0) return source;

    final local = source.substring(0, atIndex);
    final domain = source.substring(atIndex);

    // Keep at most the first two characters of the local part.
    final visible = local.length <= 2 ? local.length - 1 : 2;
    final head = local.substring(0, visible < 0 ? 0 : visible);

    return '$head${'*' * (local.length - head.length)}$domain';
  }

  /// Masks a phone number, keeping only the last [visibleDigits] digits.
  ///
  /// ```dart
  /// '05321234567'.ext.maskPhone;  // '*******4567'
  /// ```
  String maskPhone({int visibleDigits = 4}) =>
      mask(start: 0, end: visibleDigits);

  /// Converts this string into a URL friendly slug.
  ///
  /// Diacritics are folded to ASCII first, so Turkish text survives the
  /// conversion: `'Çok Güzel Bir Başlık'` becomes `'cok-guzel-bir-baslik'`.
  String toSlug({String separator = '-'}) {
    final source = value;
    if (source == null || source.isEmpty) return '';

    final folded = source.ext.withoutSpecialCharacters ?? source;

    return folded
        .toLowerCase()
        .replaceAll(
          RegExp(RegexConstants.instance().slugUnsafeRegex),
          separator,
        )
        // Trim leading and trailing separators produced by the replace above.
        .replaceAll(RegExp('^\\$separator+|\\$separator+\$'), '');
  }

  /// Truncates this string to [maxLength] characters, appending [ellipsis].
  ///
  /// The result never exceeds [maxLength], so the ellipsis is counted as part
  /// of the budget rather than added on top of it.
  ///
  /// ```dart
  /// 'Kartal makes Flutter nicer'.ext.truncate(12);  // 'Kartal ma...'
  /// ```
  String truncate(int maxLength, {String ellipsis = '...'}) {
    final source = value;
    if (source == null || source.isEmpty) return '';
    if (maxLength <= 0) return '';
    if (source.length <= maxLength) return source;
    if (maxLength <= ellipsis.length) return source.substring(0, maxLength);

    return '${source.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// The initials of this string, taken from the first [count] words.
  ///
  /// ```dart
  /// 'Veli Bacik'.ext.initials();  // 'VB'
  /// ```
  String initials({int count = 2}) {
    final source = value;
    if (source == null || source.trim().isEmpty) return '';

    final words = source
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);

    return words.take(count).map((word) => word[0].toUpperCase()).join();
  }

  /// This string with every HTML tag removed and entities decoded.
  ///
  /// Uses the `html` parser rather than a regex, so malformed markup and
  /// entities such as `&amp;` are handled correctly.
  String get removeHtmlTags {
    final source = value;
    if (source == null || source.isEmpty) return '';

    return html_parser.parse(source).body?.text ??
        html_parser.parse(source).documentElement?.text ??
        '';
  }

  /// The number of whitespace separated words in this string.
  int get wordCount {
    final source = value;
    if (source == null || source.trim().isEmpty) return 0;

    return source.trim().split(RegExp(r'\s+')).length;
  }

  /// An estimated reading time in minutes, rounded up to at least 1.
  int get readingTimeMinutes {
    final words = wordCount;
    if (words == 0) return 0;

    return (words / _wordsPerMinute).ceil();
  }

  /// This string reversed.
  String get reversed {
    final source = value;
    if (source == null || source.isEmpty) return '';

    return source.split('').reversed.join();
  }

  /// This string encoded as base64.
  String get base64Encoded {
    final source = value;
    if (source == null || source.isEmpty) return '';

    return base64Encode(utf8.encode(source));
  }

  /// This string decoded from base64, or `null` when it is not valid base64.
  String? get base64Decoded {
    final source = value;
    if (source == null || source.isEmpty) return null;

    try {
      return utf8.decode(base64Decode(source));
    } on FormatException {
      return null;
    }
  }

  /// Parses this string as a [DateTime], or `null` when it is not valid.
  ///
  /// A safe counterpart to [DateTime.parse], which throws.
  DateTime? toDateTimeOrNull() {
    final source = value;
    if (source == null || source.isEmpty) return null;

    return DateTime.tryParse(source);
  }
}
