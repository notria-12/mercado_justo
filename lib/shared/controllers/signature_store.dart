import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/shared/repositories/signature_repository.dart';
import 'package:mercado_justo/shared/utils/utils.dart';
import 'package:mobx/mobx.dart';

import '../models/signature_model.dart';

part 'signature_store.g.dart';

class SignatureStore = _SignatureStoreBase with _$SignatureStore;

abstract class _SignatureStoreBase with Store {
  final SignatureRepository _repository;
  _SignatureStoreBase(this._repository);
  @observable
  SignatureModel? signature;

  Future getSignature({required String userId}) async {
    signature = await _repository.getSignature(userId: userId);
  }

  Future<double> getRemainingDays({required String userId}) {
    return _repository.getRemainingDays(userId: userId);
  }
}
