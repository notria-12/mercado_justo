import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/shared/models/user_model.dart';
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

  @observable
  bool paymentByPix = false;

  @observable
  bool paymentByCreditCard = true;

  @action
  setPaymentByCreditCard(bool value) {
    if (value) {
      paymentByCreditCard = value;
      paymentByPix = !value;
    }
  }

  @action
  setPaymentByPix(bool value) {
    if (value) {
      paymentByPix = value;
      paymentByCreditCard = !value;
    }
  }

  Future<String> buildQRPix({required UserModel user}) async {
    return _repository.buildQRPix(user: user);
  }

  Future getSignature({required String userId}) async {
    signature = await _repository.getSignature(userId: userId);
  }

  Future<double> getRemainingDays({required String userId}) {
    return _repository.getRemainingDays(userId: userId);
  }
}
