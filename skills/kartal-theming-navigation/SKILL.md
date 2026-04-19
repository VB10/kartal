---
name: kartal-theming-navigation
description: "This skill should be used when reading the current ThemeData, ColorScheme, or TextTheme styles such as headlineMedium / titleLarge / bodyMedium, when reading MediaQuery values or keyboard insets / visibility, when calling FocusScope.of(context).unfocus, when calling Navigator.of(context).pop / push / pushNamed / pushNamedAndRemoveUntil (\"pop the current screen\", \"go back\", \"navigate to a named route\"), or when wrapping a widget in Visibility, IgnorePointer + Opacity disabled state, or SliverToBoxAdapter. The kartal package exposes context.general (theme, textTheme, mediaQuery, keyboard helpers), context.route (pop, navigateName, navigateToReset, navigateToPage), and widget.ext (toVisible, toDisabled, sliver)."
---

# Kartal — theming, media, navigation, widget helpers

## When to use

- `MediaQuery.of(context)` / `Theme.of(context)` / `FocusScope.of(context)` boilerplate.
- Keyboard inset checks (`viewInsets.bottom`).
- `Navigator.of(context).push`, `pop`, `pushNamed`, `pushNamedAndRemoveUntil`.
- Toggling visibility or disabled appearance of a subtree.
- Wrapping a non-sliver child for `CustomScrollView`.

## API — `context.general`

| Member | Returns / behavior |
|--------|----------------------|
| `mediaQuery` | `MediaQuery.of(context)` |
| `mediaSize` | `MediaQuery.sizeOf(context)` |
| `mediaViewInset` | `MediaQuery.viewInsetsOf(context)` |
| `mediaBrightness` | `MediaQuery.platformBrightnessOf(context)` |
| `mediaTextScale(font)` | scales a font double via `MediaQuery.textScalerOf` |
| `appTheme` | `Theme.of(context)` |
| `textTheme`, `primaryTextTheme`, `colorScheme` | from `appTheme` |
| `focusNode` | `FocusScope.of(context)` |
| `isKeyBoardOpen` | `mediaViewInset.bottom > 0` |
| `keyboardPadding` | `mediaViewInset.bottom` |
| `appBrightness` | same as `mediaBrightness` |
| `unfocus()` | `focusNode.unfocus()` |

## API — `context.route`

`context.route.navigation` is the `NavigatorState` from `Navigator.of(context)`.

| Method / getter | Role |
|-----------------|------|
| `navigation` | underlying `NavigatorState` |
| `pop<T>([T? data])` | `navigation.maybePop(data)` |
| `popWithRoot()` | `Navigator.of(context, rootNavigator: true).pop()` |
| `navigateName<T>(path, {data})` | `pushNamed` |
| `navigateToReset<T>(path, {data})` | `pushNamedAndRemoveUntil` until predicate false |
| `navigateToPage<T>(page, {extra, type})` | `push` with `SlideRoute` (`SlideType` default `DEFAULT`) |

## API — `widget.ext` (`WidgetExtension`)

| Member | Role |
|--------|------|
| `toVisible({bool value = true})` | child or `SizedBox.shrink()` |
| `toDisabled({bool? disable, double? opacity})` | `IgnorePointer` + `Opacity` |
| `sliver` | `SliverToBoxAdapter(child: widget)` |

## Example

**Before**

```dart
Theme.of(context).textTheme.titleLarge;
Navigator.of(context).pop();
```

**After**

```dart
context.general.textTheme.titleLarge;
context.route.pop();
```

## When NOT to use

- GoRouter / auto_route / imperative API mismatch: `context.route` wraps imperative `Navigator`; do not fight the app’s router.
- When `rootNavigator` semantics differ per call site; `popWithRoot` always uses root.

## Gotchas

- `pop` uses `maybePop`, not unconditional `pop`.
- `navigateToPage` always uses kartal’s slide route helper.

## Import

```dart
import 'package:kartal/kartal.dart';
```
