---
name: kartal-string-validation
description: "This skill should be used when validating Dart strings — email format, password rules, null or empty checks — typically inside a TextFormField / FormField `validator` callback, when capitalizing or title-casing text, when parsing a hex color string into a Color, when counting lines, when building a Bearer Authorization header map, or when decoding JSON from a String on a background isolate. The kartal package adds these via `.ext` on String and String? (e.g. `value.ext.isValidEmail`, `value.ext.isNullOrEmpty`, `value.ext.toCapitalized`, `value.ext.color`, `value.ext.safeJsonDecodeCompute`)."
---

# Kartal — string validation, formatting, and core helpers

## When to use

- Manual `email.contains('@')`, hand-rolled password rules, or ad-hoc null/empty checks.
- Title case / capitalize first letter helpers.
- Hex color strings for Flutter `Color`.
- `jsonDecode` on a `String` that should run off the UI isolate.
- Authorization header maps.

## API — direct getters on `String` / `String?` via `.ext`

| Member | Role |
|--------|------|
| `lineLength` | counts newline-separated lines |
| `color` | `Color(int.parse('0xff$value'))` — expects hex without `0x` |
| `colorCode` | `int.tryParse('0xFF$value')` |
| `toColor` | `Color(colorCode ?? 0xFFFFFFFF)` |
| `randomImage`, `randomSquareImage` | Picsum URLs |
| `customProfileImage`, `customHighProfileImage` | Gravatar URLs |
| `bearer` | `{'Authorization': 'Bearer $value'}` |

## API — validation & text cleanup (`StringValidatorMixin`)

| Member | Role |
|--------|------|
| `searchable` | lowercased + `withoutSpecialCharacters` |
| `isNullOrEmpty`, `isNotNullOrNoEmpty` | empty / non-empty checks |
| `isValidEmail` | uses package `RegexConstants` email pattern |
| `isValidPassword` | length ≥ 8, upper, lower, digit, symbol via `RegexConstants` |
| `withoutSpecialCharacters` | diacritics stripped via `diacritic` |
| `phoneFormatValue` | unmasked phone via `InputFormatter.instance.phoneFormatter` |
| `timeFormatValue` | unmasked time |
| `timeOverlineFormatValue` | unmasked overline time |

## API — generic / JSON (`StringCoreMixin`)

| Member | Role |
|--------|------|
| `toCapitalized()` | first char upper, rest lower; empty if null/empty |
| `toTitleCase()` | word-wise capitalization |
| `toPrimitiveFromGeneric<T>()` | parses bool/int/double/String; throws `ListTypeNotSupported` for list generic |
| `safeJsonDecodeCompute<T>()` | `compute(jsonDecode, value)` returning `T?` |
| `checkListFormat(type)` | regex helper for list type strings |

## Example

**Before**

```dart
final ok = email != null && email.contains('@');
```

**After**

```dart
final ok = email.ext.isValidEmail;
```

## When NOT to use

- Security-critical validation (server-side rules, OWASP compliance) — treat `isValidEmail` / `isValidPassword` as UX-level helpers only.
- Colors from untrusted input without validation — `color` parsing can throw.

## Gotchas

- `color` uses `int.parse`; invalid hex throws.
- Typo in API name: getter is `isNotNullOrNoEmpty` (matches source).

## Import

```dart
import 'package:kartal/kartal.dart';
```
