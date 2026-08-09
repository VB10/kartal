## [5.0.0]

Requires Dart `>=3.10.0` and Flutter `>=3.38.1`.

### Breaking changes

| Before | Now | Why |
| --- | --- | --- |
| `404.ext.httpStatus` returned `success` | returns `clientError` | `HttpResult.fromStatusCode` used `\|\|` between its relational patterns, so the first arm matched every integer and *every* status code resolved to `success`. Codes outside `[200, 600)` now map to `unknown`. |
| `isSmallScreen` was `300 <= w < 600`, `isMediumScreen` was `600 <= w < 900` | `isSmallScreen` is `w < 300`, `isMediumScreen` is `300 <= w < 600` | The getters were shifted a band from their own documentation, so a 200px screen answered `false` to all three. `isExpandedScreen` is new and covers the `600..900` gap that had no accessor. |
| `differenceTime()` threw on a null receiver | returns `DateLocalizationLabel.emptyLabel` | The extension is declared on `DateTime?`, so a null receiver is expected input, not an error. |
| `differenceTime()` returned `''` for sub-second and future times | returns `justNowLabel` | `''` was indistinguishable from the null-receiver result. |
| `differenceTime({DateLocalizationLabel localizationLabel = ...})` | `differenceTime({DateLocalizationLabel? localizationLabel})` | Omitting it now uses the labels from `KartalConfig`, still defaulting to English. Callers passing a label are unaffected. |
| `WebFileTypeExtension` | `FileTypeExtension` | The web copy was a verbatim duplicate; the remaining extension already resolves `File` for every platform through conditional imports. |
| `String.ext.toColor` returned white for `'#FF0000'` | parses it | Hex parsing now accepts an optional leading `#` and 8-digit ARGB. |
| `CustomLinkPreview.getLinkPreviewData('https://example.com')` returned `null` | fetches it | URL validation tested `Uri.hasAbsolutePath`, which asks whether the *path* starts with a slash, so every URL without a trailing path was rejected — while a bare `/relative/path` was accepted. |

### Fixed

- `context.popupManager` cached a single instance in a static field, pinning the first `BuildContext` it ever saw. Once that route was disposed every `showLoader()` pushed onto a dead navigator. Managers are now held in an `Expando` keyed by `NavigatorState`.
- `share()` presented the share sheet twice on iPad, because the iPad branch fell through to the generic call.
- `Color.ext.randomColor` indexed `Colors.primaries` with `nextInt(17)` against an 18 entry list, so `blueGrey` was unreachable.
- The web platform's `isAndroid`/`isMacOS`/`isWindows`/`isLinux` getters were hardcoded `false` behind a `TODO`. They now sniff the user agent, ordered so that Android (which reports `Linux`) and iOS (which reports `like Mac OS X`) are not misclassified.

### Added

