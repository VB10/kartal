import 'package:flutter/material.dart';

/// Provides convenient access to commonly used properties from [BuildContext].
extension ContextExtension on BuildContext {
  /// Provides convenient access to commonly used properties from [BuildContext].
  _ContextGeneralExtension get general => _ContextGeneralExtension(this);
}

/// Provides convenient access to commonly used properties from [MediaQueryData] and [ThemeData]
/// related to the current [BuildContext].
final class _ContextGeneralExtension {
  _ContextGeneralExtension(BuildContext context) : _context = context;
  final BuildContext _context;

  /// Returns the [MediaQueryData] associated with the current [BuildContext].
  MediaQueryData get mediaQuery => MediaQuery.of(_context);

  /// Returns the [Size] associated with the current [BuildContext].
  Size get mediaSize => MediaQuery.sizeOf(_context);

  /// Returns the [Size] associated with the current [BuildContext].
  EdgeInsets get mediaViewInset => MediaQuery.viewInsetsOf(_context);

  /// Returns the [Brightness] associated with the current [BuildContext].
  Brightness get mediaBrightness => MediaQuery.platformBrightnessOf(_context);

  /// Returns the [double] associated with the current [BuildContext].
  double mediaTextScale(double font) =>
      MediaQuery.textScalerOf(_context).scale(font);

  /// Returns the [ThemeData] associated with the current [BuildContext].
  ThemeData get appTheme => Theme.of(_context);

  /// Returns the [FocusNode] associated with the current [BuildContext].
  FocusNode get focusNode => FocusScope.of(_context);

  /// Returns the [TextTheme] defined in the current [ThemeData].
  TextTheme get textTheme => appTheme.textTheme;

  /// Returns the primary [TextTheme] defined in the current [ThemeData].
  TextTheme get primaryTextTheme => appTheme.primaryTextTheme;

  /// Returns the [ColorScheme] defined in the current [ThemeData].
  ColorScheme get colorScheme => appTheme.colorScheme;

  /// Returns whether the software keyboard is open, based on the bottom insets of the current
  /// [MediaQueryData].
  bool get isKeyBoardOpen => mediaViewInset.bottom > 0;

  /// Returns the height of the software keyboard, based on the bottom insets of the current
  /// [MediaQueryData].
  double get keyboardPadding => mediaViewInset.bottom;

  /// Returns the brightness of the application, based on the platform brightness of the current
  /// [MediaQueryData].
  Brightness get appBrightness => mediaBrightness;

  /// Removes focus from the currently focused [FocusNode].
  void unfocus() => focusNode.unfocus();

  /// Whether the app is currently rendering in dark mode.
  ///
  /// Reads the resolved [ThemeData.brightness] rather than the platform
  /// brightness, so it respects an explicit `themeMode` override.
  bool get isDarkMode => appTheme.brightness == Brightness.dark;

  /// Whether the app is currently rendering in light mode.
  bool get isLightMode => !isDarkMode;

  /// The current screen [Orientation].
  Orientation get orientation => MediaQuery.orientationOf(_context);

  /// Whether the screen is currently landscape.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Whether the screen is currently portrait.
  bool get isPortrait => orientation == Orientation.portrait;

  /// The current [Locale], falling back to the system locale.
  Locale get locale =>
      Localizations.maybeLocaleOf(_context) ?? const Locale('en');

  /// The insets intruded on by system UI such as notches and home indicators.
  EdgeInsets get safePadding => MediaQuery.viewPaddingOf(_context);

  /// The top safe area inset, typically the status bar or notch.
  double get topPadding => safePadding.top;

  /// The bottom safe area inset, typically the home indicator.
  double get bottomPadding => safePadding.bottom;

  /// The device pixel ratio.
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(_context);
}
