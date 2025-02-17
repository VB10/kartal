import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
// Import your key_extension.dart path

void main() {
  group('KeyExtension Tests', () {
    late GlobalKey<State> testKey;
    late Widget testWidget;

    setUp(() {
      testKey = GlobalKey();
      testWidget = MaterialApp(
        home: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 1000), // Add space before widget
              Container(
                key: testKey,
                height: 100,
                width: 100,
                color: Colors.red,
              ),
              const SizedBox(height: 1000), // Add space after widget
            ],
          ),
        ),
      );
    });

    testWidgets('rendererBox property returns correct RenderBox',
        (tester) async {
      await tester.pumpWidget(testWidget);

      expect(testKey.ext.rendererBox, isNotNull);
      expect(testKey.ext.rendererBox, isA<RenderBox>());
    });

    testWidgets('offset property returns correct global position',
        (tester) async {
      await tester.pumpWidget(testWidget);

      expect(testKey.ext.offset, isNotNull);
      expect(testKey.ext.offset, isA<Offset>());
    });

    testWidgets('height property returns correct widget height',
        (tester) async {
      await tester.pumpWidget(testWidget);

      expect(testKey.ext.height, 100);
    });

    testWidgets('scrollToWidget scrolls to the widget position',
        (tester) async {
      await tester.pumpWidget(testWidget);

      // Initial scroll position should be 0
      final scrollable = tester.state<ScrollableState>(find.byType(Scrollable));
      expect(scrollable.position.pixels, 0);

      // Scroll to widget
      testKey.ext.scrollToWidget();
      await tester.pumpAndSettle();

      // Verify that scroll position has changed
      expect(scrollable.position.pixels, isNot(0));
    });

    testWidgets('properties return null when context is null', (tester) async {
      final unusedKey = GlobalKey<State>();

      expect(unusedKey.ext.rendererBox, isNull);
      expect(unusedKey.ext.offset, isNull);
      expect(unusedKey.ext.height, isNull);
    });

    testWidgets('scrollToWidget does nothing when context is null',
        (tester) async {
      final unusedKey = GlobalKey<State>();

      // Should not throw error
      unusedKey.ext.scrollToWidget();
      await tester.pumpAndSettle();
    });
  });
}
