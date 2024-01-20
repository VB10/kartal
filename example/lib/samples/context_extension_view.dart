import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ContextExtensionView extends StatelessWidget {
  const ContextExtensionView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: context.sized.height,
          width: context.sized.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.general.isKeyBoardOpen ? 'Keyboard is Open' : 'Keyboard is Closed',
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
                    context.popupManager.showLoader(id: id);
                    Future.delayed(const Duration(seconds: 2), () {
                      context.popupManager.hideLoader(id: id);
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
        duration: context.duration.durationLow,
        child: Text('${context.duration.durationLow.inHours}'),
      );

  Widget paddingExtension(BuildContext context) => Padding(
        padding: context.padding.low,
        child: Padding(
          padding: context.padding.horizontalMedium,
          child: Text('${context.duration.durationLow.inHours}'),
        ),
      );

  Widget emptySizedBox(BuildContext context) => Column(
        children: [
          Text('${context.duration.durationLow.inHours}'),
          context.sized.emptySizedHeightBoxHigh,
          Row(
            children: [
              const Text('Row'),
              context.sized.emptySizedWidthBoxLow,
              const Text('Row'),
            ],
          )
        ],
      );

  Widget radiusExtension(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(borderRadius: context.border.lowBorderRadius),
      );
}
