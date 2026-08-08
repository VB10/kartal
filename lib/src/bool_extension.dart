/// Provides convenient access to commonly used properties from [bool].
extension BoolExtension on bool? {
  /// Provides convenient access to commonly used properties from [bool].
  _BoolExtension get ext => _BoolExtension(value: this);
}

final class _BoolExtension {
  _BoolExtension({required bool? value}) : _value = value;
  final bool? _value;

  /// Returns `true` if the value is `true`, otherwise `false`.
  ///
  /// A `null` value is treated as `false`.
  bool get isSuccess => _value ?? false;

  /// Returns `true` if the value is `false` or `null`, otherwise `false`.
  bool get isFail => !isSuccess;
}
