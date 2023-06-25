import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NavigationViewExtension extends StatelessWidget {
  const NavigationViewExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          child: const Text('Navigation Prop'),
          onPressed: () {
            context.route.navigation.canPop();
          },
        ),
        FloatingActionButton(
          onPressed: () {
            context.route.pop<void>();
          },
          child: const Text('Navigation Pop'),
        ),
        FloatingActionButton(
          onPressed: () {
            context.route.navigateName<void>('/hello');
          },
          child: const Text('Navigation Named'),
        ),
        FloatingActionButton(
          onPressed: () {
            context.route.navigateToReset<void>('/hello');
          },
          child: const Text('Navigation Named and Remove'),
        ),
      ],
    );
  }
}
