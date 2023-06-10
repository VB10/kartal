class _ListExtension<T> {
  _ListExtension(this.list);

  final List<T>? list;

  /// Returns `true` if the list is null or empty.
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  /// Returns `true` if the list is not null and not empty.
  bool get isNotNullOrEmpty {
    if (list != null) {
      return list!.isNotEmpty;
    } else {
      return false;
    }
  }

  /// Returns the index of the first element that satisfies the provided [search] function.
  /// If no element is found, returns null.
  int? indexOrNull(bool Function(T) search) {
    final result = list?.indexWhere(search);
    return result != -1 ? result : null;
  }
}

extension ListExtension<T> on List<T>? {
  _ListExtension<T> get ext => _ListExtension<T>(this);

  @Deprecated('Use ext.isNullOrEmpty instead')
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  @Deprecated('Use ext.isNotNullOrEmpty instead')
  bool get isNotNullOrEmpty {
    if (this is List) {
      return this!.isNotEmpty;
    } else {
      return false;
    }
  }

  @Deprecated('Use ext.indexOrNull instead')
  int? indexOrNull(bool Function(T) search) {
    final result = this?.indexWhere(search);
    return result != -1 ? result : null;
  }
}
