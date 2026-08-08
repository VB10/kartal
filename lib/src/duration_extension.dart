/// Provides convenient access to commonly used properties from [Duration].
extension DurationExtension on Duration {
  /// Provides convenient access to commonly used properties from [Duration].
  _DurationExtension get ext => _DurationExtension(this);
}

final class _DurationExtension {
  _DurationExtension(Duration duration) : _duration = duration;

  final Duration _duration;

  /// Formats this duration as a clock reading.
  ///
  /// Renders `mm:ss` and promotes to `hh:mm:ss` once the duration reaches an
  /// hour, or whenever `forceHours` is set on [format].
  ///
  /// ```dart
  /// const Duration(seconds: 45).ext.formatted;             // '00:45'
  /// const Duration(minutes: 3, seconds: 7).ext.formatted;  // '03:07'
  /// const Duration(hours: 1, minutes: 2).ext.formatted;    // '01:02:00'
  /// ```
  String get formatted => format();

  /// Formats this duration as a clock reading.
  ///
  /// Set [forceHours] to always include the hours component.
  String format({bool forceHours = false}) {
    final isNegative = _duration.isNegative;
    final absolute = _duration.abs();

    String pad(int value) => value.toString().padLeft(2, '0');

    final hours = absolute.inHours;
    final minutes = absolute.inMinutes.remainder(60);
    final seconds = absolute.inSeconds.remainder(60);

    final parts = <String>[
      if (hours > 0 || forceHours) pad(hours),
      pad(minutes),
      pad(seconds),
    ];

    return '${isNegative ? '-' : ''}${parts.join(':')}';
  }

  /// Waits for this duration.
  ///
  /// ```dart
  /// await 300.ext.ms.ext.delay();
  /// ```
  Future<void> delay() => Future<void>.delayed(_duration);

  /// Waits for this duration and then runs [computation].
  Future<T> delayed<T>(T Function() computation) =>
      Future<T>.delayed(_duration, computation);
}
