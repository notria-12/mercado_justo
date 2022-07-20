import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';

abstract class IUseTermsRepository {
  Future<UseTermsEntity> getUseTerms();
}
