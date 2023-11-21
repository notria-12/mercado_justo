import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/fair_price_repository.dart';

part 'fair_price_store.g.dart';

class FairPriceStore = _FairPriceStoreBase with _$FairPriceStore;

abstract class _FairPriceStoreBase with Store {
  final FairPriceRepository _repository;
  _FairPriceStoreBase(
    this._repository,
  );

  @observable
  List<Map> fairPricesFromList = [];

  @observable
  double? price;

  @action
  setPrice(double? value) {
    price = value;
  }

  @observable
  AppState fairPriceStatus = AppStateEmpty();

  Future<double?> getFairPrice(
      {required int listId, required productId}) async {
        
    try {
      fairPriceStatus = AppStateLoading();
      double?   fairPrice = await  _repository.getFairPrice(listId, productId);
      
      if(fairPrice != null) setPrice(fairPrice);
      fairPriceStatus = AppStateSuccess();
      
      return fairPrice;
    } catch (e) {
      fairPriceStatus = AppStateError(error: Failure(title: '', message: ''));
      rethrow;
    }
  }

  Future deleteFairPrice({required int listId, required productId}) async {
    try {
      await _repository.deleteFairPrice(listId, productId);
      setPrice(null);
    } catch (e) {
      rethrow;
    }
  }

  Future getFairPricesFromList({required int listId}) async {
    try {
      var list = await _repository.getFairPricesFromList(listId);
      if (list != null) {
        fairPricesFromList = list;
      } else {
        fairPricesFromList = [];
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
      setPrice(value);
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
      setPrice(value);
    } catch (e) {
      rethrow;
    }
  }
}
