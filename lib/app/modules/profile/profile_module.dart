import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/profile/pages/edit_profile_page.dart';
import 'package:mercado_justo/app/modules/profile/pages/maps_page.dart';

import 'package:mercado_justo/app/modules/profile/pages/profile_page.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => ProfilePage(),
    ),
    ChildRoute(
      '/edit',
      child: (context, args) => EditProfilePage(),
    ),
    ChildRoute(
      '/maps',
      child: (context, args) => MapsPosition(),
    )
  ];
}
