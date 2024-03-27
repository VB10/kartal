// ignore_for_file: prefer_constructors_over_static_methods

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final class InputFormatter {
  InputFormatter._init();
  static InputFormatter get instance => _instance ??= InputFormatter._init();
  static InputFormatter? _instance;

  String get _phoneMask => '0(###) ###-##-##';
  String get _timeMask => '##/##/####';
  String get _timeMaskUnderLine => '####-##-##';

  MaskTextInputFormatter get phoneFormatter => MaskTextInputFormatter(
        mask: _phoneMask,
        filter: {
          '#': RegExp('[0-9]'),
        },
      );
  MaskTextInputFormatter get timeFormatter => MaskTextInputFormatter(
        mask: _timeMask,
        filter: {
          '#': RegExp('[0-9]'),
        },
      );
  MaskTextInputFormatter get timeFormatterOverLine => MaskTextInputFormatter(
        mask: _timeMaskUnderLine,
        filter: {'#': RegExp('[0-9]')},
      );
}
