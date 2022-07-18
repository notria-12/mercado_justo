import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/terms_and_conditions_module.dart';

void main() {
  setUpAll(() {
    initModule(TermsAndConditionsModule());
  });
}
