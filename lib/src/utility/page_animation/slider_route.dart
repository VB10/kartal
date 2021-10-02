import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum SlideType { RIGHT, LEFT, BOTTOM, TOP, DEFAULT }

extension SlideTypeExtension on SlideType {
  Route route(Widget page, RouteSettings settings) {
    switch (this) {
      case SlideType.RIGHT:
        return _SlideRightRoute(page: page, settings: settings);

      case SlideType.TOP:
        return _SlideTopRoute(page: page, settings: settings);

      case SlideType.BOTTOM:
        return _SlideBottomRoute(page: page, settings: settings);

      case SlideType.LEFT:
        return _SlideLeftRoute(page: page, settings: settings);

      case SlideType.DEFAULT:
        return MaterialPageRoute(builder: (context) => page, settings: settings);
    }
  }
}

class _SlideRightRoute extends PageRouteBuilder {
  _SlideRightRoute({RouteSettings? settings, required Widget page})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child),
        );
}

class _SlideLeftRoute extends PageRouteBuilder {
  _SlideLeftRoute({RouteSettings? settings, required Widget page})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class _SlideTopRoute extends PageRouteBuilder {
  _SlideTopRoute({RouteSettings? settings, required Widget page})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class _SlideBottomRoute extends PageRouteBuilder {
  _SlideBottomRoute({required RouteSettings settings, required Widget page})
      : super(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
