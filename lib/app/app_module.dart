import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_module.dart';
import 'package:mercado_justo/app/modules/login/login_module.dart';
import 'package:mercado_justo/app/modules/profile/profile_module.dart';
import 'package:mercado_justo/app/modules/signature/signature_module.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';
import 'package:mercado_justo/shared/services/dio/custom_dio.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => getDioInstance()),
    Bind.singleton((i) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/login/', module: LoginModule()),
    ModuleRoute('/home_auth/', module: HomeAuthModule()),
    ModuleRoute('/profile', module: ProfileModule()),
    ModuleRoute('/signature', module: SignatureModule())
  ];
}
