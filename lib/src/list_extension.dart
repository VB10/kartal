import 'dart:math';

extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  bool get isNotNullOrEmpty {
    if (this is List) {
      return this!.isNotEmpty;
    } else {
      return false;
    }
  }
}

extension UnaryNumber on List<Object> {
  bool get isEven => length.isEven;
  bool get isOdd => !isEven;
  static bool isListEven(List<Object> list) => list.isEven;
}

extension RandomListItem<T> on List<T> {
  T? getRandom() => isEmpty
      ? null
      : length == 1
          ? first
          : this[Random().nextInt(length)];
}
