import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NumberExtensionView extends StatelessWidget {
  const NumberExtensionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.ph,
        Text('${10.randomColorValue}'),
        10.ph,
      ],
    );
  }
}
