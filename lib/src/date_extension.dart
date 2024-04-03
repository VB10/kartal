/// The `ComparingDateLocalizationExtension` extension is used to compare the current time with a target time.
extension ComparingDateLocalizationExtension on DateTime {
  /// The `ext` property provides access to the `_CurrentTimeExtension` class.
  _CurrentTimeExtension get ext => _CurrentTimeExtension(this);
}

/// The `ComparingDateLocalizationNullableExtension` extension is used to compare the current time with a target time.
extension ComparingDateLocalizationNullableExtension on DateTime? {
  /// The `ext` property provides access to the `_CurrentTimeExtension` class.
  _CurrentTimeExtension get ext => _CurrentTimeExtension(this);
}

/// The `_CurrentTimeExtension` takes a `targetTime` parameter in its constructor
/// and compares it with the current time.
final class _CurrentTimeExtension {
  _CurrentTimeExtension(
    DateTime? targetTime,
  ) : _targetTime = targetTime;

  final DateTime? _targetTime;

  /// The `differenceTime` method returns that represents the difference
  ///  between the current time and the `targetTime`.
  String differenceTime({
    DateLocalizationLabel localizationLabel = const DateLocalizationLabel(),
  }) {
    if (_targetTime == null) throw Exception('The targetTime cannot be null.');

    /// The `currentTime` variable represents the current time.
    final currentTime = DateTime.now();

    final targetTime = _targetTime;

    /// The `yearDifference` variable represents the difference between the current time and the `targetTime` in years.
    final yearDifference = currentTime.difference(targetTime).inDays ~/ 365;
    if (yearDifference > 0) {
      return '$yearDifference ${localizationLabel.yearLabel}';
    }

    /// The `monthDifference` variable represents the difference between the current time and the `targetTime` in months.
    final monthDifference = currentTime.difference(targetTime).inDays ~/ 30;
    if (monthDifference > 0) {
      return '$monthDifference ${localizationLabel.monthLabel}';
    }

    /// The `dayDifference` variable represents the difference between the current time and the `targetTime` in days.
    final dayDifference = currentTime.difference(targetTime).inDays;
    if (dayDifference > 0) {
      return '$dayDifference ${localizationLabel.dayLabel}';
    }

    /// The `hourDifference` variable represents the difference between the current time and the `targetTime` in hours.
    final hourDifference = currentTime.difference(targetTime).inHours;
    if (hourDifference > 0) {
      return '$hourDifference ${localizationLabel.hourLabel}';
    }

    /// The `minuteDifference` variable represents the difference between the current time and the `targetTime` in minutes.
    final minuteDifference = currentTime.difference(targetTime).inMinutes;
    if (minuteDifference > 0) {
      return '$minuteDifference ${localizationLabel.minuteLabel}';
    }

    /// The `secondDifference` variable represents the difference between the current time and the `targetTime` in seconds.
    final secondDifference = currentTime.difference(targetTime).inSeconds;
    if (secondDifference > 0) {
      return '$secondDifference ${localizationLabel.secondLabel}';
    }
    return '';
  }
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

  /// The `yearLabel` property represents the label for the year. The default value is `years ago`.
  final String yearLabel;

  /// The `monthLabel` property represents the label for the month. The default value is `months ago`.
  final String monthLabel;

  /// The `dayLabel` property represents the label for the day. The default value is `days ago`.
  final String dayLabel;

  /// The `hourLabel` property represents the label for the hour. The default value is `hours ago`.
  final String hourLabel;

  /// The `minuteLabel` property represents the label for the minute. The default value is `minutes ago`.
  final String minuteLabel;

  /// The `secondLabel` property represents the label for the second. The default value is `seconds ago`.
  final String secondLabel;
}
