import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home/pages/market_detail_page.dart';
import 'package:mercado_justo/shared/controllers/market_store.dart';
import 'package:mercado_justo/shared/repositories/market_repository.dart';
import '../home/home_store.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => HomeStore(),
    ),
    Bind.lazySingleton((i) => MarketRepository(i())),
    Bind.lazySingleton((i) => MarketStore(repository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ChildRoute('/marketDetail/',
        child: (_, args) => MarketDetail(
              market: args.data,
            ))
  ];
}
