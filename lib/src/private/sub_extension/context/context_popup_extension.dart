import 'package:flutter/material.dart';
import 'package:kartal/src/utility/popup_manager/popup_manager.dart';

/// Extension methods for [BuildContext] to show/hide a loader popup.
extension PopupExtension on BuildContext {
  /// Provides convenient access to loader popup helpers.
  _PopupExtension get popupManager => _PopupExtension(this);
}

/// Holds one [PopupManager] per [NavigatorState].
///
/// An [Expando] is used rather than a [Map] so that a navigator becoming
/// garbage does not keep its manager — and the routes it references — alive.
final Expando<PopupManager> _managers = Expando<PopupManager>(
  'kartal.popupManager',
);

/// Extension methods for [BuildContext] to show/hide loader
final class _PopupExtension {
  _PopupExtension(this._context);

  final BuildContext _context;

  NavigatorState get _navigator => Navigator.of(_context, rootNavigator: true);

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a
  /// specific one
  /// [barrierDismissible] is false by default
  /// [widgetBuilder] is a optional builder function that returns a widget to
  /// show as loader
  void showLoader({
    String? id,
    bool barrierDismissible = false,
    WidgetBuilder? widgetBuilder,
  }) {
    final navigator = _navigator;

    (_managers[navigator] ??= PopupManager.withState(navigator)).showLoader(
      id: id,
      barrierDismissible: barrierDismissible,
      widgetBuilder: widgetBuilder,
    );
  }

  /// Close loader with given [id]
  /// If id is not provided closes latest shown loader
  ///
  /// Does nothing when no loader has been shown for this navigator, so it is
  /// safe to call from cleanup paths such as `finally` blocks.
  void hideLoader({String? id}) {
    final manager = _managers[_navigator];

    assert(manager != null, '''
    \nTried to hide loader but no loader has been shown for this navigator.
    This error occurs when you try to hide loader before showing it.''');

    manager?.hideLoader(id: id);
  }
}
