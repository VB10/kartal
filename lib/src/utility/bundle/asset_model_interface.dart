// This interface is required for typing in BundleDecoder and cannot be converted to a top-level function.
// ignore: one_member_abstracts
abstract mixin class IAssetModel<T> {
  T fromJson(Map<String, dynamic> json);
}
