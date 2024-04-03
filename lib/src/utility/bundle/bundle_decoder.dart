import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kartal/src/utility/bundle/asset_model_interface.dart';

/// The `BundleDecoder` class is used to decode the data from a bundle.

final class BundleDecoder extends _BaseBundleDecoder with _BundleHelpers {
  BundleDecoder(super.assetPath);

  /// The function `crackBundle` loads a bundle and returns the decoded data, or throws an error if there is an exception.
  ///
  /// Args:
  ///   model (T): The `model` parameter is of type `T` which extends `IAssetModel<T>`. It is a required parameter and is
  /// used as input to `_loadBundle` function.
  ///
  /// Returns:
  ///   a `Future<R?>` object.
  Future<R?> crackBundle<T extends IAssetModel<T>, R>({
    required T model,
    AssetBundle? assetBundle,
  }) async {
    try {
      final decodedData = await _loadBundle<T, R>(
        super.assetPath,
        model: model,
        assetBundle: assetBundle,
      );
      return decodedData;
    } catch (e) {
      rethrow;
    }
  }
}

mixin _BundleHelpers {
  Future<R?> _loadBundle<T extends IAssetModel<T>, R>(
    String path, {
    required T model,
    AssetBundle? assetBundle,
  }) async {
    try {
      final bundle = await (assetBundle ?? rootBundle).loadString(path);

      Future<R> callBack(_ComputeArgument<T> argument) =>
          _parse<T, R>(argument);

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

  Future<R> _parse<T extends IAssetModel<T>, R>(
    _ComputeArgument<T> argument,
  ) async {
    if (R == List<T>) {
      final listJson = json.decode(argument.bundle) as List<dynamic>;
      final transformedData = listJson
          .map(
            (data) => argument.model.fromJson(data as Map<String, dynamic>),
          )
          .cast<T>()
          .toList() as R;

      return transformedData;
    }

    final jsonBody = json.decode(argument.bundle) as Map<String, dynamic>;
    return argument.model.fromJson(jsonBody) as R;
  }
}

class _BaseBundleDecoder {
  _BaseBundleDecoder(this.assetPath);

  /// There is local asset path from locally
  final String assetPath;
}

class _ComputeArgument<T extends IAssetModel<T>> {
  _ComputeArgument({required this.bundle, required this.model});

  final String bundle;
  final T model;
}
