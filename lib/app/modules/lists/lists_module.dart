import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/compare/compare_store.dart';
import 'package:mercado_justo/app/modules/lists/pages/filter_list_page.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_detail.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_edition_page.dart';
import 'package:mercado_justo/shared/controllers/fair_price_store.dart';
import 'package:mercado_justo/shared/controllers/market_name_store.dart';
import 'package:mercado_justo/shared/repositories/fair_price_repository.dart';
import 'package:mercado_justo/shared/repositories/list_repository.dart';
import 'package:mercado_justo/shared/repositories/market_name_repository.dart';

class ListsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => ListRepository(),
    ),
    Bind.factory((i) => FairPriceStore(i())),
    Bind.factory((i) => FairPriceRepository()),
    Bind.lazySingleton((i) => MarketNameStore(i())),
    Bind.lazySingleton((i) => NameMarketRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => ProductListDetailsPage(
              listModel: args.data,
            )),
    ChildRoute('/filters', child: (context, args) => const FilterListPage()),
    ChildRoute('/edit/:listId',
        child: (context, args) => ProductEditionPage(
              listId: args.params['listId'],
            ))
  ];
}
