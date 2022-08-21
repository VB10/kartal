class PackageInfoNotFound implements Exception {
  PackageInfoNotFound();
  final String description =
      'Please call the await DeviceUtiltiy.instance.initPackageInfo()';

  @override
  String toString() {
    return description;
  }
}
