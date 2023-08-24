import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

class MockAssetBundle extends Mock implements AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final file = File(key);
    final content = await file.readAsString();
    return content;
  }
}
