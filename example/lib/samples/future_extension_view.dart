import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FutureExtensionView extends StatelessWidget {
  const FutureExtensionView({super.key});

  Future<String> fetchDummyData2(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'oke';
  }

  Future<String> fetchDummyData3(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    return 'oke';
  }

  Future<String> fetchDummyData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'oke';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: fetchDummyData(context)
            .timeoutOrNull(timeOutDuration: const Duration(seconds: 1))
            .ext
            .toBuild(
              onSuccess: (data) => Center(child: Text(data ?? '')),
              loadingWidget: const Center(child: CircularProgressIndicator()),
              notFoundWidget: const Text('Oh no'),
              onError: const FlutterLogo(),
            ),
      );
}

extension FutureExtension<T> on Future<T> {
  Future<T?> timeoutOrNull({
    Duration timeOutDuration = const Duration(seconds: 10),
    bool enableLogger = true,
  }) async {
    try {
      final response = await timeout(timeOutDuration);
      return response;
    } catch (e) {
      if (enableLogger) print('$T $e');
      return null;
    }
  }

  Future<T?> withTimeout({
    Duration timeoutDuration = const Duration(seconds: 5),
  }) async {
    try {
      final response = await timeout(timeoutDuration);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class Operation {
  Operation._();
  static Future<T?> withTimeout<T>(
    Future<T> request, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      final response = await request.timeout(timeout);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
