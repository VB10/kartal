// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vexana/vexana.dart';

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
      return await parse<T, R>(bundle, model: model);
    } catch (e) {
      throw Exception('Error while loading:$e');
    }
  }

  Future<R> parse<T extends INetworkModel<T>, R>(String bundleData, {required T model}) async {
    if (R == List<T>) {
      try {
        final transformedData = (json.decode(bundleData) as List<dynamic>) //
            .map((data) => model.fromJson(data as Map<String, dynamic>)) //
            .cast<T>()
            .toList() as R;

        return transformedData;
      } catch (e) {
        throw Exception('Error while parsing:$e');
      }
    } else {
      return json.decode(bundleData) as R;
    }
  }
}

class _BaseBundleDecoder {
  _BaseBundleDecoder(this.assetPath);
  final String assetPath;
}
