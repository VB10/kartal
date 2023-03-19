extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  bool get isNotNullOrEmpty {
    if (this is List) {
      return this!.isNotEmpty;
    } else {
      return false;
    }
  }

  /// It return index when find a item instead of -1
  /// -1 means not found and it comes from core library
  int? indexOrNull(bool Function(T) search) {
    final result = this?.indexWhere(search);
    return result != -1 ? result : null;
  }
}
