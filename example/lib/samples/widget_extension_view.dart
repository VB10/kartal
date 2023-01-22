import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WidgetExtensionViews extends StatelessWidget {
  const WidgetExtensionViews({super.key});

  bool get isDataValid => false;

  @override
  Widget build(BuildContext context) {
    return const Text('is data not found').toVisible(isDataValid);
  }
}
