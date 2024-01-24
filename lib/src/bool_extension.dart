final class _BoolExtension {
  _BoolExtension({required bool? value}) : _value = value;
  final bool? _value;
  // thats can help to find right value
  bool get isSuccess {
    if (_value == null) return false;
    return _value! == true;
  }

  bool get isFail {
    if (_value == null) return true;
    return _value! == false;
  }
}

extension BoolExtension on bool? {
  _BoolExtension get ext => _BoolExtension(value: this);
}
