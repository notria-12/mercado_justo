import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/app/modules/common_questions/domain/entities/common_questions_entity.dart';
import 'package:mercado_justo/app/modules/common_questions/domain/usecases/get_common_questions_usecase.dart';

part 'common_questions_store.g.dart';

class CommonQuestionsStore = _CommonQuestionsStoreBase
    with _$CommonQuestionsStore;

abstract class _CommonQuestionsStoreBase with Store {
  GetCommonQuestionsUsecase usecase;
  @observable
  List<CommonQuestionEntity> commonQuestions = [];

  @observable
  AppState commonQuestionsState = AppStateEmpty();

  _CommonQuestionsStoreBase({
    required this.usecase,
  });

  Future getAllCommonQuestions() async {
    try {
      commonQuestionsState = AppStateLoading();
      commonQuestions = await usecase.call();
      commonQuestionsState = AppStateSuccess();
    } catch (e) {
      commonQuestionsState = AppStateError();
      rethrow;
    }
  }
}
