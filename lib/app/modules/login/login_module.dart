import 'package:mercado_justo/app//modules/login/presenter/controllers/signup_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/login/domain/repositories/i_login_repository.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/login_with_email_code_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/login_with_sms_code_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/send_login_code_by_email_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/signup_usecase.dart';
import 'package:mercado_justo/app/modules/login/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mercado_justo/app/modules/login/external/datasources/login_datasource.dart';
import 'package:mercado_justo/app/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:mercado_justo/app/modules/login/infra/repositories/login_repository.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_by_email_code_store.dart';
import 'package:mercado_justo/app/modules/login/presenter/controllers/login_store.dart';
import 'package:mercado_justo/app/modules/login/presenter/pages/code_by_email_page.dart';
import 'package:mercado_justo/app/modules/login/presenter/pages/received_code_by_email_page.dart';
import 'package:mercado_justo/app/modules/login/presenter/pages/received_code_page.dart';
import 'package:mercado_justo/app/modules/login/presenter/pages/signin_page.dart';
import 'package:mercado_justo/app/modules/login/presenter/pages/signup_page.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    //datasources
    Bind.lazySingleton((i) => LoginDatasourceImpl(
          i<Dio>(),
          i<AuthController>(),
        )),
    //repositories
    Bind.lazySingleton((i) => LoginRepositoryImpl(i<ILoginDatasource>())),
    //usecases
    Bind.lazySingleton((i) => SendLoginCodeByEmailImpl(i<ILoginRepository>())),
    Bind.lazySingleton((i) => LoginWithEmailCodeUsecase(i<ILoginRepository>())),
    Bind.lazySingleton((i) => VerifyPhoneNumberUsecase(i<ILoginRepository>())),
    Bind.lazySingleton((i) => LoginWithSmsCode(i<ILoginRepository>())),
    Bind.lazySingleton((i) => SignUpUseCase(i<ILoginRepository>())),
    //controllers
    Bind.lazySingleton((i) => LoginByEmailCodeStore(
        i<ISendLoginCodeByEmail>(), i<ILoginWithEmailCodeUsecase>())),
    Bind.lazySingleton((i) => LoginStore(i(), i(), i())),
    Bind.lazySingleton((i) => SignupStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SignInPage()),
    ChildRoute('/signup/', child: (_, args) => const SignUpPage()),
    ChildRoute('/receivedCode/', child: (_, args) => const ReceivedCodePage()),
    ChildRoute('/receivedEmailCode/',
        child: (_, args) => const ReceivedCodeByEmailPage()),
    ChildRoute('/codeEmail/', child: (_, args) => const CodeEmailPage()),
  ];
}
