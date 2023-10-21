import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/exception/generic_type_exception.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  test('adds one to input values', () {
    const fifteenLiras = '15';

    expect(fifteenLiras.ext.isNotNullOrNoEmpty, true);
  });

  test('[isnullormepty] check', () {
    const dataEmpty = '';
    String? dataNil;

    expect(dataEmpty.ext.isNullOrEmpty, true);
    expect(dataNil.ext.isNullOrEmpty, true);
  });

  test('Remove special characters - çamur', () {
    final correctText = 'çamur'.ext.withoutSpecialCharacters;
    expect(correctText, 'camur');
  });
  group('toTitle Tests', () {
    test('test no word title case', () async {
      const text = 'hello world';
      const expected = 'Hello World';
      expect(text.ext.toTitleCase(), expected);
    });
    test('test some letters title case', () async {
      const text = 'hElLo wOrLd';
      const expected = 'Hello World';
      expect(text.ext.toTitleCase(), expected);
    });
    test('test one word title case', () async {
      const text = 'hello World';
      const expected = 'Hello World';
      expect(text.ext.toTitleCase(), expected);
    });
    test('test empty', () async {
      const text = '';
      const expected = '';
      expect(text.ext.toTitleCase(), expected);
    });
    test('test null string', () async {
      const String? text = null;
      const expected = '';
      expect(text.ext.toTitleCase(), expected);
    });
  });

  group('Email Regex', () {
    test('test email', () async {
      const text = 'v@x-y.com';
      expect(text.ext.isValidEmail, true);
    });

    test('test email', () async {
      const text = 'veli+plus@x-y.com';
      expect(text.ext.isValidEmail, true);
    });
  });

  group('toCapitalized Tests', () {
    test('test no word capitalize case', () async {
      const text = 'helLo world';
      const expected = 'Hello world';
      expect(text.ext.toCapitalized(), expected);
    });
    test('test one word title case', () async {
      const text = 'hello WoRlD';
      const expected = 'Hello world';
      expect(text.ext.toCapitalized(), expected);
    });
    test('test one word title case', () async {
      const text = 'hello World';
      const expected = 'Hello world';
      expect(text.ext.toCapitalized(), expected);
    });
    test('test empty', () async {
      const text = '';
      const expected = '';
      expect(text.ext.toCapitalized(), expected);
    });

    test('test null string', () async {
      const String? text = null;
      const expected = '';
      expect(text.ext.toCapitalized(), expected);
    });
  });

  test('Test lineLength property', () {
    const text = 'Hello\nWorld';
    expect(text.ext.lineLength, equals(2));
  });

  test('Test color property', () {
    const hexColor = 'FF0000'; // Kırmızı rengin hexadecimal değeri
    expect(hexColor.ext.color, equals(const Color(0xFFFF0000)));
  });

  test('Test toCapitalized method', () {
    const text = 'hello world';
    expect(text.ext.toCapitalized(), equals('Hello world'));
  });

  test('Test toTitleCase method', () {
    const text = 'hello world';
    expect(text.ext.toTitleCase(), equals('Hello World'));
  });

  test('Test isNullOrEmpty property', () {
    const text = '';
    expect(text.ext.isNullOrEmpty, isTrue);
  });

  test('Test isNotNullOrNoEmpty property', () {
    const text = 'Hello';
    expect(text.ext.isNotNullOrNoEmpty, isTrue);
  });

  test('Test isValidEmail property', () {
    const email = 'test@example.com';
    expect(email.ext.isValidEmail, isTrue);
  });

  test('Test isValidPassword method', () {
    const validPassword = 'Password123!';
    const invalidPassword1 = 'password';
    const invalidPassword2 = '12345678';
    const invalidPassword3 = 'PASSWORD';
    const invalidPassword4 = 'Password!';
    const invalidPassword5 = 'Password123';

    expect(validPassword.ext.isValidPassword, isTrue);
    expect(invalidPassword1.ext.isValidPassword, isFalse);
    expect(invalidPassword2.ext.isValidPassword, isFalse);
    expect(invalidPassword3.ext.isValidPassword, isFalse);
    expect(invalidPassword4.ext.isValidPassword, isFalse);
    expect(invalidPassword5.ext.isValidPassword, isFalse);
  });

  test('Test withoutSpecialCharacters property', () {
    const text = 'héllö wôrld';
    expect(text.ext.withoutSpecialCharacters, equals('hello world'));
  });

  test('Test bearer property', () {
    const token = 'abcd1234';
    expect(token.ext.bearer, equals({'Authorization': 'Bearer abcd1234'}));
  });

  test('Test phoneFormatValue method', () {
    const phoneNumber = '0(123) 456-78-99';
    final formattedPhoneNumber = phoneNumber.ext.phoneFormatValue;
    expect(formattedPhoneNumber, equals('1234567899'));
  });

  test('Test timeFormatValue method', () {
    const timeString = '12/31/2021';
    final formattedTime = timeString.ext.timeFormatValue;
    expect(formattedTime, equals('12312021'));
  });

  test('Test timeOverlineFormatValue method', () {
    const timeString = '2022-11-05';
    final formattedTime = timeString.ext.timeOverlineFormatValue;
    expect(formattedTime, equals('20221105'));
  });

  test('Test randomImage property', () {
    final randomImage = ''.ext.randomImage;
    expect(randomImage, isNotEmpty);
  });

  test('Test randomSquareImage property', () {
    final randomSquareImage = ''.ext.randomSquareImage;
    expect(randomSquareImage, isNotEmpty);
  });

  test('Test customProfileImage property', () {
    final customProfileImage = ''.ext.customProfileImage;
    expect(customProfileImage, isNotEmpty);
  });

  test('Test customHighProfileImage property', () {
    final customHighProfileImage = ''.ext.customHighProfileImage;
    expect(customHighProfileImage, isNotEmpty);
  });

  test('Test colorCode property', () {
    const hexColor = 'FF0000';
    expect(hexColor.ext.colorCode, equals(0xFFFF0000));
  });

  test('Test toColor property', () {
    const hexColor = 'FF0000';
    expect(hexColor.ext.toColor, equals(const Color(0xFFFF0000)));
  });

  test('Test safeJsonDecodeCompute property', () async {
    const response = '{"name": "John Doe"}';

    final jsonMap =
        await response.ext.safeJsonDecodeCompute<Map<String, dynamic>>();

    if (jsonMap != null) {
      final name = jsonMap['name'];
      expect(name, equals('John Doe'));
    }
  });

  test('Test safeJsonEncodeCompute property', () async {
    final user = _User('veli');
    final jsonEncodedUser = await user.toJson().ext.safeJsonEncodeCompute();
    expect(jsonEncodedUser, isNotNull);
  });

  test('Test toPrimitiveFromGeneric property', () {
    String? valueForNull;
    const valueForEmpty = '';
    const valueForBool = 'true';
    const valueForInt = '1';
    const valueForDouble = '1.0';
    const valueForString = 'Hello World';

    expect(valueForNull.ext.toPrimitiveFromGeneric<bool>(), isNull);
    expect(valueForNull.ext.toPrimitiveFromGeneric<int>(), isNull);
    expect(valueForNull.ext.toPrimitiveFromGeneric<double>(), isNull);
    expect(valueForNull.ext.toPrimitiveFromGeneric<String>(), isNull);
    expect(
      valueForNull.ext.toPrimitiveFromGeneric<List<String>>(),
      isNull,
    );
    expect(
      valueForNull.ext.toPrimitiveFromGeneric<List<List<String>>>(),
      isNull,
    );
    expect(
      valueForNull.ext.toPrimitiveFromGeneric<List<List<List<String>>>>(),
      isNull,
    );

    expect(valueForEmpty.ext.toPrimitiveFromGeneric<bool>(), isNull);
    expect(valueForEmpty.ext.toPrimitiveFromGeneric<int>(), isNull);
    expect(valueForEmpty.ext.toPrimitiveFromGeneric<double>(), isNull);
    expect(valueForEmpty.ext.toPrimitiveFromGeneric<String>(), isEmpty);
    expect(
      () => valueForEmpty.ext.toPrimitiveFromGeneric<List<String>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      () => valueForEmpty.ext.toPrimitiveFromGeneric<List<List<String>>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      valueForEmpty.ext.toPrimitiveFromGeneric<List<List<List<String>>>>(),
      isNull,
    );

    expect(valueForBool.ext.toPrimitiveFromGeneric<bool>(), isTrue);
    expect(valueForBool.ext.toPrimitiveFromGeneric<int>(), isNull);
    expect(valueForBool.ext.toPrimitiveFromGeneric<double>(), isNull);
    expect(
      valueForBool.ext.toPrimitiveFromGeneric<String>(),
      equals(valueForBool),
    );
    expect(
      () => valueForBool.ext.toPrimitiveFromGeneric<List<bool>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      () => valueForBool.ext.toPrimitiveFromGeneric<List<List<bool>>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      valueForBool.ext.toPrimitiveFromGeneric<List<List<List<bool>>>>(),
      isNull,
    );

    expect(valueForInt.ext.toPrimitiveFromGeneric<bool>(), isNull);
    expect(valueForInt.ext.toPrimitiveFromGeneric<int>(), equals(1));
    expect(valueForInt.ext.toPrimitiveFromGeneric<double>(), equals(1.0));
    expect(
      valueForInt.ext.toPrimitiveFromGeneric<String>(),
      equals(valueForInt),
    );
    expect(
      () => valueForInt.ext.toPrimitiveFromGeneric<List<int>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      () => valueForInt.ext.toPrimitiveFromGeneric<List<List<int>>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      valueForInt.ext.toPrimitiveFromGeneric<List<List<List<int>>>>(),
      isNull,
    );

    expect(valueForDouble.ext.toPrimitiveFromGeneric<bool>(), isNull);
    expect(valueForDouble.ext.toPrimitiveFromGeneric<int>(), isNull);
    expect(valueForDouble.ext.toPrimitiveFromGeneric<double>(), equals(1.0));
    expect(
      valueForDouble.ext.toPrimitiveFromGeneric<String>(),
      equals(valueForDouble),
    );
    expect(
      () => valueForDouble.ext.toPrimitiveFromGeneric<List<double>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      () => valueForDouble.ext.toPrimitiveFromGeneric<List<List<double>>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      valueForDouble.ext.toPrimitiveFromGeneric<List<List<List<double>>>>(),
      isNull,
    );

    expect(valueForString.ext.toPrimitiveFromGeneric<bool>(), isNull);
    expect(valueForString.ext.toPrimitiveFromGeneric<int>(), isNull);
    expect(valueForString.ext.toPrimitiveFromGeneric<double>(), isNull);
    expect(
      valueForString.ext.toPrimitiveFromGeneric<String>(),
      equals(valueForString),
    );
    expect(
      () => valueForString.ext.toPrimitiveFromGeneric<List<String>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      () => valueForString.ext.toPrimitiveFromGeneric<List<List<String>>>(),
      throwsA(isA<ListTypeNotSupported>()),
    );
    expect(
      valueForString.ext.toPrimitiveFromGeneric<List<List<List<String>>>>(),
      isNull,
    );
  });

  test('Test launchMaps function it as expected for scenario', () {
    ''.ext.launchMaps();
  });

  group('Test launchMAps', () {
    test('Launch maps with empty text [False]', () async {
      final respsone = await ''.ext.launchMaps();

      expect(respsone, false);
    });

    test('Launch maps with right text [True]', () async {
      final response = await 'Istanbul'.ext.launchMaps(
            callBack: (
              urlString, {
              mode = LaunchMode.externalApplication,
              webOnlyWindowName,
              webViewConfiguration = const WebViewConfiguration(),
            }) =>
                Future.value(true),
          );

      expect(response, true);
    });
  });

  test('Custom link preview test- Success', () async {
    final response = await CustomLinkPreview.getLinkPreviewData(
      'https://www.wnycstudios.org/podcasts/radiolab/podcasts',
    );

    expect(response != null, true);
  });

  test('Custom link preview test- Fail', () async {
    final response = await CustomLinkPreview.getLinkPreviewData(
      'https://www.wnycstudios.org/ss',
    );

    expect(response == null, true);
  });

  test('Custom link preview test- Without url', () async {
    final response = await CustomLinkPreview.getLinkPreviewData(
      'xssxs',
    );

    expect(response == null, true);
  });
}

class _User {
  _User(this.name);

  final String name;

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
