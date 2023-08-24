// ignore_for_file: file_names

// ignore: one_member_abstracts
abstract mixin class IAssetModel<T> {
  T fromJson(Map<String, dynamic> json);
}
