import 'package:flutter/material.dart';

extension ContextArgumentsExtension on BuildContext {
  T? routeArgs<T>() {
    final settings = ModalRoute.of(this)?.settings;
    if (settings?.arguments is T) {
      return settings?.arguments as T;
    }
    return null;
  }

  String? get routeName => ModalRoute.of(this)?.settings.name;

  RouteSettings? get routeSettings => ModalRoute.of(this)?.settings;

  bool get isCurrentRouteFirst => ModalRoute.of(this)?.isFirst ?? false;

  bool get isCurrentRouteActive => ModalRoute.of(this)?.isActive ?? false;

  bool get isCurrentRouteCurrent => ModalRoute.of(this)?.isCurrent ?? false;
}

extension ModalRouteExtension on BuildContext {
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  void popUntilFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void popUntilNamed(String routeName) {
    Navigator.of(this).popUntil((route) => route.settings.name == routeName);
  }

  Future<T?> pushReplacement<T, TO>(Route<T> newRoute) =>
      Navigator.of(this).pushReplacement<T, TO>(newRoute);

  Future<T?> pushNamedAndRemoveAll<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(
        routeName,
        (route) => false,
        arguments: arguments,
      );
}
