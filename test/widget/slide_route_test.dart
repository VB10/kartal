import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

/// A two-screen app that pushes [type] when the button is tapped.
Widget _app(SlideType type, {Object? extra}) => MaterialApp(
  home: Builder(
    builder: (context) => Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.route.navigateToPage(
            const Scaffold(body: Center(child: Text('second'))),
            type: type,
            extra: extra,
          ),
          child: const Text('go'),
        ),
      ),
    ),
  ),
);

void main() {
  group('SlideType.route', () {
    test('defaultType builds a MaterialPageRoute', () {
      final route = SlideType.defaultType.route<void>(
        const SizedBox.shrink(),
        const RouteSettings(),
      );

      expect(route, isA<MaterialPageRoute<void>>());
    });

    test('the directional types build a transition route', () {
      for (final type in SlideType.values.where(
        (t) => t != SlideType.defaultType,
      )) {
        final route = type.route<void>(
          const SizedBox.shrink(),
          const RouteSettings(),
        );

        expect(
          route,
          isA<PageRouteBuilder<void>>(),
          reason: '${type.name} should slide',
        );
      }
    });

    test('each direction carries a distinct offset', () {
      expect(SlideType.right.offSet, const Offset(-1, 0));
      expect(SlideType.left.offSet, const Offset(1, 0));
      expect(SlideType.bottom.offSet, const Offset(0, -1));
      expect(SlideType.top.offSet, const Offset(0, 1));
      expect(SlideType.defaultType.offSet, isNull);
    });

    test('passes route settings through', () {
      final route = SlideType.right.route<void>(
        const SizedBox.shrink(),
        const RouteSettings(name: '/second', arguments: 42),
      );

      expect(route.settings.name, '/second');
      expect(route.settings.arguments, 42);
    });
  });

  group('navigation with each slide type', () {
    for (final type in SlideType.values) {
      testWidgets('${type.name} pushes and renders the page', (tester) async {
        await tester.pumpWidget(_app(type));

        await tester.tap(find.text('go'));
        await tester.pumpAndSettle();

        expect(find.text('second'), findsOneWidget);
        expect(find.text('go'), findsNothing);
      });
    }

    testWidgets('the slide animation moves the page into place', (
      tester,
    ) async {
      await tester.pumpWidget(_app(SlideType.bottom));

      await tester.tap(find.text('go'));
      // Halfway through the transition the page is on screen but offset.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final midTransition = tester.getTopLeft(find.text('second'));

      await tester.pumpAndSettle();
      final settled = tester.getTopLeft(find.text('second'));

      expect(
        midTransition,
        isNot(settled),
        reason: 'the page should still be sliding mid-transition',
      );
    });
  });

  group('context.route', () {
    testWidgets('navigateToPage forwards extra as route arguments', (
      tester,
    ) async {
      late Object? received;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => context.route.navigateToPage(
                  Builder(
                    builder: (inner) {
                      received = ModalRoute.of(inner)?.settings.arguments;
                      return const Text('second');
                    },
                  ),
                  extra: 'payload',
                ),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      expect(received, 'payload');
    });

    testWidgets('pop returns to the previous page', (tester) async {
      await tester.pumpWidget(_app(SlideType.right));

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.text('second'), findsOneWidget);

      final secondContext = tester.element(find.text('second'));
      await secondContext.route.pop();
      await tester.pumpAndSettle();

      expect(find.text('go'), findsOneWidget);
    });

    testWidgets('pop reports whether a route was popped', (tester) async {
      late BuildContext rootContext;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              rootContext = context;
              return const Scaffold(body: Text('only'));
            },
          ),
        ),
      );

      // Nothing to pop at the root of the stack.
      expect(await rootContext.route.pop(), isFalse);
    });

    testWidgets('navigation exposes the NavigatorState', (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const Scaffold();
            },
          ),
        ),
      );

      expect(context.route.navigation, isA<NavigatorState>());
    });

    testWidgets('navigateName pushes a named route', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => context.route.navigateName('/second'),
                child: const Text('go'),
              ),
            ),
            '/second': (_) => const Scaffold(body: Text('second')),
          },
        ),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      expect(find.text('second'), findsOneWidget);
    });

    testWidgets('navigateToReset clears the stack', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => context.route.navigateToReset('/second'),
                child: const Text('go'),
              ),
            ),
            '/second': (context) => Scaffold(
              body: Column(
                children: [
                  const Text('second'),
                  ElevatedButton(
                    onPressed: () => context.route.pop(),
                    child: const Text('back'),
                  ),
                ],
              ),
            ),
          },
        ),
      );

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
      expect(find.text('second'), findsOneWidget);

      // The first route was removed, so popping cannot go back to it.
      await tester.tap(find.text('back'));
      await tester.pumpAndSettle();

      expect(find.text('second'), findsOneWidget);
      expect(find.text('go'), findsNothing);
    });

    testWidgets('popWithRoot pops on the root navigator', (tester) async {
      await tester.pumpWidget(_app(SlideType.defaultType));

      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();

      tester.element(find.text('second')).route.popWithRoot();
      await tester.pumpAndSettle();

      expect(find.text('go'), findsOneWidget);
    });
  });
}
