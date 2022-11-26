// ignore_for_file: lines_longer_than_80_chars, omit_local_variable_types, prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kartal/src/utility/bundle/i_network_model.dart';

typedef ComputeCallback<T extends INetworkModel<T>, R> = Future<R> Function(_ComputeArgument<T>);

class BundleDecoder extends _BaseBundleDecoder with _BundleHelpers {
  BundleDecoder(super.assetPath);

  Future<R?> crackBundle<T extends INetworkModel<T>, R>({required T model}) async {
    try {
      final decodedData = await loadBundle<T, R>(super.assetPath, model: model);
      return decodedData;
    } catch (e) {
      rethrow;
    }
  }
}

mixin _BundleHelpers {
  Future<R?> loadBundle<T extends INetworkModel<T>, R>(String path, {required T model}) async {
    try {
      final bundle = await rootBundle.loadString(path);

      final ComputeCallback<T, R> callBack = (_ComputeArgument<T> argument) => parse<T, R>(argument);

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

  Future<R> parse<T extends INetworkModel<T>, R>(_ComputeArgument<T> argument) async {
    if (R == List<T>) {
      try {
        final transformedData = (json.decode(argument.bundle) as List<dynamic>) //
            .map((data) => argument.model.fromJson(data as Map<String, dynamic>)) //
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
