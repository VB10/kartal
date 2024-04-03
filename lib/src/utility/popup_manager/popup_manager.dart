import 'package:flutter/material.dart';

/// A [DialogRoute] shows [CircularProgressIndicator] in center
final class LoaderRoute extends DialogRoute<void> {
  @visibleForTesting
  LoaderRoute({
    required super.context,
    required super.builder,
    this.id,
    super.barrierDismissible,
  });

  final String? id;
}

/// Helper class for showing popups
///
/// [NavigatorState] key or [NavigatorState]'s itself is required either of Root's or Nested Navigator's
@immutable
final class PopupManager {
  /// It is recommended to use root navigator's key
  PopupManager(GlobalKey<NavigatorState> navigatorKey)
      : _state = navigatorKey.currentState;

  /// It is recommended to set rootNavigator: true eg. Navigator.of(context, rootNavigator: true)
  PopupManager.withState(this._state);

  final NavigatorState? _state;
  final _routes = <LoaderRoute>[];

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  void showLoader({
    String? id,
    bool barrierDismissible = false,
    WidgetBuilder? widgetBuilder,
  }) {
    assert(_state != null, 'Tried to show loader but navigatorState was null.');

    assert(
      id == null || _routes.where((element) => element.id == id).isEmpty,
      'There is already a loader showing with id: $id',
    );

    final route = LoaderRoute(
      id: id,
      barrierDismissible: barrierDismissible,
      context: _state!.context,
      builder: widgetBuilder ??
          (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
    );

    _routes.add(route);
    _state.push(route);
  }

  /// If [id] is provided closes loader with given [id]
  /// If not closes latest shown loader
  void hideLoader({String? id}) {
    assert(
      id == null || _routes.where((element) => element.id == id).isNotEmpty,
      'Tried to close loader with id: $id which does not exist',
    );
    assert(_state != null, 'Tried to hide loader but navigatorState was null.');

    if (id == null) {
      _state!.removeRoute(_routes.removeLast());
      return;
    }
    final routeIndex = _routes.indexWhere((element) => element.id == id);
    _state!.removeRoute(_routes.removeAt(routeIndex));
  }
}
