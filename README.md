[![Pub Version](https://img.shields.io/pub/v/kartal.svg)](https://pub.dev/packages/kartal)
[![GitHub Stars](https://img.shields.io/github/stars/vb10/kartal.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/vb10/kartal)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

# Kartal

A comprehensive Flutter extension and utility package that supercharges your development workflow. Provides 13 type extensions and built-in utilities for context access, string operations, navigation, responsive sizing, and more -- all accessible through a clean `.ext` syntax.

## Table of Contents

- [Installation](#installation)
- [Platform Support](#platform-support)
- [Quick Start](#quick-start)
- [Extensions](#extensions)
  - [Context Extensions](#context-extensions) ([General](#general) | [Sized](#sized) | [Padding](#padding) | [Border](#border) | [Device](#device) | [Navigation](#navigation) | [Popup Manager](#popup-manager))
  - [String Extension](#string-extension)
  - [Widget Extension](#widget-extension)
  - [Future Extension](#future-extension)
  - [List Extension](#list-extension)
  - [Iterable Extension](#iterable-extension)
  - [File Extension](#file-extension)
  - [Image Extension](#image-extension)
  - [Key Extension](#key-extension)
  - [Int Extension](#int-extension)
  - [Bool Extension](#bool-extension)
  - [Date Extension](#date-extension)
  - [Map Extension](#map-extension)
- [Utilities](#utilities)
- [Contributing](#contributing)
- [License](#license)

## Installation

Add `kartal` to your `pubspec.yaml`:

```yaml
dependencies:
  kartal: 4.3.0-dev.1
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

**Requirements:** Dart >=3.3.1 | Flutter >=3.19.0

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

Kartal extends `BuildContext` with 7 sub-extensions: `context.general`, `context.sized`, `context.padding`, `context.border`, `context.device`, `context.route`, and `context.popupManager`.

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
| `randomColor` | `MaterialColor` | Random material primary color |
| `isKeyBoardOpen` | `bool` | Whether the software keyboard is visible |
| `keyboardPadding` | `double` | Height of the keyboard when open |
| `appBrightness` | `Brightness` | Platform brightness (light/dark) |
| `focusNode` | `FocusNode` | Current focus scope node |
| `unfocus()` | `void` | Remove focus from current widget |

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

| Property | Return Type | Description |
|---|---|---|
| `isSmallScreen` | `bool` | `0 <= width < 300` |
| `isMediumScreen` | `bool` | `300 <= width < 600` |
| `isLargeScreen` | `bool` | `width >= 900` |
| `isAndroidDevice` | `bool` | Running on Android |
| `isIOSDevice` | `bool` | Running on iOS |
| `isWindowsDevice` | `bool` | Running on Windows |
| `isLinuxDevice` | `bool` | Running on Linux |
| `isMacOSDevice` | `bool` | Running on macOS |

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
| `isValidEmail` | `bool` | Email validation via regex |
| `isValidPassword` | `bool` | Min 8 chars, upper, lower, number, symbol |
| `searchable` | `String` | Lowercase with diacritics removed |
| `withoutSpecialCharacters` | `String?` | Removes diacritics |
| `toCapitalized()` | `String` | First letter uppercase, rest lowercase |
| `toTitleCase()` | `String` | Each word capitalized |
| `lineLength` | `int` | Number of lines |
| `phoneFormatValue` | `String` | Unmasked phone value |
| `timeFormatValue` | `String` | Unmasked time value |
| `timeOverlineFormatValue` | `String` | Unmasked time overline value |

##### Color & Images

```dart
'FF5733'.ext.color          // Color(0xffFF5733)
'FF5733'.ext.toColor        // Color from color code
'avatar'.ext.randomImage    // picsum.photos URL
```

| Property | Return Type | Description |
|---|---|---|
| `color` | `Color` | Color from hex string |
| `colorCode` | `int?` | Parsed color code |
| `toColor` | `Color` | Color from color code |
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
| `toBuild({onSuccess, loadingWidget, notFoundWidget, onError, data})` | `Widget` | FutureBuilder with typed callbacks |
| `timeoutOrNull({Duration timeOutDuration, bool enableLogger})` | `Future<T?>` | Returns null on timeout (default: 10s) |

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

---

### Iterable Extension

> **Note:** Uses `.exts` (plural) accessor.

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
| `differenceTime({DateLocalizationLabel})` | `String` | Human-readable time difference from now |

`DateLocalizationLabel` fields: `yearLabel`, `monthLabel`, `dayLabel`, `hourLabel`, `minuteLabel`, `secondLabel` (all default to English, e.g. "years ago").

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

### DeviceUtility

Singleton for device-related operations.

```dart
final deviceId = await DeviceUtility.instance.getUniqueDeviceId();
final isIpad = await DeviceUtility.instance.isIpad();
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
