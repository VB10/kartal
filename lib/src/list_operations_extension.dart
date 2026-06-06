extension ListOperationsExtension<T> on List<T> {
  List<List<T>> chunked(int size) {
    if (size <= 0) throw ArgumentError('Size must be greater than 0');
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      final end = (i + size < length) ? i + size : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(element);
    }
    return map;
  }

  num sum([num Function(T)? selector]) {
    if (isEmpty) return 0;
    if (selector != null) {
      return fold<num>(0, (sum, element) => sum + selector(element));
    }
    if (this is List<num>) {
      return (this as List<num>).fold<num>(0, (sum, element) => sum + element);
    }
    if (this is List<int>) {
      return (this as List<int>).fold<int>(0, (sum, element) => sum + element);
    }
    return 0;
  }

  double average([num Function(T)? selector]) {
    if (isEmpty) return 0;
    if (selector != null) {
      final total = sum(selector);
      return total / length;
    }
    if (this is List<num>) {
      return (this as List<num>)
              .fold<double>(0, (sum, element) => sum + element) /
          length;
    }
    return 0;
  }

  List<T> distinct([bool Function(T, T)? equals]) {
    if (isEmpty) return this;
    if (equals != null) {
      final result = <T>[this[0]];
      for (var i = 1; i < length; i++) {
        var isDuplicate = false;
        for (var j = 0; j < result.length; j++) {
          if (equals(this[i], result[j])) {
            isDuplicate = true;
            break;
          }
        }
        if (!isDuplicate) result.add(this[i]);
      }
      return result;
    }
    return toSet().toList();
  }

  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;

  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  List<T> replaceWhere(T newValue, bool Function(T) test) =>
      map((element) => test(element) ? newValue : element).toList();

  T? get safeFirst => isEmpty ? null : first;

  T? get safeLast => isEmpty ? null : last;

  List<T> takeLast(int n) {
    if (n >= length) return this;
    return sublist(length - n);
  }

  List<T> skipLast(int n) {
    if (n >= length) return [];
    return sublist(0, length - n);
  }
}

extension NullableListExtension<T> on List<T>? {
  List<T> get orEmpty => this ?? [];

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
