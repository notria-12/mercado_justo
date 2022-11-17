import 'package:flutter/animation.dart';
import 'package:mercado_justo/app/modules/profile/city_model.dart';
import 'package:mercado_justo/app/modules/profile/profile_repository.dart';
import 'package:mercado_justo/app/modules/profile/state_model.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

part 'profile_controller.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  ProfileRepository _repository;

  _ProfileStoreBase(this._repository);

  @observable
  StateModel? selectedState;

  @observable
  AppState stateStatus = AppStateEmpty();

  ObservableList<StateModel> states = ObservableList.of([]);
  @observable
  CityModel? selectedCity;

  @observable
  AppState cityStatus = AppStateEmpty();

  ObservableList<CityModel> cities = ObservableList.of([]);
  void getStates() async {
    try {
      stateStatus = AppStateLoading();

      states = ObservableList.of(await _repository.getStates());
      stateStatus = AppStateSuccess();
    } on Failure catch (e) {
      stateStatus = AppStateError(error: e);
    }
  }

  void getCities() async {
    try {
      cityStatus = AppStateLoading();

      cities =
          ObservableList.of(await _repository.getCities(selectedState!.sigla));
      selectedCity = null;
      cityStatus = AppStateSuccess();
    } on Failure catch (e) {
      cityStatus = AppStateError(error: e);
    }
  }
}
