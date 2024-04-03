import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  testWidgets(
    'PopupManager extension test',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: _ContextExtensionView()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show loader'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 2500));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.tap(find.text('Show loader with id'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 2500));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}

final class _ContextExtensionView extends StatelessWidget {
  const _ContextExtensionView();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
          height: context.sized.height,
          width: context.sized.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.general.isKeyBoardOpen
                      ? 'Keyboard is Open'
                      : 'Keyboard is Closed',
                  style: context.general.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.popupManager.showLoader();
                    Future.delayed(const Duration(seconds: 2), () {
                      context.popupManager.hideLoader();
                    });
                  },
                  child: const Text('Show loader'),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    final id = UniqueKey();
                    context.popupManager.showLoader(id: id.toString());
                    Future.delayed(const Duration(seconds: 2), () {
                      context.popupManager.hideLoader(id: id.toString());
                    });
                  },
                  child: const Text('Show loader with id'),
                ),
              ],
            ),
          ),
        ),
      );

  Widget mediaQueryWidgets(BuildContext context) => SizedBox(
        height: context.sized.dynamicHeight(0.1),
        width: context.sized.dynamicWidth(0.1),
        child: Text('${context.sized.lowValue}'),
      );

  Widget animatedContainerDuration(BuildContext context) => AnimatedOpacity(
        opacity: context.general.isKeyBoardOpen ? 1 : 0,
        duration: Durations.extralong2,
        child: Text('${Durations.extralong2.inHours}'),
      );

  Widget paddingExtension(BuildContext context) => Padding(
        padding: context.padding.low,
        child: Padding(
          padding: context.padding.horizontalMedium,
          child: Text('${Durations.extralong2.inHours}'),
        ),
      );

  Widget emptySizedBox(BuildContext context) => Column(
        children: [
          Text('${Durations.extralong2.inHours}'),
          context.sized.emptySizedHeightBoxHigh,
          Row(
            children: [
              const Text('Row'),
              context.sized.emptySizedWidthBoxLow,
              const Text('Row'),
            ],
          ),
        ],
      );

  Widget radiusExtension(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(borderRadius: context.border.lowBorderRadius),
      );
}
