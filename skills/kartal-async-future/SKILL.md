---
name: kartal-async-future
description: "This skill should be used when replacing a verbose FutureBuilder + ConnectionState switch with a single-line widget builder, when adding a safe timeout to a Future that returns null instead of throwing, when running jsonEncode of a large Map off the UI thread via `compute`, or when removing null entries from a List or Iterable. The kartal package exposes future.ext.toBuild, future.ext.timeoutOrNull, map.ext.safeJsonEncodeCompute, list.ext.makeSafe, and iterable.exts.makeSafe."
---

# Kartal — async UI, JSON compute, safe collections

## When to use

- Verbose `FutureBuilder` with manual `ConnectionState` switching.
- `future.timeout` with try/catch logging boilerplate.
- `jsonEncode` of large maps on the UI isolate.
- `[null, foo, bar]` cleanup or nullable list checks.

## API — `future.ext` (`FutureExtension`)

| Member | Role |
|--------|------|
| `toBuild({required onSuccess, required loadingWidget, required notFoundWidget, required onError, data})` | wraps `FutureBuilder` with `switch (snapshot.connectionState)` mapping |
| `timeoutOrNull({timeOutDuration = 10s, enableLogger = true})` | returns `null` on timeout/error; `debugPrint` in debug when logger enabled |

## API — `map.ext` (`MapExtension` on `Map<String, dynamic>`)

| Member | Role |
|--------|------|
| `safeJsonEncodeCompute()` | `compute(jsonEncode, map)` returning `Future<String?>` |

## API — `iterable.exts` (`IterableExtensions` on `Iterable<T?>`)

| Member | Role |
|--------|------|
| `makeSafe()` | filters nulls, casts to `T` |
| `makeSafeCustom(onHandle)` | custom filter + cast |

## API — `list.ext` (`ListExtension` / `ListDefaultExtension`)

| Member | Role |
|--------|------|
| `isNullOrEmpty`, `isNotNullOrEmpty` | null-safe emptiness |
| `makeSafe()` | removes null elements |
| `indexOrNull(search)` | `indexWhere` but returns `null` when `-1` |

## Example

**Before**

```dart
FutureBuilder<User>(
  future: repo.load(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.hasError) return ErrorWidget(snapshot.error!);
    if (!snapshot.hasData) return const Text('No data');
    return Text(snapshot.data!.name);
  },
);
```

**After**

```dart
repo.load().ext.toBuild(
  loadingWidget: const CircularProgressIndicator(),
  notFoundWidget: const Text('No data'),
  onError: const Text('Error'),
  onSuccess: (data) => Text(data?.name ?? ''),
);
```

## When NOT to use

- Streams or `AsyncValue` from Riverpod — different primitives.
- When precise error reporting to the UI is required — `timeoutOrNull` hides errors.

## Gotchas

- `toBuild` treats `ConnectionState.done` without data as `onError`, not `notFoundWidget`.
- `list.ext` applies to `List<T>?` and non-null `List<T>` via separate extensions.

## Import

```dart
import 'package:kartal/kartal.dart';
```
