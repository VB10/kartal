import 'package:flutter/material.dart';
import 'package:kartal/src/utility/popup_manager/popup_manager.dart';

extension PopupExtension on BuildContext {
  _PopupExtension get popupManager => _PopupExtension._init(this);
}

/// Extension methods for [BuildContext] to show/hide loader
final class _PopupExtension {
  _PopupExtension(this._context);

  factory _PopupExtension._init(BuildContext context) => _instance ??= _PopupExtension(context);

  final BuildContext _context;

  PopupManager? _manager;

  static _PopupExtension? _instance;

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  /// [barrierDismissible] is false by default
  /// [widgetBuilder] is a optional builder function that returns a widget to show as loader
  void showLoader({String? id, bool barrierDismissible = false, WidgetBuilder? widgetBuilder}) {
    _manager ??= PopupManager.withState(Navigator.of(_context, rootNavigator: true));
    _manager!.showLoader(id: id, barrierDismissible: barrierDismissible, widgetBuilder: widgetBuilder);
  }

  /// Close loader with given [id]
  /// If id is not provided closes latest shown loader
  void hideLoader({String? id}) {
    assert(_manager != null, '''
    \nTried to hide loader but navigatorState was null.
    This error occurs when you try to hide loader before showing it.''');
    _manager!.hideLoader(id: id);
  }
}
