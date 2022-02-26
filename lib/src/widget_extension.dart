import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget toVisible(bool val, {double? height}) => val ? this : SizedBox(height: height);

  Widget toDisabled([bool? disable]) =>
      IgnorePointer(ignoring: disable ?? true, child: Opacity(opacity: (disable ?? true) ? 0.2 : 1, child: this));
}
