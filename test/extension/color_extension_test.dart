import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('KartalColor.random', () {
    test('can return every entry in Colors.primaries', () {
      // Regression guard: this used to be nextInt(17) against an 18 entry
      // list, so the final primary (blueGrey) was unreachable.
      final seen = <MaterialColor>{};
      for (var seed = 0; seed < 500; seed++) {
        seen.add(KartalColor.random(seed: seed));
      }

      expect(seen.length, Colors.primaries.length);
      expect(seen, contains(Colors.blueGrey));
    });

    test('is deterministic for a given seed', () {
      expect(KartalColor.random(seed: 42), KartalColor.random(seed: 42));
    });

    test('always returns a member of Colors.primaries', () {
      for (var seed = 0; seed < 50; seed++) {
        expect(Colors.primaries, contains(KartalColor.random(seed: seed)));
      }
    });
  });

  group('KartalColor.tryParse', () {
    test('parses 6 digit values as fully opaque', () {
      expect(KartalColor.tryParse('FF0000'), const Color(0xFFFF0000));
      expect(KartalColor.tryParse('#00FF00'), const Color(0xFF00FF00));
    });

    test('parses 8 digit values including alpha', () {
      expect(KartalColor.tryParse('80FF0000'), const Color(0x80FF0000));
      expect(KartalColor.tryParse('#00000000'), const Color(0x00000000));
    });

    test('is case insensitive and tolerates surrounding whitespace', () {
      expect(KartalColor.tryParse('#ff0000'), const Color(0xFFFF0000));
      expect(KartalColor.tryParse(' #FF0000 '), const Color(0xFFFF0000));
    });

    test('returns null for invalid input', () {
      expect(KartalColor.tryParse(null), isNull);
      expect(KartalColor.tryParse(''), isNull);
      expect(KartalColor.tryParse('FF00'), isNull);
      expect(KartalColor.tryParse('GGGGGG'), isNull);
      expect(KartalColor.tryParse('not a colour'), isNull);
    });
  });

  group('ColorExtension', () {
    test('withOpacity sets the alpha channel to the given value', () {
      // The old test only asserted isA<Color>(), which held for any result.
      final result = Colors.red.ext.withOpacity(0.5);

      expect(result.a, closeTo(0.5, 0.01));
      expect(result.r, Colors.red.r);
      expect(result.g, Colors.red.g);
      expect(result.b, Colors.red.b);
    });

    test('toHex round trips through KartalColor.tryParse', () {
      const color = Color(0xFF3F51B5);

      expect(color.ext.toHex(), '#3f51b5');
      expect(color.ext.toHex(uppercase: true), '#3F51B5');
      expect(color.ext.toHex(includeAlpha: true), '#ff3f51b5');
      expect(KartalColor.tryParse(color.ext.toHex()), color);
    });

    test('isDark and isLight use perceptual luminance', () {
      expect(Colors.black.ext.isDark, isTrue);
      expect(Colors.white.ext.isLight, isTrue);

      // Yellow is bright to the eye but has a high red+green sum, so a naive
      // RGB average would wrongly call it dark.
      expect(Colors.yellow.ext.isLight, isTrue);
      expect(const Color(0xFF001133).ext.isDark, isTrue);
    });

    test('contrastText picks a readable foreground', () {
      expect(Colors.black.ext.contrastText(), Colors.white);
      expect(Colors.white.ext.contrastText(), Colors.black);
      expect(Colors.black.ext.contrastText(light: Colors.amber), Colors.amber);
    });

    test('lighten and darken move luminance in the right direction', () {
      const base = Color(0xFF3F51B5);

      expect(
        base.ext.lighten(0.2).ext.luminance,
        greaterThan(base.ext.luminance),
      );
      expect(base.ext.darken(0.2).ext.luminance, lessThan(base.ext.luminance));
    });

    test('lighten and darken clamp at white and black', () {
      expect(Colors.red.ext.lighten(5), Colors.white);
      expect(Colors.red.ext.darken(5), Colors.black);
    });

    test('blend interpolates between two colours', () {
      expect(Colors.black.ext.blend(Colors.white, 0), Colors.black);
      expect(Colors.black.ext.blend(Colors.white, 1), Colors.white);

      final middle = Colors.black.ext.blend(Colors.white);
      expect(middle.ext.luminance, greaterThan(Colors.black.ext.luminance));
      expect(middle.ext.luminance, lessThan(Colors.white.ext.luminance));
    });

    test('blend clamps t outside of [0, 1]', () {
      expect(Colors.black.ext.blend(Colors.white, -1), Colors.black);
      expect(Colors.black.ext.blend(Colors.white, 2), Colors.white);
    });

    test('toMaterialColor produces a full swatch around the seed', () {
      const seed = Color(0xFF3F51B5);
      final swatch = seed.ext.toMaterialColor();

      for (final shade in [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]) {
        expect(swatch[shade], isNotNull, reason: 'shade $shade is missing');
      }

      expect(swatch[500], seed);
      // Low shades are lighter than high shades.
      expect(
        swatch[50]!.ext.luminance,
        greaterThan(swatch[900]!.ext.luminance),
      );
    });

    test('randomColor is reachable through the instance extension', () {
      expect(Colors.primaries, contains(Colors.red.ext.randomColor));
    });
  });

  group('StringExtension colour parsing', () {
    test('toColorOrNull reports failure instead of guessing', () {
      const String? nullValue = null;

      expect('FF0000'.ext.toColorOrNull, const Color(0xFFFF0000));
      expect('#FF0000'.ext.toColorOrNull, const Color(0xFFFF0000));
      expect('nope'.ext.toColorOrNull, isNull);
      expect(nullValue.ext.toColorOrNull, isNull);
    });

    test('toColor falls back to white and now accepts a leading #', () {
      expect('FF0000'.ext.toColor, const Color(0xFFFF0000));
      expect('#FF0000'.ext.toColor, const Color(0xFFFF0000));
      expect('nope'.ext.toColor, const Color(0xFFFFFFFF));
    });
  });
}
