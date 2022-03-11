import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_page.dart';

class HomeAuthModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomeAuthPage()),
  ];
}
