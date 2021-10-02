import 'package:flutter/material.dart';

extension ImageRotateExtension on Image {
  Widget get rightRotation => RotationTransition(turns: const AlwaysStoppedAnimation(0.5), child: this);
  Widget get upRotation => RotationTransition(turns: const AlwaysStoppedAnimation(0.25), child: this);
  Widget get bottomRotation => RotationTransition(turns: const AlwaysStoppedAnimation(0.75), child: this);
  Widget get leftRotation => RotationTransition(turns: const AlwaysStoppedAnimation(1), child: this);
}
