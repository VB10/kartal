import 'dart:math';

import 'package:collection/collection.dart' as collection;

/// Collection helpers shared by the [List] and [Iterable] extensions.
///
/// Like the numeric mixin, this exists because an extension on `List<T>` wins
/// over one on `Iterable<T>` for list receivers. Mixing the same members into
/// both wrappers keeps `.ext` uniform whichever type you hold.
///
/// Where `package:collection` already implements an operation correctly this
/// delegates to it rather than reimplementing it.
mixin CollectionCoreMixin<T> {
  /// The elements these helpers operate on.
  Iterable<T> get items;

  /// Splits the collection into chunks of at most [size] elements.
  ///
  /// The final chunk holds the remainder, so no elements are dropped.
  ///
  /// ```dart
  /// [1, 2, 3, 4, 5].ext.chunked(2);  // [[1, 2], [3, 4], [5]]
  /// ```
  ///
  /// Throws a [RangeError] when [size] is not positive.
  List<List<T>> chunked(int size) {
    if (size <= 0) {
      throw RangeError.value(size, 'size', 'must be greater than zero');
    }

    return items.slices(size).toList();
  }

  /// Groups the elements by the key returned from [keyOf].
  ///
  /// ```dart
  /// people.ext.groupBy((p) => p.city);  // {'Istanbul': [...], ...}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T element) keyOf) =>
      collection.groupBy(items, keyOf);

  /// Removes duplicates, treating elements as equal when [keyOf] matches.
  ///
  /// The first occurrence of each key is kept, and the original order is
  /// preserved.
  ///
  /// ```dart
  /// users.ext.distinctBy((u) => u.id);
  /// ```
  List<T> distinctBy<K>(K Function(T element) keyOf) {
    final seen = <K>{};

    return items.where((element) => seen.add(keyOf(element))).toList();
  }

  /// Returns a new list sorted by the key returned from [keyOf].
  ///
  /// The receiver is not mutated, unlike [List.sort].
  ///
  /// ```dart
  /// people.ext.sortedBy((p) => p.age);
  /// ```
  List<T> sortedBy<K extends Comparable<Object?>>(
    K Function(T element) keyOf,
  ) => items.sortedByCompare(keyOf, (a, b) => a.compareTo(b));

  /// Returns a new list sorted in descending order by [keyOf].
  List<T> sortedByDescending<K extends Comparable<Object?>>(
    K Function(T element) keyOf,
  ) => items.sortedByCompare(keyOf, (a, b) => b.compareTo(a));

  /// The sum of [selector] across every element, or 0 when empty.
  ///
  /// ```dart
  /// orders.ext.sumBy((o) => o.total);
  /// ```
  num sumBy(num Function(T element) selector) =>
      items.fold<num>(0, (total, element) => total + selector(element));

  /// The mean of [selector] across every element, or `null` when empty.
  ///
  /// Returns `null` rather than NaN so that an empty collection is
  /// distinguishable from a genuine zero average.
  double? averageBy(num Function(T element) selector) {
    if (items.isEmpty) return null;

    return sumBy(selector) / items.length;
  }

  /// Splits the elements into those matching [test] and those that do not.
  ///
  /// ```dart
  /// final (adults, minors) = people.ext.partition((p) => p.age >= 18);
  /// ```
  (List<T> matching, List<T> rest) partition(bool Function(T element) test) {
    final matching = <T>[];
    final rest = <T>[];

    for (final element in items) {
      (test(element) ? matching : rest).add(element);
    }

    return (matching, rest);
  }

  /// Maps every element alongside its index.
  ///
  /// ```dart
  /// items.ext.mapIndexed((index, item) => '$index: $item');
  /// ```
  List<R> mapIndexed<R>(R Function(int index, T element) convert) =>
      items.mapIndexed(convert).toList();

  /// The first element matching [test], or `null` when there is none.
  ///
  /// A safe counterpart to [Iterable.firstWhere], which throws.
  T? firstWhereOrNull(bool Function(T element) test) =>
      items.firstWhereOrNull(test);

  /// A random element, or `null` when the collection is empty.
  ///
  /// Pass a [seed] for a deterministic result, which is what you want in
  /// tests.
  T? randomOrNull({int? seed}) {
    if (items.isEmpty) return null;

    return items.elementAt(Random(seed).nextInt(items.length));
  }

  /// The elements in [size] sized chunks, keyed by chunk index.
  ///
  /// Convenience over [chunked] for building paged UI.
  Map<int, List<T>> paged(int size) => chunked(size).asMap();
}
