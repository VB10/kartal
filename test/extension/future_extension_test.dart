import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('FutureExtension Tests', () {
    testWidgets('toBuild shows loading widget when future is waiting',
        (tester) async {
      final future = Future<String>.delayed(
        const Duration(seconds: 2),
        () => 'Test',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: future.ext.toBuild(
              onSuccess: (data) => Text('Success: $data'),
              loadingWidget: const CircularProgressIndicator(),
              notFoundWidget: const Text('Not Found'),
              onError: const Text('Error'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('toBuild shows success widget when future completes',
        (tester) async {
      final future = Future<String>.value('Test Data');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: future.ext.toBuild(
              onSuccess: (data) => Text('Success: $data'),
              loadingWidget: const CircularProgressIndicator(),
              notFoundWidget: const Text('Not Found'),
              onError: const Text('Error'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Success: Test Data'), findsOneWidget);
    });

    test('timeoutOrNull returns value when future completes in time', () async {
      final future = Future<String>.value('Test');
      final result = await future.ext.timeoutOrNull(
        timeOutDuration: const Duration(seconds: 5),
        enableLogger: false,
      );
      expect(result, 'Test');
    });

    test('timeoutOrNull returns null when future times out', () async {
      final future = Future<String>.delayed(
        const Duration(seconds: 2),
        () => 'Test',
      );
      final result = await future.ext.timeoutOrNull(
        timeOutDuration: const Duration(milliseconds: 100),
        enableLogger: false,
      );
      expect(result, isNull);
    });
  });
}
