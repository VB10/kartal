import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('Test isNullOrEmpty property for null list', () {
    List<int>? nullList;
    expect(nullList.ext.isNullOrEmpty, isTrue);
  });

  test('Test isNullOrEmpty property for empty list', () {
    final emptyList = <int>[];
    expect(emptyList.ext.isNullOrEmpty, isTrue);
  });

  test('Test isNullOrEmpty property for non-empty list', () {
    final nonEmptyList = <int>[1, 2, 3];
    expect(nonEmptyList.ext.isNullOrEmpty, isFalse);
  });

  test('Test isNotNullOrEmpty property for null list', () {
    List<int>? nullList;
    expect(nullList.ext.isNotNullOrEmpty, isFalse);
  });

  test('Test isNotNullOrEmpty property for empty list', () {
    final emptyList = <int>[];
    expect(emptyList.ext.isNotNullOrEmpty, isFalse);
  });

  test('Test isNotNullOrEmpty property for non-empty list', () {
    final nonEmptyList = <int>[1, 2, 3];
    expect(nonEmptyList.ext.isNotNullOrEmpty, isTrue);
  });

  test('Test indexOrNull method for finding existing item', () {
    List<String>? stringList = ['apple', 'banana', 'orange'];
    final index = stringList.ext.indexOrNull((item) => item == 'banana');
    expect(index, equals(1));
  });

  test('Test indexOrNull method for finding non-existing item', () {
    List<String>? stringList = ['apple', 'banana', 'orange'];
    final index = stringList.ext.indexOrNull((item) => item == 'grape');
    expect(index, isNull);
  });
}
