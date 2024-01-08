/// The `_CurrentTimeExtension` takes a `targetTime` parameter in its constructor
/// and compares it with the current time.
final class _CurrentTimeExtension {
  _CurrentTimeExtension(
    DateTime targetTime,
  ) : _targetTime = targetTime;

  final DateTime _targetTime;

  /// The `differenceTime` method returns that represents the difference
  ///  between the current time and the `targetTime`.
  String differenceTime({
    DateLocalizationLabel localizationLabel = const DateLocalizationLabel(),
  }) {
    /// The `currentTime` variable represents the current time.
    final currentTime = DateTime.now();

    /// The `yearDifference` variable represents the difference between the current time and the `targetTime` in years.
    final yearDifference = currentTime.difference(_targetTime).inDays ~/ 365;
    if (yearDifference > 0) {
      return '$yearDifference ${localizationLabel.yearLabel}';
    }

    /// The `monthDifference` variable represents the difference between the current time and the `targetTime` in months.
    final monthDifference = currentTime.difference(_targetTime).inDays ~/ 30;
    if (monthDifference > 0) {
      return '$monthDifference ${localizationLabel.monthLabel}';
    }

    /// The `dayDifference` variable represents the difference between the current time and the `targetTime` in days.
    final dayDifference = currentTime.difference(_targetTime).inDays;
    if (dayDifference > 0) {
      return '$dayDifference ${localizationLabel.dayLabel}';
    }

    /// The `hourDifference` variable represents the difference between the current time and the `targetTime` in hours.
    final hourDifference = currentTime.difference(_targetTime).inHours;
    if (hourDifference > 0) {
      return '$hourDifference ${localizationLabel.hourLabel}';
    }

    /// The `minuteDifference` variable represents the difference between the current time and the `targetTime` in minutes.
    final minuteDifference = currentTime.difference(_targetTime).inMinutes;
    if (minuteDifference > 0) {
      return '$minuteDifference ${localizationLabel.minuteLabel}';
    }

    /// The `secondDifference` variable represents the difference between the current time and the `targetTime` in seconds.
    final secondDifference = currentTime.difference(_targetTime).inSeconds;
    if (secondDifference > 0) {
      return '$secondDifference ${localizationLabel.secondLabel}';
    }
    return '';
  }
}

extension ComparingDateLocalizationExtension on DateTime {
  _CurrentTimeExtension get ext => _CurrentTimeExtension(this);
}

final class DateLocalizationLabel {
  const DateLocalizationLabel({
    this.yearLabel = 'years ago',
    this.monthLabel = 'months ago',
    this.dayLabel = 'days ago',
    this.hourLabel = 'hours ago',
    this.minuteLabel = 'minutes ago',
    this.secondLabel = 'seconds ago',
  });
  final String yearLabel;
  final String monthLabel;
  final String dayLabel;
  final String hourLabel;
  final String minuteLabel;
  final String secondLabel;
}
