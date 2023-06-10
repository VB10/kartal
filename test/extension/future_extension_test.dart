import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  testWidgets('Test toBuild method', (WidgetTester tester) async {
    const Widget onSuccessWidget = Text('Success');
    const Widget loadingWidget = CircularProgressIndicator();
    const Widget notFoundWidget = Text('Not found');
    const Widget onErrorWidget = Text('Error');

    final successFuture =
        Future<String>.delayed(const Duration(seconds: 1), () => 'Data');
    final loadingFuture = Future<String>.delayed(
      const Duration(seconds: 1),
      () => throw Exception('Loading error'),
    );
    final notFoundFuture =
        Future<String>.delayed(const Duration(seconds: 1), () async {
      return '';
    });
    final errorFuture = Future<String>.delayed(
      const Duration(seconds: 1),
      () => throw Exception('Request error'),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              successFuture.toBuild(
                onSuccess: (data) => onSuccessWidget,
                loadingWidget: loadingWidget,
                notFoundWidget: notFoundWidget,
                onError: onErrorWidget,
              ),
              loadingFuture.toBuild(
                onSuccess: (data) => onSuccessWidget,
                loadingWidget: loadingWidget,
                notFoundWidget: notFoundWidget,
                onError: onErrorWidget,
              ),
              notFoundFuture.toBuild(
                onSuccess: (data) => onSuccessWidget,
                loadingWidget: loadingWidget,
                notFoundWidget: notFoundWidget,
                onError: onErrorWidget,
              ),
              errorFuture.toBuild(
                onSuccess: (data) => onSuccessWidget,
                loadingWidget: loadingWidget,
                notFoundWidget: notFoundWidget,
                onError: onErrorWidget,
              ),
            ],
          ),
        ),
      ),
    );

    // Wait for the initial loading state
    await tester.pump(const Duration(seconds: 1));

    // Check if the onSuccessWidget is displayed after the successFuture completes
    expect(find.byWidget(onSuccessWidget), findsOneWidget);
    expect(find.byWidget(loadingWidget), findsNothing);
    expect(find.byWidget(notFoundWidget), findsNothing);
    expect(find.byWidget(onErrorWidget), findsNothing);

    // Check if the loadingWidget is displayed during the loadingFuture
    expect(find.byWidget(loadingWidget), findsNWidgets(2));
    expect(find.byWidget(notFoundWidget), findsNothing);
    expect(find.byWidget(onErrorWidget), findsNothing);

    // Check if the notFoundWidget is displayed after the notFoundFuture completes
    expect(find.byWidget(notFoundWidget), findsOneWidget);
    expect(find.byWidget(loadingWidget), findsNothing);
    expect(find.byWidget(onErrorWidget), findsNothing);

    // Check if the onErrorWidget is displayed after the errorFuture completes
    expect(find.byWidget(onErrorWidget), findsOneWidget);
    expect(find.byWidget(loadingWidget), findsNothing);
    expect(find.byWidget(notFoundWidget), findsNothing);
  });

  // Diğer test senaryoları da eklenebilir.
}
