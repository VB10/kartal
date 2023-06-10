// ignore_for_file: file_names

abstract class INetworkModel<T> {
  Map<String, dynamic>? toJson();
  T fromJson(Map<String, dynamic> json);
}
