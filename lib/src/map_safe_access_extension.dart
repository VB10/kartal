extension MapSafeAccessExtension on Map<String, dynamic> {
  T? getValue<T>(String key) {
    final value = this[key];
    if (value is T) return value;
    return null;
  }

  String? getString(String key) => getValue<String>(key);

  int? getInt(String key) => getValue<int>(key);

  double? getDouble(String key) => getValue<double>(key);

  bool? getBool(String key) => getValue<bool>(key);

  List<T>? getList<T>(String key) {
    final value = this[key];
    if (value is List) {
      return value.cast<T>();
    }
    return null;
  }

  Map<String, dynamic>? getMap(String key) {
    final value = this[key];
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }

  bool hasKey(String key) => containsKey(key);

  bool hasValue(dynamic value) => containsValue(value);

  T getValueOrDefault<T>(String key, T defaultValue) {
    final value = getValue<T>(key);
    return value ?? defaultValue;
  }

  String getStringOrDefault(String key, String defaultValue) =>
      getString(key) ?? defaultValue;

  int getIntOrDefault(String key, int defaultValue) =>
      getInt(key) ?? defaultValue;

  double getDoubleOrDefault(String key, double defaultValue) =>
      getDouble(key) ?? defaultValue;

  bool getBoolOrDefault(String key, {required bool defaultValue}) =>
      getBool(key) ?? defaultValue;

  Map<String, dynamic> copyWith({
    String? key,
    dynamic value,
    Map<String, dynamic>? other,
  }) {
    final newMap = Map<String, dynamic>.from(this);
    if (key != null && value != null) {
      newMap[key] = value;
    }
    if (other != null) {
      newMap.addAll(other);
    }
    return newMap;
  }
}

extension NullableMapSafeAccessExtension on Map<String, dynamic>? {
  Map<String, dynamic> get orEmpty => this ?? {};

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
