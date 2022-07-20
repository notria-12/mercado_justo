import 'package:mercado_justo/app/modules/common_questions/domain/entities/common_questions_entity.dart';

abstract class ICommonQuestionsDatasource {
  Future<List<CommonQuestionEntity>> getAllCommonQuestions();
}
