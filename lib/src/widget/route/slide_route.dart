import 'package:flutter/material.dart';

enum SlideType {
  right(offSet: Offset(-1, 0)),
  left(offSet: Offset(1, 0)),
  bottom(offSet: Offset(0, -1)),
  top(offSet: Offset(0, 1)),
  defaultType();

  const SlideType({this.offSet});

  final Offset? offSet;

  Route<T> route<T>(Widget page, RouteSettings settings) =>
      this == SlideType.defaultType
          ? MaterialPageRoute(
              builder: (context) => page,
              settings: settings,
            )
          : _SlideRoute(
              page: page,
              settings: settings,
              slideType: this,
            );
}

class _SlideRoute<T> extends PageRouteBuilder<T> {
  _SlideRoute({
    required Widget page,
    required SlideType slideType,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: slideType.offSet,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
