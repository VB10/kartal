import 'package:flutter/material.dart';

/// Provides convenient access to widgets that apply rotation animations to an [image].
class _ImageExtension {
  _ImageExtension(this.image);
  final Image image;

  /// Returns a [RotationTransition] widget that applies a right rotation animation to the [image].
  Widget get rightRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.5),
        child: image,
      );

  /// Returns a [RotationTransition] widget that applies an up rotation animation to the [image].
  Widget get upRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.25),
        child: image,
      );

  /// Returns a [RotationTransition] widget that applies a bottom rotation animation to the [image].
  Widget get bottomRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.75),
        child: image,
      );

  /// Returns a [RotationTransition] widget that applies a left rotation animation to the [image].
  Widget get leftRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(1),
        child: image,
      );
}

extension ImageRotateExtension on Image {
  _ImageExtension get ext => _ImageExtension(this);

  @Deprecated('Use ext.rightRotation instead')
  Widget get rightRotation =>
      RotationTransition(turns: const AlwaysStoppedAnimation(0.5), child: this);
  @Deprecated('Use ext.rightRotation instead')
  Widget get upRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.25),
        child: this,
      );

  @Deprecated('Use ext.rightRotation instead')
  Widget get bottomRotation => RotationTransition(
        turns: const AlwaysStoppedAnimation(0.75),
        child: this,
      );

  @Deprecated('Use ext.rightRotation instead')
  Widget get leftRotation =>
      RotationTransition(turns: const AlwaysStoppedAnimation(1), child: this);
}
