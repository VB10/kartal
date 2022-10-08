import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('adds one to input values', () {
    const fifteenLiras = '15';

    expect(fifteenLiras.isNotNullOrNoEmpty, true);
  });

  test('[isnullormepty] check', () {
    const dataEmpty = '';
    String? dataNil;

    expect(dataEmpty.isNullOrEmpty, true);
    expect(dataNil.isNullOrEmpty, true);
  });

  test('Remove special characters - çamur', () {
    final correctText = 'çamur'.withoutSpecialCharacters;
    expect(correctText, 'camur');
  });
  group('toTitle Tests', () {
    test('test no word title case', () async {
      const text = 'hello world';
      const expected = 'Hello World';
      expect(text.toTitleCase(), expected);
    });
    test('test some letters title case', () async {
      const text = 'hElLo wOrLd';
      const expected = 'Hello World';
      expect(text.toTitleCase(), expected);
    });
    test('test one word title case', () async {
      const text = 'hello World';
      const expected = 'Hello World';
      expect(text.toTitleCase(), expected);
    });
    test('test empty', () async {
      const text = '';
      const expected = '';
      expect(text.toTitleCase(), expected);
    });
    test('test null string', () async {
      const String? text = null;
      const expected = '';
      expect(text.toTitleCase(), expected);
    });
  });

  group('Email Regex', () {
    test('test email', () async {
      const text = 'v@x-y.com';
      expect(text.isValidEmail, true);
    });

    test('test email', () async {
      const text = 'veli+plus@x-y.com';
      expect(text.isValidEmail, true);
    });
  });

  group('toCapitalized Tests', () {
    test('test no word capitalize case', () async {
      const text = 'helLo world';
      const expected = 'Hello world';
      expect(text.toCapitalized(), expected);
    });
    test('test one word title case', () async {
      const text = 'hello WoRlD';
      const expected = 'Hello world';
      expect(text.toCapitalized(), expected);
    });
    test('test one word title case', () async {
      const text = 'hello World';
      const expected = 'Hello world';
      expect(text.toCapitalized(), expected);
    });
    test('test empty', () async {
      const text = '';
      const expected = '';
      expect(text.toCapitalized(), expected);
    });

    test('test null string', () async {
      const String? text = null;
      const expected = '';
      expect(text.toCapitalized(), expected);
    });
  });
}
