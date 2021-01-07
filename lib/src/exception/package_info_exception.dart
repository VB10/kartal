class PackageInfoNotFound implements Exception {
  final String description = 'Please call the await DeviceUtiltiy.instance.initPackageInfo()';
  PackageInfoNotFound();

  @override
  String toString() {
    return description;
  }
}
