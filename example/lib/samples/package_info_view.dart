// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PackageInfoView extends StatefulWidget {
  const PackageInfoView({super.key});

  @override
  State<PackageInfoView> createState() => _PackageInfoViewState();
}

class _PackageInfoViewState extends State<PackageInfoView> {
  bool isInit = false;
  @override
  void initState() {
    super.initState();
    initPackage();
  }

  Future<void> initPackage() async {
    await DeviceUtility.instance.initPackageInfo();
    setState(() {
      isInit = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isInit
          ? Text(''.ext.buildNumber)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
