import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PackageInfoView extends StatefulWidget {
  @override
  _PackageInfoViewState createState() => _PackageInfoViewState();
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
          ? Text(''.buildNumber)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
