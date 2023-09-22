class _IterableExtension<T> {
  _IterableExtension(Iterable<T?> list) : _list = list;

  final Iterable<T?> _list;

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

extension IterableExtension<T> on Iterable<T?> {
  _IterableExtension<T> get ext => _IterableExtension<T>(this);
}
