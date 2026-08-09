import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Provides convenient access to commonly used properties from [Future].
extension FutureExtension<T> on Future<T> {
  /// Provides convenient access to commonly used properties from [Future].
  _FutureExtension<T> get ext => _FutureExtension(this);
}

/// You can use future utility so easy with [FutureExtension]
final class _FutureExtension<T> {
  _FutureExtension(Future<T> future) : _future = future;

  final Future<T> _future;

  /// Builds a widget based on the state of a future. It allows specifying
  /// different widgets for
  /// different states, such as loading, success, not found, and error.
  /// [errorBuilder] takes precedence over [onError] when both are supplied,
  /// and unlike [onError] it receives the error itself.
  Widget toBuild({
    required Widget Function(T? data) onSuccess,
    required Widget loadingWidget,
    required Widget notFoundWidget,
    required Widget onError,
    T? data,
    Widget Function(Object error)? errorBuilder,
  }) => FutureBuilder<T>(
    future: _future,
    initialData: data,
    builder: (context, snapshot) {
      final result = switch (snapshot.connectionState) {
        // Display the loading widget when the future is in a waiting
        //  or active state.
        ConnectionState.waiting || ConnectionState.active => loadingWidget,
        // Display the success widget when the future is done and has data.
        ConnectionState.done =>
          snapshot.hasData
              ?
                // Display the success widget when the future is done and has data.
                onSuccess(snapshot.data)
              // Display the error widget when the future is done but has no data.
              : errorBuilder?.call(
                      snapshot.error ?? 'The future completed without data.',
                    ) ??
                    onError,
        // Display the not found widget when the future has no connection state.
        _ => notFoundWidget,
      };
      return result;
    },
  );

  /// Returns the future value if it is not null, otherwise returns the default value.
  Future<T?> timeoutOrNull({
    Duration timeOutDuration = const Duration(seconds: 10),
    bool enableLogger = true,
  }) async {
    try {
      final response = await _future.timeout(timeOutDuration);
      return response;
    } on Exception catch (e) {
      if (enableLogger && kDebugMode) debugPrint('$T $e');
      return null;
    }
  }

  /// Returns the future's value, falling back to [fallback] on error.
  ///
  /// ```dart
  /// final user = await fetchUser().ext.onErrorReturn(User.guest());
  /// ```
  Future<T> onErrorReturn(T fallback) async {
    try {
      return await _future;
    } on Object {
      return fallback;
    }
  }

  /// Returns the future's value, or `null` on error.
  Future<T?> orNull() async {
    try {
      return await _future;
    } on Object {
      return null;
    }
  }
}

/// Retries [action] until it succeeds or the attempts run out.
///
/// This is a function rather than a member on the future extension because a
/// `Future` can only be awaited once: retrying needs something that produces a
/// fresh future per attempt.
///
/// ```dart
/// final data = await kartalRetry(
///   () => api.fetch(),
///   attempts: 3,
///   delay: const Duration(milliseconds: 200),
/// );
/// ```
///
/// [delay] is applied between attempts. When [exponentialBackoff] is set the
/// delay doubles after each failure. [retryIf] can restrict which errors are
/// worth retrying; by default every error is. The last error is rethrown once
/// the attempts are exhausted.
///
/// Throws a [RangeError] when [attempts] is not positive.
Future<T> kartalRetry<T>(
  Future<T> Function() action, {
  int attempts = 3,
  Duration delay = const Duration(milliseconds: 200),
  bool exponentialBackoff = false,
  bool Function(Object error)? retryIf,
}) async {
  if (attempts <= 0) {
    throw RangeError.value(attempts, 'attempts', 'must be greater than zero');
  }

  var currentDelay = delay;

  for (var attempt = 1; ; attempt++) {
    try {
      return await action();
    } on Object catch (error) {
      final isLastAttempt = attempt >= attempts;
      if (isLastAttempt || !(retryIf?.call(error) ?? true)) rethrow;

      if (currentDelay > Duration.zero) {
        await Future<void>.delayed(currentDelay);
      }
      if (exponentialBackoff) currentDelay *= 2;
    }
  }
}
