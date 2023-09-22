class _DateTimeExtensions {
  _DateTimeExtensions(DateTime dateTime) : _dateTime = dateTime;

  final DateTime _dateTime;

  /// Converts DateTime type data to String by adding a slash between them.
  ///
  /// For example:
  /// from [1973-06-01 00:00:00.000] to [01/06/1973]
  String get toDateWithSlash =>
      '${_dateTime.day.toString().padLeft(2, '0')}/${_dateTime.month.toString().padLeft(2, '0')}/${_dateTime.year}';

  /// Converts DateTime type data to String by adding a dot between them.
  ///
  /// For example:
  /// from [1973-06-01 00:00:00.000] to [01.06.1973]
  String get toDateWithDot =>
      '${_dateTime.day.toString().padLeft(2, '0')}.${_dateTime.month.toString().padLeft(2, '0')}.${_dateTime.year}';
}

extension DateTimeExtensions on DateTime {
  _DateTimeExtensions get ext => _DateTimeExtensions(this);

  String get toDateWithSlash =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

  String get toDateWithDot =>
      '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';
}
