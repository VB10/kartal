import 'package:flutter/material.dart';

/// You can use future utility so easy with [FutureExtension]
extension FutureExtension<T> on Future<T> {
  /// It will create your future request on widget tree by using future builder.

  Widget toBuild({
    required Widget Function(T? data) onSuccess,
    required Widget loadingWidget,
    required Widget notFoundWidget,
    required Widget onError,
    T? data,
  }) {
    return FutureBuilder<T>(
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
}
