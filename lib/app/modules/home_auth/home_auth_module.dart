import 'package:mercado_justo/app/modules/common_questions/common_questions_module.dart';
import 'package:mercado_justo/app/modules/common_questions/presenter/common_questions_page.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/config/config_page.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/average_price_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/category_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/controllers/problem_controller.dart';
import 'package:mercado_justo/app/modules/home_auth/home_auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home_auth/pages/home_auth_page.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/average_price_repository.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/category_repository.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/problem_repository.dart';
import 'package:mercado_justo/app/modules/lists/lists_module.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/terms_and_conditions_module.dart';
import 'package:mercado_justo/shared/controllers/config_store.dart';
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
        CompareStore(marketStore: i(), priceRepository: i(), repository: i())),
    Bind.lazySingleton((i) => HomeAuthStore()),
    Bind.singleton((i) => ProductStore(repository: i())),
    Bind.singleton((i) => ProductRepository(dio: i())),
    Bind.lazySingleton((i) => MarketRepository(i())),
    Bind.lazySingleton((i) =>
        MarketStore(repository: i(), positionStore: i(), filterStore: i())),
    Bind.lazySingleton((i) => PriceRepository(dio: i())),
    Bind.factory((i) => PriceStore(repository: i())),
    Bind.lazySingleton((i) => ListRepository()),
    Bind.lazySingleton(
        (i) => ListStore(i(), priceRepository: i(), marketStore: i())),
    Bind.lazySingleton((i) => ProductToListStore(i())),
    Bind.lazySingleton((i) => ProductToListRepository()),
    Bind.lazySingleton((i) => CategoryStore(i())),
    Bind.lazySingleton((i) => CategoryRepository(i())),
    Bind.lazySingleton((i) => ProblemStore(i())),
    Bind.lazySingleton((i) => ProblemRepository(i())),
    Bind.factory((i) => AveragePriceRepository(i())),
    Bind.factory((i) => AveragePriceStore(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomeAuthPage()),
    ChildRoute('/config/', child: (_, args) => const ConfigPage()),
    ModuleRoute('/faq/', module: CommonQuestionsModule()),
    ModuleRoute('/list/', module: ListsModule()),
    ModuleRoute('/terms/', module: TermsAndConditionsModule())
  ];
}
