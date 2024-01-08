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
    final twoYearsAgo =
        DateTime.now().subtract(const Duration(days: 730)).ext.differenceTime();
    expect(twoYearsAgo, '2 years ago');
  });

  test('two months ago ', () {
    final twoMonthsAgo =
        DateTime.now().subtract(const Duration(days: 60)).ext.differenceTime();
    expect(twoMonthsAgo, '2 months ago');
  });

  test('two days ago ', () {
    final twoDaysAgo =
        DateTime.now().subtract(const Duration(days: 2)).ext.differenceTime();
    expect(twoDaysAgo, '2 days ago');
  });

  test('two hours ago ', () {
    final twoHoursAgo =
        DateTime.now().subtract(const Duration(hours: 2)).ext.differenceTime();
    expect(twoHoursAgo, '2 hours ago');
  });

  test('two minutes ago ', () {
    final twoMinutesAgo = DateTime.now()
        .subtract(const Duration(minutes: 2))
        .ext
        .differenceTime();
    expect(twoMinutesAgo, '2 minutes ago');
  });
}
