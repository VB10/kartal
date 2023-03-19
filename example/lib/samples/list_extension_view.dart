import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ListExtensionView extends StatelessWidget {
  const ListExtensionView({super.key});

  final List? values = null;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: values.isNotNullOrEmpty ? const Text('ok') : const Text('false'),
    );
  }
}
