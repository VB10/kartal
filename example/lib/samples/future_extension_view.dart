import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FutureExtensionView extends StatelessWidget {
  Future<String> fetchDummyData(BuildContext context) async {
    await Future.delayed(context.durationLow);
    return Future.value('Okey');
  }

  @override
  Widget build(BuildContext context) {
    return fetchDummyData(context).toBuild<String>(
        onSuccess: (data) {
          return Text(data);
        },
        loaindgWidget: CircularProgressIndicator(),
        notFoundWidget: Text('Oh no'),
        onError: FlutterLogo());
  }
}
