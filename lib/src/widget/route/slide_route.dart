// Enum values are capitalized for backwards compatibility.
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum SlideType {
  RIGHT(offSet: Offset(-1, 0)),
  LEFT(offSet: Offset(1, 0)),
  BOTTOM(offSet: Offset(0, -1)),
  TOP(offSet: Offset(0, 1)),
  DEFAULT();

  const SlideType({this.offSet});

  final Offset? offSet;

  Route<T> route<T>(Widget page, RouteSettings settings) =>
      this == SlideType.DEFAULT
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
