import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WidgetExtensionViews extends StatelessWidget {
  final bool isDataValid = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('is data not found'),
    ).toVisible(isDataValid);
  }
}
