import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormater {
  static MaskTextInputFormatter get phoneMask => MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
      );

  static MaskTextInputFormatter get cpfMask => MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
      );
}
