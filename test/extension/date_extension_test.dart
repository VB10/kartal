import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  test('ten minutes ago with english title', () {
    final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));

    expect(tenMinutesAgo.ext.differenceTime(), '10 minutes ago');
  });

  test('ten minutes ago with Turkish title', () {
    final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));

    expect(
      tenMinutesAgo.ext.differenceTime(
        localizationLabel: const DateLocalizationLabel(
          minuteLabel: 'dakika önce',
        ),
      ),
      '10 dakika önce',
    );
  });

  test('ten seconds ago with Turkish title', () {
    final tenSecondsAgo = DateTime.now().subtract(const Duration(seconds: 10));

    expect(
      tenSecondsAgo.ext.differenceTime(
        localizationLabel: const DateLocalizationLabel(
          secondLabel: 'saniye önce',
        ),
      ),
      '10 saniye önce',
    );
  });

  test('two years ago ', () {
    final twoYearsAgo = DateTime.now()
        .subtract(const Duration(days: 730))
        .ext
        .differenceTime();
    expect(twoYearsAgo, '2 years ago');
  });

  test('two months ago ', () {
    final twoMonthsAgo = DateTime.now()
        .subtract(const Duration(days: 60))
        .ext
        .differenceTime();
    expect(twoMonthsAgo, '2 months ago');
  });

  test('two days ago ', () {
    final twoDaysAgo = DateTime.now()
        .subtract(const Duration(days: 2))
        .ext
        .differenceTime();
    expect(twoDaysAgo, '2 days ago');
  });

  test('two hours ago ', () {
    final twoHoursAgo = DateTime.now()
        .subtract(const Duration(hours: 2))
        .ext
        .differenceTime();
    expect(twoHoursAgo, '2 hours ago');
  });

  test('two minutes ago ', () {
    final twoMinutesAgo = DateTime.now()
        .subtract(const Duration(minutes: 2))
        .ext
        .differenceTime();
    expect(twoMinutesAgo, '2 minutes ago');
  });

  group('null and edge case handling', () {
    test('a null target time returns emptyLabel instead of throwing', () {
      // Regression guard: the extension is declared on DateTime?, but a null
      // receiver used to throw a bare Exception.
      const DateTime? nullDate = null;

      expect(nullDate.ext.differenceTime(), '');
      expect(
        nullDate.ext.differenceTime(
          localizationLabel: const DateLocalizationLabel(emptyLabel: '-'),
        ),
        '-',
      );
    });

    test('sub-second gaps report justNowLabel rather than an empty string', () {
      expect(DateTime.now().ext.differenceTime(), 'just now');
    });

    test('future timestamps report justNowLabel', () {
      final future = DateTime.now().add(const Duration(days: 3));

      expect(future.ext.differenceTime(), 'just now');
    });

    test('the Turkish label preset covers every unit', () {
      const tr = DateLocalizationLabel.tr();
      final now = DateTime.now();

      expect(
        now
            .subtract(const Duration(days: 730))
            .ext
            .differenceTime(
              localizationLabel: tr,
            ),
        '2 yıl önce',
      );
      expect(
        now
            .subtract(const Duration(days: 60))
            .ext
            .differenceTime(
              localizationLabel: tr,
            ),
        '2 ay önce',
      );
      expect(
        now
            .subtract(const Duration(days: 2))
            .ext
            .differenceTime(
              localizationLabel: tr,
            ),
        '2 gün önce',
      );
      expect(
        now
            .subtract(const Duration(hours: 2))
            .ext
            .differenceTime(
              localizationLabel: tr,
            ),
        '2 saat önce',
      );
      expect(
        now
            .subtract(const Duration(minutes: 2))
            .ext
            .differenceTime(
              localizationLabel: tr,
            ),
        '2 dakika önce',
      );
      expect(
        now
            .subtract(const Duration(seconds: 2))
            .ext
            .differenceTime(
              localizationLabel: tr,
            ),
        '2 saniye önce',
      );
      expect(now.ext.differenceTime(localizationLabel: tr), 'az önce');
    });
  });
}
