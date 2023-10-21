import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/src/date_extension.dart';

void main() {
  test('ten minutes ago with english title', () {
    final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));

    expect(tenMinutesAgo.timeDiff().differenceTime, '10 minutes ago');
  });

  test('ten minutes ago with turkish title', () {
    final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));

    expect(
      tenMinutesAgo
          .timeDiff(
            dateDifferenceModel: const DateDifferenceModel(
              dayDifferenceLabel: 'gün önce',
              hourDifferenceLabel: 'saat önce',
              minuteDifferenceLabel: 'dakika önce',
            ),
          )
          .differenceTime,
      '10 dakika önce',
    );
  });

  test('ten minutes ago with turkish title and custom current time', () {
    final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));

    expect(
      tenMinutesAgo
          .timeDiff(
            currentTime: DateTime.now().subtract(const Duration(minutes: 5)),
            dateDifferenceModel: const DateDifferenceModel(
              dayDifferenceLabel: 'gün önce',
              hourDifferenceLabel: 'saat önce',
              minuteDifferenceLabel: 'dakika önce',
            ),
          )
          .differenceTime,
      '5 dakika önce',
    );
  });
}
