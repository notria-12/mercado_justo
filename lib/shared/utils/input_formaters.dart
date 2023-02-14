import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class InputFormater {
  static MaskTextInputFormatter phoneMask({String? initialText}) {
    return MaskTextInputFormatter(
      mask: '(##) #####-####',
      initialText: initialText,
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter cardMask({String? initialText}) {
    return MaskTextInputFormatter(
      mask: '#### #### #### ####',
      initialText: initialText,
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter cardValidity({String? initialText}) {
    return MaskTextInputFormatter(
      mask: '##/####',
      initialText: initialText,
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter cvvMask({String? initialText}) {
    return MaskTextInputFormatter(
      mask: '###',
      initialText: initialText,
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter cepMask({String? initialText}) {
    return MaskTextInputFormatter(
      mask: '#####-###',
      initialText: initialText,
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter get cpfMask => MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
      );

  static TextInputFormatter get valueMask => MaskTextInputFormatter(
      mask: '##,##', filter: {"#": RegExp(r'[0-9]')}, initialText: '0,00');
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int? maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits!) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