- **Numbers**: `compact()`, `readableFileSize`, `currency()`, `percent()`, `fraction()`, `clampRange()`, `toRadians`, `toDegrees`, `isBetween()`, plus `int.ordinal` and `int.ms`/`seconds`/`minutes`/`hours`/`days` as `Duration` builders.
- **Duration**: `formatted`, `format(forceHours:)`, `delay()`, `delayed()`.
- **Colour toolkit**: `toHex()`, `lighten()`, `darken()`, `isDark`, `isLight`, `luminance`, `contrastText()`, `blend()`, `toMaterialColor()`, plus `KartalColor.random(seed:)` and `KartalColor.tryParse()`.
- **Validators**, implemented as checksums rather than shape checks: `isValidTckn` (Turkish identity), `isValidIban` (ISO 13616 mod-97), `isValidCreditCard` (Luhn), `isValidUrl`, `isValidPhone`, `isNumeric`.
- **String formatting**: `mask()`, `maskEmail`, `maskPhone()`, `toSlug()`, `truncate()`, `initials()`, `removeHtmlTags`, `wordCount`, `readingTimeMinutes`, `reversed`, `base64Encoded`, `base64Decoded`, `toDateTimeOrNull()`.
- **Collections**, on both `List` and `Iterable`: `chunked()`, `paged()`, `groupBy()`, `distinctBy()`, `sortedBy()`, `sortedByDescending()`, `sumBy()`, `averageBy()`, `partition()`, `mapIndexed()`, `firstWhereOrNull()`, `randomOrNull()`, and `swap()`, `takeLast()`, `separatedBy()`, `replaceAt()`, `elementAtOrNull()`.
- **Async**: `kartalRetry()` with optional exponential backoff and a `retryIf` predicate, `onErrorReturn()`, `orNull()`, an `errorBuilder` on `toBuild`, plus new `Debouncer` and `Throttler`.
- **Widget chaining**: `paddingAll()`, `paddingSymmetric()`, `paddingOnly()`, `padding()`, `center`, `expanded()`, `flexible()`, `onTap()`, `safeArea`, `tooltip()`, `hero()`, `align()`, `opacity()`, `constrained()`, `sized()`, `card()`, `rotated()`, `clipRounded()`, `positioned()`.
- **Context**: `device.breakpoint` with a `DeviceBreakpoint` enum and `device.responsive()`; `general.isDarkMode`, `isLightMode`, `orientation`, `isLandscape`, `isPortrait`, `locale`, `safePadding`, `topPadding`, `bottomPadding`, `devicePixelRatio`; and a new `context.overlay` for `showSnack()`, `showSheet()`, `showDialogCustom()` and `showConfirm()`.
- **`KartalConfig`** to override breakpoints and date labels globally, plus a `DateLocalizationLabel.tr()` preset.
- `HttpResult`, `SlideType`, `MapsUtility`, `SpaceSizedHeightBox` and `SpaceSizedWidthBox` are now exported. All were already reachable from the public API but could only be named through a deep `src/` import.

### Changed

- Dependencies: `device_info_plus` 11→13, `package_info_plus` 8→10, `share_plus` 11→13, `very_good_analysis` 8→10, `dio` 5.11, `logger` 2.7.
- `CustomLinkPreview.getLinkPreviewData` accepts an optional `Dio`, so the tests no longer make real HTTP requests.
- CI now gates on formatting, `analyze --fatal-infos`, an 85% coverage floor, `pub publish --dry-run`, and a web **and wasm** build of the example.
- Test coverage 58% → 91%, 95 → 428 tests.

### Known limitations

`isValidEmail` is unchanged in this release and is more permissive than it
looks. Its regex is not anchored at the end, and a `+-/` range inside the
character class is read as a range rather than three literals, so all of these
are currently accepted:

```dart
'veli,test@kartal.dev'.ext.isValidEmail;              // true, comma
'user@domain.com<script>'.ext.isValidEmail;           // true, unanchored
'veli@kartal.dev trailing text'.ext.isValidEmail;     // true, unanchored
'user@my_mail.com'.ext.isValidEmail;                  // true, underscore
'veli..test@kartal.dev'.ext.isValidEmail;             // true, double dot
```

