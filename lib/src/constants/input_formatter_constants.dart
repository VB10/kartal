import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatter {
  InputFormatter._init();
  static InputFormatter? _instance;
  static InputFormatter get instance {
    if (_instance != null) {
      return _instance!;
    }
    _instance = InputFormatter._init();
    return _instance!;
  }

  String get _phoneMask => '0(###) ###-##-##';
  String get _timeMask => '##/##/####';
  String get _timeMaskUnderLine => '####-##-##';

  MaskTextInputFormatter get phoneFormatter =>
      MaskTextInputFormatter(mask: _phoneMask, filter: {'#': RegExp('[0-9]')});
  MaskTextInputFormatter get timeFormatter =>
      MaskTextInputFormatter(mask: _timeMask, filter: {'#': RegExp('[0-9]')});
  MaskTextInputFormatter get timeFormatterOverLine => MaskTextInputFormatter(
        mask: _timeMaskUnderLine,
        filter: {'#': RegExp('[0-9]')},
      );
}
