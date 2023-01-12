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
}

extension SlideTypeExtension on SlideType {
  Route<T> route<T>(Widget page, RouteSettings settings) {
    return this == SlideType.DEFAULT
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
}

class _SlideRoute<T> extends PageRouteBuilder<T> {
  _SlideRoute({
    super.settings,
    required Widget page,
    required SlideType slideType,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: slideType.offSet,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
