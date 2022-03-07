import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/pages/signin_page.dart';
import 'package:mercado_justo/app/modules/login/pages/signup_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SignInPage()),
    ChildRoute('/signup/', child: (_, args) => SignUpPage()),
  ];
}
