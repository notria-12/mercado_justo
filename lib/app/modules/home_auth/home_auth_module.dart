import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_page.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import 'package:mercado_justo/shared/repositories/price_repository.dart';
import 'package:mercado_justo/shared/repositories/product_repository.dart';

class HomeAuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeAuthStore()),
    Bind.singleton((i) => ProductStore(repository: i())),
    Bind.singleton((i) => ProductRepository(dio: i())),
    Bind.lazySingleton((i) => MarketRepository(i())),
    Bind.lazySingleton((i) => MarketStore(repository: i())),
    Bind.lazySingleton((i) => PriceRepository(dio: i())),
    Bind((i) => PriceStore(repository: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomeAuthPage()),
  ];
}
