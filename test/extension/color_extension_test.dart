import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('Test randomColor property', () {
    final randomColor = Colors.red.ext.randomColor;
    expect(
      randomColor,
      isA<MaterialColor>(),
    );
  });

  test('Test withOpacity property', () {
    final withOpacity = Colors.red.ext.withOpacity(0.5);
    expect(
      withOpacity,
      isA<Color>(),
    );
  });
}
