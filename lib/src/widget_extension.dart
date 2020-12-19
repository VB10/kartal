import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget toVisible(bool val) => val ? this : SizedBox(height: 1);
}
