import 'dart:async';

import 'package:flutter/foundation.dart';

/// Delays a callback until the caller stops firing for [duration].
///
/// Each new [call] cancels the pending one, so only the final invocation in a
/// burst runs. The usual case is a search field that should query once the
/// user stops typing:
///
/// ```dart
/// final _debouncer = Debouncer(const Duration(milliseconds: 300));
///
/// void onChanged(String query) => _debouncer.call(() => search(query));
///
/// @override
/// void dispose() {
///   _debouncer.dispose();
///   super.dispose();
/// }
/// ```
///
/// Always [dispose] it, otherwise a pending timer can fire after the owning
/// widget is gone.
final class Debouncer {
  /// Creates a debouncer that waits [duration] after the last call.
  Debouncer(this.duration);

  /// How long to wait after the most recent call before running it.
  final Duration duration;

  Timer? _timer;

  /// Whether a call is currently waiting to run.
  bool get isPending => _timer?.isActive ?? false;

  /// Schedules [action], replacing any call still waiting to run.
  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Cancels the pending call, if there is one.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Runs the pending call immediately instead of waiting out the delay.
  ///
  /// Does nothing when nothing is pending.
  void flush(VoidCallback action) {
    if (!isPending) return;

    cancel();
    action();
  }

  /// Cancels any pending call and releases the timer.
  void dispose() => cancel();
}

/// Runs a callback at most once per [duration].
///
/// The first [call] runs immediately and any call inside the cooldown window
/// is dropped. Use this for events that fire continuously but only need
/// periodic handling, such as scroll or resize:
///
/// ```dart
/// final _throttler = Throttler(const Duration(milliseconds: 100));
///
/// void onScroll() => _throttler.call(updateHeader);
/// ```
///
/// This drops intermediate calls rather than deferring them; reach for
/// [Debouncer] when you need the last value in a burst instead.
final class Throttler {
  /// Creates a throttler that allows one call per [duration].
  Throttler(this.duration);

  /// The minimum gap between two accepted calls.
  final Duration duration;

  Timer? _cooldown;

  /// Whether a call right now would be dropped.
  bool get isThrottled => _cooldown?.isActive ?? false;

  /// Runs [action] unless a call was already accepted within [duration].
  ///
  /// Returns `true` when the call ran and `false` when it was dropped.
  bool call(VoidCallback action) {
    if (isThrottled) return false;

    action();
    _cooldown = Timer(duration, () => _cooldown = null);

    return true;
  }

  /// Clears the cooldown, so the next call runs immediately.
  void reset() {
    _cooldown?.cancel();
    _cooldown = null;
  }

  /// Clears the cooldown and releases the timer.
  void dispose() => reset();
}
