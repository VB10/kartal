import 'package:example/gallery/gallery_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Live validation playground.
///
/// The TCKN, IBAN and card validators run real checksums, so editing a single
/// digit of a valid value flips the verdict -- which a length or shape check
/// would not catch.
class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({super.key});

  @override
  State<ValidatorsPage> createState() => _ValidatorsPageState();
}

class _ValidatorsPageState extends State<ValidatorsPage> {
  // Checksum-valid sample values, not real identities or accounts.
  final _tckn = TextEditingController(text: '10000000146');
  final _iban = TextEditingController(text: 'TR33 0006 1005 1978 6457 8413 26');
  final _card = TextEditingController(text: '4242 4242 4242 4242');
  final _phone = TextEditingController(text: '0(532) 123-45-67');
  final _email = TextEditingController(text: 'veli@kartal.dev');
  final _url = TextEditingController(text: 'https://pub.dev/packages/kartal');
  final _password = TextEditingController(text: 'Password123!');

  @override
  void dispose() {
    for (final controller in [
      _tckn,
      _iban,
      _card,
      _phone,
      _email,
      _url,
      _password,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GalleryBody(
    children: [
      DemoSection(
        title: 'Turkish identity number',
        description:
            'Runs the official checksum: the 10th digit is derived from the '
            'odd and even digit sums, and the 11th from the first ten. Change '
            'any digit to see it fail.',
        snippet: "'10000000146'.ext.isValidTckn;  // true",
        child: _Field(
          controller: _tckn,
          label: 'TCKN',
          isValid: (value) => value.ext.isValidTckn,
          onChanged: _refresh,
        ),
      ),
      DemoSection(
        title: 'IBAN',
        description:
            'ISO 13616 mod-97 check. Grouping spaces are ignored, and the '
            'number is reduced in chunks because it is far wider than 64 bits.',
        snippet: "'TR33 0006 1005 1978 6457 8413 26'.ext.isValidIban;  // true",
        child: _Field(
          controller: _iban,
          label: 'IBAN',
          isValid: (value) => value.ext.isValidIban,
          onChanged: _refresh,
        ),
      ),
      DemoSection(
        title: 'Credit card',
        description: 'Luhn checksum. Spaces and dashes are tolerated.',
        snippet: "'4242 4242 4242 4242'.ext.isValidCreditCard;  // true",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(
              controller: _card,
              label: 'Card number',
              isValid: (value) => value.ext.isValidCreditCard,
              onChanged: _refresh,
            ),
            const SizedBox(height: 12),
            ResultRow(label: 'mask()', value: _card.text.ext.mask()),
          ],
        ),
      ),
      DemoSection(
        title: 'Turkish phone number',
        description:
            'Accepts +90, 90 and 0 prefixes with spaces, dashes, dots or '
            'parentheses. The area code cannot start with zero.',
        snippet:
            "'+90 532 123 45 67'.ext.isValidPhone;  // true\n"
            "'0(032) 123-45-67'.ext.isValidPhone;   // false",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(
              controller: _phone,
              label: 'Phone',
              isValid: (value) => value.ext.isValidPhone,
              onChanged: _refresh,
            ),
            const SizedBox(height: 12),
            ResultRow(
              label: 'phoneFormatValue',
              value: _phone.text.ext.phoneFormatValue,
            ),
            ResultRow(label: 'maskPhone()', value: _phone.text.ext.maskPhone()),
          ],
        ),
      ),
      DemoSection(
        title: 'Email',
        snippet: "'veli@kartal.dev'.ext.isValidEmail;  // true",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(
              controller: _email,
              label: 'Email',
              isValid: (value) => value.ext.isValidEmail,
              onChanged: _refresh,
            ),
            const SizedBox(height: 12),
            ResultRow(label: 'maskEmail', value: _email.text.ext.maskEmail),
          ],
        ),
      ),
      DemoSection(
        title: 'URL',
        description:
            'Requires an absolute http(s) URL. A bare host such as '
            'kartal.dev is rejected, because it cannot be launched without '
            'guessing a scheme.',
        snippet:
            "'https://pub.dev'.ext.isValidUrl;  // true\n"
            "'kartal.dev'.ext.isValidUrl;       // false",
        child: _Field(
          controller: _url,
          label: 'URL',
          isValid: (value) => value.ext.isValidUrl,
          onChanged: _refresh,
        ),
      ),
      DemoSection(
        title: 'Password',
        description:
            'At least 8 characters with an upper case letter, a lower case '
            'letter, a digit and a symbol.',
        snippet: "'Password123!'.ext.isValidPassword;  // true",
        child: _Field(
          controller: _password,
          label: 'Password',
          isValid: (value) => value.ext.isValidPassword,
          onChanged: _refresh,
        ),
      ),
    ],
  );

  void _refresh() => setState(() {});
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.isValid,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final bool Function(String value) isValid;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final valid = isValid(controller.text);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (_) => onChanged(),
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
        const SizedBox(width: 12),
        VerdictChip(isValid: valid),
      ],
    );
  }
}
