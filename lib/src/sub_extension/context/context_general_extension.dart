import 'dart:math';

import 'package:flutter/material.dart';

/// Provides convenient access to commonly used properties from [MediaQueryData] and [ThemeData]
/// related to the current [BuildContext].
class _ContextGeneralExtension {
  _ContextGeneralExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  /// Returns the [MediaQueryData] associated with the current [BuildContext].
  MediaQueryData get mediaQuery => MediaQuery.of(_context);

  /// Returns the [ThemeData] associated with the current [BuildContext].
  ThemeData get appTheme => Theme.of(_context);

  /// Returns the [TextTheme] defined in the current [ThemeData].
  TextTheme get textTheme => appTheme.textTheme;

  /// Returns the primary [TextTheme] defined in the current [ThemeData].
  TextTheme get primaryTextTheme => appTheme.primaryTextTheme;

  /// Returns the [ColorScheme] defined in the current [ThemeData].
  ColorScheme get colorScheme => appTheme.colorScheme;

  /// Returns a random [MaterialColor] from the predefined list of primary colors.
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];

  /// Returns whether the software keyboard is open, based on the bottom insets of the current
  /// [MediaQueryData].
  bool get isKeyBoardOpen => mediaQuery.viewInsets.bottom > 0;

  /// Returns the height of the software keyboard, based on the bottom insets of the current
  /// [MediaQueryData].
  double get keyboardPadding => mediaQuery.viewInsets.bottom;

  /// Returns the brightness of the application, based on the platform brightness of the current
  /// [MediaQueryData].
  Brightness get appBrightness => mediaQuery.platformBrightness;

  /// Returns the text scale factor applied to the application, based on the current
  /// [MediaQueryData].
  double get textScaleFactor => mediaQuery.textScaleFactor;
}

extension ContextExtension on BuildContext {
  _ContextGeneralExtension get general => _ContextGeneralExtension(this);

  @Deprecated('Use general.mediaQuery instead')
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  @Deprecated('Use general.mediaQuery instead')
  TextTheme get textTheme => Theme.of(this).textTheme;
  @Deprecated('Use general.mediaQuery instead')
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;
  @Deprecated('Use general.mediaQuery instead')
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  @Deprecated('Use general.mediaQuery instead')
  ThemeData get appTheme => Theme.of(this);
  @Deprecated('Use general.mediaQuery instead')
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];
  @Deprecated('Use general.mediaQuery instead')
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  @Deprecated('Use general.mediaQuery instead')
  double get keyboardPadding => MediaQuery.of(this).viewInsets.bottom;
  @Deprecated('Use general.mediaQuery instead')
  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;
  @Deprecated('Use general.mediaQuery instead')
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}
