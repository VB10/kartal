extension ListExtension on List? {
  bool get isNullOrEmpty => !isNotNullOrEmpty;

  bool get isNotNullOrEmpty {
    if (this is List) {
      return this!.isNotEmpty;
    } else {
      return false;
    }
  }
}
