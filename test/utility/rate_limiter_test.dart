import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('Debouncer', () {
    test('runs only the last call in a burst', () {
      fakeAsync((async) {
        final debouncer = Debouncer(const Duration(milliseconds: 300));
        final seen = <String>[];

        debouncer.call(() => seen.add('a'));
        async.elapse(const Duration(milliseconds: 100));
        debouncer.call(() => seen.add('b'));
        async.elapse(const Duration(milliseconds: 100));
        debouncer.call(() => seen.add('c'));

        // Nothing has run yet: each call reset the timer.
        expect(seen, isEmpty);

        async.elapse(const Duration(milliseconds: 300));
        expect(seen, ['c']);

        debouncer.dispose();
      });
    });

    test('runs the call once the delay elapses', () {
      fakeAsync((async) {
        final debouncer = Debouncer(const Duration(milliseconds: 100));
        var ran = false;

        debouncer.call(() => ran = true);
        expect(ran, isFalse);

        async.elapse(const Duration(milliseconds: 99));
        expect(ran, isFalse);

        async.elapse(const Duration(milliseconds: 1));
        expect(ran, isTrue);

        debouncer.dispose();
      });
    });

    test('reports whether a call is pending', () {
      fakeAsync((async) {
        final debouncer = Debouncer(const Duration(milliseconds: 100));

        expect(debouncer.isPending, isFalse);
        debouncer.call(() {});
        expect(debouncer.isPending, isTrue);

        async.elapse(const Duration(milliseconds: 100));
        expect(debouncer.isPending, isFalse);

        debouncer.dispose();
      });
    });

    test('cancel drops the pending call', () {
      fakeAsync((async) {
        final debouncer = Debouncer(const Duration(milliseconds: 100));
        var ran = false;

        debouncer
          ..call(() => ran = true)
          ..cancel();
        async.elapse(const Duration(milliseconds: 500));

        expect(ran, isFalse);
        debouncer.dispose();
      });
    });

    test('flush runs the pending call immediately', () {
      fakeAsync((async) {
        final debouncer = Debouncer(const Duration(milliseconds: 300));
        final seen = <String>[];

        debouncer
          ..call(() => seen.add('pending'))
          ..flush(() => seen.add('flushed'));

        expect(seen, ['flushed']);

        // The original pending call must not also fire.
        async.elapse(const Duration(milliseconds: 500));
        expect(seen, ['flushed']);

        debouncer.dispose();
      });
    });

    test('flush does nothing when nothing is pending', () {
      fakeAsync((_) {
        final debouncer = Debouncer(const Duration(milliseconds: 100));
        var ran = false;

        debouncer.flush(() => ran = true);

        expect(ran, isFalse);
        debouncer.dispose();
      });
    });

    test('dispose prevents a pending call from firing later', () {
      fakeAsync((async) {
        final debouncer = Debouncer(const Duration(milliseconds: 100));
        var ran = false;

        debouncer
          ..call(() => ran = true)
          ..dispose();
        async.elapse(const Duration(seconds: 1));

        expect(ran, isFalse);
      });
    });
  });

  group('Throttler', () {
    test('runs the first call immediately and drops the rest', () {
      fakeAsync((async) {
        final throttler = Throttler(const Duration(milliseconds: 100));
        var count = 0;

        expect(throttler.call(() => count++), isTrue);
        expect(throttler.call(() => count++), isFalse);
        expect(throttler.call(() => count++), isFalse);

        expect(count, 1);

        async.elapse(const Duration(milliseconds: 100));
        expect(throttler.call(() => count++), isTrue);
        expect(count, 2);

        throttler.dispose();
      });
    });

    test('reports whether it is currently throttled', () {
      fakeAsync((async) {
        final throttler = Throttler(const Duration(milliseconds: 100));

        expect(throttler.isThrottled, isFalse);
        throttler.call(() {});
        expect(throttler.isThrottled, isTrue);

        async.elapse(const Duration(milliseconds: 100));
        expect(throttler.isThrottled, isFalse);

        throttler.dispose();
      });
    });

    test('reset clears the cooldown', () {
      fakeAsync((_) {
        final throttler = Throttler(const Duration(milliseconds: 100));
        var count = 0;

        throttler.call(() => count++);
        expect(throttler.call(() => count++), isFalse);

        throttler.reset();
        expect(throttler.call(() => count++), isTrue);
        expect(count, 2);

        throttler.dispose();
      });
    });

    test('allows one call per window over a long burst', () {
      fakeAsync((async) {
        final throttler = Throttler(const Duration(milliseconds: 100));
        var count = 0;

        // 10 windows, firing every 10ms: 100 attempts, 10 accepted.
        for (var tick = 0; tick < 100; tick++) {
          throttler.call(() => count++);
          async.elapse(const Duration(milliseconds: 10));
        }

        expect(count, 10);
        throttler.dispose();
      });
    });
  });
}
