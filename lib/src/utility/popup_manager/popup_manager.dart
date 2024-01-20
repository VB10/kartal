import 'package:flutter/material.dart';

/// A [DialogRoute] shows [CircularProgressIndicator] in center
final class LoaderRoute extends DialogRoute<dynamic> {
  @visibleForTesting
  LoaderRoute({
    required super.context,
    required super.builder,
    this.id,
    super.barrierDismissible,
  });

  final Object? id;
}

/// Helper class for showing popups
///
/// [NavigatorState] key or [NavigatorState]'s itself is required either of Root's or Nested Navigator's
@immutable
class PopupManager {
  PopupManager(GlobalKey<NavigatorState> navigatorKey) : _state = navigatorKey.currentState;

  PopupManager.withState(this._state);

  final NavigatorState? _state;
  final _routes = <LoaderRoute>[];

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  void showLoader({Object? id, bool barrierDismissible = false, WidgetBuilder? loaderBuilder}) {
    assert(_state != null, 'Tried to show loader but navigatorState was null.');
    final navigatorState = _state!;
    assert(
      id == null || _routes.where((element) => element.id == id).toList().isEmpty,
      'There is already a loader showing with id: $id',
    );

    final route = LoaderRoute(
      id: id,
      barrierDismissible: barrierDismissible,
      context: navigatorState.context,
      builder: loaderBuilder ??
          (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
    );

    _routes.add(route);
    navigatorState.push(route);
  }

  /// If [id] is provided closes loader with given [id]
  /// If not closes latest shown loader
  void hideLoader({Object? id}) {
    assert(
      id == null || _routes.where((element) => element.id == id).toList().isNotEmpty,
      'Tried to close loader with id: $id which does not exist',
    );
    assert(_state != null, 'Tried to hide loader but navigatorState was null.');
    final navigatorState = _state!;
    if (id == null) {
      navigatorState.removeRoute(_routes.removeLast());
    } else {
      final routeIndex = _routes.indexWhere((element) => element.id == id);
      navigatorState.removeRoute(_routes.removeAt(routeIndex));
    }
  }
}
