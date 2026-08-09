import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('timeoutOrNull', () {
    test('returns the value when the future completes in time', () async {
      final result = await Future.value(42).ext.timeoutOrNull();

      expect(result, 42);
    });

    test('returns null when the future exceeds the timeout', () async {
      final slow = Future<int>.delayed(const Duration(seconds: 5), () => 42);

      final result = await slow.ext.timeoutOrNull(
        timeOutDuration: const Duration(milliseconds: 20),
        enableLogger: false,
      );

      expect(result, isNull);
    });

    test('returns null when the future throws', () async {
      final failing = Future<int>.error(Exception('boom'));

      final result = await failing.ext.timeoutOrNull(enableLogger: false);

      expect(result, isNull);
    });
  });

  group('onErrorReturn', () {
    test('passes the value through on success', () async {
      expect(await Future.value(1).ext.onErrorReturn(9), 1);
    });

    test('falls back when the future throws', () async {
      final failing = Future<int>.error(Exception('boom'));

      expect(await failing.ext.onErrorReturn(9), 9);
    });

    test('catches errors that are not Exceptions', () async {
      final failing = Future<int>.error(StateError('bad state'));

      expect(await failing.ext.onErrorReturn(9), 9);
    });
  });

  group('orNull', () {
    test('passes the value through on success', () async {
      expect(await Future.value(1).ext.orNull(), 1);
    });

    test('returns null when the future throws', () async {
      final failing = Future<int>.error(Exception('boom'));

      expect(await failing.ext.orNull(), isNull);
    });
  });

  group('kartalRetry', () {
    test('returns immediately when the first attempt succeeds', () async {
      var calls = 0;

      final result = await kartalRetry(() async {
        calls++;
        return 'ok';
      });

      expect(result, 'ok');
      expect(calls, 1);
    });

    test('retries until an attempt succeeds', () async {
      var calls = 0;

      final result = await kartalRetry(
        () async {
          calls++;
          if (calls < 3) throw Exception('transient');
          return 'ok';
        },
        delay: Duration.zero,
      );

      expect(result, 'ok');
      expect(calls, 3);
    });

    test('rethrows the last error once attempts are exhausted', () async {
      var calls = 0;

      await expectLater(
        kartalRetry(
          () async {
            calls++;
            throw StateError('attempt $calls');
          },
          delay: Duration.zero,
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            'attempt 3',
          ),
        ),
      );

      expect(calls, 3);
    });

    test('retryIf can stop retrying early', () async {
      var calls = 0;

      await expectLater(
        kartalRetry(
          () async {
            calls++;
            throw ArgumentError('not worth retrying');
          },
          attempts: 5,
          delay: Duration.zero,
          retryIf: (error) => error is! ArgumentError,
        ),
        throwsArgumentError,
      );

      // Stopped after the first attempt rather than using all five.
      expect(calls, 1);
    });

    test('exponential backoff grows the delay between attempts', () async {
      var calls = 0;
      final stopwatch = Stopwatch()..start();

      await kartalRetry(
        () async {
          calls++;
          if (calls < 3) throw Exception('transient');
          return 'ok';
        },
        delay: const Duration(milliseconds: 20),
        exponentialBackoff: true,
      );
      stopwatch.stop();

      // 20ms then 40ms, so at least 60ms total.
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(50));
      expect(calls, 3);
    });

    test('rejects a non positive attempt count', () {
      expect(
        () => kartalRetry(() async => 1, attempts: 0),
        throwsRangeError,
      );
    });
  });

  group('toBuild', () {
    testWidgets('shows the loading widget while pending', (tester) async {
      final pending = Future<int>.delayed(
        const Duration(seconds: 1),
        () => 1,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: pending.ext.toBuild(
            onSuccess: (data) => Text('data $data'),
            loadingWidget: const Text('loading'),
            notFoundWidget: const Text('not found'),
            onError: const Text('error'),
          ),
        ),
      );

      expect(find.text('loading'), findsOneWidget);
      // Let the pending future settle so the test does not leak a timer.
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('shows the success widget with the data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Future.value(7).ext.toBuild(
            onSuccess: (data) => Text('data $data'),
            loadingWidget: const Text('loading'),
            notFoundWidget: const Text('not found'),
            onError: const Text('error'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('data 7'), findsOneWidget);
    });

    testWidgets('falls back to onError when the future fails', (tester) async {
      // A Completer is used rather than Future.error so the error is raised
      // after FutureBuilder has subscribed. An eagerly created Future.error
      // is reported as an unhandled zone error before the widget mounts.
      final completer = Completer<int>();

      await tester.pumpWidget(
        MaterialApp(
          home: completer.future.ext.toBuild(
            onSuccess: (data) => Text('data $data'),
            loadingWidget: const Text('loading'),
            notFoundWidget: const Text('not found'),
            onError: const Text('error'),
          ),
        ),
      );

      completer.completeError(Exception('boom'));
      await tester.pumpAndSettle();

      expect(find.text('error'), findsOneWidget);
    });

    testWidgets('errorBuilder receives the error and wins', (tester) async {
      final completer = Completer<int>();

      await tester.pumpWidget(
        MaterialApp(
          home: completer.future.ext.toBuild(
            onSuccess: (data) => Text('data $data'),
            loadingWidget: const Text('loading'),
            notFoundWidget: const Text('not found'),
            onError: const Text('error'),
            errorBuilder: (error) => Text('caught $error'),
          ),
        ),
      );

      completer.completeError(Exception('boom'));
      await tester.pumpAndSettle();

      expect(find.text('error'), findsNothing);
      expect(find.textContaining('caught'), findsOneWidget);
      expect(find.textContaining('boom'), findsOneWidget);
    });
  });
}
