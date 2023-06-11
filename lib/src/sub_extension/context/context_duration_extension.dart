import 'package:flutter/material.dart';

/// Provides convenient access to commonly used [Duration] values.
class _ContextDurationExtension {
  /// Returns a [Duration] object with a low duration of 500 milliseconds.
  Duration get durationLow => const Duration(milliseconds: 500);

  /// Returns a [Duration] object with a normal duration of 1 second.
  Duration get durationNormal => const Duration(seconds: 1);

  /// Returns a [Duration] object with a slow duration of 2 seconds.
  Duration get durationSlow => const Duration(seconds: 2);
}

extension DurationExtension on BuildContext {
  _ContextDurationExtension get duration => _ContextDurationExtension();

  @Deprecated('Use duration.durationLow instead')
  Duration get durationLow => const Duration(milliseconds: 500);
  @Deprecated('Use duration.durationLow instead')
  Duration get durationNormal => const Duration(seconds: 1);
  @Deprecated('Use duration.durationLow instead')
  Duration get durationSlow => const Duration(seconds: 2);
}
