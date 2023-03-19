import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatter {
  InputFormatter._init();
  factory InputFormatter.instance() {
   return _instance ??= InputFormatter._init();
  }
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
