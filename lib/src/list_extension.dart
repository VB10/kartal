extension ListExtension<T> on List<T>? {
  _ListExtension<T> get ext => _ListExtension<T>(this);
}

extension ListDefaultExtension<T> on List<T> {
  _ListExtension<T> get ext => _ListExtension<T>(this);
}

final class _ListExtension<T> {
  _ListExtension(List<T>? list) : _list = list;

  final List<T>? _list;

  /// Returns `true` if the list is null or empty.
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  /// Returns `true` if the list is not null and not empty.
  bool get isNotNullOrEmpty {
    if (_list != null) {
      return _list!.isNotEmpty;
    } else {
      return false;
    }
  }

  List<T> makeSafe() =>
      _list?.where((element) => element != null).cast<T>().toList() ?? [];

  /// Returns the index of the first element that satisfies the provided [search] function.
  /// If no element is found, returns null.
  int? indexOrNull(bool Function(T) search) {
    final result = _list?.indexWhere(search);
    return result != -1 ? result : null;
  }
}
