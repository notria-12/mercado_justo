import 'package:dio/dio.dart';
import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/send_login_code_by_email_usecase.dart';
import 'package:mercado_justo/app/modules/login/external/datasources/login_repository_datasource.dart';
import 'package:mercado_justo/app/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:mercado_justo/app/modules/login/infra/repositories/login_repository.dart';
import 'package:mercado_justo/app/modules/login/login_repository.dart';
import 'package:mercado_justo/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_by_email_code_store.dart';
import 'package:mercado_justo/app/modules/login/presenter/pages/code_by_email_page.dart';
import 'package:mercado_justo/app/modules/login/pages/received_code_page.dart';
import 'package:mercado_justo/app/modules/login/pages/signin_page.dart';
import 'package:mercado_justo/app/modules/login/pages/signup_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    //datasources
    Bind.lazySingleton((i) => LoginDatasourceImpl(i<Dio>())),
    //repositories
    Bind.lazySingleton((i) => LoginRepositoryImpl(i<ILoginDatasource>())),
    //usecases
    Bind.lazySingleton((i) => SendLoginCodeByEmailImpl(i<ILoginRepository>())),
    //controllers
    Bind.lazySingleton(
        (i) => LoginByEmailCodeStore(i<ISendLoginCodeByEmail>())),
    Bind.lazySingleton((i) => LoginStore(i())),

    Bind.lazySingleton((i) => LoginRepository(i(), authController: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SignInPage()),
    ChildRoute('/signup/', child: (_, args) => const SignUpPage()),
    ChildRoute('/receivedCode/', child: (_, args) => const ReceivedCodePage()),
    ChildRoute('/codeEmail/', child: (_, args) => const CodeEmailPage()),
  ];
}
