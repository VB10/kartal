import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ContextExtensionView extends StatelessWidget {
  const ContextExtensionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      appBar: AppBar(brightness: context.appBrightness),
      body: Container(
        height: context.mediaQuery.size.height,
        color: context.colorScheme.onBackground,
        child: Text(
          context.isKeyBoardOpen ? 'Open' : 'Close',
          style: context.textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget mediaQueryWidgets(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.1),
      width: context.dynamicWidth(0.1),
      child: Text('${context.lowValue}'),
    );
  }

  Widget animatedContainerDuration(BuildContext context) {
    return AnimatedOpacity(
      opacity: context.isKeyBoardOpen ? 1 : 0,
      duration: context.durationLow,
      child: Text('${context.durationLow.inHours}'),
    );
  }

  Widget paddingExtension(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Padding(
        padding: context.horizontalPaddingMedium,
        child: Text('${context.durationLow.inHours}'),
      ),
    );
  }

  Widget emptySizedBox(BuildContext context) {
    return Column(
      children: [
        Text('${context.durationLow.inHours}'),
        context.emptySizedHeightBoxHigh,
        Row(
          children: [
            const Text('Row'),
            context.emptySizedWidthBoxLow,
            const Text('Row'),
          ],
        )
      ],
    );
  }

  Widget radiusExtension(BuildContext context) {
<<<<<<< HEAD
    return Container(
=======
    return DecoratedBox(
>>>>>>> master
      decoration: BoxDecoration(borderRadius: context.lowBorderRadius),
    );
  }
}
