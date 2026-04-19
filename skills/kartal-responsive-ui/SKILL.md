---
name: kartal-responsive-ui
description: "This skill should be used when writing or editing Flutter UI that touches padding, margin, EdgeInsets, EdgeInsets.symmetric, EdgeInsets.all or EdgeInsets.only, SizedBox spacers or vertical/horizontal gaps between widgets, BorderRadius.circular or rounded button/card corners, screen-size breakpoints (small/medium/large, mobile/tablet), or any width/height computed from MediaQuery, screen size, or a screen percentage like \"60% of the screen width\" or `screenWidth * 0.6`. The kartal package exposes context.padding for percentage-based EdgeInsets, context.sized for SizedBox helpers and `dynamicWidth(v)` / `dynamicHeight(v)` fractions of MediaQuery, context.border for radii, and context.device for breakpoints."
---

# Kartal — responsive UI (`context.padding`, `context.sized`, `context.border`, `context.device`)

## When to use

- `MediaQuery.of(context).size`, `MediaQuery.sizeOf(context)`, or manual `width * 0.0x` math.
- `EdgeInsets.*` or `Padding` with hard-coded numbers for “responsive” intent.
- `SizedBox` used only for vertical or horizontal gaps.
- `BorderRadius.circular(...)` derived from screen width.
- Branching on screen width for layout.

## API — `context.padding`

Values are **fractions of the current widget height** (via `context.sized` internally): low **1%**, normal **2%**, medium **4%**, high **10%**.

| Group | Members |
|-------|---------|
| All sides | `low`, `normal`, `medium`, `high` |
| Horizontal | `horizontalLow`, `horizontalNormal`, `horizontalMedium`, `horizontalHigh` |
| Vertical | `verticalLow`, `verticalNormal`, `verticalMedium`, `verticalHigh` |
| Single side | `onlyLeft*`, `onlyRight*`, `onlyTop*`, `onlyBottom*` where `*` is `Low`, `Normal`, `Medium`, or `High` |

## API — `context.sized`

| Member | Role |
|--------|------|
| `width`, `height` | `MediaQuery` size shortcuts |
| `lowValue`, `normalValue`, `mediumValue`, `highValue` | 1% / 2% / 4% / 10% of **height** |
| `dynamicWidth(v)`, `dynamicHeight(v)` | `width * v`, `height * v` |
| `emptySizedWidthBoxLow`, `emptySizedWidthBoxLow3x`, `emptySizedWidthBoxNormal`, `emptySizedWidthBoxHigh` | horizontal `SizedBox` helpers |
| `emptySizedHeightBoxLow`, `emptySizedHeightBoxLow3x`, `emptySizedHeightBoxNormal`, `emptySizedHeightBoxHigh` | vertical `SizedBox` helpers |

`SpaceSizedWidthBox` / `SpaceSizedHeightBox` use **height ratios** for width boxes as in source.

## API — `context.border`

| Kind | Members |
|------|---------|
| `Radius` | `lowRadius`, `normalRadius`, `highRadius` (from **width** × 0.02 / 0.05 / 0.1) |
| `BorderRadius` | `lowBorderRadius`, `normalBorderRadius`, `highBorderRadius` |
| `RoundedRectangleBorder` | `roundedRectangleBorderLow`, `roundedRectangleAllBorderNormal`, `roundedRectangleBorderNormal`, `roundedRectangleBorderMedium`, `roundedRectangleBorderHigh` |

## API — `context.device`

From `ResponsibilityConstants` (`smallScreenSize` 300, `mediumScreenSize` 600, `largeScreenSize` 900):

| Getter | True when width `w` satisfies |
|--------|------------------------------|
| `isSmallScreen` | `300 <= w < 600` |
| `isMediumScreen` | `600 <= w < 900` |
| `isLargeScreen` | `w >= 900` |
| `isAndroidDevice`, `isIOSDevice`, `isWindowsDevice`, `isLinuxDevice`, `isMacOSDevice` | platform checks via `CustomPlatform` |

Widths **below 300** match none of the three `is*Screen` flags; handle explicitly if needed.

## Example

**Before**

```dart
final w = MediaQuery.sizeOf(context).width;
Padding(
  padding: const EdgeInsets.all(16),
  child: SizedBox(height: w * 0.02, child: child),
);
```

**After**

```dart
Padding(
  padding: context.padding.normal,
  child: SizedBox(height: context.sized.normalValue, child: child),
);
```

## When NOT to use

- Pixel-perfect specs from a design system token.
- Layouts already driven by `LayoutBuilder` / `SliverConstraints`.
- Web/desktop windows where height-based padding is misleading.

## Gotchas

- Padding scale uses **height**, including horizontal-only insets.
- Prefer `context.border.lowBorderRadius` vs `Radius` when a `BorderRadius` is required.

## Import

```dart
import 'package:kartal/kartal.dart';
```
