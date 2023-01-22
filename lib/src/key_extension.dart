import 'package:flutter/material.dart';

extension KeyExtension on GlobalKey {
  /// Object box
  ///
  /// You can control your widget with key
  RenderBox? get rendererBox {
    final object = currentContext?.findRenderObject();
    if (object == null) return null;
    if (object is! RenderBox) return null;

    return object;
  }

  Offset? get offset => rendererBox?.localToGlobal(Offset.zero);

  double? get height => rendererBox?.size.height;
}

extension GlobalObjectScroll on GlobalObjectKey {
  /// Scroll to specific widget
  void scrollToWidget({
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
  }) {
    if (currentContext == null) return;
    Scrollable.ensureVisible(currentContext!, alignmentPolicy: alignmentPolicy);
  }
}
