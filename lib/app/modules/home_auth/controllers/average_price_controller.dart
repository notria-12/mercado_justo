import 'package:flutter/animation.dart';
import 'package:mercado_justo/app/modules/home_auth/models/problem_model.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/average_price_repository.dart';
import 'package:mercado_justo/app/modules/home_auth/repositories/problem_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/utils/error.dart';

part 'average_price_controller.g.dart';

class AveragePriceStore = _AveragePriceStoreBase with _$AveragePriceStore;

abstract class _AveragePriceStoreBase with Store {
  final AveragePriceRepository _repository;
  _AveragePriceStoreBase(this._repository);
  @observable
  AppState status = AppStateEmpty();

  @observable
  double averagePrice = 0.0;

  getAveragePrice(
      {required String productId, required List<int> marketIds}) async {
    try {
      status = AppStateLoading();
      averagePrice = await _repository.getAveragePrice(
          productId: productId, marketIds: marketIds);
      status = AppStateSuccess();
    } on Failure catch (e) {
      status = AppStateError(error: e);
    }
  }
}
