import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// You can use future utility so easy with [FutureExtension]
class _FutureExtension<T> {
  _FutureExtension(Future<T> future) : _future = future;

  final Future<T> _future;

  /// Builds a widget based on the state of a future. It allows specifying different widgets for
  /// different states, such as loading, success, not found, and error.
  Widget toBuild({
    required Widget Function(T? data) onSuccess,
    required Widget loadingWidget,
    required Widget notFoundWidget,
    required Widget onError,
    T? data,
  }) =>
      FutureBuilder<T>(
        future: _future,
        initialData: data,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          final result = switch (snapshot.connectionState) {
            // Display the loading widget when the future is in a waiting or active state.
            ConnectionState.waiting || ConnectionState.active => loadingWidget,
            // Display the success widget when the future is done and has data.
            ConnectionState.done => snapshot.hasData
                ?
                // Display the success widget when the future is done and has data.
                onSuccess(snapshot.data)
                // Display the error widget when the future is done but has no data.
                : onError,
            // Display the not found widget when the future has no connection state.
            _ => notFoundWidget,
          };
          return result;
        },
      );

  Future<T?> timeoutOrNull({
    Duration timeOutDuration = const Duration(seconds: 10),
    bool enableLogger = true,
  }) async {
    try {
      final response = await _future.timeout(timeOutDuration);
      return response;
    } catch (e) {
      if (enableLogger && kDebugMode) print('$T $e');
      return null;
    }
  }
}

extension FutureExtension<T> on Future<T> {
  _FutureExtension<T> get ext => _FutureExtension(this);

  @Deprecated('Use ext.toBuild instead')
  Widget toBuild({
    required Widget Function(T? data) onSuccess,
    required Widget loadingWidget,
    required Widget notFoundWidget,
    required Widget onError,
    T? data,
  }) =>
      FutureBuilder<T>(
        future: this,
        initialData: data,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loadingWidget;
            case ConnectionState.done:
              if (snapshot.hasData) return onSuccess(snapshot.data);
              return onError;

            case ConnectionState.none:
              return notFoundWidget;
          }
        },
      );
}
