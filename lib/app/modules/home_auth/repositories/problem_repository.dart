// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:mercado_justo/app/modules/home_auth/models/problem_model.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class ProblemRepository {
  Dio _dio;
  ProblemRepository(
    this._dio,
  );

  Future reportProblem({required ProblemModel problem}) async {
    try {
      await _dio.post('/problemas', data: problem.toMap());
    } catch (e) {
      throw Failure(title: 'Erro', message: 'Falha ao reportar problema');
    }
  }
}
