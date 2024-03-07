final class _BoolExtension {
  _BoolExtension({required bool? value}) : _value = value;
  final bool? _value;

  /// Returns `true` if the value is `true`, otherwise `false`.
  bool get isSuccess {
    if (_value == null) return false;
    return _value! == true;
  }

//// Returns `true` if the value is `false`, otherwise `false`.
  bool get isFail {
    if (_value == null) return true;
    return _value! == false;
  }
}

extension BoolExtension on bool? {
  /// Provides convenient access to commonly used properties from [bool].
  _BoolExtension get ext => _BoolExtension(value: this);
}
