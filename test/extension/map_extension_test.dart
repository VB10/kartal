import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('MapExtension Tests', () {
    test('safeJsonEncodeCompute returns valid JSON string', () async {
      final map = {'name': 'test', 'value': 123};
      final result = await map.ext.safeJsonEncodeCompute();
      expect(result, isA<String>());
      expect(result, contains('"name":"test"'));
      expect(result, contains('"value":123'));
    });

    test('safeJsonEncodeCompute handles nested objects', () async {
      final map = {
        'user': {'name': 'John', 'age': 30},
        'active': true,
      };
      final result = await map.ext.safeJsonEncodeCompute();
      expect(result, isA<String>());
      expect(result, contains('"user"'));
      expect(result, contains('"John"'));
    });

    test('safeJsonEncodeCompute handles empty map', () async {
      final map = <String, dynamic>{};
      final result = await map.ext.safeJsonEncodeCompute();
      expect(result, '{}');
    });

    test('safeJsonEncodeCompute handles list values', () async {
      final map = {
        'items': [1, 2, 3],
        'names': ['a', 'b']
      };
      final result = await map.ext.safeJsonEncodeCompute();
      expect(result, isA<String>());
      expect(result, contains('"items"'));
    });
  });
}
