---
name: kartal-do-not-overuse
description: "This skill should be loaded alongside any other `kartal-*` skill so the agent avoids over-applying percentage-based helpers when a pixel-exact value (e.g. \"around 24 logical pixels\", \"exactly 16dp\", design-system tokens) is required, replacing declarative routers (GoRouter, auto_route) with imperative Navigator wrappers, editing generated `*.g.dart` / `*.freezed.dart` / `*.gr.dart` files, treating `string.ext.isValidEmail` or `isValidPassword` as security-grade validation, or hiding errors via `timeoutOrNull` when the user must see them."
---

# Kartal — guardrails (read before large refactors)

## When to use

Always load alongside other `kartal-*` skills before sweeping edits across a Flutter codebase.

## Do not

1. **Generated sources**  
   Never edit `*.g.dart`, `*.freezed.dart`, `*.gr.dart`, or other codegen outputs. Change the source model or builder input instead.

2. **Router conflicts**  
   If the app uses GoRouter, auto_route, or similar, do not replace declarative navigation with `context.route.navigateName` without aligning with that stack. `context.route` wraps imperative `Navigator`.

3. **Security vs convenience**  
   `string.ext.isValidEmail` / `isValidPassword` are regex-based helpers for UX. Do not treat them as authoritative for auth, compliance, or storage.

4. **Pixel-perfect design systems**  
   When tokens or Figma specs demand exact dp values, do not force `context.padding.*` / `context.sized.*` percentages.

5. **Misleading `MediaQuery` on desktop/web**  
   Window resizing changes `MediaQuery` height quickly; kartal padding based on height may jump unexpectedly.

6. **Popup manager scope**  
   `context.popupManager` uses the **root** navigator. Do not use for nested navigator overlays unless that matches UX.

7. **Color parsing**  
   `string.ext.color` uses `int.parse`; invalid strings throw.

8. **Device width gaps**  
   `context.device.isSmallScreen` / `isMediumScreen` / `isLargeScreen` use `[300,600)`, `[600,900)`, `[900,∞)`. Width `<300` matches **none** of the three.

9. **Hide errors**  
   `future.ext.timeoutOrNull` returns `null` on failure — avoid for flows that must surface errors to users.

## Prefer plain Flutter when

- A single `const EdgeInsets` is intentionally const for performance.
- `LayoutBuilder` constraints already express the layout.
- Testing requires deterministic geometry independent of screen size.

## Import

```dart
import 'package:kartal/kartal.dart';
```

Only import kartal in files where it is used; avoid blanket imports in `main.dart` unless needed.
