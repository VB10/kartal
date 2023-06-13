import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kartal/src/utility/bundle/network_model_interface.dart';

typedef ComputeCallback<T extends INetworkModel<T>, R> = Future<R> Function(
  // ignore: library_private_types_in_public_api
  _ComputeArgument<T>,
);

class BundleDecoder extends _BaseBundleDecoder with _BundleHelpers {
  BundleDecoder(super.assetPath);

  Future<R?> crackBundle<T extends INetworkModel<T>, R>({
    required T model,
  }) async {
    try {
      final decodedData = await loadBundle<T, R>(super.assetPath, model: model);
      return decodedData;
    } catch (e) {
      rethrow;
    }
  }
}

mixin _BundleHelpers {
  Future<R?> loadBundle<T extends INetworkModel<T>, R>(
    String path, {
    required T model,
  }) async {
    try {
      final bundle = await rootBundle.loadString(path);

      Future<R> callBack(_ComputeArgument<T> argument) => parse<T, R>(argument);

      return await compute(
        callBack,
        _ComputeArgument<T>(
          bundle: bundle,
          model: model,
        ),
      );
    } catch (e) {
      throw Exception('Error while loading:$e');
    }
  }

  Future<R> parse<T extends INetworkModel<T>, R>(
    _ComputeArgument<T> argument,
  ) async {
    if (R == List<T>) {
      final listJson = json.decode(argument.bundle) as List<dynamic>;
      try {
        final transformedData = listJson
            .map(
              (data) => argument.model.fromJson(data as Map<String, dynamic>),
            )
            .cast<T>()
            .toList() as R;

        return transformedData;
      } catch (e) {
        throw Exception('Error while parsing:$e');
      }
    } else {
      return json.decode(argument.bundle) as R;
    }
  }
}

class _BaseBundleDecoder {
  _BaseBundleDecoder(this.assetPath);
  final String assetPath;
}

class _ComputeArgument<T extends INetworkModel<T>> {
  _ComputeArgument({required this.bundle, required this.model});

  final String bundle;
  final T model;
}
