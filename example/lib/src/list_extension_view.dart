// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ListExtensionView extends StatelessWidget {
  const ListExtensionView({super.key});

  final List<void>? values = null;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: values.ext.isNotNullOrEmpty ? const Text('ok') : const Text('false'),
    );
  }
}
