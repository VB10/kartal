import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NumberExtensionView extends StatelessWidget {
  const NumberExtensionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${10.ext.randomColorValue}');
  }
}
