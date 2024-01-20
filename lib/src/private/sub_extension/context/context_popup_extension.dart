import 'package:flutter/material.dart';
import 'package:kartal/src/utility/popup_manager/popup_manager.dart';

extension PopupExtension on BuildContext {
  _PopupExtension get popupManager => _ManagerBox.popupExtension ??= _PopupExtension(this);
}

/// This class is used to store [_PopupExtension] instance
abstract class _ManagerBox {
  static _PopupExtension? popupExtension;
}

/// Extension methods for [BuildContext] to show/hide loader
final class _PopupExtension {
  _PopupExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  PopupManager? _manager;

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  /// [barrierDismissible] is false by default
  /// [loaderBuilder] is a optional builder function that returns a widget to show as loader
  void showLoader({Object? id, bool barrierDismissible = false, WidgetBuilder? loaderBuilder}) {
    _manager ??= PopupManager.withState(Navigator.of(_context));
    _manager!.showLoader(id: id, barrierDismissible: barrierDismissible, loaderBuilder: loaderBuilder);
  }

  /// Close loader with given [id]
  /// If id is not provided closes latest shown loader
  void hideLoader({Object? id}) {
    assert(_manager != null, '''
    \nTried to hide loader but navigatorState was null.
    This error occurs when you try to hide loader before showing it.''');
    _manager!.hideLoader(id: id);
  }
}
