import 'package:mobx/mobx.dart';

part 'config_store.g.dart';

class ConfigStore = _ConfigStoreBase with _$ConfigStore;

abstract class _ConfigStoreBase with Store {
  @observable
  bool separetedByCategory = false;

  @action
  setSeparetedByCategory(bool value) => separetedByCategory = value;
}
