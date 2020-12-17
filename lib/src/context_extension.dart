import 'dart:math';

import 'package:flutter/material.dart';

import 'widget/sized-box/space_sized_height_box.dart';
import 'widget/sized-box/space_sized_width_box.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get appTheme => Theme.of(this);
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

extension DurationExtension on BuildContext {
  Duration get durationLow => Duration(milliseconds: 500);
  Duration get durationNormal => Duration(seconds: 1);
  Duration get durationSlow => Duration(seconds: 2);
  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: mediumValue);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => SpaceSizedWidthBox(width: 0.03);
  Widget get emptySizedHeightBoxLow => SpaceSizedHeightBox(height: 0.01);
  Widget get emptySizedHeightBoxLow3x => SpaceSizedHeightBox(height: 0.03);
  Widget get emptySizedHeightBoxNormal => SpaceSizedHeightBox(height: 0.05);
  Widget get emptySizedHeightBoxHigh => SpaceSizedHeightBox(height: 0.1);
}

extension RadiusExtension on BuildContext {
  BorderRadius get normalBorderRadius => BorderRadius.all(Radius.circular(width * 0.05));
  BorderRadius get lowBorderRadius => BorderRadius.all(Radius.circular(width * 0.02));
  BorderRadius get highBorderRadius => BorderRadius.all(Radius.circular(width * 0.1));

  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highadius => Radius.circular(width * 0.1);
}

extension EdgeInsetsExtension on BuildContext {
  EdgeInsetsGeometry get lowEdgeInsetsAll => EdgeInsets.all(5);
  EdgeInsetsGeometry get normalEdgeInsetsAll => EdgeInsets.all(10);
  EdgeInsetsGeometry get mediumEdgeInsetsAll => EdgeInsets.all(20);
}

extension BorderExtension on BuildContext {
  RoundedRectangleBorder get roundedRectangleBorderLow => RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)));

  RoundedRectangleBorder get roundedRectangleAllBorderNormal => RoundedRectangleBorder(borderRadius: BorderRadius.circular(normalValue));

  RoundedRectangleBorder get roundedRectangleBorderNormal =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(normalValue)));

  RoundedRectangleBorder get roundedRectangleBorderMedium =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(mediumValue)));

  RoundedRectangleBorder get roundedRectangleBorderHigh =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(highValue)));
}
