/// The code snippet defines a private class `_DateExtension` that takes two `DateTime` parameters:
/// `currentTime` and `dateTime`. It also defines two private variables `_currentTime` and `_dateTime`
/// to store these parameters.
final class _DateExtension {
  _DateExtension(DateTime currentTime, DateTime dateTime)
      : _currentTime = currentTime,
        _dateTime = dateTime;
  final DateTime _currentTime;
  final DateTime _dateTime;

  /// The `differenceTime` getter is a method that calculates the time difference between the current
  /// DateTime object and the current time.
  String get differenceTime {
    final dayDifference = _currentTime.difference(_dateTime).inDays;
    final hourDifference = _currentTime.difference(_dateTime).inHours;
    final minuteDifference = _currentTime.difference(_dateTime).inMinutes;
    if (dayDifference > 0) {
      return '$dayDifference days ago';
    } else if (hourDifference > 0) {
      return '$hourDifference hours ago';
    } else if (minuteDifference > 0) {
      return '$minuteDifference minutes ago';
    }
    return '';
  }
}

/// The code snippet defines an extension method `timeDiff` on the `DateTime` class. This extension
/// method returns a custom extension object `_DateExtension` that calculates the time difference
/// between the current time and a given time.

extension DateTimeExtension1 on DateTime {
  /// The function returns a custom extension object that calculates the time difference between the
  /// current time and a given time.
  ///
  /// Args:
  ///   currentTime (DateTime): The `currentTime` parameter is a nullable `DateTime` object that
  /// represents the current time. If a value is provided, it will be used as the current time for
  /// calculating the time difference. If no value is provided, the current system time will be used.
  _DateExtension timeDiff({DateTime? currentTime}) =>
      _DateExtension(currentTime ?? DateTime.now(), this);
}
