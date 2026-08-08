import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

/// Pumps [child] inside a minimal app so gesture and theme lookups work.
Future<void> _pump(WidgetTester tester, Widget child) =>
    tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));

/// The nearest [T] wrapping the marker text.
///
/// Scoping to the marker matters because MaterialApp and Scaffold contribute
/// their own Padding, IgnorePointer and ConstrainedBox widgets to the tree.
T _wrapping<T extends Widget>(WidgetTester tester) => tester.widget<T>(
  find.ancestor(of: find.text('marker'), matching: find.byType(T)).first,
);

void main() {
  const marker = Text('marker');

  group('toVisible', () {
    testWidgets('renders the widget when visible', (tester) async {
      await _pump(tester, marker.ext.toVisible());

      expect(find.text('marker'), findsOneWidget);
    });

    testWidgets('collapses to a zero size box when hidden', (tester) async {
      await _pump(tester, marker.ext.toVisible(value: false));

      expect(find.text('marker'), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });

  group('toDisabled', () {
    testWidgets('dims and blocks pointers when disabled', (tester) async {
      await _pump(tester, marker.ext.toDisabled(disable: true));

      final ignorePointer = _wrapping<IgnorePointer>(tester);
      final opacity = _wrapping<Opacity>(tester);

      expect(ignorePointer.ignoring, isTrue);
      expect(opacity.opacity, 0.2);
    });

    testWidgets('renders normally when enabled', (tester) async {
      await _pump(tester, marker.ext.toDisabled(disable: false));

      expect(_wrapping<Opacity>(tester).opacity, 1.0);
    });

    testWidgets('honours a custom opacity', (tester) async {
      await _pump(tester, marker.ext.toDisabled(disable: true, opacity: 0.7));

      expect(_wrapping<Opacity>(tester).opacity, 0.7);
    });
  });

  group('padding helpers', () {
    testWidgets('paddingAll applies the same inset on each side', (
      tester,
    ) async {
      await _pump(tester, marker.ext.paddingAll(12));

      expect(
        _wrapping<Padding>(tester).padding,
        const EdgeInsets.all(12),
      );
    });

    testWidgets('paddingSymmetric applies symmetric insets', (tester) async {
      await _pump(
        tester,
        marker.ext.paddingSymmetric(horizontal: 8, vertical: 4),
      );

      expect(
        _wrapping<Padding>(tester).padding,
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      );
    });

    testWidgets('paddingOnly applies per side insets', (tester) async {
      await _pump(tester, marker.ext.paddingOnly(left: 2, bottom: 6));

      expect(
        _wrapping<Padding>(tester).padding,
        const EdgeInsets.only(left: 2, bottom: 6),
      );
    });

    testWidgets('padding accepts an EdgeInsetsGeometry', (tester) async {
      await _pump(tester, marker.ext.padding(const EdgeInsets.all(3)));

      expect(
        _wrapping<Padding>(tester).padding,
        const EdgeInsets.all(3),
      );
    });
  });

  group('layout helpers', () {
    testWidgets('center wraps in Center', (tester) async {
      await _pump(tester, marker.ext.center);

      expect(find.byType(Center), findsWidgets);
      expect(find.text('marker'), findsOneWidget);
    });

    testWidgets('expanded wraps in Expanded with the flex', (tester) async {
      await _pump(tester, Row(children: [marker.ext.expanded(flex: 3)]));

      expect(_wrapping<Expanded>(tester).flex, 3);
    });

    testWidgets('flexible wraps in Flexible with the fit', (tester) async {
      await _pump(
        tester,
        Row(children: [marker.ext.flexible(flex: 2, fit: FlexFit.tight)]),
      );

      final flexible = _wrapping<Flexible>(tester);

      expect(flexible.flex, 2);
      expect(flexible.fit, FlexFit.tight);
    });

    testWidgets('align wraps in Align', (tester) async {
      await _pump(tester, marker.ext.align(Alignment.topLeft));

      expect(
        _wrapping<Align>(tester).alignment,
        Alignment.topLeft,
      );
    });

    testWidgets('sized applies a fixed size', (tester) async {
      await _pump(tester, marker.ext.sized(width: 40, height: 20));

      final box = _wrapping<SizedBox>(tester);

      expect(box.width, 40);
      expect(box.height, 20);
    });

    testWidgets('constrained applies box constraints', (tester) async {
      await _pump(tester, marker.ext.constrained(maxWidth: 100));

      expect(
        _wrapping<ConstrainedBox>(tester).constraints.maxWidth,
        100,
      );
    });

    testWidgets('positioned works inside a Stack', (tester) async {
      await _pump(
        tester,
        Stack(children: [marker.ext.positioned(left: 5, top: 10)]),
      );

      final positioned = _wrapping<Positioned>(tester);

      expect(positioned.left, 5);
      expect(positioned.top, 10);
    });

    testWidgets('sliver works inside a CustomScrollView', (tester) async {
      await _pump(tester, CustomScrollView(slivers: [marker.ext.sliver]));

      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
      expect(find.text('marker'), findsOneWidget);
    });
  });

  group('onTap', () {
    testWidgets('fires the callback through an InkWell by default', (
      tester,
    ) async {
      var taps = 0;
      await _pump(tester, marker.ext.onTap(() => taps++));

      expect(find.byType(InkWell), findsOneWidget);

      await tester.tap(find.text('marker'));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('uses a GestureDetector when the ripple is off', (
      tester,
    ) async {
      var taps = 0;
      await _pump(
        tester,
        marker.ext.onTap(() => taps++, withRipple: false),
      );

      expect(find.byType(InkWell), findsNothing);

      await tester.tap(find.text('marker'));
      await tester.pump();

      expect(taps, 1);
    });
  });

  group('decoration helpers', () {
    testWidgets('safeArea wraps in SafeArea', (tester) async {
      await _pump(tester, marker.ext.safeArea);

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('tooltip attaches the message', (tester) async {
      await _pump(tester, marker.ext.tooltip('hint'));

      expect(_wrapping<Tooltip>(tester).message, 'hint');
    });

    testWidgets('hero attaches the tag', (tester) async {
      await _pump(tester, marker.ext.hero('tag'));

      expect(_wrapping<Hero>(tester).tag, 'tag');
    });

    testWidgets('opacity wraps in Opacity', (tester) async {
      await _pump(tester, marker.ext.opacity(0.4));

      expect(_wrapping<Opacity>(tester).opacity, 0.4);
    });

    testWidgets('card wraps in Card', (tester) async {
      await _pump(tester, marker.ext.card(elevation: 4));

      expect(_wrapping<Card>(tester).elevation, 4);
    });

    testWidgets('rotated wraps in RotatedBox', (tester) async {
      await _pump(tester, marker.ext.rotated(1));

      expect(
        _wrapping<RotatedBox>(tester).quarterTurns,
        1,
      );
    });

    testWidgets('clipRounded wraps in ClipRRect', (tester) async {
      await _pump(tester, marker.ext.clipRounded(16));

      expect(
        _wrapping<ClipRRect>(tester).borderRadius,
        BorderRadius.circular(16),
      );
    });
  });

  group('chaining', () {
    testWidgets('helpers compose in the written order', (tester) async {
      await _pump(
        tester,
        marker.ext.paddingAll(8).ext.center.ext.opacity(0.5),
      );

      // Opacity is outermost because it was applied last.
      expect(
        find.ancestor(of: find.byType(Center), matching: find.byType(Opacity)),
        findsOneWidget,
      );
      expect(
        find.ancestor(of: find.byType(Padding), matching: find.byType(Center)),
        findsWidgets,
      );
      expect(find.text('marker'), findsOneWidget);
    });
  });
}
