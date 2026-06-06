import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('WidgetExtension Tests', () {
    testWidgets('toVisible shows widget when value is true', (tester) async {
      const widget = Text('Test Widget');
      final visibleWidget = widget.ext.toVisible();

      await tester.pumpWidget(MaterialApp(home: visibleWidget));
      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('toVisible hides widget when value is false', (tester) async {
      const widget = Text('Test Widget');
      final hiddenWidget = widget.ext.toVisible(value: false);

      await tester.pumpWidget(MaterialApp(home: hiddenWidget));
      expect(find.text('Test Widget'), findsNothing);
    });

    testWidgets('toDisabled renders with reduced opacity when disabled',
        (tester) async {
      const widget = Text('Test Widget');
      final disabledWidget = widget.ext.toDisabled(disable: true, opacity: 0.3);

      await tester.pumpWidget(MaterialApp(home: disabledWidget));
      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 0.3);
    });

    testWidgets('toDisabled renders normally when not disabled',
        (tester) async {
      const widget = Text('Test Widget');
      final enabledWidget = widget.ext.toDisabled(disable: false);

      await tester.pumpWidget(MaterialApp(home: enabledWidget));
      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, 1.0);
    });

    testWidgets('sliver wraps widget in SliverToBoxAdapter', (tester) async {
      const widget = Text('Test Widget');
      final sliverWidget = widget.ext.sliver;

      await tester.pumpWidget(MaterialApp(
        home: CustomScrollView(slivers: [sliverWidget]),
      ));
      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
    });
  });
}
