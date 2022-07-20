import 'package:mercado_justo/app/modules/terms_and_conditions/external/use_terms_datasource.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/infra/repositories/use_terms__repository.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/presenter/terms_and_conditions_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/presenter/use_terms_page.dart';

class TermsAndConditionsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TermsAndConditionsStore(i())),
    Bind.lazySingleton((i) => UseTermsRepository(i())),
    Bind.lazySingleton((i) => UseTermsDatasource(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => UseTermsPage())
  ];
}
