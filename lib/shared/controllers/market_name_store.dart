import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/market_name_repository.dart';

part 'market_name_store.g.dart';

class MarketNameStore = _MarketNameStoreBase with _$MarketNameStore;

abstract class _MarketNameStoreBase with Store {
  NameMarketRepository _repository;
  _MarketNameStoreBase(
    this._repository,
  );

  Future saveMarketName({required String name, required int listId}) async {
    try {
      await _repository.saveMarketName(name, listId);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getMarketName({required int listId}) async {
    try {
      return _repository.getMarketName(listId);
    } catch (e) {
      rethrow;
    }
  }

  Future updateMarketName({required String name, required int listId}) async {
    try {
      await _repository.updateMarketName(name, listId);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteMarketName({required int listId}) async {
    try {
      await _repository.deleteMarketName(listId);
    } catch (e) {
      rethrow;
    }
  }
}
