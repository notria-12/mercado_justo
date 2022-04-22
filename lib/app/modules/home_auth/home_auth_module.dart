import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_page.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import 'package:mercado_justo/shared/repositories/product_repository.dart';

class HomeAuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ProductStore(repository: i())),
    Bind.singleton((i) => ProductRepository(dio: i())),
    Bind.lazySingleton((i) => MarketRepository(i())),
    Bind.lazySingleton((i) => MarketStore(repository: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomeAuthPage()),
  ];
}
