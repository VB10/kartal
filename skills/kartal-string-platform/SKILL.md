---
name: kartal-string-platform
description: "This skill should be used when launching URLs from a string (https://, mailto:, tel:) — typically replacing `url_launcher` boilerplate — opening native Apple Maps or Google Maps from a free-text address or query, sharing text via WhatsApp / email / system share sheet (equivalent of `share_plus`), or reading app metadata such as appName, packageName, version, buildNumber, or deviceId (equivalent of `package_info_plus`). The kartal package exposes these via `.ext` on String (e.g. `email.ext.launchEmail`, `address.ext.launchMaps`, `text.ext.share()`)."
---

# Kartal — string platform, launchers, and share

## When to use

- `url_launcher` boilerplate for `mailto:`, `tel:`, or `https:`.
- Opening Apple Maps / Google Maps / web maps from a free-text query.
- WhatsApp / email / system share of a string.
- Reading app / package metadata exposed by `CustomPlatform`.

## API — app metadata (`StringPlatformMixin`)

| Member | Role |
|--------|------|
| `appName`, `packageName`, `version`, `buildNumber` | from `CustomPlatform.instance` |
| `deviceId` | `Future<String>` from `CustomPlatform.instance.deviceId` (empty string fallback) |

## API — launch & share (`StringShareMixin`)

| Member | Role |
|--------|------|
| `launchEmail` | `mailto:` via `launchUrlString` |
| `launchPhone` | `tel:` |
| `launchWebsite` | `launchUrlString(value)` |
| `launchWebsiteCustom({enableJavaScript, enableDomStorage, headers, webOnlyWindowName, mode})` | advanced `launchUrlString` |
| `launchMaps({callBack})` | Apple Maps on iOS else Google Maps; falls back to `MapsUtility.openGoogleWebMapsWithQuery` |
| `shareWhatsApp()`, `shareMail(title)`, `share()` | delegates to `CustomPlatform.instance` |

## Example

**Before**

```dart
await launchUrl(Uri.parse('mailto:$email'));
```

**After**

```dart
await email.ext.launchEmail;
```

## When NOT to use

- Deep links that need custom schemes or Android intent extras not covered by `url_launcher`.
- When `CustomPlatform` is not initialized and metadata would be wrong — verify app setup.

## Gotchas

- `launchMaps` URL-encodes the query; pass raw address text on the string receiver.
- `launchWebsite` returns `Future<bool>`; handle `false`.

## Import

```dart
import 'package:kartal/kartal.dart';
```
