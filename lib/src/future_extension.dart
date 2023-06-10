import 'package:flutter/material.dart';

/// You can use future utility so easy with [FutureExtension]
class _FutureExtension<T> {
  _FutureExtension(this.future);

  final Future<T> future;

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
        future: future,
        initialData: data,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              // Display the loading widget when the future is in a waiting or active state.
              return loadingWidget;
            case ConnectionState.done:
              if (snapshot.hasData) {
                // Display the success widget when the future is done and has data.
                return onSuccess(snapshot.data);
              } else {
                // Display the error widget when the future is done but has no data.
                return onError;
              }
            case ConnectionState.none:
              // Display the not found widget when the future has no connection state.
              return notFoundWidget;
          }
        },
      );
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
