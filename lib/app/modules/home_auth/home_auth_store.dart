import 'package:flutter/animation.dart';
import 'package:mobx/mobx.dart';

part 'home_auth_store.g.dart';

class HomeAuthStore = _HomeAuthStoreBase with _$HomeAuthStore;

abstract class _HomeAuthStoreBase with Store {
  @observable
  int currentIndex = 0;

  @action
  void onTabTapped(int index) {
    currentIndex = index;
  }
}
