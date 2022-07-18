import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/domain/repositories/i_use_terms_repository.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/infra/datasources/i_use_terms_datasources.dart';

class UseTermsRepository implements IUseTermsRepository {
  IUseTermsDatasource _datasource;
  UseTermsRepository(
    this._datasource,
  );

  @override
  Future<UseTermsEntity> getUseTerms() async {
    try {
      return _datasource.getUseTerms();
    } catch (e) {
      rethrow;
    }
  }
}
