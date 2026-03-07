import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ListExtensionView extends StatelessWidget {
  const ListExtensionView({this.values, super.key});

  final List<void>? values;
  @override
  Widget build(BuildContext context) => Container(
        child: values.ext.isNotNullOrEmpty
            ? const Text('ok')
            : const Text('false'),
      );
}
