# kartal

![kartal](https://www.gezilecekyerler.biz/wp-content/uploads/2015/12/Kartal-%C4%B0stanbul.jpg)

Kartal is the place for my borning country so I created an extension for giving born to more power with simple use.
If you want to example with these extensions, you should be look example folder.

------

## Future Extension

You can easy use for network or any future request.

```dart
extension FutureExtension on Future {
  Widget toBuild<T>(
      {@required Widget Function(T data) onSuccess,
      @required Widget loaindgWidget,
      @required Widget notFoundWidget,
      @required Widget onError,
      dynamic data})}
```

## Context Extension

------

You can easy to use context power so context help for many needs.

### General Context Extension

I use the most this extesnion. It's  most needed for the your products.

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
```

### Widget Extension

Sometimes need visible widget so you can this extension.

```dart
extension WidgetExtension on Widget {
  Widget toVisible(bool val) => val ? this : SizedBox(height: 1);
}

```

### MediaQuery Extension

These extension gives device size use so you can need dynamic(grid) value for device aspect, use the dyanmic height or width.

```dart
extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get lowValue => height * 0.01;
  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

```

### Duration Extension

These extensions mainly for animation use.

```dart
extension DurationExtension on BuildContext {
  Duration get durationLow => Duration(milliseconds: 500);
  Duration get durationNormal => Duration(seconds: 1);
  Duration get durationSlow => Duration(seconds: 2);
}
```

### Padding Extension

These extensions declare project main padding values.

```dart
extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingNormal => EdgeInsets.symmetric(horizontal: mediumValue);
}
```

### Empty Widget Extension

Sometimes need empty widget screen for space area, you can use that time.

```dart
extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => SpaceSizedWidthBox(width: 0.03);
  Widget get emptySizedHeightBoxLow => SpaceSizedHeightBox(height: 0.01);
  Widget get emptySizedHeightBoxLow3x => SpaceSizedHeightBox(height: 0.03);
  Widget get emptySizedHeightBoxNormal => SpaceSizedHeightBox(height: 0.05);
  Widget get emptySizedHeightBoxHigh => SpaceSizedHeightBox(height: 0.1);
}
```

### Radius Extension

This extension only uses to draw the border.

```dart
extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highadius => Radius.circular(width * 0.1);
}

```

### Border Extension

More using for rectangle border, container decration etc.

```dart
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
```

## Image Extension 🌠

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

------
Now, we has a a little code.

```dart
extension IntagerExtension on int {
  int get randomValue => Random().nextInt(17);
}
```

## String Extension

------

Strıng need validation, color, launch, share etc.

### Validation Extension

Validate your string value to some features.

```dart
extension StringValidatorExtension on String {
  bool get isNullOrEmpty => this == null || this.isEmpty;
  bool get isNotNullOrNoEmpty => !isNullOrEmpty;

  bool get isValidEmail => RegExp(RegexConstans.instance.emailRegex).hasMatch(this);
}

```

### Launch Any Content In App Dialog Extension

You need open the value in device system. You can just say string value to launch prefix.

```dart
extension LaunchExtension on String {
  get launchEmail => launch("mailto:$this");
  get launchPhone => launch("tel:$this");
  get launchWebsite => launch("$this");
}
```

### Share Any Content External Apps Extension

These extension share your value to other apps or optional apps.

```dart
extension ShareText on String {
  Future<void> shareWhatsApp() async { ... }
  Future<void> shareMail(String title) async { ... }
  Future<void> share() async { ... }
}
```

### Authorization Extension

Sometimes need this extension from send service request so easy create bearer token string.

```dart
extension AuthorizationExtension on String {
  Map<String, dynamic> get beraer => {"Authorization": "Bearer ${this}"};
}
```

## Tasks

------

- [ ] Advance String Extension
- [ ] More Integer Extension
- [ ] Unit Test
- [ ] File Extension
- [ ] SQLite etc. extension
- [ ] Application Extensions

------

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

2020 created for @VB10

## Youtube Channel

[![Youtube](https://yt3.ggpht.com/a/AATXAJyul3hpzl86GIjF-EZxBzy6T62PJxpvzRwz9AbUOw=s288-c-k-c0xffffffff-no-rj-mo)](https://www.youtube.com/watch?v=UCdUaAKTLJrPZFStzEJnpQAg)