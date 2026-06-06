extension DurationExtension on int {
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
  Duration get weeks => Duration(days: this * 7);
}

extension DurationReadableExtension on Duration {
  String toHumanReadable() {
    final days = inDays;
    final hours = inHours % 24;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;

    final parts = <String>[];
    if (days > 0) {
      parts.add('$days day${days > 1 ? 's' : ''}');
    }
    if (hours > 0) {
      parts.add('$hours hour${hours > 1 ? 's' : ''}');
    }
    if (minutes > 0) {
      parts.add('$minutes minute${minutes > 1 ? 's' : ''}');
    }
    if (seconds > 0 && parts.isEmpty) {
      parts.add('$seconds second${seconds > 1 ? 's' : ''}');
    }

    return parts.isEmpty ? '0 seconds' : parts.join(' ');
  }

  String timeFromNow() {
    if (inSeconds < 0) {
      return '${-this}.timeAgo';
    }
    return 'in ${toHumanReadable()}';
  }

  String timeAgo() {
    if (inSeconds < 0) {
      return 'in ${(-this).toHumanReadable()}';
    }
    return '${toHumanReadable()} ago';
  }
}

extension DateTimeRelativeExtension on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
    return '${difference.inSeconds} second${difference.inSeconds > 1 ? 's' : ''} ago';
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  DateTime get startOfWeek {
    final daysToSubtract = weekday - 1;
    return subtract(Duration(days: daysToSubtract)).startOfDay;
  }

  DateTime get endOfWeek {
    final daysToAdd = 7 - weekday;
    return add(Duration(days: daysToAdd)).endOfDay;
  }

  int get age {
    final now = DateTime.now();
    var years = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      years--;
    }
    return years;
  }
}
