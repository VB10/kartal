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
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get horizontalPaddingMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get horizontalPaddingHigh => EdgeInsets.symmetric(horizontal: highValue);

  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get verticalPaddingNormal => EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get verticalPaddingMedium => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get verticalPaddingHigh => EdgeInsets.symmetric(vertical: highValue);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => SpaceSizedWidthBox(width: 0.01);
  Widget get emptySizedWidthBoxLow3x => SpaceSizedWidthBox(width: 0.03);
  Widget get emptySizedWidthBoxNormal => SpaceSizedWidthBox(width: 0.53);
  Widget get emptySizedWidthBoxHigh => SpaceSizedWidthBox(width: 0.1);

  Widget get emptySizedHeightBoxLow => SpaceSizedHeightBox(height: 0.01);
  Widget get emptySizedHeightBoxLow3x => SpaceSizedHeightBox(height: 0.03);
  Widget get emptySizedHeightBoxNormal => SpaceSizedHeightBox(height: 0.05);
  Widget get emptySizedHeightBoxHigh => SpaceSizedHeightBox(height: 0.1);
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highadius => Radius.circular(width * 0.1);
}

extension BorderExtension on BuildContext {
  BorderRadius get normalBorderRadius => BorderRadius.all(Radius.circular(width * 0.05));
  BorderRadius get lowBorderRadius => BorderRadius.all(Radius.circular(width * 0.02));
  BorderRadius get highBorderRadius => BorderRadius.all(Radius.circular(width * 0.1));

  RoundedRectangleBorder get roundedRectangleBorderLow => RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)));

  RoundedRectangleBorder get roundedRectangleAllBorderNormal => RoundedRectangleBorder(borderRadius: BorderRadius.circular(normalValue));

  RoundedRectangleBorder get roundedRectangleBorderNormal =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(normalValue)));

  RoundedRectangleBorder get roundedRectangleBorderMedium =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(mediumValue)));

  RoundedRectangleBorder get roundedRectangleBorderHigh =>
      RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(highValue)));
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigation => Navigator.of(this);

  Future<void> pop() async {
    return await navigation.maybePop();
  }

  Future<T> navigateName<T>(String path, {Object data}) async {
    return await navigation.pushNamed<T>(path, arguments: data);
  }

  Future<T> navigateToReset<T>(String path, {Object data}) async {
    return await navigation.pushNamedAndRemoveUntil(path, (route) => false, arguments: data);
  }
}
