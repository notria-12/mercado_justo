import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  _ConnectivityStoreBase() {
    final InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker();
    internetConnectionChecker.checkInterval = const Duration(seconds: 1);
    internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          hasConnection = true;
          break;
        case InternetConnectionStatus.disconnected:
          hasConnection = false;
          break;
      }
    });
  }

  @observable
  bool? hasConnection;
}
