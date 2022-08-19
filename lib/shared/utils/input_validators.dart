import 'package:cpf_cnpj_validator/cpf_validator.dart';

class InputValidators {
  static String? validateNotEmpyField(String? text) {
    if (text == null || text.isEmpty) {
      return 'O campo não pode ser vazio!';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "O campo não pode ser vazio!";
    } else if (phone.length != 15) {
      return "Informe o código do país, o ddd e o número";
    } else {
      return null;
    }
  }

  static String? cpfValidator(String? value) {
    if (CPFValidator.isValid(value)) {
      print(value);
      return null;
    } else {
      return "Formato do CPF inválido ou não existe";
    }
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'O campo não pode ser vazio!';
    } else {
      final RegExp emailPattern = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailPattern.hasMatch(email)) {
        return "E-mail inválido";
      }
    }
    return null;
  }
}
