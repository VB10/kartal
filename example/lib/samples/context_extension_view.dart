import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ContextExtensionView extends StatelessWidget {
  const ContextExtensionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.general.mediaQuery.size.height,
        color: context.general.colorScheme.onBackground,
        child: Text(
          context.general.isKeyBoardOpen ? 'Open' : 'Close',
          style: context.general.textTheme.titleMedium,
        ),
      ),
    );
  }

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

  Widget radiusExtension(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: context.border.lowBorderRadius),
    );
  }
}
