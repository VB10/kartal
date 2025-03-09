import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  late Image testImage;

  setUp(() {
    testImage = Image.asset('test_asset.png');
  });

  test('rightRotation returns RotationTransition with 0.5 turns', () {
    final widget = testImage.ext.rightRotation;

    expect(widget, isA<RotationTransition>());
    final rotationTransition = widget as RotationTransition;
    expect(rotationTransition.turns, isA<AlwaysStoppedAnimation<double>>());
    expect((rotationTransition.turns as AlwaysStoppedAnimation<double>).value,
        0.5);
    expect(rotationTransition.child, equals(testImage));
  });

  test('upRotation returns RotationTransition with 0.25 turns', () {
    final widget = testImage.ext.upRotation;

    expect(widget, isA<RotationTransition>());
    final rotationTransition = widget as RotationTransition;
    expect(rotationTransition.turns, isA<AlwaysStoppedAnimation<double>>());
    expect((rotationTransition.turns as AlwaysStoppedAnimation<double>).value,
        0.25);
    expect(rotationTransition.child, equals(testImage));
  });

  test('bottomRotation returns RotationTransition with 0.75 turns', () {
    final widget = testImage.ext.bottomRotation;

    expect(widget, isA<RotationTransition>());
    final rotationTransition = widget as RotationTransition;
    expect(rotationTransition.turns, isA<AlwaysStoppedAnimation<double>>());
    expect((rotationTransition.turns as AlwaysStoppedAnimation<double>).value,
        0.75);
    expect(rotationTransition.child, equals(testImage));
  });

  test('leftRotation returns RotationTransition with 1.0 turns', () {
    final widget = testImage.ext.leftRotation;

    expect(widget, isA<RotationTransition>());
    final rotationTransition = widget as RotationTransition;
    expect(rotationTransition.turns, isA<AlwaysStoppedAnimation<double>>());
    expect((rotationTransition.turns as AlwaysStoppedAnimation<double>).value,
        1.0);
    expect(rotationTransition.child, equals(testImage));
  });
}
