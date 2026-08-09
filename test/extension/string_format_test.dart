import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('mask', () {
    test('keeps the requested head and tail visible', () {
      expect('4242424242424242'.ext.mask(), '4242********4242');
      expect('4242424242424242'.ext.mask(start: 0), '************4242');
      expect('4242424242424242'.ext.mask(start: 6, end: 2), '424242********42');
    });

    test('accepts a custom mask character', () {
      expect('4242424242424242'.ext.mask(char: '#'), '4242########4242');
    });

    test('masks in full when the string is too short to keep both ends', () {
      // Never leaks more than requested.
      expect('1234'.ext.mask(), '****');
      expect('12345678'.ext.mask(), '********');
      // One character over the threshold, so the ends become visible again.
      expect('123456789'.ext.mask(), '1234*6789');
    });

    test('handles empty and null input', () {
      const String? nullValue = null;

      expect(''.ext.mask(), '');
      expect(nullValue.ext.mask(), '');
    });

    test('returns the input unchanged for negative bounds', () {
      expect('12345678'.ext.mask(start: -1), '12345678');
    });
  });

  group('maskEmail', () {
    test('masks the local part and keeps the domain', () {
      expect('veli@kartal.dev'.ext.maskEmail, 've**@kartal.dev');
      expect('a.long.name@kartal.dev'.ext.maskEmail, 'a.*********@kartal.dev');
    });

    test('handles very short local parts', () {
      expect('ab@kartal.dev'.ext.maskEmail, 'a*@kartal.dev');
      expect('a@kartal.dev'.ext.maskEmail, '*@kartal.dev');
    });

    test('returns non email input unchanged', () {
      const String? nullValue = null;

      expect('not an email'.ext.maskEmail, 'not an email');
      expect('@kartal.dev'.ext.maskEmail, '@kartal.dev');
      expect(''.ext.maskEmail, '');
      expect(nullValue.ext.maskEmail, '');
    });
  });

  group('maskPhone', () {
    test('keeps only the trailing digits visible', () {
      expect('05321234567'.ext.maskPhone(), '*******4567');
      expect('05321234567'.ext.maskPhone(visibleDigits: 2), '*********67');
    });
  });

  group('toSlug', () {
    test('lowercases and joins with a separator', () {
      expect('Hello World'.ext.toSlug(), 'hello-world');
      expect('  spaced   out  '.ext.toSlug(), 'spaced-out');
    });

    test('folds Turkish diacritics to ASCII', () {
      expect('Çok Güzel Bir Başlık'.ext.toSlug(), 'cok-guzel-bir-baslik');
      expect('İstanbul Şişli'.ext.toSlug(), 'istanbul-sisli');
    });

    test('strips punctuation and collapses runs', () {
      expect('Hello, World!!! Again'.ext.toSlug(), 'hello-world-again');
      expect('a---b'.ext.toSlug(), 'a-b');
    });

    test('trims leading and trailing separators', () {
      expect('!!!Hello!!!'.ext.toSlug(), 'hello');
    });

    test('accepts a custom separator', () {
      expect('Hello World'.ext.toSlug(separator: '_'), 'hello_world');
    });

    test('handles empty and null input', () {
      const String? nullValue = null;

      expect(''.ext.toSlug(), '');
      expect(nullValue.ext.toSlug(), '');
    });
  });

  group('truncate', () {
    test('never exceeds maxLength, counting the ellipsis', () {
      const text = 'Kartal makes Flutter nicer';

      expect('Kartal ma...'.length, 12);
      expect(text.ext.truncate(12), 'Kartal ma...');
      expect(text.ext.truncate(12).length, lessThanOrEqualTo(12));
    });

    test('returns the input when it already fits', () {
      expect('short'.ext.truncate(10), 'short');
      expect('exactly10!'.ext.truncate(10), 'exactly10!');
    });

    test('accepts a custom ellipsis', () {
      expect(
        'Kartal makes it nicer'.ext.truncate(10, ellipsis: '…'),
        'Kartal ma…',
      );
    });

    test('degrades gracefully for tiny budgets', () {
      expect('Kartal'.ext.truncate(2), 'Ka');
      expect('Kartal'.ext.truncate(0), '');
      expect('Kartal'.ext.truncate(-1), '');
    });

    test('handles empty and null input', () {
      const String? nullValue = null;

      expect(''.ext.truncate(5), '');
      expect(nullValue.ext.truncate(5), '');
    });
  });

  group('initials', () {
    test('takes the first letter of each word', () {
      expect('Veli Bacik'.ext.initials(), 'VB');
      expect('veli bacik'.ext.initials(), 'VB');
      expect('Veli'.ext.initials(), 'V');
    });

    test('honours the count limit', () {
      expect('One Two Three Four'.ext.initials(), 'OT');
      expect('One Two Three Four'.ext.initials(count: 3), 'OTT');
      expect('One Two Three Four'.ext.initials(count: 10), 'OTTF');
    });

    test('tolerates extra whitespace', () {
      expect('  Veli   Bacik  '.ext.initials(), 'VB');
    });

    test('handles empty and null input', () {
      const String? nullValue = null;

      expect(''.ext.initials(), '');
      expect('   '.ext.initials(), '');
      expect(nullValue.ext.initials(), '');
    });
  });

  group('removeHtmlTags', () {
    test('strips tags and keeps the text', () {
      expect('<p>Hello <b>World</b></p>'.ext.removeHtmlTags, 'Hello World');
      expect('<div><span>a</span></div>'.ext.removeHtmlTags, 'a');
    });

    test('decodes entities, which a regex could not', () {
      expect('<p>Tom &amp; Jerry</p>'.ext.removeHtmlTags, 'Tom & Jerry');
      expect('<p>a &lt; b</p>'.ext.removeHtmlTags, 'a < b');
    });

    test('handles plain text and malformed markup', () {
      const String? nullValue = null;

      expect('no tags here'.ext.removeHtmlTags, 'no tags here');
      expect(''.ext.removeHtmlTags, '');
      expect(nullValue.ext.removeHtmlTags, '');
    });
  });

  group('wordCount and readingTimeMinutes', () {
    test('counts whitespace separated words', () {
      expect('one two three'.ext.wordCount, 3);
      expect('  one   two  '.ext.wordCount, 2);
      expect('single'.ext.wordCount, 1);
    });

    test('returns zero for blank input', () {
      const String? nullValue = null;

      expect(''.ext.wordCount, 0);
      expect('   '.ext.wordCount, 0);
      expect(nullValue.ext.wordCount, 0);
    });

    test('rounds reading time up to at least a minute', () {
      expect('one two three'.ext.readingTimeMinutes, 1);
      expect(List.filled(400, 'word').join(' ').ext.readingTimeMinutes, 2);
      expect(''.ext.readingTimeMinutes, 0);
    });
  });

  group('reversed', () {
    test('reverses the characters', () {
      const String? nullValue = null;

      expect('kartal'.ext.reversed, 'latrak');
      expect('ab'.ext.reversed, 'ba');
      expect(''.ext.reversed, '');
      expect(nullValue.ext.reversed, '');
    });
  });

  group('base64', () {
    test('round trips through encode and decode', () {
      const text = 'Kartal, İstanbul';
      final encoded = text.ext.base64Encoded;

      expect(encoded, isNotEmpty);
      expect(encoded.ext.base64Decoded, text);
    });

    test('encodes to the expected value', () {
      expect('hello'.ext.base64Encoded, 'aGVsbG8=');
      expect('aGVsbG8='.ext.base64Decoded, 'hello');
    });

    test('returns null rather than throwing on invalid base64', () {
      const String? nullValue = null;

      expect('!!!not base64!!!'.ext.base64Decoded, isNull);
      expect(''.ext.base64Decoded, isNull);
      expect(nullValue.ext.base64Decoded, isNull);
      expect(''.ext.base64Encoded, '');
    });
  });

  group('toDateTimeOrNull', () {
    test('parses ISO 8601 input', () {
      expect(
        '2026-08-08'.ext.toDateTimeOrNull(),
        DateTime(2026, 8, 8),
      );
      expect('2026-08-08T12:30:00Z'.ext.toDateTimeOrNull(), isNotNull);
    });

    test('returns null rather than throwing on invalid input', () {
      const String? nullValue = null;

      expect('not a date'.ext.toDateTimeOrNull(), isNull);
      expect(''.ext.toDateTimeOrNull(), isNull);
      expect(nullValue.ext.toDateTimeOrNull(), isNull);
    });
  });
}
