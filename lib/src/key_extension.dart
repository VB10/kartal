import 'package:flutter/material.dart';

/// Extension methods for [GlobalKey] to provide convenient access to properties and methods related to rendering and scrolling of widgets.
extension KeyExtension<T extends State> on GlobalKey<T> {
  /// Provides convenient access to properties and methods related to rendering and scrolling of widgets.
  _KeyExtension<T> get ext => _KeyExtension<T>(this);
}

/// Provides convenient access to properties and methods related to rendering and scrolling of widgets.
final class _KeyExtension<T extends State> {
  const _KeyExtension(GlobalKey<T> key) : _key = key;
  final GlobalKey<T> _key;

  /// Returns the [RenderBox] associated with the current widget.
  RenderBox? get rendererBox {
    final object = _key.currentContext?.findRenderObject();
    if (object == null) return null;
    if (object is! RenderBox) return null;

    return object;
  }

  /// Returns the global offset of the current widget.
  Offset? get offset => rendererBox?.localToGlobal(Offset.zero);

  /// Returns the height of the current widget.
  double? get height => rendererBox?.size.height;

  /// Scrolls to the current widget.
  Future<void> scrollToWidget({
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) async {
    if (_key.currentContext == null) return;
    await Scrollable.ensureVisible(
      _key.currentContext!,
      alignmentPolicy: alignmentPolicy,
    );
  }
}
