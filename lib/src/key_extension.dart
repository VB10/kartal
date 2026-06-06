import 'package:flutter/material.dart';

extension KeyExtension<T extends State> on GlobalKey<T> {
  _KeyExtension<T> get ext => _KeyExtension<T>(this);
}

final class _KeyExtension<T extends State> {
  _KeyExtension(this._key);
  final GlobalKey<T> _key;

  RenderBox? get rendererBox {
    final element = _key.currentContext as Element?;
    return element?.renderObject as RenderBox?;
  }

  Offset? get offset {
    final box = rendererBox;
    return box?.localToGlobal(Offset.zero);
  }

  double? get height {
    final box = rendererBox;
    return box?.size.height;
  }

  void scrollToWidget({Duration duration = const Duration(milliseconds: 300)}) {
    final box = rendererBox;
    if (box == null) return;
    final context = _key.currentContext;
    if (context == null) return;
    final renderBox = box;
    final position = renderBox.localToGlobal(Offset.zero);
    final scrollable = Scrollable.of(context);
    scrollable.position.animateTo(
      position.dy,
      duration: duration,
      curve: Curves.ease,
    );
  }
}

extension FormKeyExtension on GlobalKey<FormState> {
  bool validateOrFocus() {
    final state = currentState;
    if (state == null) return false;
    return state.validate();
  }

  void resetForm() {
    final state = currentState;
    state?.reset();
  }

  void saveForm() {
    final state = currentState;
    state?.save();
  }

  bool get isValid => currentState?.validate() ?? false;

  bool get isInvalid => !isValid;
}
