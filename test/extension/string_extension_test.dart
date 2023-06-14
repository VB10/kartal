import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('adds one to input values', () {
    const fifteenLiras = '15';

    expect(fifteenLiras.ext.isNotNullOrNoEmpty, true);
  });

  test('[isnullormepty] check', () {
    const dataEmpty = '';
    String? dataNil;

    expect(dataEmpty.isNullOrEmpty, true);
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
    String? text = 'Hello\nWorld';
    expect(text.ext.lineLength, equals(2));
  });

  test('Test color property', () {
    const hexColor = 'FF0000'; // Kırmızı rengin hexadecimal değeri
    expect(hexColor.ext.color, equals(const Color(0xFFFF0000)));
  });

  test('Test toCapitalized method', () {
    String? text = 'hello world';
    expect(text.ext.toCapitalized(), equals('Hello world'));
  });

  test('Test toTitleCase method', () {
    String? text = 'hello world';
    expect(text.ext.toTitleCase(), equals('Hello World'));
  });

  test('Test isNullOrEmpty property', () {
    String? text = '';
    expect(text.ext.isNullOrEmpty, isTrue);
  });

  test('Test isNotNullOrNoEmpty property', () {
    String? text = 'Hello';
    expect(text.ext.isNotNullOrNoEmpty, isTrue);
  });

  test('Test isValidEmail property', () {
    String? email = 'test@example.com';
    expect(email.ext.isValidEmail, isTrue);
  });

  test('Test isValidPassword method', () {
    String? validPassword = 'Password123!';
    String? invalidPassword1 = 'password';
    String? invalidPassword2 = '12345678';
    String? invalidPassword3 = 'PASSWORD';
    String? invalidPassword4 = 'Password!';
    String? invalidPassword5 = 'Password123';

    expect(validPassword.isValidPassword, isTrue);
    expect(invalidPassword1.isValidPassword, isFalse);
    expect(invalidPassword2.isValidPassword, isFalse);
    expect(invalidPassword3.isValidPassword, isFalse);
    expect(invalidPassword4.isValidPassword, isFalse);
    expect(invalidPassword5.isValidPassword, isFalse);
  });

  test('Test withoutSpecialCharacters property', () {
    String? text = 'héllö wôrld';
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
}
