extension ListExtension on List {
  bool get isNullOrEmpty => this == null || isEmpty;
  bool get isNotNullOrEmpty => this != null && isNotEmpty;
}
