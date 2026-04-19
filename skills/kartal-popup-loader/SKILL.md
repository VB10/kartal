---
name: kartal-popup-loader
description: "This skill should be used when showing or hiding a blocking modal loading indicator — typically a full-screen spinner, CircularProgressIndicator inside `showDialog`, or \"block UI while awaiting\" pattern — before and after an async call, or when dismissing the latest loader without manual `Navigator.of(context).pop()` tracking. The kartal package exposes `context.popupManager.showLoader()` and `hideLoader()` backed by a root-navigator dialog route, with optional `id` for concurrent loaders."
---

# Kartal — popup loader manager

## When to use

- Hand-written `showDialog` + `CircularProgressIndicator` for blocking loads.
- Multiple concurrent loaders that need ids.
- Need to dismiss the latest loader without tracking the route manually.

## API — `context.popupManager`

| Method | Role |
|--------|------|
| `showLoader({String? id, bool barrierDismissible = false, WidgetBuilder? widgetBuilder})` | uses `Navigator.of(context, rootNavigator: true)` and `PopupManager.withState` |
| `hideLoader({String? id})` | pops latest route or the route matching `id` |

Behavior details:

- `PopupManager` stores `LoaderRoute` instances with optional `id`; duplicate ids assert in debug.
- `_PopupExtension` is a singleton per `BuildContext` pattern (factory `_init`); first call sets the manager.

## Example

**Before**

```dart
showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => const Center(child: CircularProgressIndicator()),
);
```

**After**

```dart
context.popupManager.showLoader();
// ... async work ...
context.popupManager.hideLoader();
```

## When NOT to use

- Scoped progress inside a card (non-modal) — prefer local `ProgressIndicator`.
- When `Navigator` is unavailable or nested navigators must be targeted — this uses **root** navigator.

## Gotchas

- Calling `hideLoader` before `showLoader` triggers an assert.
- For multiple loaders, pass unique `id` values and close with the same `id`.

## Import

```dart
import 'package:kartal/kartal.dart';
```
