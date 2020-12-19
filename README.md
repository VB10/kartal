# kartal
This project for created extenions uses.

## Getting Started


## Context Extension

----------
You can easy to use context power.

```dart
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
  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

extension DurationExtension on BuildContext {
  Duration get durationLow => Duration(milliseconds: 500);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: mediumValue);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => SpaceSizedWidthBox(width: 0.03);
  Widget get emptySizedHeightBoxHigh => SpaceSizedHeightBox(height: 0.1);
}

extension RadiusExtension on BuildContext {
  BorderRadius get normalBorderRadius => BorderRadius.all(Radius.circular(width * 0.05));
  Radius get highadius => Radius.circular(width * 0.1);
}

extension EdgeInsetsExtension on BuildContext {
  EdgeInsetsGeometry get lowEdgeInsetsAll => EdgeInsets.all(5);
}

extension BorderExtension on BuildContext {
  RoundedRectangleBorder get roundedRectangleBorderLow => RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(lowValue)));
}

```

### Image Extension 🌠

----------
You can use very easy rotiaton from image.

```dart
extension ImageRotateExtension on Image {
  Widget get rightRotation => RotationTransition(turns: AlwaysStoppedAnimation(0.5), child: this);
  Widget get upRotation => RotationTransition(turns: AlwaysStoppedAnimation(0.25), child: this);
  Widget get bottomRotation => RotationTransition(turns: AlwaysStoppedAnimation(0.75), child: this);
  Widget get leftRotation => RotationTransition(turns: AlwaysStoppedAnimation(1), child: this);
}
```

## Intager Extensıon

----------
Now, we has a a little code.

```dart
extension IntagerExtension on int {
  int get randomValue => Random().nextInt(17);
}
```


