import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/lists/pages/product_list_detail.dart';
import 'package:mercado_justo/shared/repositories/list_repository.dart';

class ListsModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => ListRepository())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, args) => ProductListDetailsPage(
              listModel: args.data,
            ))
  ];
}
