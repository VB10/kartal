import 'package:diacritic/diacritic.dart';
import 'package:kartal/kartal.dart';

/// It provides platform-specific functionalities for [String].
mixin StringValidatorMixin {
  String? get value;

  /// Returns lowercase version with no special characters.
  String get searchable =>
      value?.toLowerCase().ext.withoutSpecialCharacters ?? '';

  /// Returns true if this string is null or empty.
  bool get isNullOrEmpty => value?.isEmpty ?? true;

  /// Returns true if this string is not null and not empty.
  bool get isNotNullOrNoEmpty => value?.isNotEmpty ?? false;

  // Check if email is valid
  bool get isValidEmail {
    if (!isNotNullOrNoEmpty) return false;
    return RegExp(
      RegexConstants.instance().emailRegex,
    ).hasMatch(value!);
  }

  /// Checks if the password is valid.
  ///
  /// A valid password is one that is at least 8 characters long and contains
  /// at least one uppercase letter, one lowercase letter, one number, and one
  /// symbol.
  ///
  /// Returns `true` if the password is valid, otherwise returns `false`.
  bool get isValidPassword => RegExp(
    RegexConstants.instance().passwordRegex,
  ).hasMatch(value ?? '');

  /// Removes all diacritics from the string.
  ///
  /// For example, [removeDiacritics] would transform 'à' to 'a'.
  String? get withoutSpecialCharacters =>
      isNullOrEmpty ? value : removeDiacritics(value!);

  /// Returns the _value of the phone number without the formatting characters.
  String get phoneFormatValue =>
      InputFormatter.instance.phoneFormatter.unmaskText(value ?? '');

  /// Formats the _value of this [String] as a time.
  ///
  /// This assumes that the _value of this [String] is a time string, and
  /// returns a [String] representing the formatted version of the _value.
  String get timeFormatValue =>
      InputFormatter.instance.timeFormatter.unmaskText(value ?? '');

  /// Unmasks the text for the time overline format.
  ///
  /// This format only allows numbers.
  String get timeOverlineFormatValue =>
      InputFormatter.instance.timeFormatterOverLine.unmaskText(value ?? '');

  /// Whether this string is an absolute `http` or `https` URL.
  ///
  /// Scheme-relative and bare host values such as `example.com` are rejected,
  /// because they cannot be launched without guessing a scheme.
  bool get isValidUrl {
    if (!isNotNullOrNoEmpty) return false;

    return RegExp(RegexConstants.instance().urlRegex).hasMatch(value!.trim());
  }

  /// Whether this string is a valid Turkish phone number.
  ///
  /// Accepts an optional `+90`, `90` or `0` prefix, spaces, dashes,
  /// parentheses and dots as separators. The subscriber number must be 10
  /// digits and its area code cannot start with zero.
  ///
  /// ```dart
  /// '0(532) 123-45-67'.ext.isValidPhone;  // true
  /// '+90 532 123 45 67'.ext.isValidPhone; // true
  /// '0(032) 123-45-67'.ext.isValidPhone;  // false, area code starts with 0
  /// ```
  bool get isValidPhone {
    if (!isNotNullOrNoEmpty) return false;

    final compact = value!.replaceAll(RegExp(r'[\s\-().]'), '');

    return RegExp(RegexConstants.instance().phoneTrRegex).hasMatch(compact);
  }

  /// Whether this string is a valid Turkish national identity number (TCKN).
  ///
  /// Implements the official checksum rather than a length check:
  /// * exactly 11 digits, and the first cannot be zero
  /// * the 10th digit is `((odd digit sum * 7) - even digit sum) mod 10`
  /// * the 11th digit is the sum of the first ten digits `mod 10`
  bool get isValidTckn {
    if (!isNotNullOrNoEmpty) return false;

    final identity = value!.trim();
    if (identity.length != 11) return false;
    if (!RegExp(r'^[1-9]\d{10}$').hasMatch(identity)) return false;

    final digits = identity.split('').map(int.parse).toList();

    // Digits at positions 1, 3, 5, 7, 9 (odd places, zero indexed evens).
    final oddSum = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
    // Digits at positions 2, 4, 6, 8 (even places, zero indexed odds).
    final evenSum = digits[1] + digits[3] + digits[5] + digits[7];

    final tenth = ((oddSum * 7) - evenSum) % 10;
    if (tenth != digits[9]) return false;

    final firstTenSum = digits.take(10).reduce((a, b) => a + b);

    return firstTenSum % 10 == digits[10];
  }

  /// Whether this string is a valid IBAN.
  ///
  /// Implements the ISO 13616 mod-97 check: the first four characters are
  /// moved to the end, every letter is replaced by its position in the
  /// alphabet plus nine, and the resulting number must be congruent to 1
  /// modulo 97. Spaces are ignored, so grouped input is accepted.
  bool get isValidIban {
    if (!isNotNullOrNoEmpty) return false;

    final iban = value!.replaceAll(' ', '').toUpperCase();
    if (iban.length < 15 || iban.length > 34) return false;
    if (!RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]+$').hasMatch(iban)) return false;

    final rearranged = '${iban.substring(4)}${iban.substring(0, 4)}';

    final buffer = StringBuffer();
    for (final unit in rearranged.codeUnits) {
      const zero = 48; // '0'
      const nine = 57; // '9'
      const upperA = 65; // 'A'

      if (unit >= zero && unit <= nine) {
        buffer.write(unit - zero);
      } else {
        // 'A' maps to 10, 'B' to 11, and so on.
        buffer.write(unit - upperA + 10);
      }
    }

    // The number is far wider than 64 bits, so reduce it in chunks rather
    // than parsing it whole.
    var remainder = 0;
    for (final digit in buffer.toString().split('')) {
      remainder = (remainder * 10 + int.parse(digit)) % 97;
    }

    return remainder == 1;
  }

  /// Whether this string is a valid credit card number.
  ///
  /// Implements the Luhn checksum. Spaces and dashes are ignored, so grouped
  /// input is accepted.
  bool get isValidCreditCard {
    if (!isNotNullOrNoEmpty) return false;

    final digitsOnly = value!.replaceAll(RegExp(r'[\s\-]'), '');
    if (!RegExp(r'^\d{12,19}$').hasMatch(digitsOnly)) return false;

    var sum = 0;
    var shouldDouble = false;

    // Walk right to left, doubling every second digit.
    for (var index = digitsOnly.length - 1; index >= 0; index--) {
      var digit = int.parse(digitsOnly[index]);

      if (shouldDouble) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }

      sum += digit;
      shouldDouble = !shouldDouble;
    }

    return sum % 10 == 0;
  }

  /// Whether this string contains only digits.
  bool get isNumeric {
    if (!isNotNullOrNoEmpty) return false;

    return RegExp(r'^\d+$').hasMatch(value!);
  }
}
