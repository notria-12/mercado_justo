import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/pages/code_by_email_page.dart';
import 'package:mercado_justo/app/modules/login/pages/received_code_page.dart';
import 'package:mercado_justo/app/modules/login/pages/signin_page.dart';
import 'package:mercado_justo/app/modules/login/pages/signup_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SignInPage()),
    ChildRoute('/signup/', child: (_, args) => const SignUpPage()),
    ChildRoute('/receivedCode/', child: (_, args) => const ReceivedCodePage()),
    ChildRoute('/codeEmail/', child: (_, args) => const CodeEmailPage()),
  ];
}
