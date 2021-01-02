import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NumberExtensionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${10.randomColorValue}'),
    );
  }
}
