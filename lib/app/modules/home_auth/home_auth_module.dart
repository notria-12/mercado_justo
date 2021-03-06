import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_page.dart';
import 'package:mercado_justo/app/modules/lists/lists_module.dart';
import 'package:mercado_justo/shared/controllers/list_store.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/controllers/price_store.dart';
import 'package:mercado_justo/shared/controllers/product_store.dart';
import 'package:mercado_justo/shared/controllers/product_to_list_store.dart';
import 'package:mercado_justo/shared/repositories/list_repository.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import 'package:mercado_justo/shared/repositories/price_repository.dart';
import 'package:mercado_justo/shared/repositories/product_repository.dart';
import 'package:mercado_justo/shared/repositories/product_to_list_repository.dart';

class HomeAuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) =>
        CompareStore(marketStore: i(), priceStore: i(), repository: i())),
    Bind.lazySingleton((i) => HomeAuthStore()),
    Bind.singleton((i) => ProductStore(repository: i())),
    Bind.singleton((i) => ProductRepository(dio: i())),
    Bind.lazySingleton((i) => MarketRepository(i())),
    Bind.lazySingleton((i) => MarketStore(repository: i())),
    Bind.lazySingleton((i) => PriceRepository(dio: i())),
    Bind((i) => PriceStore(repository: i())),
    Bind.lazySingleton((i) => ListRepository()),
    Bind.lazySingleton(
        (i) => ListStore(i(), priceStore: i(), marketStore: i())),
    Bind.lazySingleton((i) => ProductToListStore(i())),
    Bind.lazySingleton((i) => ProductToListRepository())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomeAuthPage()),
    ModuleRoute('/list/', module: ListsModule())
  ];
}
