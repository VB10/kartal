import 'dart:convert';

import 'package:flutter/foundation.dart';

final class _MapExtension {
  _MapExtension(this._map);
  final Map<String, dynamic> _map;

  /// this method work with map value to convert json or any model
  Future<String?> safeJsonEncodeCompute() async {
    try {
      final response = await compute<Object, String>(
        jsonEncode,
        _map,
      );

      return response;
    } catch (e) {
      return null;
    }
  }
}

extension MapExtension on Map<String, dynamic> {
  /// Map extension
  _MapExtension get ext => _MapExtension(this);
}