Do not rely on it as a sanitising gate. A fix is open as
[#93](https://github.com/VB10/kartal/pull/93) and is deferred to a follow-up
release, because tightening it rejects addresses that pass today and so is a
behavioural break of its own.

## [4.2.0]
- Added new color extension for random color and with opacity
- Updated readme file for new version
- Updated package for mime and share_plus

## [4.1.0]
- Updated package for share_plus with major update
- Added new pr about focus scope node #73 

## [4.0.4]
- Updated package name issues for string extension

## [4.0.3]
- Fixed [#67](https://github.com/VB10/kartal/issues/67)

## [4.0.2]
- Updated readme file for new screen shoot url

## [4.0.1]
- Updated readme file for new version

## [4.0.0]
- Added web support for all extension
- Updated documentation for general
- Added PopupManager extension on BuildContext for showing loader widget
- Added PopupManager class for showing
- Added link preview extension
- Implemented new date extension from #60
- Added new extension for iterable list
- New version has removed all deprecated code now using.
- Added new extension about LinkPreview for any url.
- Fixed issue for iterable extension
- Updated readme file for utility and some other extension
- Fixed open maps issue for android side.

## [4.0.0-dev4]
- Added web support for all extension
- Updated documentation for general
- Added PopupManager extension on BuildContext for showing loader widget
- Added PopupManager class for showing loader widget

## [4.0.0-dev3]
- Fixed some extension with default value
- Added new extension for nullable boolean check
- Some coding fixes

## [4.0.0-dev2]
- Fixed share issue for whatsapp


## [4.0.0-dev1]
- Added link preview extension
- Implemented new date extension from #60
- Added new extension for iterable list


## [3.5.0]

- New version has removed all deprecated code now using.
- Added new extension about LinkPreview for any url.
- Fixed issue for iterable extension
- Updated readme file for utility and some other extension

## [3.4.4]

- Fixed open maps issue for android side.

## [3.4.3]

- Timeout extension added for any future request

## [3.4.2]

- Added Maps Redirection with Any String Value

## [3.4.1]

- Deleted json data in test folder

## [3.4.0]

- Bundle decoder has fixed for single model parse
- Removed unused json file

## [3.3.0]

- Added mediaSize, mediaViewInset, mediaBrightness etc instead of directly use MediaQuery.
- Updated readme file for some sample images.

## [3.2.0]

- makeSafe and makeSafeCustom added for iterable nullable list.

## [3.1.0]

- Added on new extension about json encode and decode operation
- You can call safeJsonDecodeCompute with any string value
- You can call safeJsonEncodeCompute with Map<String,dynamic> value

## [3.0.1]

- Readme updated for new version requirement

## [3.0.0]

- updated major package version changes

## [2.8.0]

- device info package updated
- added new platform support
- added new key extension feature
- updated indexOrNull for generic list

## [2.7.0]

- added device id method in string extension
- added some coding fix

## [2.5.1]

- Same coding fixes and fixing package dependency.

## [2.4.3]

- added plus format in email regex

## [2.4.2]

- improved email regex
- added lineLength on string

## [2.4.1]

- added sliver extension on widget
- small fixes

## [2.4.0]

- popWithRoot added in context.
- new padding ability added
- keyboard bottom padding added
- collection exported
- to disable has a opacity property for custom scenario.

## [2.3.2]

- Flutter 3 linter updated
- Some improvement added

## [2.3.1]

- Navigation pop problems fixed
- Web example added.

## [2.3.0]

- Navigation has accept Dynamic type for will be return this result
- Removed special character extension added on string.

## [2.2.1]

- Added custom launch options
- String extension fixed for nullable.

## [2.2.0]

- Lint updated then fixed problems.
- @desxz added file type, tablet and new extensions to library.
- @Krdnzbyza fixed height size problems.

## [2.1.1]

- Migrated from the deprecated package_info plugin to package_info_plus.

## [2.1.0] - 6/6/2021

- Animated navigation
- Random image
- Some fixes.

## [0.0.1] - 14/12/2020

- Context, Image, Int and String Extension first version added.

## [0.0.2] - 18/12/2020

- More extension added with context, string, padding etc.

## [1.0.0] - 19/12/2020

- Documentation completed.

## [1.1.0] - 2/1/2021

- Input formatter added on string extension.
- Vertical padding added on context.
- Navigation acsess added on context.

## [1.2.0] - 6/1/2021

- List Extension added.
- Platform extension added.

## [2.0.0] - 27/2/2021

- Null safety migration complete

## [2.0.0-nullsafety.1] - 27/2/2021

- Null safety versioning added migration complete
