import 'package:dio/dio.dart';

import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/infra/datasources/i_use_terms_datasources.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/infra/models/use_terms_model.dart';

class UseTermsDatasource implements IUseTermsDatasource {
  Dio _dio;
  UseTermsDatasource(
    this._dio,
  );

  @override
  Future<UseTermsEntity> getUseTerms() async {
    try {
      var result = await _dio.get('/termos-uso');
      var term = result.data['dados'];
      return UseTermsModel.fromMap(term);
    } catch (e) {
      rethrow;
    }
  }
}
