import 'package:flutter/material.dart';

/// Provides convenient access to properties and methods related to rendering and scrolling of widgets.
class _KeyExtension<T extends State> {
  _KeyExtension(this.key);
  final GlobalKey<T> key;

  /// Returns the [RenderBox] associated with the current widget.
  RenderBox? get rendererBox {
    final object = key.currentContext?.findRenderObject();
    if (object == null) return null;
    if (object is! RenderBox) return null;

    return object;
  }

  /// Returns the global offset of the current widget.
  Offset? get offset => rendererBox?.localToGlobal(Offset.zero);

  /// Returns the height of the current widget.
  double? get height => rendererBox?.size.height;

  /// Scrolls to the current widget.
  void scrollToWidget({
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    if (key.currentContext == null) return;
    Scrollable.ensureVisible(
      key.currentContext!,
      alignmentPolicy: alignmentPolicy,
    );
  }
}

extension KeyExtension<T extends State> on GlobalKey<T> {
  _KeyExtension<T> get ext => _KeyExtension<T>(this);

  @Deprecated('Use ext.rendererBox instead')
  RenderBox? get rendererBox {
    final object = currentContext?.findRenderObject();
    if (object == null) return null;
    if (object is! RenderBox) return null;

    return object;
  }

  @Deprecated('Use ext.offset instead')
  Offset? get offset => rendererBox?.localToGlobal(Offset.zero);

  @Deprecated('Use ext.height instead')
  double? get height => rendererBox?.size.height;

  @Deprecated('Use ext.scrollToWidget instead')
  void scrollToWidget({
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    if (currentContext == null) return;
    Scrollable.ensureVisible(currentContext!, alignmentPolicy: alignmentPolicy);
  }
}
