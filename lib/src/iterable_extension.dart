import 'package:kartal/src/private/mixin/collection/collection_core_mixin.dart';

/// Provides null-stripping helpers for iterables with nullable elements.
///
/// This keeps the `exts` accessor because its element type is `T?`, which the
/// collection helpers on [IterableCollectionExtension] cannot express.
extension IterableExtensions<T> on Iterable<T?> {
  /// Iterable extension with [exts] property.
  _IterableExtension<T> get exts => _IterableExtension<T>(this);
}

/// Provides the shared collection helpers for non-nullable iterables.
///
/// For [List] receivers the more specific list extension wins, but both mix in
/// the same helpers, so `.ext` behaves identically either way.
extension IterableCollectionExtension<T> on Iterable<T> {
  /// Iterable extension with [ext] property.
  _IterableCollectionExtension<T> get ext =>
      _IterableCollectionExtension<T>(this);
}

final class _IterableExtension<T> {
  _IterableExtension(Iterable<T?> list) : _list = list;

  final Iterable<T?> _list;

  ///  Convert to nullable list for safe operations.
  List<T> makeSafe() =>
      _list.where((element) => element != null).cast<T>().toList();

  /// The function `makeSafeCustom` filters a list `_list` based on a given condition `onHandle` and returns a new list of
  /// type `T`.
  ///
  /// Args:
  ///   onHandle (bool Function(T? value)): The `onHandle` parameter is a function that takes a nullable value of type `T`
  /// and returns a boolean value. It is used to filter the elements in the `_list` based on the condition specified in the
  /// function.
  List<T> makeSafeCustom(bool Function(T? value) onHandle) =>
      _list.where(onHandle).cast<T>().toList();
}

final class _IterableCollectionExtension<T> with CollectionCoreMixin<T> {
  _IterableCollectionExtension(this.items);

  @override
  final Iterable<T> items;

  /// Returns `true` if the iterable is empty.
  bool get isNullOrEmpty => items.isEmpty;

  /// Returns `true` if the iterable has at least one element.
  bool get isNotNullOrEmpty => items.isNotEmpty;
}
