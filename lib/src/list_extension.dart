import 'package:kartal/src/private/mixin/collection/collection_core_mixin.dart';

/// List extension for nullable lists.
extension ListExtension<T> on List<T>? {
  /// List extension with [ext] property.
  _ListExtension<T> get ext => _ListExtension<T>(this);
}

/// List extension for non-nullable lists.
extension ListDefaultExtension<T> on List<T> {
  /// List extension with [ext] property.
  _ListExtension<T> get ext => _ListExtension<T>(this);
}

final class _ListExtension<T> with CollectionCoreMixin<T> {
  _ListExtension(List<T>? list) : _list = list;

  final List<T>? _list;

  @override
  Iterable<T> get items => _list ?? const [];

  /// Returns `true` if the list is null or empty.
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  /// Returns `true` if the list is not null and not empty.
  bool get isNotNullOrEmpty {
    if (_list != null) {
      return _list.isNotEmpty;
    } else {
      return false;
    }
  }

  /// Convert to nullable list for safe operations.
  List<T> makeSafe() =>
      _list?.where((element) => element != null).cast<T>().toList() ?? [];

  /// Returns the index of the first element that satisfies the provided [search] function.
  /// If no element is found, returns null.
  int? indexOrNull(bool Function(T) search) {
    final result = _list?.indexWhere(search);
    return result != -1 ? result : null;
  }

  /// Returns a new list with the elements at [first] and [second] swapped.
  ///
  /// The receiver is not mutated. Throws a [RangeError] when either index is
  /// out of bounds.
  List<T> swap(int first, int second) {
    final source = items.toList();

    RangeError.checkValidIndex(first, source, 'first');
    RangeError.checkValidIndex(second, source, 'second');

    final swapped = [...source];
    swapped[first] = source[second];
    swapped[second] = source[first];

    return swapped;
  }

  /// The last [count] elements, or every element when there are fewer.
  ///
  /// ```dart
  /// [1, 2, 3, 4, 5].ext.takeLast(2);  // [4, 5]
  /// ```
  List<T> takeLast(int count) {
    if (count <= 0) return [];

    final source = items.toList();
    if (count >= source.length) return source;

    return source.sublist(source.length - count);
  }

  /// The elements with [separator] inserted between each pair.
  ///
  /// Useful for laying out widgets without a trailing separator:
  ///
  /// ```dart
  /// Column(children: tiles.ext.separatedBy(const Divider()));
  /// ```
  List<T> separatedBy(T separator) {
    final source = items.toList();
    if (source.length <= 1) return source;

    return [
      for (var index = 0; index < source.length; index++) ...[
        if (index > 0) separator,
        source[index],
      ],
    ];
  }

  /// A new list with the element at [index] replaced by [element].
  ///
  /// The receiver is not mutated. Throws a [RangeError] when [index] is out of
  /// bounds.
  List<T> replaceAt(int index, T element) {
    final source = items.toList();
    RangeError.checkValidIndex(index, source, 'index');

    final replaced = [...source];
    replaced[index] = element;

    return replaced;
  }

  /// The element at [index], or `null` when the index is out of bounds.
  ///
  /// A safe counterpart to the `[]` operator, which throws.
  T? elementAtOrNull(int index) {
    if (index < 0) return null;

    final source = items.toList();
    if (index >= source.length) return null;

    return source[index];
  }
}
