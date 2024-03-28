// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WidgetExtensionViews extends StatelessWidget {
  const WidgetExtensionViews({super.key});

  final bool isDataValid = false;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Text(
            'is data not found',
          ).ext.toVisible(
                value: isDataValid,
              ),
          const Text(
            'is data not found',
          ).ext.toDisabled(
                opacity: 0.5,
                disable: true,
              ),
        ],
      );
}
