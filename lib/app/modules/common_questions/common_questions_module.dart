import 'package:flutter_modular/flutter_modular.dart';
import 'package:mercado_justo/app/modules/common_questions/domain/usecases/get_common_questions_usecase.dart';
import 'package:mercado_justo/app/modules/common_questions/external/datasources/common_questions_database.dart';
import 'package:mercado_justo/app/modules/common_questions/infra/repositories/common_questions_repository.dart';
import 'package:mercado_justo/app/modules/common_questions/presenter/common_questions_page.dart';
import 'package:mercado_justo/app/modules/common_questions/presenter/common_questions_store.dart';

class CommonQuestionsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CommonQuestionsStore(usecase: i())),
    Bind.lazySingleton(
      (i) => GetCommonQuestionsUsecase(
          repository: i.get<CommonQuestionsRepository>()),
    ),
    Bind.lazySingleton(
        (i) => CommonQuestionsRepository(i.get<CommonQuestionsDatasource>())),
    Bind.lazySingleton((i) => CommonQuestionsDatasource(i()))
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CommonQuestionsPage()),
  ];
}
