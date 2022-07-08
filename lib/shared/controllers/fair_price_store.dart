import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/fair_price_repository.dart';

part 'fair_price_store.g.dart';

class FairPriceStore = _FairPriceStoreBase with _$FairPriceStore;

abstract class _FairPriceStoreBase with Store {
  FairPriceRepository _repository;
  _FairPriceStoreBase(
    this._repository,
  );

  @observable
  List<Map> fairPricesFromList = [];

  Future<double?> getFairPrice(
      {required int listId, required productId}) async {
    try {
      return _repository.getFairPrice(listId, productId);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteFairPrice({required int listId, required productId}) async {
    try {
      return _repository.deleteFairPrice(listId, productId);
    } catch (e) {
      rethrow;
    }
  }

  Future getFairPricesFromList({required int listId}) async {
    try {
      var list = await _repository.getFairPricesFromList(listId);
      if (list != null) {
        fairPricesFromList = list;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future saveFairPrice(
      {required double value,
      required int listId,
      required int productId}) async {
    try {
      await _repository.saveFairPrice(value, listId, productId);
    } catch (e) {
      rethrow;
    }
  }

  Future updateFairPrice(
      {required double value,
      required int listId,
      required int productId}) async {
    try {
      await _repository.updateFairPrice(value, listId, productId);
    } catch (e) {
      rethrow;
    }
  }
}
