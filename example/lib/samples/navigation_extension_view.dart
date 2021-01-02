import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NavigationViewExtenion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FloatingActionButton(
            child: Text('Navigation Prop'),
            onPressed: () {
              context.navigation.canPop();
            },
          ),
          FloatingActionButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Navigation Pop'),
          ),
          FloatingActionButton(
            onPressed: () {
              context.navigateName('/hello');
            },
            child: Text('Navigation Named'),
          ),
          FloatingActionButton(
            onPressed: () {
              context.navigateToReset('/hello');
            },
            child: Text('Navigation Named and Remove'),
          ),
        ],
      ),
    );
  }
}
