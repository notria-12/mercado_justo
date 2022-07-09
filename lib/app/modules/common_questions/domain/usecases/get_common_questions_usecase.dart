import 'package:mercado_justo/app/modules/common_questions/domain/entities/common_questions_entity.dart';
import 'package:mercado_justo/app/modules/common_questions/domain/repositories/common_questions_repository.dart';

abstract class IGetCommonQuestions {
  Future<List<CommonQuestionEntity>> call();
}

class GetCommonQuestions implements IGetCommonQuestions {
  ICommonQuestionsRepository repository;
  GetCommonQuestions({
    required this.repository,
  });

  @override
  Future<List<CommonQuestionEntity>> call() {
    return repository.getAllCommonQuestions();
  }
}
