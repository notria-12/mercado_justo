import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/home/pages/market_detail_page.dart';
import '../home/home_store.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
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
