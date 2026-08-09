import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('isValidUrl', () {
    test('accepts absolute http and https URLs', () {
      expect('https://kartal.dev'.ext.isValidUrl, isTrue);
      expect('http://kartal.dev'.ext.isValidUrl, isTrue);
      expect('https://www.kartal.dev/path?a=1#frag'.ext.isValidUrl, isTrue);
      expect('https://kartal.dev:8080/path'.ext.isValidUrl, isTrue);
      expect('http://localhost:3000'.ext.isValidUrl, isTrue);
      expect('http://127.0.0.1:8080'.ext.isValidUrl, isTrue);
    });

    test('rejects values that cannot be launched without guessing', () {
      const String? nullValue = null;

      expect('kartal.dev'.ext.isValidUrl, isFalse);
      expect('//kartal.dev'.ext.isValidUrl, isFalse);
      expect('ftp://kartal.dev'.ext.isValidUrl, isFalse);
      expect('https://'.ext.isValidUrl, isFalse);
      expect('not a url'.ext.isValidUrl, isFalse);
      expect(''.ext.isValidUrl, isFalse);
      expect(nullValue.ext.isValidUrl, isFalse);
    });
  });

  group('isValidPhone', () {
    test('accepts Turkish numbers in common written forms', () {
      expect('05321234567'.ext.isValidPhone, isTrue);
      expect('5321234567'.ext.isValidPhone, isTrue);
      expect('+905321234567'.ext.isValidPhone, isTrue);
      expect('905321234567'.ext.isValidPhone, isTrue);
      expect('0(532) 123-45-67'.ext.isValidPhone, isTrue);
      expect('+90 532 123 45 67'.ext.isValidPhone, isTrue);
      expect('0532.123.45.67'.ext.isValidPhone, isTrue);
    });

    test('rejects malformed numbers', () {
      const String? nullValue = null;

      // Area code cannot start with zero.
      expect('0(032) 123-45-67'.ext.isValidPhone, isFalse);
      // Too short and too long.
      expect('053212345'.ext.isValidPhone, isFalse);
      expect('053212345678'.ext.isValidPhone, isFalse);
      expect('abcdefghij'.ext.isValidPhone, isFalse);
      expect(''.ext.isValidPhone, isFalse);
      expect(nullValue.ext.isValidPhone, isFalse);
    });
  });

  group('isValidTckn', () {
    test('accepts numbers with a correct checksum', () {
      // Checksum-valid test values, not real identities.
      expect('10000000146'.ext.isValidTckn, isTrue);
      expect('19191919190'.ext.isValidTckn, isTrue);
    });

    test('rejects a wrong 10th or 11th digit', () {
      // Same as the valid value above with the final digit changed.
      expect('10000000147'.ext.isValidTckn, isFalse);
      expect('10000000156'.ext.isValidTckn, isFalse);
    });

    test('rejects structurally invalid input', () {
      const String? nullValue = null;

      // Cannot start with zero.
      expect('01234567890'.ext.isValidTckn, isFalse);
      // Wrong length.
      expect('1234567890'.ext.isValidTckn, isFalse);
      expect('123456789012'.ext.isValidTckn, isFalse);
      // Not digits.
      expect('1234567890a'.ext.isValidTckn, isFalse);
      expect(''.ext.isValidTckn, isFalse);
      expect(nullValue.ext.isValidTckn, isFalse);
    });
  });

  group('isValidIban', () {
    test('accepts published example IBANs', () {
      expect('TR330006100519786457841326'.ext.isValidIban, isTrue);
      expect('GB82WEST12345698765432'.ext.isValidIban, isTrue);
      expect('DE89370400440532013000'.ext.isValidIban, isTrue);
    });

    test('ignores grouping spaces and is case insensitive', () {
      expect('TR33 0006 1005 1978 6457 8413 26'.ext.isValidIban, isTrue);
      expect('gb82west12345698765432'.ext.isValidIban, isTrue);
    });

    test('rejects a failed mod-97 check', () {
      // Final digit altered, so the checksum no longer holds.
      expect('TR330006100519786457841327'.ext.isValidIban, isFalse);
      expect('GB82WEST12345698765433'.ext.isValidIban, isFalse);
    });

    test('rejects structurally invalid input', () {
      const String? nullValue = null;

      expect('TR'.ext.isValidIban, isFalse);
      expect('1234567890123456'.ext.isValidIban, isFalse);
      expect(''.ext.isValidIban, isFalse);
      expect(nullValue.ext.isValidIban, isFalse);
    });
  });

  group('isValidCreditCard', () {
    test('accepts standard Luhn-valid test numbers', () {
      expect('4242424242424242'.ext.isValidCreditCard, isTrue);
      expect('5555555555554444'.ext.isValidCreditCard, isTrue);
      expect('378282246310005'.ext.isValidCreditCard, isTrue);
      expect('6011111111111117'.ext.isValidCreditCard, isTrue);
    });

    test('ignores grouping spaces and dashes', () {
      expect('4242 4242 4242 4242'.ext.isValidCreditCard, isTrue);
      expect('4242-4242-4242-4242'.ext.isValidCreditCard, isTrue);
    });

    test('rejects a failed Luhn check', () {
      expect('4242424242424241'.ext.isValidCreditCard, isFalse);
      expect('1234567812345678'.ext.isValidCreditCard, isFalse);
    });

    test('rejects structurally invalid input', () {
      const String? nullValue = null;

      expect('42424242'.ext.isValidCreditCard, isFalse);
      expect('4242424242424242424242'.ext.isValidCreditCard, isFalse);
      expect('4242abcd4242efgh'.ext.isValidCreditCard, isFalse);
      expect(''.ext.isValidCreditCard, isFalse);
      expect(nullValue.ext.isValidCreditCard, isFalse);
    });
  });

  // These assertions pin behaviour that is *known to be wrong*, so that the
  // deferred fix in https://github.com/VB10/kartal/pull/93 shows up as a
  // deliberate change rather than a silent one. When that lands, every
  // expectation in this group flips to isFalse and the group can be folded
  // into the normal isValidEmail tests.
  group('isValidEmail known limitations (see #93)', () {
    test('accepts a comma in the local part', () {
      // The character class contains `+-/`, which is read as a range covering
      // ',' rather than three literal characters.
      expect('veli,test@kartal.dev'.ext.isValidEmail, isTrue);
    });

    test('accepts trailing content because the regex is not anchored', () {
      expect('user@domain.com<script>'.ext.isValidEmail, isTrue);
      expect('veli@kartal.dev trailing text'.ext.isValidEmail, isTrue);
    });

    test('accepts an underscore in the domain', () {
      expect('user@my_mail.com'.ext.isValidEmail, isTrue);
    });

    test('accepts consecutive dots', () {
      expect('veli..test@kartal.dev'.ext.isValidEmail, isTrue);
    });

    test('still rejects the obviously malformed cases', () {
      expect('veli@kartal'.ext.isValidEmail, isFalse);
      expect('@kartal.dev'.ext.isValidEmail, isFalse);
      expect('not an email'.ext.isValidEmail, isFalse);
    });
  });

  group('isNumeric', () {
    test('accepts digit only strings', () {
      expect('12345'.ext.isNumeric, isTrue);
      expect('0'.ext.isNumeric, isTrue);
    });

    test('rejects anything else', () {
      const String? nullValue = null;

      expect('12.34'.ext.isNumeric, isFalse);
      expect('-12'.ext.isNumeric, isFalse);
      expect('12a'.ext.isNumeric, isFalse);
      expect(''.ext.isNumeric, isFalse);
      expect(nullValue.ext.isNumeric, isFalse);
    });
  });
}
