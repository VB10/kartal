import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('Test isNullOrEmpty property for null list', () {
    List<int>? nullList;
    expect(nullList.isNullOrEmpty, isTrue);
  });

  test('Test isNullOrEmpty property for empty list', () {
    final emptyList = <int>[];
    expect(emptyList.isNullOrEmpty, isTrue);
  });

  test('Test isNullOrEmpty property for non-empty list', () {
    final nonEmptyList = <int>[1, 2, 3];
    expect(nonEmptyList.isNullOrEmpty, isFalse);
  });

  test('Test isNotNullOrEmpty property for null list', () {
    List<int>? nullList;
    expect(nullList.isNotNullOrEmpty, isFalse);
  });

  test('Test isNotNullOrEmpty property for empty list', () {
    final emptyList = <int>[];
    expect(emptyList.isNotNullOrEmpty, isFalse);
  });

  test('Test isNotNullOrEmpty property for non-empty list', () {
    final nonEmptyList = <int>[1, 2, 3];
    expect(nonEmptyList.isNotNullOrEmpty, isTrue);
  });

  test('Test indexOrNull method for finding existing item', () {
    List<String>? stringList = ['apple', 'banana', 'orange'];
    final index = stringList.indexOrNull((item) => item == 'banana');
    expect(index, equals(1));
  });

  test('Test indexOrNull method for finding non-existing item', () {
    List<String>? stringList = ['apple', 'banana', 'orange'];
    final index = stringList.indexOrNull((item) => item == 'grape');
    expect(index, isNull);
  });
}
