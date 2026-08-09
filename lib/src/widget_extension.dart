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

  /// Wraps the widget in [Padding] with the same inset on every side.
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: _widget);

  /// Wraps the widget in [Padding] with symmetric insets.
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: _widget,
      );

  /// Wraps the widget in [Padding] with per-side insets.
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: _widget,
  );

  /// Wraps the widget in [Padding] with the given [padding].
  Widget padding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: _widget);

  /// Centers the widget.
  Widget get center => Center(child: _widget);

  /// Wraps the widget in [Expanded], for use inside a [Row] or [Column].
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: _widget);

  /// Wraps the widget in [Flexible], for use inside a [Row] or [Column].
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: _widget);

  /// Makes the widget tappable.
  ///
  /// Uses [InkWell] so the tap produces a ripple. Pass `withRipple: false` for
  /// a [GestureDetector] instead, which is what you want on top of an image or
  /// custom-painted surface.
  Widget onTap(
    VoidCallback onTap, {
    bool withRipple = true,
    BorderRadius? borderRadius,
  }) => withRipple
      ? InkWell(onTap: onTap, borderRadius: borderRadius, child: _widget)
      : GestureDetector(onTap: onTap, child: _widget);

  /// Wraps the widget in a [SafeArea].
  Widget get safeArea => SafeArea(child: _widget);

  /// Attaches a long-press [Tooltip] with the given [message].
  Widget tooltip(String message) => Tooltip(message: message, child: _widget);

  /// Wraps the widget in a [Hero] with the given [tag].
  Widget hero(Object tag) => Hero(tag: tag, child: _widget);

  /// Aligns the widget within its parent.
  Widget align([AlignmentGeometry alignment = Alignment.center]) =>
      Align(alignment: alignment, child: _widget);

  /// Wraps the widget in [Opacity].
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: _widget);

  /// Constrains the widget's size.
  Widget constrained({
    double minWidth = 0,
    double maxWidth = double.infinity,
    double minHeight = 0,
    double maxHeight = double.infinity,
  }) => ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    child: _widget,
  );

  /// Gives the widget a fixed size.
  Widget sized({double? width, double? height}) =>
      SizedBox(width: width, height: height, child: _widget);

  /// Wraps the widget in a [Card].
  Widget card({double? elevation, Color? color, ShapeBorder? shape}) =>
      Card(elevation: elevation, color: color, shape: shape, child: _widget);

  /// Rotates the widget by [quarterTurns] quarter turns.
  Widget rotated(int quarterTurns) =>
      RotatedBox(quarterTurns: quarterTurns, child: _widget);

  /// Clips the widget to a rounded rectangle.
  Widget clipRounded([double radius = 8]) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: _widget);

  /// Wraps the widget in a [Positioned], for use inside a [Stack].
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: _widget,
  );
}
