import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ImageExtensionView extends StatelessWidget {
  const ImageExtensionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network('https://picsum.photos/200/300').ext.bottomRotation;
  }
}
