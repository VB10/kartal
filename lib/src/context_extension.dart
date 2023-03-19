import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kartal/src/constants/responsivity_constants.dart';
import 'package:kartal/src/utility/page_animation/slider_route.dart';
import 'package:kartal/src/widget/sized-box/space_sized_height_box.dart';
import 'package:kartal/src/widget/sized-box/space_sized_width_box.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get appTheme => Theme.of(this);
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  double get keyboardPadding => MediaQuery.of(this).viewInsets.bottom;
  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;

  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
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

//Device operating system checking with context value
extension DeviceOSExtension on BuildContext {
  bool get isAndroidDevice => Platform.isAndroid;
  bool get isIOSDevice => Platform.isIOS;
  bool get isWindowsDevice => Platform.isWindows;
  bool get isLinuxDevice => Platform.isLinux;
  bool get isMacOSDevice => Platform.isMacOS;
}

//Device Screen Type By Width(300-600-900)
//Values from https://flutter.dev/docs/development/ui/layout/building-adaptive-apps
extension ContextDeviceTypeExtension on BuildContext {
  bool get isSmallScreen {
    return width >= ResponsibilityConstants.instance().smallScreenSize &&
        width < ResponsibilityConstants.instance().mediumScreenSize;
  }

  bool get isMediumScreen {
    return width >= ResponsibilityConstants.instance().mediumScreenSize &&
        width < ResponsibilityConstants.instance().largeScreenSize;
  }

  bool get isLargeScreen {
    return width >= ResponsibilityConstants.instance().largeScreenSize;
  }
}

extension DurationExtension on BuildContext {
  Duration get durationLow => const Duration(milliseconds: 500);
  Duration get durationNormal => const Duration(seconds: 1);
  Duration get durationSlow => const Duration(seconds: 2);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  EdgeInsets get horizontalPaddingLow {
    return EdgeInsets.symmetric(horizontal: lowValue);
  }

  EdgeInsets get horizontalPaddingNormal {
    return EdgeInsets.symmetric(horizontal: normalValue);
  }

  EdgeInsets get horizontalPaddingMedium {
    return EdgeInsets.symmetric(horizontal: mediumValue);
  }

  EdgeInsets get horizontalPaddingHigh {
    return EdgeInsets.symmetric(horizontal: highValue);
  }

  EdgeInsets get verticalPaddingLow {
    return EdgeInsets.symmetric(vertical: lowValue);
  }

  EdgeInsets get verticalPaddingNormal {
    return EdgeInsets.symmetric(vertical: normalValue);
  }

  EdgeInsets get verticalPaddingMedium {
    return EdgeInsets.symmetric(vertical: mediumValue);
  }

  EdgeInsets get verticalPaddingHigh {
    return EdgeInsets.symmetric(vertical: highValue);
  }

  EdgeInsets get onlyLeftPaddingLow {
    return EdgeInsets.only(left: lowValue);
  }

  EdgeInsets get onlyLeftPaddingNormal {
    return EdgeInsets.only(left: normalValue);
  }

  EdgeInsets get onlyLeftPaddingMedium {
    return EdgeInsets.only(left: mediumValue);
  }

  EdgeInsets get onlyLeftPaddingHigh {
    return EdgeInsets.only(left: highValue);
  }

  EdgeInsets get onlyRightPaddingLow {
    return EdgeInsets.only(right: lowValue);
  }

  EdgeInsets get onlyRightPaddingNormal {
    return EdgeInsets.only(right: normalValue);
  }

  EdgeInsets get onlyRightPaddingMedium {
    return EdgeInsets.only(right: mediumValue);
  }

  EdgeInsets get onlyRightPaddingHigh {
    return EdgeInsets.only(right: highValue);
  }

  EdgeInsets get onlyBottomPaddingLow {
    return EdgeInsets.only(bottom: lowValue);
  }

  EdgeInsets get onlyBottomPaddingNormal {
    return EdgeInsets.only(bottom: normalValue);
  }

  EdgeInsets get onlyBottomPaddingMedium {
    return EdgeInsets.only(bottom: mediumValue);
  }

  EdgeInsets get onlyBottomPaddingHigh {
    return EdgeInsets.only(bottom: highValue);
  }

  EdgeInsets get onlyTopPaddingLow {
    return EdgeInsets.only(top: lowValue);
  }

  EdgeInsets get onlyTopPaddingNormal {
    return EdgeInsets.only(top: normalValue);
  }

  EdgeInsets get onlyTopPaddingMedium {
    return EdgeInsets.only(top: mediumValue);
  }

  EdgeInsets get onlyTopPaddingHigh {
    return EdgeInsets.only(top: highValue);
  }
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow {
    return const SpaceSizedWidthBox(width: 0.01);
  }

  Widget get emptySizedWidthBoxLow3x {
    return const SpaceSizedWidthBox(width: 0.03);
  }

  Widget get emptySizedWidthBoxNormal {
    return const SpaceSizedWidthBox(width: 0.05);
  }

  Widget get emptySizedWidthBoxHigh {
    return const SpaceSizedWidthBox(width: 0.1);
  }

  Widget get emptySizedHeightBoxLow {
    return const SpaceSizedHeightBox(height: 0.01);
  }

  Widget get emptySizedHeightBoxLow3x {
    return const SpaceSizedHeightBox(height: 0.03);
  }

  Widget get emptySizedHeightBoxNormal {
    return const SpaceSizedHeightBox(height: 0.05);
  }

  Widget get emptySizedHeightBoxHigh {
    return const SpaceSizedHeightBox(height: 0.1);
  }
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highRadius => Radius.circular(width * 0.1);
}

extension BorderExtension on BuildContext {
  BorderRadius get normalBorderRadius {
    return BorderRadius.all(Radius.circular(width * 0.05));
  }

  BorderRadius get lowBorderRadius {
    return BorderRadius.all(Radius.circular(width * 0.02));
  }

  BorderRadius get highBorderRadius {
    return BorderRadius.all(Radius.circular(width * 0.1));
  }

  RoundedRectangleBorder get roundedRectangleBorderLow {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)),
    );
  }

  RoundedRectangleBorder get roundedRectangleAllBorderNormal {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(normalValue),
    );
  }

  RoundedRectangleBorder get roundedRectangleBorderNormal {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(normalValue)),
    );
  }

  RoundedRectangleBorder get roundedRectangleBorderMedium {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(mediumValue)),
    );
  }

  RoundedRectangleBorder get roundedRectangleBorderHigh {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(highValue)),
    );
  }
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigation => Navigator.of(this);

  Future<bool> pop<T>([T? data]) async {
    return navigation.maybePop(data);
  }

  void popWithRoot() => Navigator.of(this, rootNavigator: true).pop();

  Future<T?> navigateName<T>(String path, {Object? data}) async {
    return navigation.pushNamed<T>(path, arguments: data);
  }

  Future<T?> navigateToReset<T>(String path, {Object? data}) async {
    return navigation.pushNamedAndRemoveUntil(
      path,
      (route) => false,
      arguments: data,
    );
  }

  Future<T?> navigateToPage<T>(
    Widget page, {
    Object? extra,
    SlideType type = SlideType.DEFAULT,
  }) async {
    return navigation.push<T>(
      type.route(page, RouteSettings(arguments: extra)),
    );
  }
}
