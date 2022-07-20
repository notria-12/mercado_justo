import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  @observable
  double rating = 100;
}
