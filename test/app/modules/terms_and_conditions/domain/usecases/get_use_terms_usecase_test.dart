import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/domain/repositories/i_use_terms_repository.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/domain/usecases/get_use_terms_usecase.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/external/use_terms_datasource.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/infra/datasources/i_use_terms_datasources.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/infra/repositories/use_terms__repository.dart';
import 'package:mercado_justo/shared/services/dio/custom_dio.dart';

void main() {
  Dio dio = Dio(BaseOptions(
      baseUrl:
          'https://mercado-justo-api.herokuapp.com/mercado-justo/api/v1/'));
  IUseTermsDatasource datasource = UseTermsDatasource(dio);
  IUseTermsRepository repository = UseTermsRepository(datasource);
  GetUseTermsUsecase usecase = GetUseTermsUsecase(repository);
  setUp(() {});
  test('should return UseTermEntity', () async {
    var useTerms = await usecase.call();
    expect(UseTermsEntity, useTerms);
  });
}
