import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Provides convenient access to commonly used properties from [Map].
extension MapExtension on Map<String, dynamic> {
  /// Provides convenient access to commonly used properties from [Map].
  _MapExtension get ext => _MapExtension(this);
}

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
    } on Exception {
      return null;
    }
  }
}
