import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_module.dart';

void main() {
  setUpAll(() {
    initModule(HomeAuthModule());
  });
}
