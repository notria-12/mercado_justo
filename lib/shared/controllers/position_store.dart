import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/shared/utils/utils.dart';
import 'package:mobx/mobx.dart';

part 'position_store.g.dart';

class PositionStore = _PositionStoreBase with _$PositionStore;

abstract class _PositionStoreBase with Store {
  @observable
  Position? position;

  Future getCurrentPosition() async {
    try {
      position = await Utils.determinePosition();
    } catch (e) {}
  }
}
