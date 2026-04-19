---
name: kartal-overview
description: "This skill should be used as the first kartal skill loaded whenever a Flutter project imports `package:kartal/kartal.dart` or lists kartal in `pubspec.yaml`. It maps which other `kartal-*` skill to consult for BuildContext extensions, strings, futures, loaders, navigation, theming, or utilities."
---

# Kartal — overview for agents

The **kartal** package adds ergonomic extensions on `BuildContext`, `String`, `Future`, `List`, `Iterable`, primitives, and small utilities (maps, assets, link preview, logging).

## When to use this skill

Use when `package:kartal/kartal.dart` is imported or listed in `pubspec.yaml`, and the task touches UI, navigation, strings, async widgets, loaders, maps, or assets.

## Which skill to open next

| Topic | Skill folder |
|------|----------------|
| Responsive padding, spacers, border radius, breakpoints | `kartal-responsive-ui` |
| Theme, media query helpers, navigation, widget wrappers | `kartal-theming-navigation` |
| Validation, capitalization, JSON-from-string, colors from hex | `kartal-string-validation` |
| Launchers, share, app metadata, maps query | `kartal-string-platform` |
| `FutureBuilder` replacement, timeouts, safe lists | `kartal-async-future` |
| Global blocking loader dialogs | `kartal-popup-loader` |
| Maps utility, bundle JSON, link preview, logger, file/image/key helpers | `kartal-utilities` |
| Guardrails and anti-patterns | `kartal-do-not-overuse` |

## Import

```dart
import 'package:kartal/kartal.dart';
```

Always read `kartal-do-not-overuse` before large refactors.
