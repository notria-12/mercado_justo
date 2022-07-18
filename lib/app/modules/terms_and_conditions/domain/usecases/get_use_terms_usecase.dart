import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';
import 'package:mercado_justo/app/modules/terms_and_conditions/domain/repositories/i_use_terms_repository.dart';

abstract class IGetUseTermsUsecase {
  Future<UseTermsEntity> call();
}

class GetUseTermsUsecase implements IGetUseTermsUsecase {
  IUseTermsRepository _repository;
  GetUseTermsUsecase(
    this._repository,
  );

  @override
  Future<UseTermsEntity> call() {
    try {
      return _repository.getUseTerms();
    } catch (e) {
      rethrow;
    }
  }
}
