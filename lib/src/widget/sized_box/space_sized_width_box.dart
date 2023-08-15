import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SpaceSizedWidthBox extends StatelessWidget {
  const SpaceSizedWidthBox({
    required this.width,
    super.key,
  }) : assert(width > 0 && width <= 1, 'Width must be between 0 and 1');
  final double width;
  @override
  Widget build(BuildContext context) =>
      SizedBox(width: context.sized.width * width);
}
