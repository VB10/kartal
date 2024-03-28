import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

// Assuming 'sized' is a custom class you've attached to your BuildContext
final class FakeSized extends Fake {
  FakeSized({
    this.width = 100.0, // Default values
    this.lowValue = 5.0,
    this.normalValue = 10.0,
    this.highValue = 15.0,
    this.mediumValue = 12.5,
  });
  final double width;
  final double lowValue;
  final double normalValue;
  final double highValue;
  final double mediumValue;
}
