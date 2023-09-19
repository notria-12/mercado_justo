import 'package:geolocator/geolocator.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mercado_justo/shared/utils/utils.dart';
import 'package:mobx/mobx.dart';

part 'position_store.g.dart';

class PositionStore = _PositionStoreBase with _$PositionStore;

abstract class _PositionStoreBase with Store {
  @observable
  Position? position;

  @observable
  AppState positionState = AppStateEmpty();

  Future getCurrentPosition() async {
    try {
      positionState = AppStateLoading();
      position = await Utils.determinePosition();
      positionState = AppStateSuccess();
    } on Failure catch (e) {
      positionState = AppStateError(error: e);
      rethrow;
    }
  }
}
