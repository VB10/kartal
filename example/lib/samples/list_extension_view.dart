import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ListExtensionView extends StatelessWidget {
  final List values = null;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: values.isNotNullOrEmpty ? Text('ok') : Text('false'),
    );
  }
}
