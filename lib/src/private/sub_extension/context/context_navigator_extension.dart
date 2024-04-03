import 'package:flutter/material.dart';
import 'package:kartal/src/widget/route/slide_route.dart';

/// Extension methods for [BuildContext] to navigate between routes.
extension NavigationExtension on BuildContext {
  /// Provides convenient access to navigation methods.
  _ContextNavigationExtension get route => _ContextNavigationExtension(this);
}

final class _ContextNavigationExtension {
  _ContextNavigationExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  /// Returns the [NavigatorState] associated with the current [BuildContext].
  NavigatorState get navigation => Navigator.of(_context);

  /// Pops the top route from the [Navigator] stack and returns a [Future] that completes with
  /// `true` if the route was successfully popped or `false` otherwise. Optionally, you can pass
  /// [data] to be returned as the result of the pop operation.
  Future<bool> pop<T extends Object?>([T? data]) async =>
      navigation.maybePop(data);

  /// Pops all routes until the root route from the [Navigator] stack.
  void popWithRoot() => Navigator.of(_context, rootNavigator: true).pop();

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
