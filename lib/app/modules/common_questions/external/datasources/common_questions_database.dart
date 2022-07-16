import 'package:dio/dio.dart';

import 'package:mercado_justo/app/modules/common_questions/domain/entities/common_questions_entity.dart';
import 'package:mercado_justo/app/modules/common_questions/infra/datasources/i_common_questions_datasource.dart';
import 'package:mercado_justo/app/modules/common_questions/infra/models/common_questions_model.dart';

class CommonQuestionsDatasource implements ICommonQuestionsDatasource {
  Dio _dio;
  CommonQuestionsDatasource(
    this._dio,
  );

  @override
  Future<List<CommonQuestionEntity>> getAllCommonQuestions() async {
    try {
      var result = await _dio.get('/perguntas-frequentes');
      List commonQuestions = result.data['dados'] as List;

      return commonQuestions
          .map((e) => CommonQuestionsModel.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
