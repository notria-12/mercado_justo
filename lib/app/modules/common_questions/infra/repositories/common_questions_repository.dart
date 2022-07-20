import 'package:mercado_justo/app/modules/common_questions/domain/entities/common_questions_entity.dart';
import 'package:mercado_justo/app/modules/common_questions/domain/repositories/i_common_questions_repository.dart';
import 'package:mercado_justo/app/modules/common_questions/infra/datasources/i_common_questions_datasource.dart';

class CommonQuestionsRepository implements ICommonQuestionsRepository {
  ICommonQuestionsDatasource _datasource;
  CommonQuestionsRepository(
    this._datasource,
  );

  @override
  Future<List<CommonQuestionEntity>> getAllCommonQuestions() {
    try {
      return _datasource.getAllCommonQuestions();
    } catch (e) {
      rethrow;
    }
  }
}
