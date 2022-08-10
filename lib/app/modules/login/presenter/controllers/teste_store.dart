import 'package:mobx/mobx.dart';

part 'teste_store.g.dart';

class TesteStore = _TesteStoreBase with _$TesteStore;
abstract class _TesteStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}