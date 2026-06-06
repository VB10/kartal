// The file name uses standard PascalCase or snake_case with some specific exceptions that might trigger file name rules.
// ignore_for_file: file_names

// This interface requires only a single member fromJson for model mapping.
// ignore: one_member_abstracts
abstract mixin class IAssetModel<T> {
  T fromJson(Map<String, dynamic> json);
}
