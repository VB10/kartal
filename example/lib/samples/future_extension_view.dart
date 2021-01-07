import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FutureExtensionView extends StatelessWidget {
  Future<String> fetchDummyData(BuildContext context) async {
    await Future.delayed(context.durationLow);
    return Future.value('Okey');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: fetchDummyData(context).toBuild<String>(
          onSuccess: (data) {
            return Center(child: Text(data));
          },
          loadingWidget: Center(child: CircularProgressIndicator()),
          notFoundWidget: Text('Oh no'),
          onError: FlutterLogo()),
    );
  }
}
