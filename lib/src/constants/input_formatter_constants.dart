import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatter {
  static InputFormatter? _instace;
  static InputFormatter get instance {
    if (_instace != null) {
      return _instace!;
    }
    _instace = InputFormatter._init();
    return _instace!;
  }

  InputFormatter._init();

  String get _phoneMask => '0(###) ###-##-##';
  String get _timeMask => '##/##/####';
  String get _timeMaskUnderLine => '####-##-##';

  MaskTextInputFormatter get phoneFormatter => MaskTextInputFormatter(mask: _phoneMask, filter: {'#': RegExp(r'[0-9]')});
  MaskTextInputFormatter get timeFormatter => MaskTextInputFormatter(mask: _timeMask, filter: {'#': RegExp(r'[0-9]')});
  MaskTextInputFormatter get timeFormatterOverLine => MaskTextInputFormatter(mask: _timeMaskUnderLine, filter: {'#': RegExp(r'[0-9]')});
}
