import 'package:flutter/material.dart';

extension ImageRotateExtension on Image {
  _ImageExtension get ext => _ImageExtension(this);
}

/// Provides convenient access to widgets that apply rotation animations to an [Image].
final class _ImageExtension {
  _ImageExtension(Image image) : _image = image;
  final Image _image;

  /// Returns a [RotationTransition] widget that applies a right rotation animation to the [Image].
  Widget get rightRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.5),
        child: _image,
      );

  /// Returns a [RotationTransition] widget that applies an up rotation animation to the [Image].
  Widget get upRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.25),
        child: _image,
      );

  /// Returns a [RotationTransition] widget that applies a bottom rotation animation to the [Image].
  Widget get bottomRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.75),
        child: _image,
      );

  /// Returns a [RotationTransition] widget that applies a left rotation animation to the [Image].
  Widget get leftRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(1),
        child: _image,
      );
}
