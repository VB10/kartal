import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('formatted', () {
    test('renders mm:ss below an hour', () {
      expect(Duration.zero.ext.formatted, '00:00');
      expect(const Duration(seconds: 45).ext.formatted, '00:45');
      expect(const Duration(minutes: 3, seconds: 7).ext.formatted, '03:07');
      expect(const Duration(minutes: 59, seconds: 59).ext.formatted, '59:59');
    });

    test('promotes to hh:mm:ss at an hour', () {
      expect(const Duration(hours: 1).ext.formatted, '01:00:00');
      expect(
        const Duration(hours: 1, minutes: 2, seconds: 3).ext.formatted,
        '01:02:03',
      );
      expect(const Duration(hours: 100).ext.formatted, '100:00:00');
    });

    test('forceHours always includes the hour component', () {
      expect(
        const Duration(seconds: 45).ext.format(forceHours: true),
        '00:00:45',
      );
    });

    test('preserves the sign of a negative duration', () {
      expect(const Duration(seconds: -45).ext.formatted, '-00:45');
      expect(const Duration(hours: -1, minutes: -2).ext.formatted, '-01:02:00');
    });
  });

  group('delay', () {
    test('waits for the duration', () async {
      final stopwatch = Stopwatch()..start();
      await 50.ext.ms.ext.delay();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(40));
    });

    test('delayed runs the computation and returns its value', () async {
      final result = await 1.ext.ms.ext.delayed(() => 'done');

      expect(result, 'done');
    });

    test('composes with the int duration builders', () async {
      // The headline ergonomic win: 300.ext.ms.ext.delay()
      final stopwatch = Stopwatch()..start();
      await 10.ext.ms.ext.delay();
      stopwatch.stop();

      expect(stopwatch.elapsed, greaterThan(Duration.zero));
    });
  });
}
