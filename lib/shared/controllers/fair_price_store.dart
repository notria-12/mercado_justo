import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/fair_price_repository.dart';

part 'fair_price_store.g.dart';

class FairPriceStore = _FairPriceStoreBase with _$FairPriceStore;

abstract class _FairPriceStoreBase with Store {
  FairPriceRepository _repository;
  _FairPriceStoreBase(
    this._repository,
  );

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
