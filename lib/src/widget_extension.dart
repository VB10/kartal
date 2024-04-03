import 'package:flutter/material.dart';

/// Extension methods for [Widget] to apply visibility and disable animations.
extension WidgetExtension on Widget {
  /// Widget extension with [ext] property.
  _WidgetExtension get ext => _WidgetExtension(this);
}

final class _WidgetExtension {
  _WidgetExtension(Widget widget) : _widget = widget;

  final Widget _widget;

  /// Returns the widget if [value] is true, otherwise returns a SizedBox with zero size.
  Widget toVisible({bool value = true}) =>
      value ? _widget : const SizedBox.shrink();

  /// Returns a widget that is disabled based on the [disable] parameter.
  /// If [disable] is true, the widget is rendered with reduced opacity using the [Opacity] widget.
  /// If [disable] is false or null, the widget is rendered normally.
  Widget toDisabled({bool? disable, double? opacity}) => IgnorePointer(
        ignoring: disable ?? true,
        child: Opacity(
          opacity: (disable ?? true) ? (opacity ?? 0.2) : 1,
          child: _widget,
        ),
      );

  /// Wraps the widget in a [SliverToBoxAdapter] widget for use in a [CustomScrollView].
  Widget get sliver => SliverToBoxAdapter(child: _widget);
}
