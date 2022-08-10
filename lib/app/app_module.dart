import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercado_justo/app/../shared/controllers/config_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/../shared/controllers/position_store.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_module.dart';
import 'package:mercado_justo/app/modules/login/login_module.dart';
import 'package:mercado_justo/app/modules/profile/profile_module.dart';
import 'package:mercado_justo/app/modules/signature/signature_module.dart';
import 'package:mercado_justo/app/splash_page.dart';
import 'package:mercado_justo/shared/auth/auth_controller.dart';

import '../shared/services/dio/custom_dio.dart'
    if (dart.library.io) '../shared/services/dio/custom_dio_native.dart'
    if (dart.library.js) '../shared/services/dio/custom_dio_browser.dart';
import 'modules/home/home_module.dart';
import 'modules/lists/filter_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ConfigStore()),
    Bind.lazySingleton((i) => FilterStore()),
    Bind.lazySingleton((i) => PositionStore()),
    Bind.singleton((i) => getDioInstance()),
    Bind.singleton((i) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => SplashPage(),
    ),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/login/', module: LoginModule()),
    ModuleRoute('/home_auth/', module: HomeAuthModule()),
    ModuleRoute('/profile', module: ProfileModule()),
    ModuleRoute('/signature', module: SignatureModule())
  ];
}
