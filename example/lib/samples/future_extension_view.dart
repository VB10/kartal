import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FutureExtensionView extends StatelessWidget {
  const FutureExtensionView({super.key});

  Future<String> fetchDummyData(BuildContext context) async {
    await Future<void>.delayed(context.durationLow);
    return Future.value('Oke');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: fetchDummyData(context).toBuild(
        onSuccess: (data) {
          return Center(
            child: Text(data ?? ''),
          );
        },
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        notFoundWidget: const Text('Oh no'),
        onError: const FlutterLogo(),
      ),
    );
  }
}
