import 'package:flutter/material.dart';
import 'package:kartal/src/list_extension.dart';

class _WidgetExtension {
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

  /// If a List is null, it shows the Widget it takes as a parameter,
  /// otherwise it shows the normally used widget.
  Widget checkNullableWidget({
    required Widget nullWidget,
    List<dynamic>? list,
  }) {
    if (list.ext.isNullOrEmpty) {
      return nullWidget;
    }
    return _widget;
  }
}

extension WidgetExtension on Widget {
  _WidgetExtension get ext => _WidgetExtension(this);

  @Deprecated('Use ext.toVisible instead')
  Widget toVisible(bool value) => value ? this : const SizedBox.shrink();

  @Deprecated('Use ext.toDisabled instead')
  Widget toDisabled([bool? disable, double? opacity]) => IgnorePointer(
        ignoring: disable ?? true,
        child: Opacity(
          opacity: (disable ?? true) ? (opacity ?? 0.2) : 1,
          child: this,
        ),
      );

  @Deprecated('Use ext.sliver instead')
  Widget get sliver => SliverToBoxAdapter(child: this);

  Widget checkNullableWidget({
    required Widget nullWidget,
    List<dynamic>? list,
  }) {
    if (list.ext.isNullOrEmpty) {
      return nullWidget;
    }
    return this;
  }
}
