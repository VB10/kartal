final class PackageInfoNotFound implements Exception {
  PackageInfoNotFound();
  final String description =
      'Please call the await DeviceUtility.instance.initPackageInfo()';

  @override
  String toString() => description;
}
