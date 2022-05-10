import 'package:mercado_justo/shared/models/list_model.dart';
import 'package:mobx/mobx.dart';

import 'package:mercado_justo/shared/repositories/list_repository.dart';

part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  ListRepository _repository;
  _ListStoreBase(
    this._repository,
  );

  Future createNewList(String name) async {
    try {
      ListModel listModel = ListModel(name: name);
      await _repository.createList(listModel);
    } catch (e) {
      rethrow;
    }
  }
}
