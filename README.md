[![Pub Version](https://img.shields.io/pub/v/kartal.svg)](https://pub.dev/packages/kartal)
[![GitHub Stars](https://img.shields.io/github/stars/vb10/kartal.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/vb10/kartal)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Live demo](https://img.shields.io/badge/live%20demo-vb10.github.io%2Fkartal-blue)](https://vb10.github.io/kartal/)

# Kartal

A comprehensive Flutter extension and utility package that supercharges your development workflow. Provides 16 type extensions and built-in utilities for context access, string operations, navigation, responsive sizing, and more -- all accessible through a clean `.ext` syntax.

**[Try it live at vb10.github.io/kartal](https://vb10.github.io/kartal/)** — an
interactive gallery where you can type into the validators, drag the
formatters, pick colours, and resize the window to watch the responsive
breakpoints switch. Its source is [`example/`](example/), so every snippet in
this README is running code.

## Table of Contents

- [Installation](#installation)
- [Platform Support](#platform-support)
- [Quick Start](#quick-start)
- [Extensions](#extensions)
  - [Context Extensions](#context-extensions) ([General](#general) | [Sized](#sized) | [Padding](#padding) | [Border](#border) | [Device](#device) | [Navigation](#navigation) | [Popup Manager](#popup-manager) | [Overlay](#overlay))
  - [String Extension](#string-extension)
  - [Widget Extension](#widget-extension)
  - [Future Extension](#future-extension)
  - [List Extension](#list-extension)
  - [Iterable Extension](#iterable-extension)
  - [File Extension](#file-extension)
  - [Image Extension](#image-extension)
  - [Key Extension](#key-extension)
  - [Int Extension](#int-extension)
  - [Num Extension](#num-extension)
  - [Duration Extension](#duration-extension)
  - [Color Extension](#color-extension)
  - [Bool Extension](#bool-extension)
  - [Date Extension](#date-extension)
  - [Map Extension](#map-extension)
- [Utilities](#utilities)
- [Configuration](#configuration)
- [Demo gallery](#demo-gallery)
- [Contributing](#contributing)
- [License](#license)

## Installation

Add `kartal` to your `pubspec.yaml`:

```yaml
dependencies:
  kartal: ^5.0.0
```

Then run:

```bash
flutter pub get
```

Import it in your Dart files:

```dart
import 'package:kartal/kartal.dart';
```

## Platform Support

| Android | iOS | Web | macOS | Windows | Linux |
|:-------:|:---:|:---:|:-----:|:-------:|:-----:|
|   ✅    | ✅  | ✅  |  ✅   |   ✅    |  ✅   |

**Requirements:** Dart >=3.10.0 | Flutter >=3.38.1

Compiles for the web with both `dart2js` and `dart2wasm`.

## Quick Start

```dart
// Responsive sizing and theming
Container(
  padding: context.padding.low,
  height: context.sized.dynamicHeight(0.1),
  child: Text(
    'Hello',
    style: context.general.textTheme.titleMedium,
  ),
)

// Form validation
final isValid = 'user@mail.com'.ext.isValidEmail; // true

// Conditional visibility
const Text('Premium Feature').ext.toVisible(value: isPremiumUser)

// Safe future building
fetchUserData().ext.toBuild(
  onSuccess: (data) => Text(data?.name ?? ''),
  loadingWidget: const CircularProgressIndicator(),
  notFoundWidget: const Text('No data'),
  onError: const Text('Something went wrong'),
)
```

## Extensions

### Context Extensions

Kartal extends `BuildContext` with 8 sub-extensions: `context.general`, `context.sized`, `context.padding`, `context.border`, `context.device`, `context.route`, `context.popupManager`, and `context.overlay`.

#### General

Access theme data, media query, keyboard state, and focus management.

```dart
final theme = context.general.appTheme;
final isOpen = context.general.isKeyBoardOpen;
context.general.unfocus(); // dismiss keyboard
```

| Property / Method | Return Type | Description |
|---|---|---|
| `mediaQuery` | `MediaQueryData` | Current media query data |
| `mediaSize` | `Size` | Current media size |
| `mediaViewInset` | `EdgeInsets` | Current view insets |
| `mediaBrightness` | `Brightness` | Platform brightness |
| `mediaTextScale(double)` | `double` | Scaled font size |
| `appTheme` | `ThemeData` | Current app theme |
| `textTheme` | `TextTheme` | Text theme from current theme |
| `primaryTextTheme` | `TextTheme` | Primary text theme |
| `colorScheme` | `ColorScheme` | Color scheme from current theme |
| `isKeyBoardOpen` | `bool` | Whether the software keyboard is visible |
| `keyboardPadding` | `double` | Height of the keyboard when open |
| `appBrightness` | `Brightness` | Platform brightness (light/dark) |
| `isDarkMode` | `bool` | Whether the resolved theme is dark |
| `isLightMode` | `bool` | Whether the resolved theme is light |
| `orientation` | `Orientation` | Current screen orientation |
| `isLandscape` | `bool` | Whether the screen is landscape |
| `isPortrait` | `bool` | Whether the screen is portrait |
| `locale` | `Locale` | Current locale, falling back to `en` |
| `safePadding` | `EdgeInsets` | Insets taken by notches and home indicators |
| `topPadding` | `double` | Top safe area inset |
| `bottomPadding` | `double` | Bottom safe area inset |
| `devicePixelRatio` | `double` | Device pixel ratio |
| `focusNode` | `FocusNode` | Current focus scope node |
| `unfocus()` | `void` | Remove focus from current widget |

`isDarkMode` reads the resolved `ThemeData.brightness` rather than the platform
brightness, so it respects an explicit `themeMode` override.

#### Sized

Responsive sizing helpers based on device dimensions.

```dart
SizedBox(
  height: context.sized.dynamicHeight(0.1),
  width: context.sized.dynamicWidth(0.5),
)
```

| Property / Method | Return Type | Description |
|---|---|---|
| `height` | `double` | Device height |
| `width` | `double` | Device width |
| `lowValue` | `double` | 1% of device height |
| `normalValue` | `double` | 2% of device height |
| `mediumValue` | `double` | 4% of device height |
| `highValue` | `double` | 10% of device height |
| `dynamicWidth(double)` | `double` | Width multiplied by value |
| `dynamicHeight(double)` | `double` | Height multiplied by value |
| `emptySizedWidthBoxLow` | `Widget` | 1% width empty box |
| `emptySizedWidthBoxLow3x` | `Widget` | 3% width empty box |
| `emptySizedWidthBoxNormal` | `Widget` | 5% width empty box |
| `emptySizedWidthBoxHigh` | `Widget` | 10% width empty box |
| `emptySizedHeightBoxLow` | `Widget` | 1% height empty box |
| `emptySizedHeightBoxLow3x` | `Widget` | 3% height empty box |
| `emptySizedHeightBoxNormal` | `Widget` | 5% height empty box |
| `emptySizedHeightBoxHigh` | `Widget` | 10% height empty box |

#### Padding

Responsive padding helpers. Values are percentages of device height: low=1%, normal=2%, medium=4%, high=10%.

```dart
Padding(
  padding: context.padding.horizontalNormal,
  child: Text('Hello'),
)
```

| Property | Return Type | Description |
|---|---|---|
| `low` | `EdgeInsets` | 1% padding on all sides |
| `normal` | `EdgeInsets` | 2% padding on all sides |
| `medium` | `EdgeInsets` | 4% padding on all sides |
| `high` | `EdgeInsets` | 10% padding on all sides |
| `horizontalLow` | `EdgeInsets` | 1% horizontal padding |
| `horizontalNormal` | `EdgeInsets` | 2% horizontal padding |
| `horizontalMedium` | `EdgeInsets` | 4% horizontal padding |
| `horizontalHigh` | `EdgeInsets` | 10% horizontal padding |
| `verticalLow` | `EdgeInsets` | 1% vertical padding |
| `verticalNormal` | `EdgeInsets` | 2% vertical padding |
| `verticalMedium` | `EdgeInsets` | 4% vertical padding |
| `verticalHigh` | `EdgeInsets` | 10% vertical padding |
| `onlyLeftLow` | `EdgeInsets` | 1% left-only padding |
| `onlyLeftNormal` | `EdgeInsets` | 2% left-only padding |
| `onlyLeftMedium` | `EdgeInsets` | 4% left-only padding |
| `onlyLeftHigh` | `EdgeInsets` | 10% left-only padding |
| `onlyRightLow` | `EdgeInsets` | 1% right-only padding |
| `onlyRightNormal` | `EdgeInsets` | 2% right-only padding |
| `onlyRightMedium` | `EdgeInsets` | 4% right-only padding |
| `onlyRightHigh` | `EdgeInsets` | 10% right-only padding |
| `onlyBottomLow` | `EdgeInsets` | 1% bottom-only padding |
| `onlyBottomNormal` | `EdgeInsets` | 2% bottom-only padding |
| `onlyBottomMedium` | `EdgeInsets` | 4% bottom-only padding |
| `onlyBottomHigh` | `EdgeInsets` | 10% bottom-only padding |
| `onlyTopLow` | `EdgeInsets` | 1% top-only padding |
| `onlyTopNormal` | `EdgeInsets` | 2% top-only padding |
| `onlyTopMedium` | `EdgeInsets` | 4% top-only padding |
| `onlyTopHigh` | `EdgeInsets` | 10% top-only padding |

#### Border

Border radius and rounded rectangle helpers based on device width.

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: context.border.normalBorderRadius,
  ),
)
```

| Property | Return Type | Description |
|---|---|---|
| `lowRadius` | `Radius` | 2% of width circular radius |
| `normalRadius` | `Radius` | 5% of width circular radius |
| `highRadius` | `Radius` | 10% of width circular radius |
| `lowBorderRadius` | `BorderRadius` | 2% of width all corners |
| `normalBorderRadius` | `BorderRadius` | 5% of width all corners |
| `highBorderRadius` | `BorderRadius` | 10% of width all corners |
| `roundedRectangleBorderLow` | `RoundedRectangleBorder` | Low radius top corners |
| `roundedRectangleAllBorderNormal` | `RoundedRectangleBorder` | Normal radius all corners |
| `roundedRectangleBorderNormal` | `RoundedRectangleBorder` | Normal radius top corners |
| `roundedRectangleBorderMedium` | `RoundedRectangleBorder` | Medium radius top corners |
| `roundedRectangleBorderHigh` | `RoundedRectangleBorder` | High radius top corners |

#### Device

Screen size checks and platform detection.

```dart
if (context.device.isSmallScreen) {
  // compact layout
}
```

The four bands are contiguous, so exactly one is always true.

| Property | Return Type | Description |
|---|---|---|
| `isSmallScreen` | `bool` | `width < 300` |
| `isMediumScreen` | `bool` | `300 <= width < 600` |
| `isExpandedScreen` | `bool` | `600 <= width < 900` |
| `isLargeScreen` | `bool` | `width >= 900` |
| `breakpoint` | `DeviceBreakpoint` | The band as an exhaustive enum |
| `responsive<T>(...)` | `T` | Picks a value for the current band |
| `isAndroidDevice` | `bool` | Running on Android |
| `isIOSDevice` | `bool` | Running on iOS |
| `isWindowsDevice` | `bool` | Running on Windows |
| `isLinuxDevice` | `bool` | Running on Linux |
| `isMacOSDevice` | `bool` | Running on macOS |

`responsive` takes a required `small` value and optional wider ones. Wider
bands fall back to the next narrower value supplied, so you only specify the
breakpoints you actually care about:

```dart
final columns = context.device.responsive(small: 1, medium: 2, large: 4);

final padding = context.device.responsive<EdgeInsets>(
  small: const EdgeInsets.all(8),
  large: const EdgeInsets.all(32),
);
```

Switch over `breakpoint` when you need every case handled:

```dart
final layout = switch (context.device.breakpoint) {
  DeviceBreakpoint.small => const PhoneLayout(),
  DeviceBreakpoint.medium => const TabletLayout(),
  DeviceBreakpoint.expanded => const SplitLayout(),
  DeviceBreakpoint.large => const DesktopLayout(),
};
```

The thresholds are configurable — see [Configuration](#configuration).

#### Navigation

Route navigation helpers via `context.route`.

```dart
context.route.pop();
context.route.navigateName('/details', data: item);
context.route.navigateToPage(const DetailsPage());
```

| Method | Return Type | Description |
|---|---|---|
| `navigation` | `NavigatorState` | Current navigator state |
| `pop<T>([T? data])` | `Future<bool>` | Pop current route |
| `popWithRoot()` | `void` | Pop to root route |
| `navigateName<T>(String path, {Object? data})` | `Future<T?>` | Push named route |
| `navigateToReset<T>(String path, {Object? data})` | `Future<T?>` | Push named and clear stack |
| `navigateToPage<T>(Widget page, {Object? extra, SlideType type})` | `Future<T?>` | Push widget with slide transition |

#### Popup Manager

Show and hide loading dialogs via `context.popupManager`.

```dart
// Show loader
context.popupManager.showLoader();

// Hide loader
context.popupManager.hideLoader();

// With custom widget and ID
context.popupManager.showLoader(
  id: 'upload',
  widgetBuilder: (context) => const MyCustomLoader(),
);
context.popupManager.hideLoader(id: 'upload');
```

| Method | Return Type | Description |
|---|---|---|
| `showLoader({String? id, bool barrierDismissible, WidgetBuilder? widgetBuilder})` | `void` | Show a loading dialog |
| `hideLoader({String? id})` | `void` | Hide loader by ID or the latest one |

Managers are held per `NavigatorState`, so a loader shown before a route change
does not strand the next `hideLoader` on a disposed navigator. `hideLoader` is a
no-op when nothing is showing, making it safe to call from a `finally`.

#### Overlay

Transient UI via `context.overlay`.

```dart
context.overlay.showSnack('Saved');

final confirmed = await context.overlay.showConfirm(
  title: 'Delete this item?',
  message: 'This cannot be undone.',
  confirmLabel: 'Delete',
  isDestructive: true,
);
if (confirmed) await delete();

await context.overlay.showSheet(const FilterSheet());
```

| Method | Return Type | Description |
|---|---|---|
| `showSnack(String, {duration, action, backgroundColor, behavior})` | `ScaffoldFeatureController` | Show a snack bar |
| `showSnackWidget(SnackBar)` | `ScaffoldFeatureController` | Show a fully custom snack bar |
| `hideSnack()` | `void` | Dismiss the current snack bar |
| `removeSnack()` | `void` | Remove it without the exit animation |
| `showSheet<T>(Widget, {isScrollControlled, isDismissible, useSafeArea, backgroundColor, shape})` | `Future<T?>` | Modal bottom sheet |
| `showDialogCustom<T>(Widget, {barrierDismissible})` | `Future<T?>` | Modal dialog |
| `showConfirm({title, message, confirmLabel, cancelLabel, isDestructive})` | `Future<bool>` | Two-button confirmation |

`showConfirm` completes with `false` rather than `null` when dismissed, so the
result is usable directly in an `if`. `showSheet` defaults to
`isScrollControlled: true`, since a sheet holding a text field or a long list
needs it to size correctly above the keyboard.

---

### String Extension

Access string utilities via `'value'.ext`. Works on both `String` and `String?`.

##### Validation & Formatting

```dart
'test@email.com'.ext.isValidEmail      // true
'Abc123!@'.ext.isValidPassword         // true
'hello world'.ext.toTitleCase()        // "Hello World"
'hello world'.ext.toCapitalized()      // "Hello world"
'ÇÖĞ'.ext.withoutSpecialCharacters    // "COG"
'ÇÖĞ test'.ext.searchable             // "cog test"
```

| Property / Method | Return Type | Description |
|---|---|---|
| `isNullOrEmpty` | `bool` | `true` if null or empty |
| `isNotNullOrNoEmpty` | `bool` | `true` if not null and not empty |
| `isValidEmail` | `bool` | Email validation via regex — see the caveat below |
| `isValidPassword` | `bool` | Min 8 chars, upper, lower, number, symbol |
| `isValidUrl` | `bool` | Absolute `http(s)` URL |
| `isValidPhone` | `bool` | Turkish number, across common written forms |
| `isValidTckn` | `bool` | Turkish identity number, full checksum |
| `isValidIban` | `bool` | IBAN, ISO 13616 mod-97 check |
| `isValidCreditCard` | `bool` | Card number, Luhn check |
| `isNumeric` | `bool` | Digits only |
| `searchable` | `String` | Lowercase with diacritics removed |
| `withoutSpecialCharacters` | `String?` | Removes diacritics |
| `toCapitalized()` | `String` | First letter uppercase, rest lowercase |
| `toTitleCase()` | `String` | Each word capitalized |
| `lineLength` | `int` | Number of lines |
| `phoneFormatValue` | `String` | Unmasked phone value |
| `timeFormatValue` | `String` | Unmasked time value |
| `timeOverlineFormatValue` | `String` | Unmasked time overline value |

> **`isValidEmail` is more permissive than it looks.** Its regex is not anchored
> at the end, so trailing content passes, and it accepts a comma in the local
> part. `'user@domain.com<script>'` and `'veli,test@kartal.dev'` both return
> `true`. Do not use it as a sanitising gate. Tracked in
> [#93](https://github.com/VB10/kartal/pull/93); the fix is deferred because it
> rejects addresses that pass today.

`isValidTckn`, `isValidIban` and `isValidCreditCard` run the real checksum
algorithms rather than length or shape checks, so they reject plausible-looking
invalid input. Spaces, dashes and grouping are tolerated:

```dart
'4242 4242 4242 4242'.ext.isValidCreditCard;         // true
'4242424242424241'.ext.isValidCreditCard;            // false
'TR33 0006 1005 1978 6457 8413 26'.ext.isValidIban;  // true
'+90 532 123 45 67'.ext.isValidPhone;                // true
'0(032) 123-45-67'.ext.isValidPhone;                 // false, area code
```

##### Text shaping

```dart
'4242424242424242'.ext.mask();                  // '4242********4242'
'veli@kartal.dev'.ext.maskEmail;                // 've**@kartal.dev'
'Cok Guzel Bir Baslik'.ext.toSlug();            // 'cok-guzel-bir-baslik'
'Kartal makes Flutter nicer'.ext.truncate(12);  // 'Kartal ma...'
'Veli Bacik'.ext.initials();                    // 'VB'
'<p>Tom &amp; Jerry</p>'.ext.removeHtmlTags;     // 'Tom & Jerry'
```

| Property / Method | Return Type | Description |
|---|---|---|
| `mask({start, end, char})` | `String` | Middle masked, ends visible |
| `maskEmail` | `String` | Local part masked, domain kept |
| `maskPhone({int visibleDigits})` | `String` | Only the trailing digits kept |
| `toSlug({String separator})` | `String` | URL-friendly slug |
| `truncate(int, {String ellipsis})` | `String` | Shortened, never exceeding the budget |
| `initials({int count})` | `String` | Initials from the first n words |
| `removeHtmlTags` | `String` | Tags stripped and entities decoded |
| `wordCount` | `int` | Whitespace separated word count |
| `readingTimeMinutes` | `int` | Estimated reading time |
| `reversed` | `String` | Characters reversed |
| `base64Encoded` | `String` | Encoded as base64 |
| `base64Decoded` | `String?` | Decoded, `null` when invalid |
| `toDateTimeOrNull()` | `DateTime?` | Parsed, `null` when invalid |

`toSlug` folds diacritics before slugifying, so Turkish text survives the
conversion. `truncate` counts the ellipsis inside `maxLength` rather than
appending past it, and `mask` masks in full when the input is too short to keep
both ends visible, so it never leaks more than requested.

##### Color & Images

```dart
'FF5733'.ext.color          // Color(0xffFF5733)
'FF5733'.ext.toColor        // Color from color code
'avatar'.ext.randomImage    // picsum.photos URL
```

| Property | Return Type | Description |
|---|---|---|
| `color` | `Color` | Color from hex string; **throws** when invalid |
| `colorCode` | `int?` | Parsed color code |
| `toColor` | `Color` | Parsed colour, falling back to white |
| `toColorOrNull` | `Color?` | Parsed colour, `null` when invalid |
| `randomImage` | `String` | Random 200x300 image URL |
| `randomSquareImage` | `String` | Random 200x200 image URL |
| `customProfileImage` | `String` | Gravatar placeholder URL |
| `customHighProfileImage` | `String` | Gravatar high-res placeholder URL |

##### Sharing & Launching

```dart
'user@mail.com'.ext.launchEmail
'+905551234567'.ext.launchPhone
'https://pub.dev'.ext.launchWebsite
'Istanbul'.ext.launchMaps()
'Hello!'.ext.share()
```

| Property / Method | Return Type | Description |
|---|---|---|
| `launchEmail` | `Future<bool>` | Open email app |
| `launchPhone` | `Future<bool>` | Open phone app |
| `launchWebsite` | `Future<bool>` | Open URL in browser |
| `launchWebsiteCustom(...)` | `Future<bool>` | Open URL with custom config |
| `launchMaps()` | `Future<bool>` | Open maps (Apple Maps on iOS, Google Maps on Android) |
| `shareWhatsApp()` | `Future<void>` | Share via WhatsApp |
| `shareMail(String title)` | `Future<void>` | Share via email |
| `share()` | `Future<void>` | Share via system dialog |

##### Platform Info & Utilities

```dart
final name = ''.ext.appName;
final id = await ''.ext.deviceId;
final header = 'my-token'.ext.bearer; // {'Authorization': 'Bearer my-token'}
```

| Property | Return Type | Description |
|---|---|---|
| `appName` | `String` | Application name |
| `packageName` | `String` | Package name |
| `version` | `String` | App version |
| `buildNumber` | `String` | Build number |
| `deviceId` | `Future<String>` | Unique device ID |
| `bearer` | `Map<String, dynamic>` | Bearer token authorization header |

##### JSON & Type Conversion

```dart
final map = await '{"name":"kartal"}'.ext.safeJsonDecodeCompute<Map<String, dynamic>>();
final intVal = '42'.ext.toPrimitiveFromGeneric<int>(); // 42
```

| Method | Return Type | Description |
|---|---|---|
| `safeJsonDecodeCompute<T>()` | `Future<T?>` | JSON decode in background isolate |
| `toPrimitiveFromGeneric<T>()` | `T?` | Convert to bool, int, double, or String |

---

### Widget Extension

```dart
const Text('Hello').ext.toVisible(value: isLoggedIn)
const Text('Disabled').ext.toDisabled(opacity: 0.5)
myWidget.ext.sliver  // wrap in SliverToBoxAdapter
```

| Method | Return Type | Description |
|---|---|---|
| `toVisible({bool value = true})` | `Widget` | Show widget or `SizedBox.shrink()` |
| `toDisabled({bool? disable, double? opacity})` | `Widget` | Wrap in `IgnorePointer` + `Opacity` (default opacity: 0.2) |
| `sliver` | `Widget` | Wrap in `SliverToBoxAdapter` |
| `paddingAll(double)` | `Widget` | Equal padding on every side |
| `paddingSymmetric({horizontal, vertical})` | `Widget` | Symmetric padding |
| `paddingOnly({left, top, right, bottom})` | `Widget` | Per-side padding |
| `padding(EdgeInsetsGeometry)` | `Widget` | Padding from an explicit value |
| `center` | `Widget` | Wrap in `Center` |
| `expanded({int flex = 1})` | `Widget` | Wrap in `Expanded` |
| `flexible({int flex, FlexFit fit})` | `Widget` | Wrap in `Flexible` |
| `onTap(VoidCallback, {withRipple, borderRadius})` | `Widget` | `InkWell`, or `GestureDetector` when `withRipple: false` |
| `safeArea` | `Widget` | Wrap in `SafeArea` |
| `tooltip(String)` | `Widget` | Attach a long-press tooltip |
| `hero(Object tag)` | `Widget` | Wrap in `Hero` |
| `align([AlignmentGeometry])` | `Widget` | Wrap in `Align` |
| `opacity(double)` | `Widget` | Wrap in `Opacity` |
| `constrained({minWidth, maxWidth, minHeight, maxHeight})` | `Widget` | Wrap in `ConstrainedBox` |
| `sized({width, height})` | `Widget` | Wrap in `SizedBox` |
| `card({elevation, color, shape})` | `Widget` | Wrap in `Card` |
| `rotated(int quarterTurns)` | `Widget` | Wrap in `RotatedBox` |
| `clipRounded([double radius = 8])` | `Widget` | Wrap in `ClipRRect` |
| `positioned({left, top, right, bottom, width, height})` | `Widget` | Wrap in `Positioned` |

Helpers compose left to right, so the last one applied ends up outermost:

```dart
const Text('Tap me')
    .ext.paddingAll(12)
    .ext.card(elevation: 2)
    .ext.onTap(onPressed);
```

---

### Future Extension

```dart
fetchData().ext.toBuild(
  onSuccess: (data) => Text(data.toString()),
  loadingWidget: const CircularProgressIndicator(),
  notFoundWidget: const Text('Not found'),
  onError: const Text('Error'),
)

// Returns null on timeout instead of throwing
final result = await fetchData().ext.timeoutOrNull(
  timeOutDuration: const Duration(seconds: 5),
);
```

| Method | Return Type | Description |
|---|---|---|
| `toBuild({onSuccess, loadingWidget, notFoundWidget, onError, data, errorBuilder})` | `Widget` | FutureBuilder with typed callbacks |
| `timeoutOrNull({Duration timeOutDuration, bool enableLogger})` | `Future<T?>` | Returns null on timeout (default: 10s) |
| `onErrorReturn(T fallback)` | `Future<T>` | Falls back to a value on error |
| `orNull()` | `Future<T?>` | Returns null on error |

`errorBuilder` takes precedence over `onError` and, unlike it, receives the
error itself.

Retrying lives in a top-level function rather than on the extension, because a
`Future` can only be awaited once — retrying needs something that produces a
fresh future per attempt:

```dart
final data = await kartalRetry(
  () => api.fetch(),
  attempts: 3,
  delay: const Duration(milliseconds: 200),
  exponentialBackoff: true,
  retryIf: (error) => error is! ArgumentError,
);
```

The last error is rethrown once the attempts are exhausted.

---

### List Extension

Works on both `List<T>` and `List<T>?`.

```dart
List<String>? names;
names.ext.isNullOrEmpty        // true (null-safe)
[1, null, 3].ext.makeSafe()    // [1, 3]
['a', 'b'].ext.indexOrNull((e) => e == 'b')  // 1
```

| Property / Method | Return Type | Description |
|---|---|---|
| `isNullOrEmpty` | `bool` | `true` if list is null or empty |
| `isNotNullOrEmpty` | `bool` | `true` if list has elements |
| `makeSafe()` | `List<T>` | Filters out null values |
| `indexOrNull(bool Function(T))` | `int?` | Index of first match, or `null` |
| `swap(int, int)` | `List<T>` | Two positions exchanged |
| `takeLast(int)` | `List<T>` | The last n elements |
| `separatedBy(T)` | `List<T>` | Separator inserted between elements |
| `replaceAt(int, T)` | `List<T>` | One element replaced |
| `elementAtOrNull(int)` | `T?` | Bounds-safe element access |

None of these mutate the receiver.

#### Collection helpers

These are available on **both** `List` and `Iterable` through `.ext`:

```dart
[1, 2, 3, 4, 5].ext.chunked(2);            // [[1, 2], [3, 4], [5]]
people.ext.groupBy((p) => p.city);          // {'Istanbul': [...], ...}
people.ext.sortedBy((p) => p.age);          // does not mutate
orders.ext.sumBy((o) => o.total);
final (adults, minors) = people.ext.partition((p) => p.age >= 18);
```

| Method | Return Type | Description |
|---|---|---|
| `chunked(int size)` | `List<List<T>>` | Fixed size chunks, remainder kept |
| `paged(int size)` | `Map<int, List<T>>` | Chunks keyed by page index |
| `groupBy<K>(K Function(T))` | `Map<K, List<T>>` | Grouped by key |
| `distinctBy<K>(K Function(T))` | `List<T>` | First occurrence per key |
| `sortedBy<K>(K Function(T))` | `List<T>` | Sorted ascending, non-mutating |
| `sortedByDescending<K>(K Function(T))` | `List<T>` | Sorted descending |
| `sumBy(num Function(T))` | `num` | Sum, 0 when empty |
| `averageBy(num Function(T))` | `double?` | Mean, `null` when empty |
| `partition(bool Function(T))` | `(List<T>, List<T>)` | Matching and rest |
| `mapIndexed<R>(R Function(int, T))` | `List<R>` | Map with the index |
| `firstWhereOrNull(bool Function(T))` | `T?` | First match or `null` |
| `randomOrNull({int? seed})` | `T?` | Random element, seedable |

`averageBy` returns `null` rather than `NaN` for an empty collection, so "no
data" stays distinguishable from a genuine zero average.

---

### Iterable Extension

> **Note:** The null-stripping helpers use the `.exts` (plural) accessor,
> because their element type is `T?`. The
> [collection helpers](#collection-helpers) are on `.ext` and work on any
> `Iterable`.

```dart
[null, 1, null, 3].exts.makeSafe()  // [1, 3]
[1, 2, 3, null].exts.makeSafeCustom((v) => v != null && v > 1)  // [2, 3]
```

| Method | Return Type | Description |
|---|---|---|
| `makeSafe()` | `List<T>` | Filters out null values |
| `makeSafeCustom(bool Function(T?))` | `List<T>` | Filters by custom predicate |

---

### File Extension

```dart
final file = File('photo.jpg');
file.ext.isImageFile  // true
file.ext.fileType     // FileType.IMAGE
```

| Property | Return Type | Description |
|---|---|---|
| `fileType` | `FileType` | File type based on MIME (IMAGE, VIDEO, AUDIO, TEXT, UNKNOWN) |
| `isImageFile` | `bool` | Check if image |
| `isVideoFile` | `bool` | Check if video |
| `isAudioFile` | `bool` | Check if audio |
| `isTextFile` | `bool` | Check if text |

---

### Image Extension

Apply rotation transformations to Image widgets.

```dart
Image.network('https://picsum.photos/200').ext.upRotation
```

| Property | Return Type | Description |
|---|---|---|
| `rightRotation` | `Widget` | 180-degree rotation |
| `upRotation` | `Widget` | 90-degree (quarter turn) rotation |
| `bottomRotation` | `Widget` | 270-degree rotation |
| `leftRotation` | `Widget` | 360-degree (full) rotation |

---

### Key Extension

Access render information and scroll behavior for `GlobalKey`.

```dart
final key = GlobalKey();
// after build:
final widgetHeight = key.ext.height;
final position = key.ext.offset;
key.ext.scrollToWidget();
```

| Property / Method | Return Type | Description |
|---|---|---|
| `rendererBox` | `RenderBox?` | RenderBox of the widget |
| `offset` | `Offset?` | Global position |
| `height` | `double?` | Widget height |
| `scrollToWidget({ScrollPositionAlignmentPolicy})` | `void` | Scroll to make widget visible |

---

### Int Extension

```dart
final color = 42.ext.randomColorValue;       // Random 0-255
final status = 200.ext.httpStatus;           // HttpResult.success
final statusColor = 404.ext.httpStatusColor; // Colors.orange
```

| Property | Return Type | Description |
|---|---|---|
| `randomColorValue` | `int` | Random color value 0-255 seeded by the int |
| `httpStatus` | `HttpResult` | HTTP result category (success, redirection, clientError, serverError, unknown) |
| `httpStatusColor` | `Color` | Color for the HTTP status (green, blue, orange, red, grey) |
| `ordinal` | `String` | English ordinal, handling the 11th/12th/13th exception |
| `microseconds` / `ms` / `milliseconds` | `Duration` | This many of the unit |
| `seconds` / `minutes` / `hours` / `days` | `Duration` | This many of the unit |

`int` also carries every [Num Extension](#num-extension) member.

Status codes outside `[200, 600)`, including informational `1xx`, map to
`HttpResult.unknown`.

---

### Num Extension

Available on `num`, and on `int` through the same accessor.

```dart
1234567.ext.compact();          // '1.2M'
1536000.ext.readableFileSize;   // '1.5 MB'
1234.5.ext.currency(symbol: r'$');  // '$1,234.50'
0.85.ext.fraction();            // '85%'
```

| Method | Return Type | Description |
|---|---|---|
| `compact({int decimals = 1})` | `String` | Short form scaling through K/M/B/T |
| `readableFileSize` | `String` | Byte count with a binary unit |
| `readableFileSizeWith({int decimals})` | `String` | As above, with precision control |
| `currency({symbol, decimals, thousandSeparator, decimalSeparator, symbolOnLeft})` | `String` | Grouped amount |
| `percent({int decimals})` | `String` | Treats the value as already scaled |
| `fraction({int decimals})` | `String` | Treats the value as a `[0, 1]` ratio |
| `clampRange(num, num)` | `num` | Clamped, returning `num` not `Comparable` |
| `toRadians` | `double` | Degrees to radians |
| `toDegrees` | `double` | Radians to degrees |
| `isBetween(num, num, {bool inclusive})` | `bool` | Range check |

Turkish-style formatting is expressible without adding `intl`:

```dart
1234567.89.ext.currency(
  symbol: '\u20BA',
  symbolOnLeft: false,
  thousandSeparator: '.',
  decimalSeparator: ',',
);  // '1.234.567,89 \u20BA'
```

---

### Duration Extension

```dart
const Duration(minutes: 3, seconds: 7).ext.formatted;  // '03:07'
const Duration(hours: 1, minutes: 2).ext.formatted;    // '01:02:00'

await 300.ext.ms.ext.delay();
```

| Method | Return Type | Description |
|---|---|---|
| `formatted` | `String` | `mm:ss`, promoting to `hh:mm:ss` past an hour |
| `format({bool forceHours})` | `String` | Always include hours when forced |
| `delay()` | `Future<void>` | Wait for this duration |
| `delayed<T>(T Function())` | `Future<T>` | Wait, then run and return |

Negative durations keep their sign: `-00:45`.

---

### Color Extension

```dart
const Color(0xFF3F51B5).ext.toHex();         // '#3f51b5'
Colors.indigo.ext.lighten(0.2);
Colors.indigo.ext.contrastText();            // white or black
Colors.indigo.ext.toMaterialColor();         // full 50..900 swatch
KartalColor.tryParse('#FF0000');             // Color? -- null when invalid
KartalColor.random(seed: 42);                // deterministic
```

| Method | Return Type | Description |
|---|---|---|
| `toHex({includeAlpha, uppercase})` | `String` | Hex string, `#AARRGGBB` when alpha is included |
| `withOpacity(double)` | `Color` | Alpha applied via `withValues` |
| `luminance` | `double` | WCAG relative luminance |
| `isDark` / `isLight` | `bool` | Perceptual, not a naive RGB average |
| `contrastText({light, dark})` | `Color` | A readable foreground for this colour |
| `lighten([double])` / `darken([double])` | `Color` | HSL shade, clamped at white/black |
| `blend(Color, [double t])` | `Color` | Interpolate towards another colour |
| `toMaterialColor()` | `MaterialColor` | Swatch from this colour as shade 500 |
| `randomColor` | `MaterialColor` | Random entry from `Colors.primaries` |

`isDark` uses relative luminance, so perceptually bright hues such as yellow are
correctly reported as light.

`KartalColor.tryParse` accepts an optional leading `#` and either 6-digit RGB or
8-digit ARGB. `String.ext.toColorOrNull` is the same parser on a string
receiver, and `String.ext.toColor` falls back to white.

---

### Bool Extension

Works on `bool?` (nullable booleans). Null is treated as failure.

```dart
bool? apiResult = true;
apiResult.ext.isSuccess  // true
apiResult.ext.isFail     // false

bool? nullResult;
nullResult.ext.isSuccess // false
nullResult.ext.isFail    // true
```

| Property | Return Type | Description |
|---|---|---|
| `isSuccess` | `bool` | `true` only if value is `true` |
| `isFail` | `bool` | `true` if value is `false` or `null` |

---

### Date Extension

Human-readable relative time with localizable labels. Works on both `DateTime` and `DateTime?`.

```dart
final postDate = DateTime(2024, 1, 15);
postDate.ext.differenceTime()  // "1 years ago"

// Custom localization
postDate.ext.differenceTime(
  localizationLabel: DateLocalizationLabel(
    yearLabel: 'yil once',
    monthLabel: 'ay once',
    dayLabel: 'gun once',
  ),
)
```

| Method | Return Type | Description |
|---|---|---|
| `differenceTime({DateLocalizationLabel? localizationLabel})` | `String` | Human-readable time difference from now |

`DateLocalizationLabel` fields: `yearLabel`, `monthLabel`, `dayLabel`,
`hourLabel`, `minuteLabel`, `secondLabel`, `justNowLabel` and `emptyLabel` (all
default to English, e.g. "years ago"). `DateLocalizationLabel.tr()` provides the
Turkish set:

```dart
postDate.ext.differenceTime(
  localizationLabel: const DateLocalizationLabel.tr(),
);  // '1 yil once'
```

Omitting `localizationLabel` uses whatever is set through
[`KartalConfig`](#configuration), so you can pick a language once at startup
instead of at every call site.

A `null` receiver returns `emptyLabel` (empty by default) rather than throwing,
and sub-second or future timestamps return `justNowLabel`.

---

### Map Extension

```dart
final map = {'name': 'Kartal', 'version': 4};
final json = await map.ext.safeJsonEncodeCompute(); // runs in isolate
```

| Method | Return Type | Description |
|---|---|---|
| `safeJsonEncodeCompute()` | `Future<String?>` | JSON-encode in background isolate; returns null on failure |

---

## Utilities

### BundleDecoder

Parse local asset JSON files into typed Dart models using isolate-based decoding. Your model must implement `IAssetModel<T>` with a `fromJson` factory.

```dart
final posts = await BundleDecoder('assets/posts.json')
    .crackBundle<Post, List<Post>>(model: Post());
```

### MapsUtility

Open map applications with a search query.

```dart
await MapsUtility.openAppleMapsWithQuery('Istanbul Kartal');
await MapsUtility.openGoogleMapsWithQuery('Istanbul Kartal');
await MapsUtility.openGoogleWebMapsWithQuery('Istanbul Kartal');
```

### CustomLinkPreview

Fetch Open Graph metadata (title, description, image) from any URL.

```dart
final preview = await CustomLinkPreview.getLinkPreviewData('https://example.com');
print(preview?.title);
print(preview?.description);
print(preview?.image);
```

### CustomLogger

Debug-mode-only error logging.

```dart
CustomLogger.showError<MyClass>(errorObject);
```

### Debouncer and Throttler

`Debouncer` waits until the caller stops firing, keeping only the last call in a
burst -- the usual case for a search field. `Throttler` runs the first call and
drops the rest inside the window, for continuous events such as scrolling.

```dart
final _debouncer = Debouncer(const Duration(milliseconds: 300));

void onChanged(String query) => _debouncer.call(() => search(query));

@override
void dispose() {
  _debouncer.dispose();
  super.dispose();
}
```

| Member | Type | Description |
|---|---|---|
| `Debouncer.call(VoidCallback)` | `void` | Schedule, replacing any pending call |
| `Debouncer.isPending` | `bool` | Whether a call is waiting |
| `Debouncer.cancel()` | `void` | Drop the pending call |
| `Debouncer.flush(VoidCallback)` | `void` | Run now instead of waiting out the delay |
| `Throttler.call(VoidCallback)` | `bool` | Run unless inside the cooldown; returns whether it ran |
| `Throttler.isThrottled` | `bool` | Whether a call now would be dropped |
| `Throttler.reset()` | `void` | Clear the cooldown |

Always `dispose()` both, otherwise a pending timer can outlive the widget that
owns it.

### DeviceUtility

Singleton for device-related operations.

```dart
final deviceId = await DeviceUtility.instance.getUniqueDeviceId();
final isIpad = await DeviceUtility.instance.isIpad();
```

## Configuration

Breakpoints and relative-time labels are the two opinionated parts of the
package. Both previously had values baked in with no way to change them, which
forced apps on a different design system or language to avoid those helpers
entirely. Configure them once during startup:

```dart
void main() {
  KartalConfig.instance.configure(
    breakpoints: const KartalBreakpoints(
      small: 480,
      medium: 768,
      large: 1200,
    ),
    dateLabel: const DateLocalizationLabel.tr(),
  );

  runApp(const MyApp());
}
```

Everything has a default, so configuring is optional. `KartalBreakpoints`
asserts its values increase, which catches a misordered configuration at
construction rather than producing silently overlapping bands.

| Member | Description |
|---|---|
| `KartalConfig.instance.configure({breakpoints, dateLabel})` | Override defaults; arguments left null keep their current value |
| `KartalConfig.instance.reset()` | Restore every default, intended for test `setUp` |
| `KartalConfig.instance.breakpoints` | The thresholds currently in force |
| `KartalConfig.instance.dateLabel` | The labels currently in force |

`DateLocalizationLabel.tr()` ships Turkish labels, so `differenceTime()` needs
no wiring for the common case.

## Demo gallery

The [`example/`](example/) app doubles as the live demo at
[vb10.github.io/kartal](https://vb10.github.io/kartal/). One page per feature
set, each interactive:

| Page | What you can do |
|---|---|
| Validators | Type a TCKN, IBAN, card or phone number and watch the checksum verdict flip on a single changed digit |
| Formatters | Enter a number and see `compact`, `currency`, `readableFileSize`; drag a slider to watch `mm:ss` promote to `hh:mm:ss` |
| Colours | Pick or paste a colour and see hex, luminance, contrast foreground, lighten/darken ramps and the generated swatch |
| Responsive | Resize the window and watch the band, derived metrics and a `responsive()`-driven grid react live |
| Collections | `chunked`, `groupBy`, `partition` and friends over sample data, plus working `Debouncer`, `Throttler` and `kartalRetry` demos |
| Widgets | Toggle and drag the chaining helpers to see the composed result |
| Overlays | Snack bars, sheets, confirmation dialogs, loaders and relative-time labels |

Run it locally:

```bash
cd example
flutter run           # or: flutter run -d chrome
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created and maintained by [VB10](https://github.com/vb10).

[![YouTube](https://img.shields.io/youtube/channel/subscribers/UCdUaAKTLJrPZFStzEJnpQAg?label=HardwareAndro&style=social)](https://www.youtube.com/@hardwareandro)
[![Medium](https://img.shields.io/badge/Medium-@vbacik--10-black?logo=medium)](https://medium.com/@vbacik-10)
[![Discord](https://dcbadge.vercel.app/api/server/Bzn8WtuZD2?style=flat)](https://discord.gg/Bzn8WtuZD2)

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/vb10)

### Contributors

<a href="https://github.com/vb10/kartal/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=vb10/kartal" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
