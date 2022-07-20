import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/app/modules/terms_and_conditions/infra/repositories/use_terms__repository.dart';

part 'terms_and_conditions_store.g.dart';

class TermsAndConditionsStore = _TermsAndConditionsStoreBase
    with _$TermsAndConditionsStore;

abstract class _TermsAndConditionsStoreBase with Store {
  UseTermsRepository _repository;
  _TermsAndConditionsStoreBase(
    this._repository,
  );

  Future<UseTermsEntity> getUseTerms() async {
    try {
      return await _repository.getUseTerms();
    } catch (e) {
      rethrow;
    }
  }
}
