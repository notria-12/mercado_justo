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
    } else if (phone.length != 19) {
      return "Informe o código do país, o ddd e o número";
    } else {
      return null;
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
