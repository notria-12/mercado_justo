import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/profile/profile_page.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => ProfilePage(),
    )
  ];
}
