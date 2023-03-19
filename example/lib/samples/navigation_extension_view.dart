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
            context.navigation.canPop();
          },
        ),
        FloatingActionButton(
          onPressed: () {
            context.pop<void>();
          },
          child: const Text('Navigation Pop'),
        ),
        FloatingActionButton(
          onPressed: () {
            context.navigateName<void>('/hello');
          },
          child: const Text('Navigation Named'),
        ),
        FloatingActionButton(
          onPressed: () {
            context.navigateToReset<void>('/hello');
          },
          child: const Text('Navigation Named and Remove'),
        ),
      ],
    );
  }
}
