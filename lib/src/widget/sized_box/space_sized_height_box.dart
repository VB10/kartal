import 'package:flutter/material.dart';

import 'package:kartal/kartal.dart';

class SpaceSizedHeightBox extends StatelessWidget {
  const SpaceSizedHeightBox({super.key, required this.height})
      : assert(height > 0 && height <= 1, 'Height');
  final double height;
  @override
  Widget build(BuildContext context) =>
      SizedBox(height: context.height * height);
}
