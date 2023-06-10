import 'package:flutter/material.dart';

import 'package:kartal/kartal.dart';

class _ContextNavigationExtension {
  _ContextNavigationExtension(this.context);

  final BuildContext context;

  /// Returns the [NavigatorState] associated with the current [BuildContext].
  NavigatorState get navigation => Navigator.of(context);

  /// Pops the top route from the [Navigator] stack and returns a [Future] that completes with
  /// `true` if the route was successfully popped or `false` otherwise. Optionally, you can pass
  /// [data] to be returned as the result of the pop operation.
  Future<bool> pop<T extends Object?>([T? data]) async =>
      navigation.maybePop(data);

  /// Pops all routes until the root route from the [Navigator] stack.
  void popWithRoot() => Navigator.of(context, rootNavigator: true).pop();

  /// Pushes a named route onto the [Navigator] stack identified by [path]. You can optionally pass
  /// [data] to be passed as arguments to the pushed route. Returns a [Future] that completes with
  /// the result value returned by the route.
  Future<T?> navigateName<T extends Object?>(
    String path, {
    Object? data,
  }) async =>
      navigation.pushNamed<T>(path, arguments: data);

  /// Pushes a named route onto the [Navigator] stack identified by [path] and removes all the
  /// existing routes until the new route becomes the only one in the stack. You can optionally pass
  /// [data] to be passed as arguments to the pushed route. Returns a [Future] that completes with
  /// the result value returned by the route.
  Future<T?> navigateToReset<T extends Object?>(
    String path, {
    Object? data,
  }) async =>
      navigation.pushNamedAndRemoveUntil(
        path,
        (route) => false,
        arguments: data,
      );

  /// Pushes a custom [page] onto the [Navigator] stack. You can optionally pass [extra] data to be
  /// passed as arguments to the pushed page. The [type] parameter specifies the transition type
  /// when pushing the page, with the default value being [SlideType.DEFAULT]. Returns a [Future]
  /// that completes with the result value returned by the page.
  Future<T?> navigateToPage<T extends Object?>(
    Widget page, {
    Object? extra,
    SlideType type = SlideType.DEFAULT,
  }) async =>
      navigation.push<T>(
        type.route(page, RouteSettings(arguments: extra)),
      );
}

extension NavigationExtension on BuildContext {
  _ContextNavigationExtension get route => _ContextNavigationExtension(this);

  @Deprecated('Use ext.navigation instead')
  NavigatorState get navigation => Navigator.of(this);

  @Deprecated('Use ext.pop instead')
  Future<bool> pop<T extends Object?>([T? data]) async =>
      navigation.maybePop(data);

  @Deprecated('Use ext.popWithRoot instead')
  void popWithRoot() => Navigator.of(this, rootNavigator: true).pop();

  @Deprecated('Use ext.navigateName instead')
  Future<T?> navigateName<T extends Object?>(
    String path, {
    Object? data,
  }) async =>
      navigation.pushNamed<T>(path, arguments: data);

  @Deprecated('Use ext.navigateToReset instead')
  Future<T?> navigateToReset<T extends Object?>(
    String path, {
    Object? data,
  }) async =>
      navigation.pushNamedAndRemoveUntil(
        path,
        (route) => false,
        arguments: data,
      );

  @Deprecated('Use ext.navigateToPage instead')
  Future<T?> navigateToPage<T extends Object?>(
    Widget page, {
    Object? extra,
    SlideType type = SlideType.DEFAULT,
  }) async =>
      navigation.push<T>(
        type.route(page, RouteSettings(arguments: extra)),
      );
}
