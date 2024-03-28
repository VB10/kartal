import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

final class SpaceSizedHeightBox extends StatelessWidget {
  const SpaceSizedHeightBox({
    required this.height,
    super.key,
  }) : assert(height > 0 && height <= 1, 'Height must be between 0 and 1');
  final double height;
  @override
  Widget build(BuildContext context) =>
      SizedBox(height: context.sized.height * height);
}
