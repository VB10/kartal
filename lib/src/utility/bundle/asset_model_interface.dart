// This is an interface name convention
// ignore_for_file: file_names

// Defining a single-method interface
// ignore: one_member_abstracts
abstract mixin class IAssetModel<T> {
  T fromJson(Map<String, dynamic> json);
}
