import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kartal/src/int_extension.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension PageContextExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get width => size.width;
  double get height => size.height;
}

extension ColorExtension on BuildContext {
  Color get randomColor => Colors.primaries[17.randomValue];
}

extension MediaQueryExtension on BuildContext {
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.05;
  double get heighValue => height * 0.1;

  double dynamicHeight(double value) => height * value;
  double dynamicWidth(double value) => width * value;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllLow => EdgeInsets.all(lowValue);
}
