import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mercado_justo/shared/models/product_list_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/list_repository.dart';

part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  ListRepository _repository;
  _ListStoreBase(
    this._repository,
  );

  @observable
  List<ListModel> product_list = [];

  @observable
  AppState listState = AppStateEmpty();

  Future createNewList(String name) async {
    try {
      ListModel listModel = ListModel(name: name);
      await _repository.createList(listModel);
      getAllLists();
    } catch (e) {
      rethrow;
    }
  }

  Future getAllLists() async {
    try {
      listState = AppStateLoading();
      product_list = await _repository.getAllLists();
      listState = AppStateSuccess();
    } catch (e) {
      listState = AppStateError();
      rethrow;
    }
  }

  Future<int> getProductsByList(int listId) async {
    try {
      List<ProductListModel> list_products =
          await _repository.getProductsByList(listId);
      return list_products.length;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteList(int listId) async {
    try {
      await _repository.deleteList(listId);
      getAllLists();
    } catch (e) {
      rethrow;
    }
  }
}
